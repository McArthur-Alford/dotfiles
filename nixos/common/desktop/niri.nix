{
  inputs,
  system,
  username,
  pkgs,
  ...
}:
{
  imports = [
    inputs.niri.nixosModules.niri
  ];

  nixpkgs.overlays = [ inputs.niri.overlays.niri ];
  programs.niri.package = pkgs.niri-unstable;
  programs.niri.enable = true;

  services = {
    fprintd.enable = true;
    greetd = {
      enable = true;
      settings = rec {
        initial_session = {
          command = "${pkgs.niri-unstable}/bin/niri-session";
          user = "${username}";
        };
        default_session = initial_session;
      };
    };
  };
}
