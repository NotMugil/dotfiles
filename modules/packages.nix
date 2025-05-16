{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [

    # essential
    vim
    wget
    curl
    git
    unzip

    # terminal
    eza
    tree 
    fzf
    ranger
    zenith
    yt-dlp
    manga-tui
    zathura

    # graphical
    firefox
    komikku
    eog
    anki-bin
    miru
    mpv
    qbittorrent
    vesktop
    whatsapp-for-linux
    youtube-music
    zed-editor

    # dev
    nodejs_23
    gcc
    go
    gnumake
    android-studio

    # misc
    fcitx5
    libimobiledevice
    ifuse
  ];
}
