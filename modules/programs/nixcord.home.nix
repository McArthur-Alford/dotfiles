{ inputs, pkgs, ... }:
{
  imports = [
    inputs.nixcord.homeModules.nixcord
    # inputs.nixcord.homeManagerModules.nixcord
  ];

  # programs.nixcord = {
  #   discord.vencord.package = pkgs.vencord;
  #   enable = true; # enable Nixcord. Also installs discord package

  #   # quickCss = "some CSS";  # quickCSS file
  #   config = {
  #     # useQuickCss = true; # use out quickCSS
  #     # themeLinks = [        # or use an online theme
  #     # "https://raw.githubusercontent.com/link/to/some/theme.css"
  #     # ];
  #     frameless = true;
  #     # plugins = {
  #     #   hideAttachments.enable = true;    # Enable a Vencord plugin
  #     #   ignoreActivities = {    # Enable a plugin and set some options
  #     #     enable = true;
  #     #     ignorePlaying = true;
  #     #     ignoreWatching = true;
  #     #     ignoredActivities = [ "someActivity" ];
  #     #   };
  #     # };
  #   };
  #   extraConfig =
  #     {
  #     };
  # };
  programs.nixcord = {
    enable = true;
    vesktop = {
      enable = true;
      package = pkgs.vesktop.override { withTTS = false; };
    };
    config = {
      # rpcServer = true;
      plugins = {
        alwaysTrust = {
          enable = true;
          file = true;
        };
        anonymiseFileNames = {
          enable = true;
          anonymiseByDefault = true;
        };
        newGuildSettings = {
          enable = true;
          messages = 1;
          everyone = false;
          role = false;
        };
        alwaysAnimate.enable = true;
        betterSettings.enable = true;
        betterUploadButton.enable = true;
        clearURLs.enable = true;
        disableCallIdle.enable = true;
        favoriteEmojiFirst.enable = true;
        favoriteGifSearch.enable = true;
        fixSpotifyEmbeds.enable = true;
        fixYoutubeEmbeds.enable = true;
        noF1.enable = true;
        noMosaic.enable = true;
        noOnboardingDelay.enable = true;
        noProfileThemes.enable = true;
        # noRPC.enable = false;
        onePingPerDM.enable = true;
        plainFolderIcon.enable = true;
        stickerPaste.enable = true;
        voiceChatDoubleClick.enable = true;
        youtubeAdblock.enable = true;
      };
      themeLinks = [
        "https://raw.githubusercontent.com/rose-pine/discord/refs/heads/main/rose-pine.theme.css"
      ];
    };
    discord.enable = true;
    extraConfig.SKIP_HOST_UPDATE = true;
  };
}
