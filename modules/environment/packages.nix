{ pkgs, lib, ... }:

{
  environment.systemPackages = with pkgs; [
    wget
    zsh
    oh-my-zsh
    zsh-syntax-highlighting
    zsh-history-substring-search
    eza
    zsh-autosuggestions
    git
    niri
    gnumake
    nodejs_23
    home-manager
    adw-gtk3
    amberol
    nautilus
    file-roller
    eyedropper
    celluloid
  ];
}
