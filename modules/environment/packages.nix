{ pkgs, lib, ... }:

{
  environment.systemPackages = with pkgs; [
    wget
    git
    zsh
    gnumake
    home-manager
    adw-gtk3
    amberol
    nautilus
    file-roller
    eyedropper
    celluloid
  ];
}
