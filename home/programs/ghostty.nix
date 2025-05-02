{ pkgs, ... }:

{
  home.packages = with pkgs; [
    ghostty
  ];

  programs.ghostty = {
    enable = true;
    enableZshIntegration = true;

    themes = {
      ## name: evergarden fall green
      ## author: comfysage
      ## license: GPL-3.0
      ## blurb: a comfy colorscheme for cozy morning coding
      evergarden = {
        foreground = "dddecf";
        background = "232a2e";
 	      cursor-color = "bcd19c";
        cursor-text = "171c1f";
        palette = [
          "0=#232a2e"
          "1=#e67e80"
          "2=#bcd19c"
          "3=#e1c182"
          "4=#9bb5cf"
          "5=#ebb9dd"
          "6=#a1cfad"
          "7=#dddecf"
          "8=#313b40"
          "9=#e67e80"
          "10=#bcd19c"
          "11=#e1c182"
          "12=#9bb5cf"
          "13=#ebb9dd"
          "14=#a1cfad"
          "15=#96b4aa"
        ];
        selection-background = "3d494d";
        selection-foreground = "dddecf";
      };
    };

    settings = {
      theme = "evergarden";
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
        "super+t=new_tab"
        "super+d=close_window"
     ];
    };
   };
}
