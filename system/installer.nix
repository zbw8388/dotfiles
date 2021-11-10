{ config, pkgs, ... }:

{
  imports = 
    [
      "${nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-graphical-gnome.nix"
    ];
    
  boot.kernelPackages = pkgs.linuxPackages_5_14;
}