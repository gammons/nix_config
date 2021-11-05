{ config, pkgs, ... }:
{
  imports = [
    ./wm/i3.nix
  ];
  home.packages = with pkgs; [
    # applications
    playerctl
    kitty
    slack
    google-chrome
    spotify
    obsidian

    # tooling
    git
    curl
    wget

    # desktop env things
    picom
    xautolock
    flameshot
  ];
}
