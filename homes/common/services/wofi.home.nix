{ config, lib, pkgs, host, user, ...}:

{
  programs.wofi = {
    enable = true;

    settings = {
      show="drun";
      prompt="Apps";
      normal_window=false;
      layer="top";
      columns=4;
      width="50%";
      height="50%";
      location=0;
      orientation="vertical";
      halign="fill";
      line_wrap="off";
      dynamic_lines=false;
      allow_markup=true;
      allow_images=true;
      image_size=32;
      exec_search=false;
      hide_search=false;
      parse_search=false;
      insensitive=false;
      hide_scroll=true;
      no_actions=true;
      sort_order="alphabetical";
      gtk_dark=true;
      filter_rate=100;
      key_expand="Tab";
      key_exit="Escape";
    };

    # Simpler menu with one column!
    # settings = {
    #   width=600;
    #   height=300;
    #   location="center";
    #   show="drun";
    #   prompt="Search...";
    #   filter_rate=100;
    #   allow_markup=true;
    #   no_actions=true;
    #   halign="fill";
    #   orientation="vertical";
    #   content_halign="fill";
    #   insensitive=true;
    #   allow_images=true;
    #   image_size=40;
    #   gtk_dark=true;
    #   dynamic_lines=true;
    # };

    style = ''
      /* Restyled CSS for Dracula Theme */

      window {
          margin: 0px;
          border: 5px solid #44475a; /* Dracula current line for border */
          background-color: #282a36; /* Dracula background */
          border-radius: 0px;
      }

      #input {
          padding: 4px;
          margin: 4px;
          padding-left: 20px;
          border: none;
          color: #f8f8f2; /* Dracula foreground for text */
          font-weight: bold;
          background-color: #44475a; /* Dracula current line for input background */
          outline: none;
          border-radius: 15px;
          margin: 10px;
          margin-bottom: 2px;
      }
      #input:focus {
          border: 0px solid #44475a;
          margin-bottom: 0px;
      }

      #inner-box {
          margin: 4px;
          border: 10px solid #44475a; /* Dracula current line for border */
          color: #f8f8f2; /* Dracula foreground for text */
          font-weight: bold;
          background-color: #282a36; /* Dracula background */
          border-radius: 15px;
      }

      #outer-box {
          margin: 0px;
          border: none;
          border-radius: 15px;
          background-color: #282a36; /* Dracula background */
      }

      #scroll {
          margin-top: 5px;
          border: none;
          border-radius: 15px;
          margin-bottom: 5px;
          /* background: rgb(255,255,255); */
      }

      #img:selected {
          background-color: #6272a4; /* Dracula comment for selected image background */
          border-radius: 15px;
      }

      #text:selected {
          color: #f8f8f2; /* Dracula foreground for selected text */
          margin: 0px 0px;
          border: none;
          border-radius: 15px;
          background-color: #6272a4; /* Dracula comment for selected text background */
      }

      #entry {
          margin: 0px 0px;
          border: none;
          border-radius: 15px;
          background-color: transparent;
      }

      #entry:selected {
          margin: 0px 0px;
          border: none;
          border-radius: 15px;
          background-color: #6272a4; /* Dracula comment for selected entry background */
      }
    '';
  };
}
