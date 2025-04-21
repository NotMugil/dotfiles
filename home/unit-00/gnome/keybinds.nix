{ ... }:

{
  dconf.settings = {
    # default keybindings
    "org/gnome/desktop/wm/keybindings" = {
      # window management
      close = ["<Super>q"];
      toggle-maximized = [ "<Super>f" ];
      toggle-fullscreen = [ "<Shift><Super>f" ];

      # workspace
      switch-to-workspace-1 = ["<Super>1"];
      switch-to-workspace-2 = ["<Super>2"];
      switch-to-workspace-3 = ["<Super>3"];
      switch-to-workspace-4 = ["<Super>4"];
      move-to-workspace-1 = ["<Shift><Super>1"];
      move-to-workspace-2 = ["<Shift><Super>2"];
      move-to-workspace-3 = ["<Shift><Super>3"];
      move-to-workspace-4 = ["<Shift><Super>4"];
    };

    # custom keybindings
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
