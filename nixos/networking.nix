{ config, pkgs, ... }:{ networking = {

hostName = "nixos";
networkmanager.enable = true;
firewall.enable = true;

wireless.iwd.settings = {
    IPv6 = {
      Enabled = true;
    };
    Settings = {
      AutoConnect = true;
    };
  };

};}
