#!/usr/bin/env bash

selected=$(cliphist list | anyrun --plugins libstdin.so)

if [ ! -z "$selected" ]; then
	cliphist decode <<<"$selected" | wl-copy
fi
