{ pkgs, ... }:

{
  home.programs = with pkgs; [ 
    kitty
  ];
}
