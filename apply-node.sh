#!/bin/sh
pushd ~/.dotfiles
nix-shell -p nodePackages.node2nix --command "cd ./users/dominic/node && node2nix -i ./node-packages.json -o node-packages.nix"
popd