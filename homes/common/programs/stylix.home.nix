{
  pkgs,
  inputs,
  lib,
  config,
  # config,
  # lib,
  ...
}:
let
  active = eva;
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

  # Based on https://github.com/xero/dotfiles/
  eva = pkgs.writeText "eva.yaml" ''
    # Base16 EVA Refined Theme
    scheme: "EVA Refined"
    author: "Based on EVA color scheme"
    base00: "201430" # ------- Background
    base01: "34204A" #  -----  Light Background
    base02: "483160" #   ---   Selection Background
    base03: "66457D" #    -    Comments, Invisibles
    base04: "875FAF" #    +    Dark Foreground
    base05: "A47DC7" #   +++   Default Foreground
    base06: "C4A3E4" #  +++++  Light Foreground
    base07: "d1c3f4" # +++++++ Light Background
    base08: "f7262b" # Red
    base09: "d65c30" # Orange
    base0A: "ff8c28" # Yellow
    base0B: "ADF182" # Green
    base0C: "858fe6" # Cyan
    base0D: "ab92fc" # Blue
    base0E: "6e3e58" # Magenta
    base0F: "dc7d68" # Brown
  '';

  nh = "${pkgs.nh}/bin/nh";
  palette =
    with config.lib.stylix.colors;
    pkgs.writeScriptBin "palette" ''
      #!${pkgs.nushell}/bin/nu --stdin

      def main [
      ] {
        let colors = [
          { hex: "#${base00}", name: "base00" },
          { hex: "#${base01}", name: "base01" },
          { hex: "#${base02}", name: "base02" },
          { hex: "#${base03}", name: "base03" },
          { hex: "#${base04}", name: "base04" },
          { hex: "#${base05}", name: "base05" },
          { hex: "#${base06}", name: "base06" },
          { hex: "#${base07}", name: "base07" },
          { hex: "#${base08}", name: "base08" },
          { hex: "#${base09}", name: "base09" },
          { hex: "#${base0A}", name: "base0A" },
          { hex: "#${base0B}", name: "base0B" },
          { hex: "#${base0C}", name: "base0C" },
          { hex: "#${base0D}", name: "base0D" },
          { hex: "#${base0E}", name: "base0E" },
          { hex: "#${base0F}", name: "base0F" },
        ]

        for $color in $colors {
          $"($color.name): (ansi --escape { fg: $color.hex })($color.hex): (ansi --escape { fg: "black", bg: $color.hex })($color.hex)(ansi reset)" | print
        }
      }
    '';
in
{
  imports = [ inputs.stylix.homeManagerModules.stylix ];
  home.packages = with pkgs; [ palette ];

  stylix = {
    enable = true;
    autoEnable = true;
    targets.hyprland.enable = false;
    targets.spicetify.enable = false;
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/dracula.yaml";
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-night-dark.yaml";
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-macchiato.yaml";
    base16Scheme = "${active}";
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
    image = ../../../wallpapers/PhantomThieves-Ultrawide.png;
    # cursor.name = "Breeze-gtk";
    # cursor.package = pkgs.breeze-gtk;
    cursor = {
      package = pkgs.qogir-icon-theme;
      name = "Qogir";
      size = 24;
    };
    fonts = {
      monospace = {
        package = (pkgs.nerdfonts.override { fonts = [ "FiraCode" ]; });
        name = "FiraCode Nerd Font Mono Medium";
        # package = pkgs.meslo-lgs-nf;
        # name = "MesloLGS NF";
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
