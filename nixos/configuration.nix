{ config, pkgs, ... }:{

imports = [
  ./hardware-configuration.nix
  ./hardware-additions.nix
  ./other.nix
  ./networking.nix
  ./packages.nix
  ./programs.nix
  ./services.nix
  ./users.nix
];

system.stateVersion = "25.05";
time.timeZone = "America/Edmonton";
}
