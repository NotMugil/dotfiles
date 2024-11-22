#!/usr/bin/env zsh

# Set XDG Base Directory paths
export XDG_CONFIG_HOME="${HOME}/.config"          # User configuration files
export XDG_CACHE_HOME="${HOME}/.cache"            # User cache files
export XDG_DATA_HOME="${HOME}/.local/share"       # User data files
export XDG_STATE_HOME="${HOME}/.local/state"      # User state files

# Set other tool and configuration paths to clean up ~
export CARGO_HOME="$XDG_DATA_HOME"/cargo          # Cargo package manager
export GNUPGHOME="$XDG_DATA_HOME"/gnupg           # GNU Privacy Guard home
export _JAVA_OPTIONS="-Djava.util.prefs.userRoot="${XDG_CONFIG_HOME}"/java \
                      -Dawt.useSystemAAFontSettings=gasp" # Java preferences
export ANDROID_HOME="${XDG_DATA_HOME}/android"    # Android SDK home

# Set zsh shell history file path and set max history length
export HISTFILE="${XDG_STATE_HOME}/zsh_history"
export HISTSIZE=10000
export SAVEHIST=10000

export ZSH_FZF_HISTORY_SEARCH_DATES_IN_SEARCH=0 # Disable dates in zsh-fzf-history
export ZSH_FZF_HISTORY_SEARCH_EVENT_NUMBERS=0 # Disable index in zsh-fzf-history
export ZSH_FZF_HISTORY_SEARCH_REMOVE_DUPLICATES=1 # Hide duplicates in zsh-fzf-history

# Add additional directories to PATH
export PATH=${PATH}:~/.local/scripts:~/.local/bin:~/.local/share/cargo/bin
export PATH=$PATH:/home/$USER/.spicetify

# Set sudo password prompt
export SUDO_PROMPT='[] Enter Password: '

# Set default editor
export EDITOR='nano'

# Set language environment
export LANG=en_US.UTF-8

# Set default file manager
export fileManager='thunar'

export RUST_BACKTRACE=1

