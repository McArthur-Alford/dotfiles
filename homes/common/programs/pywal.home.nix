{ pkgs, lib, ... }:
let
  pywalfox-wrapper = pkgs.writeShellScriptBin "pywalfox-wrapper" ''
    ${pkgs.pywalfox-native}/bin/pywalfox start
  '';
    switch-theme = pkgs.writeShellScriptBin "switch-theme" ''
    if [ -z "$1" ]; then
        wal --theme "$1"
    elif [ -f "$1" ]; then
        wal -i "$1"
    else
        wal --theme "$1"
    fi
    # Hooks to run after applying the theme or wallpaper
    pywalfox update
  '';
in
{
  home.packages = with pkgs; [
    pywal
    pywalfox-native
    switch-theme
  ];

  home.file.".config/wal/templates".recursive = true;
  home.file.".config/wal/templates".source = ../../../dotfiles/wal/templates;

  home.file.".mozilla/native-messaging-hosts/pywalfox.json".text = lib.replaceStrings [ "<path>" ] [
    "${pywalfox-wrapper}/bin/pywalfox-wrapper"
  ] (lib.readFile "${pkgs.pywalfox-native}/lib/python3.11/site-packages/pywalfox/assets/manifest.json");

}
