{ pkgs, lib, username, ... }:

{
  environment.systemPackages = with pkgs; [
    zsh
    oh-my-zsh
    zsh-syntax-highlighting
    zsh-history-substring-search
    zsh-autosuggestions
  ];

  # set zsh as default shell
  users.users.${username}.shell = pkgs.zsh;

  # Prevent the new user dialog in zsh
  system.userActivationScripts.zshrc = "touch .zshrc";

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

    interactiveShellInit = ''
     # plugins=(git zsh-history-substring-search)

      PROMPT='%F{yellow}%3~%f $ '

      export HISTSIZE=10000
      export SAVEHIST=10000

      # Define key bindings
      # Use "bindkey -l" to list available key bindings
      # Use "bindkey -M viins" to list key bindings for insert mode
      # Use "bindkey -M vicmd" to list key bindings for command mode

      # Move cursor to beginning and end of line
      bindkey "\e[5~" beginning-of-line # Page Up
      bindkey "\e[6~" end-of-line # Page Down

      # Delete characters and words
      bindkey "^[[3~" delete-char # DEL
      bindkey '^H' backward-kill-word # Ctrl+Backspace (delete word backwards)
      bindkey '^[[3;5~' kill-word # Ctrl+Delete (delete word forwards)

      # Move cursor forward and backward one word at a time
      bindkey "^[[1;5C" forward-word # CTRL+ARROW_RIGHT
      bindkey "^[[1;5D" backward-word # CTRL+ARROW_LEFT

      # Undo and redo changes
      bindkey "^Z" undo # CTRL+Z
      bindkey "^Y" redo # CTRL+Y

      # Allow backspace to delete characters across multiple lines like in Vim
      bindkey -v '^?' backward-delete-char

      # Bind keys for history substring search
      bindkey '^[[A' history-substring-search-up
      bindkey '^[OA' history-substring-search-up
      bindkey '^[[B' history-substring-search-down
      bindkey '^[OB' history-substring-search-down

    '';

    ohMyZsh.enable = true;
  };
}
