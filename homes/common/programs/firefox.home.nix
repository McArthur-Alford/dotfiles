{ pkgs, ... }:
let
  profileName = "mcarthur.alford@proton.me";
  mozillaPath = ".mozilla/firefox/${profileName}";
  # shyfox = builtins.fetchGit {
  #   url = "https://github.com/mcarthur-alford/ShyFox";
  #   rev = "425852198d0db1761ee31692ac38299043646667";
  # };
  theme = builtins.fetchGit {
    url = "https://github.com/artsyfriedchicken/EdgyArc-fr";
  };
  # userjs = theme + "/user.js";
  chrome = builtins.path { path = theme + "/chrome"; filter = path: _type: !pkgs.lib.hasSuffix ".png" path; };
in
{
  home.file."${mozillaPath}/chrome".source = chrome;
  # home.file."${mozillaPath}/user.js".source = userjs;

  programs.firefox = {
    enable = true;
    profiles = {
      "${profileName}" = {
        id = 0;
        isDefault = true;

        search.force = true;
        search.engines = {
          "Nix Packages" = {
            urls = [{
              template = "https://search.nixos.org/packages";
              params = [
                { name = "query"; value = "{searchTerms}"; }
              ];
            }];
            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = [ "@np" ];
          };
          "Nix Options" = {
            definedAliases = [ "@no" ];
            urls = [{
              template = "https://search.nixos.org/options";
              params = [
                { name = "query"; value = "{searchTerms}"; }
              ];
            }];
          };
          "Rust Docs" = {
            definedAliases = [ "@rs" ];
            urls = [{
              template = "https://docs.rs";
              params = [
                { name = "/"; value = "{searchTerms}"; }
              ];
            }];
          };
        };
      };
    };
  };
}
