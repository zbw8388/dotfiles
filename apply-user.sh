#!/bin/sh
pushd ~/.dotfiles
nix build .#homeManagerConfigurations.dominic.activationPackage
./result/activate
popd
