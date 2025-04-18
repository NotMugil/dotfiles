{ ... }:

{
  dconf.settings = {

    # GNOME tweaks appearence
    "org/gnome/desktop/interface" = {
      icon-theme = "Adwaita";
      cursor-theme = "Banana";
      gtk-theme = "adw-gtk3";
      color-scheme = "prefer-dark";
    };

    # GNOME shell theme
    "org/gnome/shell/extensions/user-theme".name = "Marble-gray-dark";

    "org/gnome/mutter" = {
      workspaces-only-on-primary = false;
    };

    "org/gnome/control-center" = {
      last-panel = "display";
    };
  };
}
