{ pkgs, ... }:

{
  home.packages = with pkgs; [
#    hyprnome
    xfce.thunar
    
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
 	exec-once = [

	];


	"$mod" = "SUPER";
	"$terminal" = "kitty -o allow_remote_control=yes";
	"$browser" = "firefox";
	"$fileManager" = "thunar";
	"$menu" = "rofi -show drun";

        bind = [
          "$mod, RETURN, exec, $terminal"
          "$mod, E, exec, $fileManager"
          "$mod, D, exec, $menu"
	  "$mod, F, fullscreen,"
	  "$mod, Q, killactive,"
	  "$mod, V, togglefloating,"
	  "$mod, P, pseudo,"
	  "$mod, J, togglesplit,"
	  "CTRL ALT, Delete, exit,"

 	  # Workspace keybinds
	  "$mod, 1, workspace, 1"
	  "$mod, 2, workspace, 2"
	  "$mod, 3, workspace, 3"
	  "$mod, 4, workspace, 4"
	  "$mod, 5, workspace, 5"
	  "$mod, 6, workspace, 6"
	  "$mod, 7, workspace, 7"
	  "$mod, 8, workspace, 8"
	  "$mod, 9, workspace, 9"
	  "$mod, 0, workspace, 10"

	  "$mod SHIFT, 1, movetoworkspace, 1"
	  "$mod SHIFT, 2, movetoworkspace, 2"
	  "$mod SHIFT, 3, movetoworkspace, 3"
	  "$mod SHIFT, 4, movetoworkspace, 4"
	  "$mod SHIFT, 5, movetoworkspace, 5"
	  "$mod SHIFT, 6, movetoworkspace, 6"
	  "$mod SHIFT, 7, movetoworkspace, 7"
	  "$mod SHIFT, 8, movetoworkspace, 8"
	  "$mod SHIFT, 9, movetoworkspace, 9"
	  "$mod SHIFT, 0, movetoworkspace, 10"

	  "$mod Alt, 1, movetoworkspacesilent, 1"
	  "$mod Alt, 2, movetoworkspacesilent, 2"
	  "$mod Alt, 3, movetoworkspacesilent, 3"
	  "$mod Alt, 4, movetoworkspacesilent, 4"
	  "$mod Alt, 5, movetoworkspacesilent, 5"
	  "$mod Alt, 6, movetoworkspacesilent, 6"
	  "$mod Alt, 7, movetoworkspacesilent, 7"
	  "$mod Alt, 8, movetoworkspacesilent, 8"
	  "$mod Alt, 9, movetoworkspacesilent, 9"
	  "$mod Alt, 0, movetoworkspacesilent, 10"

	  "$mod ALT, left, resizeactive, -40 0"
	  "$mod ALT, right, resizeactive, 40 0"
	  "$mod ALT, up, resizeactive, 0 -40"
	  "$mod ALT, down, resizeactive, 0 40"

	  "$mod, TAB, workspace, m+1"

          "$mod, Page_Up, workspace, r-1"
          "$mod, Page_Down, workspace, r+1"

	  # Window keybinds
	  "$mod, Left, movefocus, l"
	  "$mod, Right, movefocus, r"
	  "$mod, Up, movefocus, u"
	  "$mod, Down, movefocus, d"
	  "$mod SHIFT, Left, movewindow, l"
	  "$mod SHIFT, Right, movewindow, r"
	  "$mod SHIFT, Up, movewindow, u"
	  "$mod SHIFT, Down, movewindow, d"
	  
        ];

    decoration = {
      blur = {
        enabled = true;
	size = 3;
	passes = 2;
	noise = 0.0075;
        brightness = 0.8;
        contrast = 0.8;
        vibrancy = 0.1696;
      };

      shadow = {
	enabled = false;
	range = 7;
	render_power = 3;
	color = "rgba(1e1e1eee)";
      };
      active_opacity = 1.0;
      inactive_opacity = 0.9;
      rounding = 7;
    };

    dwindle = {
      preserve_split = true;
      pseudotile = true;
    };

    general = {
      no_border_on_floating = true;
      resize_on_border = true;
      allow_tearing = false;
      layout = "dwindle";

      border_size = 2;
      "col.active_border" = "rgba(907aa9ee)";
      "col.inactive_border" = "rgba(1a1a1aee)";

      gaps_in = 3;
      gaps_out = 6;
    };

    };


  };
}
