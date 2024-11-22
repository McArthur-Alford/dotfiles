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
      mosaic = {
        host = "mosaic";
        hostname = "mosaic.local";
        proxyJump = "benefactor";
      };
      thaumaturge = {
        host = "thaumaturge";
        hostname = "thaumaturge.local";
        proxyJump = "benefactor";
      };
      moss = {
        hostname = "moss.labs.eait.uq.edu.au";
        user = "s4696730";
      };
      lichen = {
        hostname = "lichen.labs.eait.uq.edu.au";
        user = "s4696730";
      };
      comp3301-control = {
        host = "comp3301-control";
        user = "control";
        hostname = "comp3301-vm1.eait.uq.edu.au";
        proxyJump = "moss";
      };
      comp3301-vm = {
        host = "comp3301-vm";
        user = "s4696730";
        hostname = "10.138.64.131";
        proxyJump = "moss";
      };
      getafix = {
        host = "getafix";
        user = "s4696730";
        hostname = "getafix.smp.uq.edu.au";
        proxyJump = "moss";
      };
      rangpur = {
        host = "rangpur";
        user = "s4696730";
        hostname = "rangpur";
        proxyJump = "moss";
      };
    };
  };
}
