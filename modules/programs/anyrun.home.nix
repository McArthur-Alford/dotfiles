{
  osConfig,
  inputs,
  pkgs,
  config,
  ...
}:
{
  imports = [ inputs.anyrun.homeManagerModules.default ];

  programs.anyrun = {
    enable = true;
    config = {
      x = {
        fraction = 0.5;
      };
      y = {
        fraction = 0.1;
      };
      width = {
        fraction = 0.3;
      };
      hideIcons = false;
      ignoreExclusiveZones = false;
      layer = "overlay";
      hidePluginInfo = true;
      closeOnClick = false;
      showResultsImmediately = true;
      maxEntries = 10;

      plugins =
        (with inputs.anyrun.packages.${pkgs.system}; [
          applications
          rink
          shell
          translate
          websearch
        ])
        ++ [ inputs.anyrun-nixos-options.packages.${pkgs.system}.default ];
    };

    extraCss = # css
      ''
        * {
          all: unset;
          font-size: 1.2rem;
        }

        #window,
        #match,
        #entry,
        #plugin,
        #main {
          background: transparent;
        }

        box#main {
          background: "#${config.lib.stylix.colors.base02}";
          border-radius: 10px;
          padding: 12px;
        }
      '';

    extraConfigFiles."nixos-options.ron".text =
      let
        nixos-options = osConfig.system.build.manual.optionsJSON + "/share/doc/nixos/options.json";
        hm-options =
          inputs.home-manager.packages.${pkgs.system}.docs-json + "/share/doc/home-manager/options.json";
        options = builtins.toJSON {
          ":nix" = [ nixos-options ];
          ":hm" = [ hm-options ];
          ":nall" = [
            nixos-options
            hm-options
          ];
        };

      in
      ''
        Config(
            options: ${options},
            min_score: 0,
            max_entries: Some(10)
         )
      '';
  };
}
