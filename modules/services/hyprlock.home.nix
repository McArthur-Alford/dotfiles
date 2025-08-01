{ ... }:
{
  programs.hyprlock = {
    enable = true;
    sourceFirst = true;
    settings = {
      general = {
        disable_loading_bar = false;
        grace = 0;
        no_fade_in = false;
      };

      background = [
        {
          monitor = "";
          # path = "~/.config/hypr/hyprlock.png";
          path = "screenshot";
          blur_passes = 3;
          contrast = 0.8916;
          brightness = 0.8172;
          vibrancy = 0.1696;
          vibrancy_darkness = 0.0;
        }
      ];

      image = [
        {
          monitor = "";
          path = "~/.config/hypr/vivek.png";
          border_size = 2;
          border_color = "rgba(255, 255, 255, 0)";
          size = 130;
          rounding = -1;
          rotate = 0;
          reload_time = -1;
          reload_cmd = "";
          position = "0, 40";
          halign = "center";
          valign = "center";
        }
      ];

      label = [
        {
          monitor = "";
          text = ''cmd[update:1000] echo -e "$(date +"%A, %B %d")"'';
          color = "rgba(216, 222, 233, 0.70)";
          font_size = 25;
          font_family = "SF Pro Display Bold";
          position = "0, 350";
          halign = "center";
          valign = "center";
        }
        {
          monitor = "";
          text = ''cmd[update:1000] echo "<span>$(date +"%I:%M")</span>"'';
          color = "rgba(216, 222, 233, 0.70)";
          font_size = 120;
          font_family = "SF Pro Display Bold";
          position = "0, 250";
          halign = "center";
          valign = "center";
        }
        {
          monitor = "";
          text = ''cmd[update:1000] echo "$(~/.config/hypr/Scripts/songdetail.sh)"'';
          color = "rgba(255, 255, 255, 0.6)";
          font_size = 18;
          font_family = "JetBrains Mono Nerd, SF Pro Display Bold";
          position = "0, 50";
          halign = "center";
          valign = "bottom";
        }
        {
          monitor = "";
          text = "    $USER";
          color = "rgba(216, 222, 233, 0.80)";
          outline_thickness = 2;
          dots_size = 0.2;
          dots_spacing = 0.2;
          dots_center = true;
          font_size = 18;
          font_family = "SF Pro Display Bold";
          position = "0, -130";
          halign = "center";
          valign = "center";
        }
      ];

      shape = [
        {
          monitor = "";
          size = "300, 60";
          color = "rgba(255, 255, 255, 0.1)";
          rounding = -1;
          border_size = 0;
          border_color = "rgba(253, 198, 135, 0)";
          rotate = 0;
          xray = false;
          position = "0, -130";
          halign = "center";
          valign = "center";
        }
      ];

      input-field = [
        {
          monitor = "";
          size = "300, 60";
          outline_thickness = 2;
          dots_size = 0.2;
          dots_spacing = 0.2;
          dots_center = true;
          outer_color = "rgba(0, 0, 0, 0)";
          inner_color = "rgba(255, 255, 255, 0.1)";
          font_color = "rgb(200, 200, 200)";
          fade_on_empty = false;
          font_family = "SF Pro Display Bold";
          placeholder_text = ''<i><span foreground="##ffffff99">🔒 Enter Pass</span></i>'';
          hide_input = false;
          position = "0, -210";
          halign = "center";
          valign = "center";
        }
      ];
    };
  };
}
