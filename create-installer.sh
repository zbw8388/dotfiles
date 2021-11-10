#!/bin/sh
pushd ~/.dotfiles
nix build .#nixosConfigurations.nixos-installer.config.system.build.isoImage
popd
