#!/bin/bash

#####################################################################
# 
# DESC:
#   Kinda like environment variables but not
#
#####################################################################

declare -A NIXOS_DICT
declare -A CONF_DICT
CREATED_ARRAY=()
MOD_ARRAY=()
UNMOD_ARRAY=()

#--------------------------------------------------------------------
# Required Directory Variables
REPO="/home/$USER/Github/public-configs"
WINDOWMANAGER="$REPO/WindowManager"
MENU="$REPO/MENU"
TERMINALEMULATOR="$REPO/TerminalEmulator"
CONF="/home/$USER/.config"

#--------------------------------------------------------------------
# NIXOS Variables
NIXOS_CONF_OVERRIDE="true" # "true" to enable nixos config overriding

### NIXOS Configs (Except user-configuraton.nix)
declare -A NIXOS_DICT=(
    ["$REPO/NixOS/configuration.nix"]="/etc/nixos/configuration.nix"
)

#--------------------------------------------------------------------
# Other Configuration Variables
CONF_OVERRIDE="true" # "true" to general config overriding

### Other Configs to Deploy - Value must include filename
declare -A CONF_DICT+=(
    # WindowManager
    ["$WINDOWMANAGER/Hyprland/hyprland.conf"]="$CONF/hypr/hyprland.conf"
    
    # TerminalEmulator
    ["$TERMINALEMULATOR/kitty/kitty.conf"]="$CONF/kitty/kitty.conf"
    
    # Menu
    ["$MENU/wofi/menu-toggle.sh"]="$CONF/wofi/menu-toggle.sh"
)

#--------------------------------------------------------------------
# Special Conditions Variables
SPECIAL_CONDITIONS="true" # "true" to enable custom commands
