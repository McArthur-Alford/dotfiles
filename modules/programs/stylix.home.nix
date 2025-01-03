{
  pkgs,
  inputs,
  config,
  userSettings,
  self,
  # config,
  # lib,
  ...
}:
let
  # Based on https://github.com/xero/dotfiles/
  base16Yaml =
    with (import "${self}/modules/themes/${userSettings.theme}.nix").base16;
    pkgs.writeText "eva.yaml" ''
      # Base16 EVA Refined Theme
      scheme: "${scheme}"
      author: "${author}" Based on EVA color scheme"
      base00: "${base00}" # ------- Background
      base01: "${base01}" #  -----  Light Background
      base02: "${base02}" #   ---   Selection Background
      base03: "${base03}" #    -    Comments, Invisibles
      base04: "${base04}" #    +    Dark Foreground
      base05: "${base05}" #   +++   Default Foreground
      base06: "${base06}" #  +++++  Light Foreground
      base07: "${base07}" # +++++++ Light Background
      base08: "${base08}" # Red
      base09: "${base09}" # Orange
      base0A: "${base0A}" # Yellow
      base0B: "${base0B}" # Green
      base0C: "${base0C}" # Cyan
      base0D: "${base0D}" # Blue
      base0E: "${base0E}" # Magenta
      base0F: "${base0F}" # Brown
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
    base16Scheme = "${base16Yaml}";
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
    image = "${self}/assets/wallpapers/PhantomThieves-Ultrawide.png";
    # cursor.name = "Breeze-gtk";
    # cursor.package = pkgs.breeze-gtk;
    cursor = {
      package = pkgs.qogir-icon-theme;
      name = "Qogir";
      size = 24;
    };
    fonts = {
      monospace = {
        package = pkgs.nerd-fonts.fira-code;
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
