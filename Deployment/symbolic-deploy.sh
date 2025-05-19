#!/bin/bash

#####################################################################
# 
# DESC:
#   A comprehensive bash script to symbolically link configs
#   to this repo. (More permanent),
#
#   Use at your own risk.
#
#####################################################################

# Load config definitions
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/config.sh"

#--------------------------------------------------------------------
# Script Completion
link_dict() {
    local -n dict_ref=$1
    local use_sudo=$2

    for src in "${!dict_ref[@]}"; do
        dest="${dict_ref[$src]}"

        # Ensure destination directory exists
        if [ "$use_sudo" == "true" ]; then
            sudo mkdir -p "$(dirname "$dest")"
        else
            mkdir -p "$(dirname "$dest")"
        fi

        if [ -L "$dest" ]; then
            existing_target=$(readlink -- "$dest")
            if [ "$existing_target" != "$src" ]; then
                [ "$use_sudo" == "true" ] && sudo rm "$dest" || rm "$dest"
                [ "$use_sudo" == "true" ] && sudo ln -s "$src" "$dest" || ln -s "$src" "$dest"
                MOD_ARRAY+=("$dest")
            else
                UNMOD_ARRAY+=("$dest")
            fi
        elif [ -f "$dest" ]; then
            [ "$use_sudo" == "true" ] && sudo rm "$dest" || rm "$dest"
            [ "$use_sudo" == "true" ] && sudo ln -s "$src" "$dest" || ln -s "$src" "$dest"
            CREATED_ARRAY+=("$dest")
        elif [ -d "$dest" ]; then
            echo "WARNING $dest is a directory, not a file and will be skipped."
        else
            [ "$use_sudo" == "true" ] && sudo ln -s "$src" "$dest" || ln -s "$src" "$dest"
            CREATED_ARRAY+=("$dest")
        fi
    done
}

if [ "$NIXOS_CONF_OVERRIDE" == "true" ]; then
    link_dict NIXOS_DICT "true"
fi

if [ "$CONF_OVERRIDE" == "true" ]; then
    link_dict CONF_DICT "false"
fi

#--------------------------------------------------------------------
# Script Completion
echo ""
echo "##### REPORT ######"
echo "Symlink Created:"
for file in "${CREATED_ARRAY[@]}"; do
    echo "$file"
done
echo ""
echo "Symlink Modified:"
for file in "${MOD_ARRAY[@]}"; do
    echo "$file"
done
echo ""
echo "Symlink Unmodified:"
for file in "${UNMOD_ARRAY[@]}"; do
    echo "$file"
done
echo ""
echo "REMINDER: Reboot or Display server Reload may be Required."
echo "Script Execution Complete - Have a nice day."

CREATED_ARRAY=()
MOD_ARRAY=()
UNMOD_ARRAY=()