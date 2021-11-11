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

  # Use new linux kernel
  # As of 5.15 WiFi works correctly; it did NOT work on the (at the time)
  # LTS kernel 5.10.
  boot.kernelPackages = pkgs.linuxPackages_latest;
}

