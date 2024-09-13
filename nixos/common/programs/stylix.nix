{
  user,
  inputs,
  pkgs,
  ...
}:
let

  eva = pkgs.writeText "eva.yaml" ''
    # Base16 EVA Refined Theme
    scheme: "EVA Refined"
    author: "Based on EVA color scheme"

    base00: "201430" # background - a darker purple, subtle but rich
    base01: "483160" # Lighter Background - matches the background separator for smooth contrast
    base02: "660831" # Selection Background - lcl, a slightly more muted tone for selection
    base03: "666666" # Comments, Invisibles, Line Highlighting - soft gray (lost)
    base04: "E1D6F8" # Dark Foreground - slightly brighter white for text highlights
    base05: "AB92FC" # Default Foreground, Caret, Delimiters, Operators - primary text color, pastel purple
    base06: "c7fba5" # Light Foreground - mint, adds vibrancy without overpowering
    base07: "F8F8FF" # Light Background - off-white, softens the overall look
    base08: "d65c30" # Variables, XML Tags, Markup Link Text, Markup Lists, Diff Deleted - warm orange
    base09: "875FAF" # Integers, Boolean, Constants, XML Attributes, Markup Link Url - attribute color, dark purple
    base0A: "AB92FC" # Classes, Markup Bold, Search Text Background - vibrant and lively purple
    base0B: "87FF5F" # Strings, Inherited Class, Markup Code, Diff Inserted - bright green
    base0C: "6D7BA6" # Support, Regular Expressions, Escape Characters, Markup Quotes - teal blue, subtle but distinct
    base0D: "875FAF" # Functions, Methods, Attribute IDs, Headings - consistent dark purple for visibility
    base0E: "AB92FC" # Keywords, Storage, Selector, Markup Italic, Diff Changed - matching vibrant purple
    base0F: "f7262b" # Deprecated, Opening/Closing Embedded Language Tags - bright nerv color for strong emphasis
  '';
in
{
  imports = [ inputs.stylix.nixosModules.stylix ];

  stylix = {
    enable = true;
    autoEnable = true;
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-night-dark.yaml";
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/dracula.yaml";
    base16Scheme = "${eva}";
    homeManagerIntegration.autoImport = true;
  };
}
