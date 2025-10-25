{ config, pkgs, ... }:{ programs = {

# Browser
firefox.enable = true;

# Window Tiling Manager
hyprland.enable = true;

# Taskbar
waybar.enable = true;

# Smarter Shell
fish.enable = true;

# Password Manager
_1password.enable = true;
_1password-gui = {
    enable = true;
    polkitPolicyOwners = [ "kolby" ];
};

steam.enable = true;

};}
