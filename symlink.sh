#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/vars.sh"

### Configs to Symlink
declare -A CONF_DICT+=(
    # NixOS
    ["$REPO/NixOS/configuration.nix"]="/etc/nixos"

    # WindowManager
    ["$REPO/hypr/hyprland.conf"]="$CONF/hypr"
    
    # TerminalEmulator
    ["$REPO/kitty/kitty.conf"]="$CONF/kitty"
    
    # Menu
    ["$REPO/wofi/menu-toggle.sh"]="$CONF/wofi"
)

#--------------------------------------------------------------------

if [ "$(logname)" == "root" ]; then
    echo "It is not recommended to run this directly as root."
    echo "The script will ask for permission when required."
    exit 1
fi

echo "🔗 Creating symlinks..."

for SRC in "${!CONF_DICT[@]}"; do
    DST_DIR="${CONF_DICT[$SRC]}"
    FILE_NAME=$(basename "$SRC")
    DST_PATH="$DST_DIR/$FILE_NAME"

    echo "→ Linking $SRC → $DST_PATH"

    USE_SUDO=""
    if [[ "$DST_PATH" == /etc/* ]]; then
        USE_SUDO="sudo"
    fi

    $USE_SUDO mkdir -p "$DST_DIR"

    # Check if symlink is already correct
    if [ -L "$DST_PATH" ] && [ "$(readlink "$DST_PATH")" = "$SRC" ]; then
        echo "✔️  Symlink already correct: $DST_PATH"
        continue
    fi

    if [ -e "$DST_PATH" ] || [ -L "$DST_PATH" ]; then
        echo "⚠️  Removing existing file/link at $DST_PATH"
        $USE_SUDO rm -rf "$DST_PATH"
    fi

    $USE_SUDO ln -s "$SRC" "$DST_PATH"
    echo "✅ Linked $SRC to $DST_PATH"
done

echo "✅ All done!"

echo "Reloading Hyprland"
hyprctl reload

echo "REMINDER: 1. Some changes may require a restart or a logout to take effect."
echo "          2. This script does not rebuild NixOS."
echo ""
echo "Script Execution Complete - Have a nice day"

#--------------------------------------------------------------------