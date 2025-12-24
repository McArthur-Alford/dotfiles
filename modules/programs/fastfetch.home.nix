{
  pkgs,
  self,
  ...
}:
let
  brrtfetch = pkgs.callPackage "${self}/modules/programs/brrtfetch.home.nix" { };
in
{
  home.packages = [
    # brrtfetch
  ];

  home.shellAliases = {
    fastfetch = ''bash -c "brrtfetch --multiplier 90 --fps 5 ${self}/assets/brrtfetch.gif"'';
  };

  programs.fastfetch = {
    enable = true;
    settings = {
      display = {
        size.binaryPrefix = "si";
        color = "blue";
        separator = "  ";
      };
      modules = [
        "title"
        "separator"
        "os"
        "host"
        "kernel"
        "uptime"
        "packages"
        "shell"
        "display"
        "de"
        "wm"
        "wmtheme"
        "theme"
        "icons"
        "font"
        "cursor"
        "terminal"
        "terminalfont"
        "cpu"
        "gpu"
        "memory"
        "swap"
        "disk"
        "localip"
        "battery"
        "poweradapter"
        "locale"
        "break"
        "colors"
      ];
    };
  };
}
