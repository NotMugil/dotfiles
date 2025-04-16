{ username, pkgs, ... }: 

{
  home.packages = with pkgs.gnomeExtensions; [
    appindicator
    blur-my-shell
    user-themes
    window-title-is-back
  ];
  
  dconf.settings = {
    "org/gnome/shell" = {
      disable-user-extensions = false;
      disabled-extensions = "disabled";
      enabled-extensions = with pkgs.gnomeExtensions; [
        blur-my-shell.extensionUuid
	user-themes.extensionUuid
	appindicator.extensionUuid
      ];
    };

    "org/gnome/shell/extensions/user-theme" = {
      name = "Marble-gray-dark";
    };

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
  };

}
