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
      showResultsImmediately = false;
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

    # Inline comments are supported for language injection into
    # multi-line strings with Treesitter! (Depends on your editor)
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
    # #match.activatable {
    #   border-radius: 8px;
    #   margin: 4px 0;
    #   padding: 4px;
    #   /* transition: 100ms ease-out; */
    # }
    # #match.activatable:first-child {
    #   margin-top: 12px;
    # }
    # #match.activatable:last-child {
    #   margin-bottom: 0;
    # }

    # #match:hover {
    #   background: rgba(255, 255, 255, 0.05);
    # }
    # #match:selected {
    #   background: rgba(255, 255, 255, 0.1);
    # }

    # #entry {
    #   background: rgba(255, 255, 255, 0.05);
    #   border: 1px solid rgba(255, 255, 255, 0.1);
    #   border-radius: 8px;
    #   padding: 4px 8px;
    # }

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
