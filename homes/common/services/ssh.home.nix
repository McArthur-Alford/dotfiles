{ pkgs, ... }:
{
  programs.ssh = {
    enable = true;
    matchBlocks = {
      benefactor = {
        host = "benefactor.thaumaturgy.tech";
        proxyCommand = "${pkgs.cloudflared}/bin/cloudflared access ssh --hostname %h";
      };
      mosaic = {
        host = "mosaic.thaumaturgy.tech";
        proxyCommand = "${pkgs.cloudflared}/bin/cloudflared access ssh --hostname %h";
      };
      thaumaturge = {
        host = "thaumaturge.thaumaturgy.tech";
        proxyCommand = "${pkgs.cloudflared}/bin/cloudflared access ssh --hostname %h";
      };
    };
  };
}
