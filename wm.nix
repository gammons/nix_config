{ config, pkgs, ... }:
{
  imports = [
    ./wm/i3.nix
    ./wm/kitty.nix
    ./wm/rofi.nix
  ];
  home.packages = with pkgs; [
    # applications
    slack
    google-chrome
    spotify
    obsidian

    # tooling
    git
    curl
    wget

    # desktop env things
    playerctl
    pasystray
    picom
    polybar
    xautolock
    flameshot
    brightnessctl
    roboto-mono
    xfce.thunar
  ];
}
