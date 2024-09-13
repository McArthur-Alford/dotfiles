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

  # Based on https://github.com/xero/dotfiles/
  # bg = "#201430",
  # black = "#000000",
  # magenta = "#483160",
  # green = "#87FF5F",
  # lost = "#666666",
  # unit01 = "#67478a",
  # selee = "#875FAF",
  # mint = "#9cda7c",
  # hazard = "#D99145",
  # purple = "#AB92FC",
  # lcl = "#5b2b41",
  # nerv = "#bf2d2d",
  # rei = "#e1d6f8",
  eva = pkgs.writeText "eva.yaml" ''
    # Base16 EVA Refined Theme
    scheme: "EVA Refined"
    author: "Based on EVA color scheme"

    base00: "201430" # background - a darker purple, subtle but rich
    base01: "483160" # Lighter Background - matches the background separator for smooth contrast
    base02: "5B2B41" # Selection Background - lcl, a slightly more muted tone for selection
    base03: "666666" # Comments, Invisibles, Line Highlighting - soft gray (lost)
    base04: "E1D6F8" # Dark Foreground - slightly brighter white for text highlights
    base05: "AB92FC" # Default Foreground, Caret, Delimiters, Operators - primary text color, pastel purple
    base06: "9CDA7C" # Light Foreground - mint, adds vibrancy without overpowering
    base07: "F8F8FF" # Light Background - off-white, softens the overall look
    base08: "D99145" # Variables, XML Tags, Markup Link Text, Markup Lists, Diff Deleted - warm orange
    base09: "875FAF" # Integers, Boolean, Constants, XML Attributes, Markup Link Url - attribute color, dark purple
    base0A: "AB92FC" # Classes, Markup Bold, Search Text Background - vibrant and lively purple
    base0B: "87FF5F" # Strings, Inherited Class, Markup Code, Diff Inserted - bright green
    base0C: "6D7BA6" # Support, Regular Expressions, Escape Characters, Markup Quotes - teal blue, subtle but distinct
    base0D: "875FAF" # Functions, Methods, Attribute IDs, Headings - consistent dark purple for visibility
    base0E: "AB92FC" # Keywords, Storage, Selector, Markup Italic, Diff Changed - matching vibrant purple
    base0F: "BF2D2D" # Deprecated, Opening/Closing Embedded Language Tags - bright nerv color for strong emphasis
  '';
in
# # Base16 EVA Refined Theme
# scheme: "EVA Refined"
# author: "Based on EVA color scheme"

# base00: "201430" # background - a darker purple, subtle but rich
# base01: "483160" # Lighter Background - matches the background separator for smooth contrast
# base02: "5B2B41" # Selection Background - lcl, a slightly more muted tone for selection
# base03: "666666" # Comments, Invisibles, Line Highlighting - soft gray (lost)
# base04: "E1D6F8" # Dark Foreground - slightly brighter white for text highlights
# base05: "AB92FC" # Default Foreground, Caret, Delimiters, Operators - primary text color, pastel purple
# base06: "9CDA7C" # Light Foreground - mint, adds vibrancy without overpowering
# base07: "F8F8FF" # Light Background - off-white, softens the overall look
# base08: "D99145" # Variables, XML Tags, Markup Link Text, Markup Lists, Diff Deleted - warm orange
# base09: "875FAF" # Integers, Boolean, Constants, XML Attributes, Markup Link Url - attribute color, dark purple
# base0A: "AB92FC" # Classes, Markup Bold, Search Text Background - vibrant and lively purple
# base0B: "87FF5F" # Strings, Inherited Class, Markup Code, Diff Inserted - bright green
# base0C: "6D7BA6" # Support, Regular Expressions, Escape Characters, Markup Quotes - teal blue, subtle but distinct
# base0D: "875FAF" # Functions, Methods, Attribute IDs, Headings - consistent dark purple for visibility
# base0E: "AB92FC" # Keywords, Storage, Selector, Markup Italic, Diff Changed - matching vibrant purple
# base0F: "BF2D2D" # Deprecated, Opening/Closing Embedded Language Tags - bright nerv color for strong emphasis

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
    base16Scheme = "${eva}";
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
