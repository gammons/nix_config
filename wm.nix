{ config, pkgs, ... }:
{
  imports = [
    ./wm/i3.nix
    ./wm/polybar.nix
    ./wm/kitty.nix
    ./wm/rofi.nix
  ];

  xsession.enable = true;

  xsession.pointerCursor = {
    package = pkgs.capitaine-cursors;
    name = "capitaine-cursors";
    size = 48;
  };

  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    # applications
    slack
    google-chrome
    spotify
    obsidian
    pavucontrol

    # tooling
    git
    curl
    wget

    # fonts
    roboto-mono
    font-awesome-ttf
    material-icons
    weather-icons

    # desktop env things
    playerctl
    pasystray
    picom
    xautolock
    flameshot
    brightnessctl
    xfce.thunar
  ];
}
