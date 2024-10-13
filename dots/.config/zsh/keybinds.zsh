#!/usr/bin/env zsh

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

# Select the Bash word style so backward-kill-word goes to last / or .
autoload -U select-word-style
select-word-style bash
