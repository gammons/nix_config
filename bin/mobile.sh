#!/usr/bin/env sh

rm ~/.config/nixpkgs/wm/i3/dpi.nix

ln -s ~/.config/nixpkgs/wm/i3/dpi-laptop.nix ~/.config/nixpkgs/wm/i3/dpi.nix
autorandr --load mobile
systemctl --user restart setxkbmap
home-manager switch
systemctl --user restart polybar

