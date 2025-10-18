{
  osConfig,
  inputs,
  pkgs,
  config,
  lib,
  ...
}:
{
  # imports = [ inputs.anyrun.homeManagerModules.default ];
  # Obsolete, got merged into home manager

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

      plugins = ([
        "${pkgs.anyrun}/lib/libapplications.so"
        # "${pkgs.anyrun}/lib/librink.so"
        # "${pkgs.anyrun}/lib/libshell.so"
        # "${pkgs.anyrun}/lib/libtranslate.so"
        # "${pkgs.anyrun}/lib/libwebsearch.so"
      ])
      ++ [ inputs.anyrun-nixos-options.packages.${pkgs.system}.default ];
    };

    extraCss = # css
      ''
        * {
          all: unset;
          font-size: 1.2rem;
        }

        window,
        box.main,
        text.match,
        entry,
        box.plugin {
          background: transparent;
        }

        box.main {
          background-color: #${config.lib.stylix.colors.base02};
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
