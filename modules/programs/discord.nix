{ pkgs, discordHash, ... }:
{
  environment.systemPackages = with pkgs; [ discord ];
  nixpkgs.overlays = [							# Keeps discord up to date
    (self: super: {
      discord = super.discord.overrideAttrs (
        _: { 
          src = builtins.fetchTarball {
      	  url = "https://discord.com/api/download?platform=linux&format=tar.gz";
      	  sha256 = discordHash;
        };}
      );
    })
  ];
}