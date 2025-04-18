{ config, lib, pkgs, ... }:

{
  programs.ghostty = {
    enable = true;
    enableZshIntegration = true;
    
    settings = {
      theme = "Everblush";
      font-size = 11;
      keybind = [
        "ctrl+h=goto_split:left"
        "ctrl+l=goto_split:right"
     ];
    };
   };
}
