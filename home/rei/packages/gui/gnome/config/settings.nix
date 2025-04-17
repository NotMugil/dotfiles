{ ... }:

{
  dconf.settings = {
    # blur my shell
    "org/gnome/shell/extensions/blur-my-shell/applications" = {
      sigma = 20;
      brightness = "0.80";
      blur = true;
      blur-on-overview = true;
      enable-all = true;
      opacity = 225;
      dynamic-opacity = false;
    };

    # pano clipboard manager
    "org/gnome/shell/extensions/pano" = {
      global-shortcut = ["<Super>comma"];
      incognito-shortcut = ["<Shift><Super>less"];
    };

    # gtk4 desktop icons ng
    "org/gnome/shell/extensions/gtk4-ding" = {
      icon-size = "tiny";
      show-volumes = true;
      add-volumes-opposite = true;
    };

    # dash to panel
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
    };

    # coverflow alt tab
    "org/gnome/shell/extensions/coverflowalttab" = {
      current-workspace-only = "all";
    };
  };
}
