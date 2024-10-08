{
  inputs,
  hostname,
  ...
}:
{
  imports = [ inputs.lan-mouse.homeManagerModules.default ];

  programs.lan-mouse = {
    enable = true;

    settings =
      {
        release_bind = [
          "KeyZ"
        ];
      }
      // (
        if hostname == "thaumaturge" then
          {
            bottom = {
              hostname = "mosaic";
              # ips = [ "mosaic.local" ];
              activate_on_startup = true;
            };
          }
        else if hostname == "mosaic" then
          {
            top = {
              hostname = "thaumaturge";
              # ips = [ "thaumaturge.local" ];
              activate_on_startup = true;
            };
          }
        else
          { }
      );
  };
}
