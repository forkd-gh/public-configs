#!/usr/bin/env nix-shell
#!nix-shell -i bash -p wofi procps

# ~/.config/hypr/menu-toggle.sh

wofi_pid=$(pgrep -f "wofi --show drun")

if [[ -n "$wofi_pid" ]]; then
    pkill -f "wofi --show drun"
else
    wofi --show drun &
fi
