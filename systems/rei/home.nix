
{ username, lib, ... }:

{
  home.username = "rei";
  home.homeDirectory = "/home/rei";

  home.stateVersion = "24.11";

  programs.home-manager.enable = true;

  imports = [
    ../../home/rei
  ];
}
