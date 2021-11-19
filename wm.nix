{ config, pkgs, ... }:
{
  imports = [
    #./wm/i3.nix
    #./wm/picom.nix
    #./wm/polybar.nix
    ./wm/kitty.nix
    ./wm/rofi.nix
    #./wm/xscreensaver.nix
    ./wm/redshift.nix
    ./wm/gnome-settings.nix
    #./wm/dpi.nix
  ];

  #xsession.enable = true;

  #xsession.pointerCursor = {
  #  package = pkgs.capitaine-cursors;
  #  name = "capitaine-cursors";
  #  size = 36;
  #};

  #programs.dconf.enable = true;

  fonts.fontconfig.enable = true;

  #services.udev.packages = with pkgs; [
  #  gnome3.gnome-settings-daemon
  #];

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

    # gnome stuff
    gnome3.eog
    gnome3.gnome-tweak-tool
    gnome3.adwaita-icon-theme
    gnomeExtensions.appindicator
    gnomeExtensions.dash-to-dock

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
    ruby # for a quick irb shell
  ];
}
