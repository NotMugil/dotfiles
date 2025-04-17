{ lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    hello
    firefox
    qbittorrent
    zed-editor
    gnome-tweaks
    ghostty
    marble-shell-theme
    youtube-music
    vesktop
    whatsapp-for-linux
    banana-cursor
  ];
}
