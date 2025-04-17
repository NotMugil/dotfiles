{ pkgs, ... }:

rec {
  home.packages = with pkgs.gnomeExtensions; [
    appindicator
    blur-my-shell
    bluetooth-quick-connect
    caffeine
   # coverflow-alt-tab
    date-menu-formatter
   # eye-on-cursor
    gamemode-indicator-in-system-settings
    gsconnect
    gtk4-desktop-icons-ng-ding
    pano
    privacy-settings-menu
    removable-drive-menu
    rounded-window-corners-reborn
   # super-key
   # switch-workspace
    user-avatar-in-quick-settings
    user-themes
   # quick-settings-audio-panel
   # window-title-is-back
    dash-to-panel
  ];

  dconf.settings = {
    "org/gnome/shell" = {
      disable-user-extensions = false;
      disabled-extensions = "disabled";
      enabled-extensions = (map (extension: extension.extensionUuid) home.packages) ++ [];
      favorite-apps = ["firefox.desktop" "com.mitchellh.ghostty.desktop" "youtube-music.desktop" "org.gnome.Nautilus.desktop" ];
    };
  };
}
