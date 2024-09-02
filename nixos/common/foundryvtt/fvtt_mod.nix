{
  lib,
  pkgs,
  config,
  ...
}:
with lib;
let
  # Extract a few options for readability
  cfg = config.fvtt;
  instances = cfg.instances;
  host = config.networking.hostName;
in
{
  # Define the NixOS module option
  options.fvtt = {
    enable = mkEnableOption "foundry vtt";
    instances = mkOption { type = types.anything; };
    tunnel = mkOption { type = types.string; };
  };

  # If Foundry is enabled, we make all of the below happen
  config = mkIf cfg.enable {
    networking = {
      nat = {
        enable = true;
        internalInterfaces = [ "ve-fvtt-*" ];
        externalInterface = "enp1s0";
      };
    };

    networking.firewall = {
      allowedTCPPorts = [
        80
        443
      ];
      checkReversePath = false;
      # I don't remember why this is necessary, but it is.
      extraCommands = "iptables -t nat -A POSTROUTING -o enp1s0 -j MASQUERADE";
    };

    containers = listToAttrs (
      map (
        x:
        nameValuePair "fvtt-${x.ident}" {
          ephemeral = true;
          autoStart = true;
          privateNetwork = true;
          hostAddress = "192.168.100.1";
          localAddress = x.ip;
          forwardPorts = [
            {
              containerPort = 22;
              hostPort = 2222;
              protocol = "tcp";
            }
            {
              containerPort = 80;
              hostPort = 8080;
              protocol = "tcp";
            }
            {
              containerPort = 30000;
              hostPort = 30000;
              protocol = "tcp";
            }
          ];

          # We make each instance's folder a subfolder on the host. Convenient for backups!
          bindMounts."/opt/fvtt/" = {
            hostPath = "/opt/fvtt/${x.ident}/";
            isReadOnly = false;
          };

          # The cache holds the base copy of Foundry. Just need it to bootstrap the instance.
          bindMounts."/opt/fvtt_static" = {
            hostPath = "/opt/fvtt_static/";
            isReadOnly = true; # It's still modifyable from the host, this is for correctness
          };

          config =
            { config, pkgs, ... }:
            {
              networking.firewall.allowedTCPPorts = [
                80
                30000
              ];
              # And finally, FOUNDRY
              systemd.services.foundry = {
                description = "FoundryVTT";
                after = [ "network.target" ];
                wants = [ "network-online.target" ];
                # This sets up and executes Foundry. Sadly, a bash wrapper is necessary for some parts
                script = "exec ${
                  pkgs.callPackage ./fvtt_pkg.nix { version = x.version; }
                }/bin/foundryvtt-bootstrap";
                wantedBy = [ "multi-user.target" ];
                serviceConfig = {
                  RestartSec = 1; # There's a weird race condition that makes the delay necessary
                  Restart = "always"; # Foundry sometimes requires a restart as part of some settings changes
                };
              };

              # These are the static options that need to be hard set. If edited from within Foundry,
              # Foundry will restart, and the bootstrap script will overwrite the options.json with
              # these values. This is to prevent the user from breaking their instance and requiring
              # manual intervention.
              environment.etc."fvtt/options.json".text = builtins.toJSON {
                port = 30000;
                dataPath = "/opt/fvtt/data/";
                hostname = "${x.ident}.${host}";
                upnp = true;
              };
            };
        }
      ) (builtins.attrValues instances)
    );
  };
}
