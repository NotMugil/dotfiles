#!/bin/bash

playerctl metadata --format '{{ title }}' -F | while read -r title; do
    if [ ${#title} -gt 24 ]; then
        echo "${title:0:24}..."
    else
        echo "$title"
    fi
done
