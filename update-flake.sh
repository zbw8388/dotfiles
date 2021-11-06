#!/bin/sh
pushd ~/.dotfiles
nix flake update --recreate-lock-file
popd
