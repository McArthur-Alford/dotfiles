{ pkgs, ... }:
{
  programs.ssh = {
    enable = true;
    matchBlocks = {
      benefactor = {
        host = "benefactor";
        hostname = "benefactor.thaumaturgy.tech";
        proxyCommand = "${pkgs.cloudflared}/bin/cloudflared access ssh --hostname %h";
      };
      benefactor-2 = {
        host = "benefactor.thaumaturgy.tech";
        hostname = "benefactor.thaumaturgy.tech";
        proxyCommand = "${pkgs.cloudflared}/bin/cloudflared access ssh --hostname %h";
      };
      mosaic = {
        host = "mosaic";
        hostname = "mosaic.thaumaturgy.tech";
        # proxyCommand = "${pkgs.cloudflared}/bin/cloudflared access ssh --hostname %h";
      };
      thaumaturge = {
        host = "thaumaturge";
        hostname = "thaumaturge.thaumaturgy.tech";
        # proxyCommand = "${pkgs.cloudflared}/bin/cloudflared access ssh --hostname %h";
      };
    };
  };
}
