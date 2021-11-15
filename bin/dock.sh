#!/usr/bin/env sh

cp ~/.config/nixpkgs/wm/dpi-desktop.nix ~/.config/nixpkgs/wm/dpi.nix
autorandr --load docked
systemctl --user restart setxkbmap
home-manager switch
