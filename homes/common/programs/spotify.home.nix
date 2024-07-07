{ pkgs, inputs, ... }:
let
  spicePkgs = inputs.spicetify-nix.packages.${pkgs.system}.default;
in
{
  imports = [ inputs.spicetify-nix.homeManagerModule ];

  home.packages = with pkgs; [
    # spotify
  ];

  programs.spicetify = {
    enable = true;

    enabledExtensions = with spicePkgs.extensions; [
      fullAppDisplay
      shuffle
      hidePodcasts
    ];
    enabledCustomApps = with spicePkgs.apps; [
      new-releases
    ];
    # custom Dribbblish theme
    # theme = spicePkgs.themes.Dracula;
    # colorScheme = "custom";
    # customColorScheme = {
    #   text = "f8f8f2";
    #   subtext = "f8f8f2";
    #   main = "282a36";
    #   sidebar = "44475a";
    #   player = "44475a";
    #   card = "313244";
    #   shadow = "181825";
    #   selected-row = "585B70";
    #   button = "50fa7b";
    #   button-active = "50fa7b";
    #   button-disabled = "6272a4";
    #   tab-active = "313244";
    #   notification = "313244";
    #   notification-error = "F28FAD";
    #   equalizer = "B4BEFE";
    #   misc = "585B70";
    # };
  };

}
