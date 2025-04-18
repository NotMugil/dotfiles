{ pkgs, lib, ... }:

{
  programs.zsh = {
    enable = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ll = "eza --icons -lah --group-directories-first";
      la = "eza --icons -a --group-directories-first";
      ls = "eza --icons --group-directories-first";
    };

  };
}
