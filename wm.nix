{ config, pkgs, ... }:
{
  imports = [
    ./wm/i3.nix
    ./wm/picom.nix
    ./wm/polybar.nix
    ./wm/kitty.nix
    ./wm/rofi.nix
    ./wm/redshift.nix
    ./wm/dpi.nix
  ];

  xsession.enable = true;

  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    # applications
    slack
    google-chrome
    spotify
    obsidian
    pavucontrol
    jdk11
    zoom-us

    # tooling
    git
    curl
    wget

    # fonts
    font-manager
    roboto-mono
    font-awesome-ttf
    material-icons
    weather-icons
    nerdfonts

    # desktop env things
    playerctl
    keychain
    pasystray
    xautolock
    flameshot
    brightnessctl
    autorandr
    xfce.xfce4-notifyd
    xfce.thunar
    feh
    xss-lock
    i3lock-fancy-rapid
    v4l-utils
    ruby # for a quick irb shell
  ];
}
