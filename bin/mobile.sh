#!/usr/bin/env sh

rm ~/.config/nixpkgs/wm/dpi.nix

ln -s ~/.config/nixpkgs/wm/dpi-laptop.nix ~/.config/nixpkgs/wm/dpi.nix
autorandr --load mobile
systemctl --user restart setxkbmap
home-manager switch
systemctl --user restart polybar

