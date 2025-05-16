{ lib, pkgs, ... }:

{
  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Enable the GNOME Browser Connector for gnome extensions
  services.gnome.gnome-browser-connector.enable = true;

  # Disable GNOME core utilities
  services.gnome.core-utilities.enable = false;

  environment.gnome.excludePackages = with pkgs; [
    pkgs.gnome-tour
  ];

  # GNOME System-level Packages
  environment.systemPackages = with pkgs; [
    adw-gtk3
    gnome-tweaks
    amberol
    nautilus
    file-roller
    evince
    eyedropper
    celluloid
    marble-shell-theme
    banana-cursor
  ];
}
