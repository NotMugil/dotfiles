{ pkgs, lib, ... }:

{
  environment.systemPackages = with pkgs; [
    wget
    zsh
    oh-my-zsh
    zsh-syntax-highlighting
    eza
    zsh-autosuggestions
    git
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
