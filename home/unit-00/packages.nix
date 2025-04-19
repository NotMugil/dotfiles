{ inputs, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    hello
    firefox
    qbittorrent
    zed-editor
    gnome-tweaks
    ghostty
    marble-shell-theme
    niri
    youtube-music
    vesktop
    whatsapp-for-linux
    banana-cursor
  ];
}
