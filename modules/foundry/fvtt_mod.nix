{
  lib,
  pkgs,
  config,
  ...
}:
with lib;
let
  cfg = config.fvtt;
  instances = cfg.instances;
  interface = cfg.interface;
  host = config.networking.hostName;
in
{
  options.fvtt = {
    enable = mkEnableOption "foundry vtt";
    instances = mkOption { type = types.anything; };
    tunnel = mkOption { type = types.string; };
    interface = mkOption { type = types.string; };
  };

  config = mkIf cfg.enable {
    networking = {
      bridges.br0.interfaces = [ "${interface}" ];

      useDHCP = false;
      interfaces."br0".useDHCP = true;

      interfaces."br0".ipv4.addresses = [
        {
          address = "192.168.100.3";
          prefixLength = 24;
        }
      ];
      defaultGateway = "192.168.100.1";
      nameservers = [ "192.168.100.1" ];

      nat = {
        enable = true;
        internalInterfaces = [ "ve-fvtt-*" ];
        externalInterface = "${interface}";
      };

      firewall = {
        allowedTCPPorts = [
          80
          443
        ];
        extraCommands = ''
          iptables -t nat -F POSTROUTING  # Clears existing POSTROUTING rules \n
          iptables -t nat -A POSTROUTING -o ${interface} -j MASQUERADE
        '';
      };
    };

    containers = listToAttrs (
      map (
        x:
        nameValuePair "fvtt-${x.ident}" {
          autoStart = true;
          ephemeral = true;
          privateNetwork = true;
          hostBridge = "br0";
          localAddress = "${x.ip}/24";
          config = {
            networking.firewall = {
              enable = true;
              allowedTCPPorts = [
                80
                443
                30000
              ];
            };
            networking.useDHCP = lib.mkForce true;
            networking.useHostResolvConf = lib.mkForce false;
            services.resolved.enable = true;
            environment.systemPackages = with pkgs; [
              helix
              busybox
            ];

            systemd.services.foundry = {
              description = "FoundryVTT";
              after = [ "network.target" ];
              wants = [ "network-online.target" ];
              script = "exec ${
                pkgs.callPackage ./fvtt_pkg.nix { version = x.version; }
              }/bin/foundryvtt-bootstrap";
              wantedBy = [ "multi-user.target" ];
              serviceConfig = {
                RestartSec = 1;
                Restart = "always";
              };
            };

            environment.etc."fvtt/options.json".text = builtins.toJSON {
              port = 30000;
              dataPath = "/opt/fvtt/data/";
              hostname = "${x.ident}.${host}";
              upnp = true;
            };
          };
          bindMounts."/opt/fvtt/" = {
            # hostPath = "/opt/fvtt/${x.ident}/";
            hostPath = "${x.dir}/${x.ident}";
            isReadOnly = false;
          };
          bindMounts."/opt/fvtt_static" = {
            hostPath = "/opt/fvtt_static/";
            # Only modifiable by host, not containers
            isReadOnly = true;
          };
        }
      ) (builtins.attrValues instances)
    );
  };
}

