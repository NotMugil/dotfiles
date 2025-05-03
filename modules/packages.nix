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
    fzf
    ranger
    zenith
    yt-dlp
    manga-tui

    # graphical
    firefox
    miru
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
