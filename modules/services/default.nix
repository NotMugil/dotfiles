{ lib, ... }:

{
  imports = [
    ./firewall.nix
    ./printing.nix
    ./sound.nix
    ./zsh.nix
    ./ssh.nix
    ./user.nix
    ./x11.nix
  ];
}
