{ config, pkgs, ... }:

{
  imports = 
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  networking.hostName = "nixos-laptop"; # Define your hostname.

  boot.kernelPackages = pkgs.linuxPackages_5_14;

  services.thermald.enable = true;

  # Fix for XPS 9700 audio
  boot.kernelPatches = [{
    name = "enable-soundwire-drivers";
    patch = null;
    extraConfig = ''
      SND_SOC_INTEL_USER_FRIENDLY_LONG_NAMES y
      SND_SOC_INTEL_SOUNDWIRE_SOF_MACH m
      SND_SOC_RT1308 m
    '';
    ignoreConfigErrors = true;
  }];
}
