{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [ discord ];
  nixpkgs.overlays = [							# Keeps discord up to date
    (self: super: {
      discord = super.discord.overrideAttrs (
        _: { 
          src = builtins.fetchTarball {
      	  url = "https://discord.com/api/download?platform=linux&format=tar.gz";
      	  sha256 = "0mr1az32rcfdnqh61jq7jil6ki1dpg7bdld88y2jjfl2bk14vq4s";
        };}
      );
    })
  ];
}