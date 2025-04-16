{ username, pkgs, ... }: 

rec {
  home.packages = with pkgs.gnomeExtensions; [
    appindicator
    blur-my-shell
    bluetooth-quick-connect
    caffeine
    coverflow-alt-tab
    date-menu-formatter
    panel-corners
    pano
    rounded-window-corners-reborn
    user-themes
    # window-title-is-back
    dash-to-panel
  ];
  
  dconf.settings = {
    "org/gnome/shell" = {
      disable-user-extensions = false;
      disabled-extensions = "disabled";
      enabled-extensions = (map (extension: extension.extensionUuid) home.packages) ++ [];
      favorite-apps = ["firefox.desktop" "org.gnome.Console.desktop" "youtube-music.desktop" "org.gnome.Nautilus.desktop" ];
    };

    # Keybindings
    "org/gnome/desktop/wm/keybindings" = {
      close = ["<Super>q"];
      switch-to-workspace-1 = ["<Super>1"];
      switch-to-workspace-2 = ["<Super>2"];
      switch-to-workspace-3 = ["<Super>3"];
      switch-to-workspace-4 = ["<Super>4"];
      move-to-workspace-1 = ["<Shift><Super>1"];
      move-to-workspace-2 = ["<Shift><Super>2"];
      move-to-workspace-3 = ["<Shift><Super>3"];
      move-to-workspace-4 = ["<Shift><Super>4"];
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = { 
        binding = "<Super>Return";
	command = "ghostty";
	name = "open-terminal";
    };

    # Extensions
    "org/gnome/shell/extensions/user-theme" = {
      name = "Marble-gray-dark";
    };

    "org/gnome/shell/extensions/blur-my-shell/applications" = {
      sigma = 20;
      brightness = "0.80";
      blur = true;
      blur-on-overview = true;
      enable-all = true;
      opacity = 225;
      dynamic-opacity = false;
    };

    "org/gnome/shell/extensions/dash-to-panel" = {
      window-preview-fixed-x = true;
      window-preview-fixed-y = true;
      preview-custom-opacity = 90;
      window-preview-size = 130;
      appicon-padding = 6;
      appicon-margin = 2;
      show-tooltip = false;
      dot-style-unfocused = "DOTS";
      dot-style-focused = "DOTS";
      trans-use-custom-opacity = true;
      trans-panel-opacity = "0.15";
      panel-sizes = "{ \"BOE-0x00000000\": 32 }";
    };



  };

}
