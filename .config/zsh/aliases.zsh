#!/usr/bin/env zsh

# Basic aliases
alias c='clear' # Clear terminal
alias x='exit' # Close terminal or Exit
alias e='$fileManager .' # Open current directory in filemanger
alias h='history -10' # Show last 10 history commands
alias hc='history -c' # Clear history
alias hg="history | grep " # +command
alias cp='cp -rv'   # Recursive and verbose `cp`
alias rm='rm -rIv'   # Recursive, interactive, and verbose `rm`
alias mv='mv -v'    # Verbose `mv`
alias mkdir='mkdir -p'  # recursive mkdir

# alias grep='rg' # use ripgrep
# alias cat='bat'

# `eza` alias for displaying directory trees
alias tree='eza --icons --tree'

# Quality of life commands
alias mkcd='function _mkcd() { mkdir -p "$1" && cd "$1"; }; _mkcd'

# Git aliases
alias g='git'
alias ga='git add'
alias gaa='git add --all'
alias gb='git branch'
alias gc='git commit --verbose'
alias gcam='git commit --all --message'
alias gd='git diff'
alias gp='git push'

# Misc aliases
alias updates='yay -Qu'  # Check system and AUR updates
alias wget=wget --hsts-file="$XDG_DATA_HOME/wget-hsts"
