#!/bin/bash

# Check if any media player is running using playerctl
if playerctl status &>/dev/null; then
    echo "1"  # Player found
else
    echo "0"  # No players found
fi
