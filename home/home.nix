{ username, lib, ... }:

{
  home.username = "${username}";
  home.homeDirectory = "/home/${username}";

  home.stateVersion = "24.11";

  programs.home-manager.enable = true;

  imports = [
    ./desktop/gnome.nix
    ./desktop/hyprland.nix
    ./programs/ghostty.nix
  ];
}
