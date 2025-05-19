#!/bin/bash

#####################################################################
# 
# DESC:
#   An overly comprehensive bash script to deploy files from 
#   this repo to their desired configuration location and then
#   run commands to load those files as required.
#
#   Use at your own risk.
#
#####################################################################

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/config.sh"

#--------------------------------------------------------------------
# User Check
if [ "$USER" == "root" ]; then
    echo "Error: The script cannot be run as the root user directly."
    exit 1
fi

#--------------------------------------------------------------------
# NixOS Deployment (If required)
if [ "$NIXOS_CONF_OVERRIDE" == "true" ]; then
    if grep -qi '^ID=nixos' /etc/os-release; then

        cust_userconf="true"
        nixos_rebuild="false"

        for tracked in "${!NIXOS_DICT[@]}"; do
            placed="${NIXOS_DICT[$tracked]}"

            if [ ! -f "$placed" ] || [ "$(md5sum "$tracked" | awk '{print $1}')" != "$(md5sum "$placed" | awk '{print $1}')" ]; then
                if [ "$nixos_rebuild" == "false" ]; then
                    nixos_rebuild="true"
                fi
                sudo cp "$tracked" "$placed"
                MOD_ARRAY+=("$placed")
            else
                UNMOD_ARRAY+=("$placed")
            fi
        done

        creation_message="WARNING: To Make NixOS Config Changes, Modify: /etc/nixos/user-configuration.nix"
        if [ ! -f /etc/nixos/user-configuration.nix ]; then
            sudo cp "$REPO/NixOS/user-configuration.nix" /etc/nixos/user-configuration.nix
            
            echo "WARNING: NixOS User Conf Did Not Exist"
            echo "$creation_message"

            CREATED_ARRAY+=("/etc/nixos/user-configuration.nix")
        else
            TEMPLATE_HASH=$(md5sum "$REPO/NixOS/user-configuration.nix" | awk '{print $1}')
            EXISTING_HASH=$(sudo md5sum /etc/nixos/user-configuration.nix | awk '{print $1}')
            
            if [ "$TEMPLATE_HASH" == "$EXISTING_HASH" ]; then
                echo "$creation_message"
                cust_userconf="false"
            fi
        fi

        if [ "$nixos_rebuild" == "true" ] && [ "$cust_userconf" != "false" ]; then
            sudo nixos-rebuild switch
            echo "Rebuilt Nix"
        fi
    fi
fi

#--------------------------------------------------------------------
# Other Config Deployment
if [ "$CONF_OVERRIDE" == "true" ]; then
    for tracked in "${!CONF_DICT[@]}"; do
        placed="${CONF_DICT[$tracked]}"

        if [ ! -f "$placed" ]; then
            mkdir -p "$(dirname "$placed")"
            cp "$tracked" "$placed"
            CREATED_ARRAY+=("$placed")
        elif [ -f "$tracked" ] && [ "$(md5sum "$tracked" | awk '{print $1}')" != "$(md5sum "$placed" | awk '{print $1}')" ]; then
            cp "$tracked" "$placed"
            MOD_ARRAY+=("$placed")
        else
            UNMOD_ARRAY+=("$placed")
        fi
    done
fi

#--------------------------------------------------------------------
# Custom Commands (Special Conditions)
if [ "$SPECIAL_CONDITIONS" == "true" ]; then
    echo ""
    echo "Reloading Hyprland Status:" && hyprctl reload
    # MODIFY COMMANDS AS REQUIRED
fi

#--------------------------------------------------------------------
# Script Completion
echo ""
echo "##### REPORT ######"
echo "Files Created:"
for file in "${CREATED_ARRAY[@]}"; do
    echo "$file"
done
echo ""
echo "Files Modified:"
for file in "${MOD_ARRAY[@]}"; do
    echo "$file"
done
echo ""
echo "Files Unmodified:"
for file in "${UNMOD_ARRAY[@]}"; do
    echo "$file"
done
echo ""
echo "REMINDER: Reboot or Display server Reload may be Required."
echo "Script Execution Complete - Have a nice day."
