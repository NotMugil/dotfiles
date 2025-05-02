{ pkgs, ... }:

rec {
  # GNOME User-level Packages
  home.packages = with pkgs.gnomeExtensions; [
    appindicator
    blur-my-shell
    bluetooth-quick-connect
    caffeine
    date-menu-formatter
    gamemode-indicator-in-system-settings
    gsconnect
    gtk4-desktop-icons-ng-ding
    pano
    pip-on-top
    privacy-settings-menu
    removable-drive-menu
    rounded-window-corners-reborn
    user-avatar-in-quick-settings
    user-themes
    dash-to-panel
  ];

  # GNOME DConf Settings
  dconf.settings = {
    # Shell settings
    "org/gnome/shell" = {
      disable-user-extensions = false;
      disabled-extensions = "disabled";
      enabled-extensions = (map (extension: extension.extensionUuid) home.packages) ++ [];
      favorite-apps = [
        "firefox.desktop"
        "com.mitchellh.ghostty.desktop"
        "youtube-music.desktop"
        "org.gnome.Nautilus.desktop"
      ];
    };

    # GNOME Tweaks Appearance settings
    "org/gnome/desktop/interface" = {
      icon-theme = "Adwaita";
      cursor-theme = "Banana";
      gtk-theme = "adw-gtk3";
      color-scheme = "prefer-dark";
    };

    # GNOME Shell Theme settings
    "org/gnome/shell/extensions/user-theme".name = "Marble-gray-dark";

    # Blur My Shell settings
    "org/gnome/shell/extensions/blur-my-shell/applications" = {
      sigma = 20;
      brightness = "0.80";
      blur = true;
      blur-on-overview = true;
      enable-all = false;
      opacity = 225;
      dynamic-opacity = false;
    };

    # Pano Clipboard Manager settings
    "org/gnome/shell/extensions/pano" = {
      global-shortcut = ["<Super>comma"];
      incognito-shortcut = ["<Shift><Super>less"];
    };

    # GTK4 Desktop Icons NG settings
    "org/gnome/shell/extensions/gtk4-ding" = {
      icon-size = "tiny";
      show-volumes = true;
      add-volumes-opposite = true;
    };

    # Dash to Panel settings
    "org/gnome/shell/extensions/dash-to-panel" = {
      window-preview-fixed-x = true;
      window-preview-fixed-y = true;
      preview-custom-opacity = 90;
      window-preview-size = 130;
      appicon-padding = 6;
      appicon-margin = 2;
      show-tooltip = false;
      show-showdesktop-hover = true;
      dot-style-unfocused = "DOTS";
      dot-style-focused = "DOTS";
      trans-use-custom-opacity = true;
      trans-panel-opacity = "0.15";
      panel-sizes = "{ \"BOE-0x00000000\": 32 }";
      showdesktop-button-width = "6";
      show-apps-icon-file = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake-white.svg";
    };


    # Mutter settings
    "org/gnome/mutter" = {
      workspaces-only-on-primary = false;
    };

    # Control Center settings
    "org/gnome/control-center" = {
      last-panel = "display";
    };

    # Window Manager Keybindings
    "org/gnome/desktop/wm/keybindings" = {
      # Window management
      close = ["<Super>q"];
      toggle-maximized = ["<Super>f"];
      toggle-fullscreen = ["<Shift><Super>f"];

      # Workspace management
      switch-to-workspace-1 = ["<Super>1"];
      switch-to-workspace-2 = ["<Super>2"];
      switch-to-workspace-3 = ["<Super>3"];
      switch-to-workspace-4 = ["<Super>4"];
      move-to-workspace-1 = ["<Shift><Super>1"];
      move-to-workspace-2 = ["<Shift><Super>2"];
      move-to-workspace-3 = ["<Shift><Super>3"];
      move-to-workspace-4 = ["<Shift><Super>4"];
    };

    # Custom Keybindings
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      binding = "<Super>Return";
      command = "ghostty";
      name = "open-terminal";
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
      binding = "<Super>e";
      command = "nautilus";
      name = "open-nautilus";
    };
  };
}
