{ pkgs, user, ... }:
{
  virtualisation.docker.enable = true;
  users.users.${user}.extraGroups = [ "docker" ];

  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };
  
  environment.systemPackages = with pkgs; [
    docker
  ];
}
