{ config, pkgs, ... }:

{
  imports = 
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];
  networking.hostName = "nixos-desktop"; # Define your hostname.
  # Enable proprietary NVidia drivers
  services.xserver.videoDrivers = [ "nvidia" ];
}

