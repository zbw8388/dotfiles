{ config, pkgs, ... }:

{
  imports = 
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  networking.hostName = "nixos-laptop"; # Define your hostname.
  hardware.video.hidpi.enable = true; # Enable HiDPI mode.
  # Enable proprietary NVidia drivers
  services.xserver.videoDrivers = [ "nvidia" ];
}
