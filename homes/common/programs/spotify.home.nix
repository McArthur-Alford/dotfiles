{
  pkgs,
  inputs,
  system,
  ...
}:
let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${system};
in
{
  imports = [ inputs.spicetify-nix.homeManagerModules.default ];

  # home.packages = with pkgs; [ spotify ];

  programs.spicetify = {
    enable = true;
    # theme = spicePkgs.themes.catppuccin;
    # colorScheme = "dracula";

    # theme = {
    #   name = "frostify";
    #   src = pkgs.fetchFromGitHub {
    #     owner = "KooshaPari";
    #     repo = "Frostify";
    #     rev = "9906ed37a2b6e66d8288f3b9bdb164996c662726";
    #     hash = "sha256-taylypmqUpEpnayRLVsvUjISjhtbzpX243d+AuhHA2k=";
    #   };
    #   injectCss = true;
    #   injectThemeJs = true;
    #   replaceColors = false;
    #   sidebarConfig = true;
    #   homeConfig = true;
    #   overwriteAssets = false;
    #   # injectCss = true;
    #   # replaceColors = true;
    #   # overwriteAssets = true;
    #   # sidebarConfig = true;
    # };

    # enabledExtensions = with spicePkgs.extensions; [
    #   # fullAppDisplay
    #   # shuffle
    #   # hidePodcasts
    # ];
    # enabledCustomApps = with spicePkgs.apps; [ new-releases ];

    # official dracula:
    # theme = spicePkgs.themes.Dracula;

    # custom dracula:
    colorScheme = "custom";
    customColorScheme = {
      text = "f8f8f2";
      subtext = "f8f8f2";
      main = "282a36";
      sidebar = "44475a";
      player = "44475a";
      card = "313244";
      shadow = "181825";
      selected-row = "585B70";
      button = "50fa7b";
      button-active = "50fa7b";
      button-disabled = "6272a4";
      tab-active = "313244";
      notification = "313244";
      notification-error = "F28FAD";
      equalizer = "B4BEFE";
      misc = "585B70";
    };
  };

}
