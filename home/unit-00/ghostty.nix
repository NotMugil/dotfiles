{ config, lib, pkgs, ... }:

{
  programs.ghostty = {
    enable = true;
    enableZshIntegration = true;

    settings = {
      theme = "Everblush";
      font-size = 11;
      window-padding-x = 10;
      window-padding-y = 10;
      keybind = [
        "ctrl+j=goto_split:left"
        "ctrl+i=goto_split:up"
        "ctrl+k=goto_split:down"
        "ctrl+l=goto_split:right"
        "shift+ctrl+j=new_split:left"
        "shift+ctrl+i=new_split:up"
        "shift+ctrl+k=new_split:down"
        "shift+ctrl+l=new_split:right"
        "super+t=new_window"
	      "super+d=close_window"
     ];
    };
   };
}
