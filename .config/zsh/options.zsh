#!/usr/bin/env zsh

# When trimming the internal history, discard duplicates before unique events
setopt HIST_EXPIRE_DUPS_FIRST

# Remove older command if a duplicate is added to the history list
setopt HIST_IGNORE_ALL_DUPS

# Do not add duplicates of previous command to the history list
setopt HIST_IGNORE_DUPS

# Do not save older duplicates of newer commands when writing the history file
setopt HIST_SAVE_NO_DUPS

# Append new history lines to the $HISTFILE as soon as they are entered
setopt INC_APPEND_HISTORY

# Match files beginning with . without explicitly specifying the dot
setopt globdots

# Enable using cd command without explicitly using cd in command
setopt autocd

# Disable all beeps in zsh
unsetopt BEEP

# tells zsh to ignore case when completing commands or filenames.
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
