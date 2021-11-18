{ config, pkgs, ... }:
{
  imports = [
    ./wm/sway.nix
    ./wm/kitty.nix
    #./wm/polybar.nix
    #./wm/rofi.nix
    #./wm/xscreensaver.nix
    ./wm/redshift.nix
    #./wm/dpi.nix
  ];

  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    # applications
    slack
    google-chrome
    spotify
    obsidian
    pavucontrol
    jdk11

    # tooling
    git
    curl
    wget

    # fonts
    roboto-mono
    font-awesome-ttf
    material-icons
    weather-icons

    # i3 / X things
    # xautolock
    # autorandr

    # sway things
    swaylock
    swayidle
    wl-clipboard
    mako # notification daemon
    wofi

    # desktop env things
    playerctl
    keychain
    pasystray
    flameshot
    brightnessctl
    xfce.xfce4-notifyd
    xfce.thunar
    ruby # for a quick irb shell
  ];
}
