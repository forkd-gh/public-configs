{ config, pkgs, ... }:{

# One-off configurations
boot.loader.systemd-boot.enable = true;
boot.loader.efi.canTouchEfiVariables = true;
i18n.defaultLocale = "en_CA.UTF-8";
security.rtkit.enable = true;
virtualisation.docker.enable = true;

}
