{ lib, ... }:

{
  imports = [
    ./firewall.nix
    ./printing.nix
    ./sound.nix
    ./ssh.nix
    ./user.nix
    ./x11.nix
  ];
}
