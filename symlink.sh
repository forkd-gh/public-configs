#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/vars.sh"

#---------------------------------------------------------------
# 📁 Declare source → destination folder mappings
declare -A CONF_DICT=(
    ["$REPO/nixos"]="/etc/nixos"
    ["$REPO/hypr"]="$CONF/hypr"
    ["$REPO/kitty"]="$CONF/kitty"
    ["$REPO/wofi"]="$CONF/wofi"
    ["$REPO/neofetch"]="$CONF/neofetch"
)

#---------------------------------------------------------------

if [ "$(logname)" == "root" ]; then
    echo "WARNING: Don't run this directly as root. The script will use sudo when needed."
    exit 1
fi

echo "Linking configuration folders..."

for SRC in "${!CONF_DICT[@]}"; do
    DST="${CONF_DICT[$SRC]}"

    if [ ! -d "$SRC" ]; then
        echo "❌ Source folder does not exist: $SRC"
        continue
    fi

    USE_SUDO=""
    [[ "$DST" == /etc/* ]] && USE_SUDO="sudo"

    echo "→ Linking $SRC → $DST"
    $USE_SUDO rm -rf "$DST"
    $USE_SUDO ln -s "$SRC" "$DST"
    echo "✅ Linked $DST"
done

#---------------------------------------------------------------
if command -v hyprctl &> /dev/null && pgrep Hyprland &> /dev/null; then
    hyprctl reload &> /dev/null
fi

echo -e "\nAll symlinks created!"
echo "Reminder: some changes require a logout or restart."

#--------------------------------------------------------------------