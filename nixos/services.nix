{ config, pkgs, ... }:{ services = {

# GUI Windows
xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    videoDrivers = ["nouveau"];
    xkb = {
        layout = "us";
        variant = "";
    };
};

# Sound
pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
};

# Bluetooth
blueman.enable = true;

};}
