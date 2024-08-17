{
  pkgs,
  inputs,
  lib,
  # config,
  # lib,
  ...
}:
let
  dracula = pkgs.writeText "dracula.yaml" ''
    scheme: "Dracula"
    author: "McArthur Alford (http://github.com/McArthur-Alford) based on Dracula Theme (http://github.com/dracula)"
    base00: "282A36" # background
    base01: "44475a" # Lighter Background (Used for status bars, line number and folding marks)
    base02: "363848" # Selection Background
    base03: "6272A4" # Comments, Invisibles, Line Highlighting
    base04: "f8f8f2" # Dark Foreground (Used for status bars)
    base05: "f8f8f2" # Default Foreground, Caret, Delimiters, Operators
    base06: "e9e9f4" # Light Foreground (Not often used)
    base07: "f7f7fb" # Light Background (Not often used)
    base08: "ff5555" # Variables, XML Tags, Markup Link Text, Markup Lists, Diff Deleted
    base09: "ffb86c" # Integers, Boolean, Constants, XML Attributes, Markup Link Url
    base0A: "f1fa8c" # Classes, Markup Bold, Search Text Background
    base0B: "50fa7b" # Strings, Inherited Class, Markup Code, Diff Inserted
    base0C: "8be9fd" # Support, Regular Expressions, Escape Characters, Markup Quotes
    base0D: "bd93f9" # Functions, Methods, Attribute IDs, Headings
    base0E: "ff79c6" # Keywords, Storage, Selector, Markup Italic, Diff Changed
    base0F: "ffffff" # Deprecated, Opening/Closing Embedded Language Tags, e.g. <?php ?>
  '';
in
{
  imports = [ inputs.stylix.homeManagerModules.stylix ];

  stylix = {
    enable = true;
    autoEnable = true;
    targets.hyprland.enable = false;
    # targets.helix.enable = false;
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/dracula.yaml";
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-night-dark.yaml";
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-macchiato.yaml";
    base16Scheme = "${dracula}";
    image = ../../../wallpapers/PhantomThieves-Ultrawide.png;
    # cursor.name = "Breeze-gtk";
    # cursor.package = pkgs.breeze-gtk;
    cursor = {
      package = pkgs.qogir-icon-theme;
      name = "Qogir";
      size = 16;
    };
    fonts = {
      monospace = {
        # package = (pkgs.nerdfonts.override { fonts = [ "FiraCode" ]; });
        # name = "FiraCode Nerd Font Mono Medium";
        package = pkgs.meslo-lgs-nf;
        name = "MesloLGS NF";
      };
      sansSerif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Sans";
      };
      serif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Serif";
      };
    };
  };
}
