{ config, pkgs, ... }:{ hardware = {

# Nvidia Drivers
nvidia = {
    modesetting.enable = true;
    open = true;
    nvidiaSettings = true;
};

# Enable blueman to control bluetooth
bluetooth.enable = true;

};}
