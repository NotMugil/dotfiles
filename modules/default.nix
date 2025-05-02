{ lib, ... }:

{
  imports = [
    ./applications/gaming.nix
    ./desktop/gnome.nix
    ./desktop/hyprland.nix
    ./packages.nix
    ./shell.nix
    ./nix.nix
    ./services.nix
  ];
}
