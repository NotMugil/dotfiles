#!/bin/bash

theme=$1

case "$theme" in
    "Catppuccin")
        kitten themes --reload-in=all "Catppuccin-Mocha"
        ;;
    "Tokyo-Night")
        kitten themes --reload-in=all "Tokyo Night"
        ;;
    "Gruvbox-Dark")
        kitten themes --reload-in=all "Gruvbox Dark"
        ;;
    # Add more themes as needed
    *)
        echo "Unknown theme for Kitty: $theme"
        ;;	
esac

