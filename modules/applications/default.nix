{ lib, ... }:

{
  imports = [
    ./firefox.nix
    ./nix.nix
    ./gaming.nix
  ];
}
