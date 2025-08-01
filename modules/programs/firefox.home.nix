{
  pkgs,
  system,
  ...
}:
let
  profileName = "mcarthur.alford@proton.me";
  mozillaPath = ".mozilla/firefox/${profileName}";
  # shyfox = builtins.fetchGit {
  #   url = "https://github.com/mcarthur-alford/ShyFox";
  #   rev = "425852198d0db1761ee31692ac38299043646667";
  # };
  theme = builtins.fetchGit {
    url = "https://github.com/artsyfriedchicken/EdgyArc-fr";
    rev = "2ba31f414811324f218111c94586651456d89fdf";
  };
  # userjs = theme + "/user.js";
  chrome = builtins.path {
    path = theme + "/chrome";
    filter = path: _type: !pkgs.lib.hasSuffix ".png" path;
  };
in
{
  # home.file."${mozillaPath}/chrome".source = chrome;
  # home.file."${mozillaPath}/user.js".source = userjs;

  home.sessionVariables.DEFAULT_BROWSER = "${pkgs.firefox}/bin/firefox";

  xdg.mimeApps.defaultApplications = {
    "text/html" = "firefox.desktop";
    "x-scheme-handler/http" = "firefox.desktop";
    "x-scheme-handler/https" = "firefox.desktop";
    "x-scheme-handler/about" = "firefox.desktop";
    "x-scheme-handler/unknown" = "firefox.desktop";
  };

  programs.firefox = {
    enable = true;
    profiles = {
      "${profileName}" = {
        id = 0;
        isDefault = true;

        search.force = true;
        search.default = "DuckDuckGo";
        search.engines = {
          "Nix Packages" = {
            urls = [
              {
                template = "https://search.nixos.org/packages";
                params = [
                  {
                    name = "query";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = [ "@np" ];
          };
          "Nix Options" = {
            definedAliases = [ "@no" ];
            urls = [
              {
                template = "https://search.nixos.org/options";
                params = [
                  {
                    name = "query";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
          };
          "Rust Docs" = {
            definedAliases = [ "@rs" ];
            urls = [
              {
                template = "https://docs.rs";
                params = [
                  {
                    name = "/";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
          };
        };
      };
    };
  };
}
