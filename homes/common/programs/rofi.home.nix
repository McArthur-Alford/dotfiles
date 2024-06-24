{pkgs, config, ...}:
{
  programs.rofi = {
    enable = true;
    cycle = true;
    location = "center";
    pass = { };
    plugins = [
      pkgs.rofi-calc
      pkgs.rofi-emoji
      pkgs.rofi-systemd
    ];
    package = pkgs.rofi-wayland;

    theme = let
      inherit (config.lib.formats.rasi) mkLiteral;
    in {
      "*" = {
        # font = mkLiteral "Jetbrains Mono 12";
        foreground = mkLiteral "#f8f8f2";
        background-color = mkLiteral "#282a36";
        active-background = mkLiteral "#6272a4";
        urgent-background = mkLiteral "#ff5555";
        urgent-foreground = mkLiteral "#282a36";
        selected-background = mkLiteral "@active-background";
        selected-urgent-background = mkLiteral "@urgent-background";
        selected-active-background = mkLiteral "@active-background";
        separatorcolor = mkLiteral "@active-background";
        bordercolor = mkLiteral "@active-background";
      };

      "#window" = {
        background-color = mkLiteral "@background-color";
        border = 3;
        border-radius = 6;
        border-color = mkLiteral "@bordercolor";
        padding = 15;
      };

      "#mainbox" = {
        border = 0;
        padding = 0;
      };

      "#message" = {
        border = 0;
        border-color = mkLiteral "@separatorcolor";
        padding = 1;
      };

      "#textbox" = {
        text-color = mkLiteral "@foreground";
      };

      "#listview" = {
        fixed-height = 0;
        border = 0;
        border-color = mkLiteral "@bordercolor";
        spacing = 2;
        scrollbar = false;
        padding = mkLiteral "2px 0px 0px";
      };

      "#element" = {
        border = 0;
        padding = 3;
      };

      "#element.normal.normal" = {
        background-color = mkLiteral "@background-color";
        text-color = mkLiteral "@foreground";
      };

      "#element.normal.urgent" = {
        background-color = mkLiteral "@urgent-background";
        text-color = mkLiteral "@urgent-foreground";
      };

      "#element.normal.active" = {
        background-color = mkLiteral "@active-background";
        text-color = mkLiteral "@foreground";
      };

      "#element.selected.normal" = {
        background-color = mkLiteral "@selected-background";
        text-color = mkLiteral "@foreground";
      };

      "#element.selected.urgent" = {
        background-color = mkLiteral "@selected-urgent-background";
        text-color = mkLiteral "@foreground";
      };

      "#element.selected.active" = {
        background-color = mkLiteral "@selected-active-background";
        text-color = mkLiteral "@foreground";
      };

      "#element.alternate.normal" = {
        background-color = mkLiteral "@background-color";
        text-color = mkLiteral "@foreground";
      };

      "#element.alternate.urgent" = {
        background-color = mkLiteral "@urgent-background";
        text-color = mkLiteral "@foreground";
      };

      "#element.alternate.active" = {
        background-color = mkLiteral "@active-background";
        text-color = mkLiteral "@foreground";
      };

      "#scrollbar" = {
        width = 2;
        border = 0;
        handle-width = 8;
        padding = 0;
      };

      "#sidebar" = {
        border = mkLiteral "2px dash 0px 0px";
        border-color = mkLiteral "@separatorcolor";
      };

      "#button.selected" = {
        background-color = mkLiteral "@selected-background";
        text-color = mkLiteral "@foreground";
      };

      "#inputbar" = {
        spacing = 0;
        text-color = mkLiteral "@foreground";
        padding = 1;
      };

      "#case-indicator" = {
        spacing = 0;
        text-color = mkLiteral "@foreground";
      };

      "#entry" = {
        spacing = 0;
        text-color = mkLiteral "@foreground";
      };

      "#prompt" = {
        spacing = 0;
        text-color = mkLiteral "@foreground";
      };

      "#inputbar" = {
        children = mkLiteral "[ prompt,textbox-prompt-colon,entry,case-indicator ]";
      };

      "#textbox-prompt-colon" = {
        expand = false;
        str = ">";
        margin = mkLiteral "0px 0.3em 0em 0em";
        text-color = mkLiteral "@foreground";
      };

      "element-text, element-icon" = {
        background-color = mkLiteral "inherit";
        text-color = mkLiteral "inherit";
      };
    };
  };
}
