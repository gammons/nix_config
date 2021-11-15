#!/usr/bin/env sh

cp ~/.config/nixpkgs/wm/dpi-laptop.nix ~/.config/nixpkgs/wm/dpi.nix
autorandr --load mobile
systemctl --user restart setxkbmap
home-manager switch

