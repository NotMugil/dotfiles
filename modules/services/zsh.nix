{ pkgs, lib, ... }:

{
  programs.zsh = {
    enable = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      # quality of life aliases
      c = "clear";
      x = "exit";
      h = "history -10"; # show last 10 commands
      hc = "history -c"; # clear history
      hg = "history | grep"; # +command
      cp = "cp -rv"; # recursive and verbose
      rm = "rm -rIv"; # recursive, interactive, and verbose `rm`
      mv = "mv -v"; # verbose
      mkdir = "mkdir -p"; # recursive mkdir
#      mkcd = "function _mkcd() { mkdir -p "$1" && cd "$1"; }; _mkcd";

      # eza aliases
      ll = "eza --icons -lah --group-directories-first"; # list permissions
      la = "eza --icons -a --group-directories-first"; # list all dir and files including hidden
      ls = "eza --icons --group-directories-first"; # list all (not hidden)

      # git aliases
      g = "git";
      ga = "git add";
      gaa = "git add --all";
      gb = "git branch";
      gc = "git commit --verbose";
      gcam = "git commit --all --message";
      gd = "git diff";
      gp = "git push";
    };
  };
}
