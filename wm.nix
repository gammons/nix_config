{ config, pkgs, ... }:
{
  imports = [
    ./wm/i3.nix
    ./wm/kitty.nix
    ./wm/rofi.nix
  ];
  home.packages = with pkgs; [
    # applications
    playerctl
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
    polybar
    xautolock
    flameshot
    brightnessctl
    roboto-mono
  ];
}
