{
  inputs,
  ...
}:
{
  imports = [ inputs.lan-mouse.homeManagerModules.default ];

  programs.lan-mouse = {
    enable = true;

    settings = {
      release_bind = [
        "KeyZ"
      ];
      top = {
        hostname = "thaumaturge.local";
        # ips = [ "thaumaturge.local" ];
        activate_on_startup = true;
      };
      bottom = {
        hostname = "mosaic";
        # ips = [ "mosaic.local" ];
        activate_on_startup = true;
      };
    };
  };
}
