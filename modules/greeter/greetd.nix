{ ... }:
{
  systemd.services.greetd = {
    serviceConfig.Type = "idle";
    unitConfig.After = [ "docker.service" ];
  };

  services = {
    greetd = {
      enable = true;
    };
  };
}
