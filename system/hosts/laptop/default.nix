{ config, pkgs, ... }:

{
  imports = 
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  networking.hostName = "nixos-laptop"; # Define your hostname.

  boot.kernelPackages = pkgs.linuxPackages_5_14;
}
