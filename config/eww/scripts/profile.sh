#!/usr/bin/env bash

declare -a profiles_photos=("$HOME/.face.jpg" "$HOME/.face.png")

for profile in ${profiles_photos[@]}; do
  if test -f $profile; then
    echo $profile
    exit 0
  fi
done

echo $HOME/.config/eww/assets/default-pfp.png