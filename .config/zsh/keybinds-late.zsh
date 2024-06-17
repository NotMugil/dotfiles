#!/usr/bin/env zsh

# Bind keys for history substring search

# This is here instead of keybinds.zsh due to some ordering issues
bindkey '^[[A' history-substring-search-up
bindkey '^[OA' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey '^[OB' history-substring-search-down
