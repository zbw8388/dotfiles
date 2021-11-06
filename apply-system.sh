#!/bin/sh
pushd ~/.dotfiles
sudo nixos-rebuild boot --flake .#
popd
