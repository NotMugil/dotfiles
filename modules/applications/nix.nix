{ pkgs, lib, username, ... }:

{
  nixpkgs.config.allowUnfree = true;

  # nix settings
  nix.settings.trusted-users = [username];
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # nix automatic garbage collection
  nix.gc = {
    automatic = lib.mkDefault true;
    dates = lib.mkDefault "weekly";
    options = lib.mkDefault "--delete-older-than 7d";
  };
}
