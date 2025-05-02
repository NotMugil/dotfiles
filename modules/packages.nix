{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [

    # essential
    vim
    wget
    curl
    git

    # terminal
    eza
    tree

    # graphical
    firefox
    mpv
    qbittorrent

    whatsapp-for-linux
    youtube-music
    zed-editor

    # dev
    nodejs_23
    gcc
    go
    gnumake
  ];
}
