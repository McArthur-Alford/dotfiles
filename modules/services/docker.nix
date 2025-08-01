{ ... }:
{
  virtualisation.docker.enable = true;
  virtualisation.docker.daemon.settings.live-restore = false;

  networking.extraHosts = ''
    127.0.0.1   host.docker.internal
  '';
}
