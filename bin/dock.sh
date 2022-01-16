#!/usr/bin/env sh

rm ~/.config/nixpkgs/wm/i3/dpi.nix
ln -s ~/.config/nixpkgs/wm/i3/dpi-desktop.nix ~/.config/nixpkgs/wm/i3/dpi.nix
autorandr --load docked
systemctl --user restart setxkbmap
home-manager switch
systemctl --user restart polybar
