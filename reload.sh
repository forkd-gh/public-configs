#!/run/current-system/sw/bin/bash

# Process Management
pkill waybar

# Config Replacement
cp -r ~/github/public-configs/dotfiles/* ~/.config/

# Restarting
hyprctl reload
waybar &