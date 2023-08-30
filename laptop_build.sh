sudo nixos-rebuild switch --flake .#laptop
hyprctl reload
nix-shell -p neofetch --run neofetch
