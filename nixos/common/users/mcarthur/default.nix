{username, ...}:
{
  users.users.${username} = {
    openssh.authorizedKeys.keyFiles = [
      ../sshKeys/desktop.pub
      ../sshKeys/laptop.pub
      ../sshKeys/server.pub
    ];
    isNormalUser = true;
    description = "${username}";
    extraGroups = [ "networkmanager" "libvirtd" "wheel" "audio" "corectrl" ];
  };
}
