{ pkgs, ... }:
{
  # Note that themes are set in home manager.... sadly
  environment.systemPackages = with pkgs; [
    (discord.override {
      withVencord = true;
    })
    vesktop
  ];
}
