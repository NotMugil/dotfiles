
{ config, lib, ... }:

{
  home.username = "shinji";
  home.homeDirectory = "/home/shinji";

  home.stateVersion = "24.11";

  programs.home-manager.enable = true;

  imports = [
    ../../home/shinji
  ];
}
