#!/bin/bash

theme=$1

# Change this if this aint your firefox dir 
# To find this dir search `about:profiles` in firefox

FILE_PATH=~/.mozilla/firefox/*.default-release/prefs.js

# Change this 

CATPPUCCIN="8446b178-c865-4f5c-8ccc-1d7887811ae3"
TOKYO_NIGHT="4520dc08-80f4-4b2e-982a-c17af42e5e4d"
GRUVBOX_DARK="08d5243b-4236-4a27-984b-1ded22ce01c3"
STARLIT="b7afe29e-2e0a-4f94-bd00-9c1efc629995"

case "$theme" in
    "Catppuccin")
        sed -i '/user_pref("extensions.activeThemeID",/s/{[^}]*}/{'"${CATPPUCCIN}"'}/' $FILE_PATH
    	echo "Theme ID updated successfully."
        ;;
    "Tokyo-Night")
        sed -i '/user_pref("extensions.activeThemeID",/s/{[^}]*}/{'"${TOKYO_NIGHT}"'}/' $FILE_PATH
    	echo "Theme ID updated successfully."
        ;;
    "Gruvbox-Dark")
        sed -i '/user_pref("extensions.activeThemeID",/s/{[^}]*}/{'"${GRUVBOX_DARK}"'}/' $FILE_PATH
    	echo "Theme ID updated successfully."
        ;;
    "Starlit")
        sed -i '/user_pref("extensions.activeThemeID",/s/{[^}]*}/{'"${STARLIT}"'}/' $FILE_PATH
    	echo "Theme ID updated successfully."
        ;;
    # Add more themes as needed
    *)
        echo "Unknown theme: $theme"
        ;;
esac

pkill -f firefox
while pgrep -x "firefox" > /dev/null; do sleep 1; done
firefox &
