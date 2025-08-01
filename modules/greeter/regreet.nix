{ pkgs, self, ... }:
{
  imports = [
    "${self}/modules/greeter/greetd.nix"
  ];
  programs.regreet.enable = true;
  services.greetd.settings = {
    default_session = {
      command = "${pkgs.cage}/bin/cage -s -- ${pkgs.greetd.regreet}/bin/regreet";
      user = "greeter";
    };
  };
}
