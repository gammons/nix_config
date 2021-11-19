{ config, pkgs, ... }:
let
  googleChromeOzone = pkgs.makeDesktopItem {
    name = "Chrome";
    desktopName = "Google Chrome (Ozone Support)";
    exec = "${pkgs.google-chrome}/bin/google-chrome-stable --enable-features=UseOzonePlatform --ozone-platform=wayland";
  };
  obsidianOzone = pkgs.makeDesktopItem {
    name = "ObsidianOzone";
    desktopName = "Obsidian (Ozone Support)";
    exec = "${pkgs.obsidian}/bin/obsidian --enable-features=UseOzonePlatform --ozone-platform=wayland";
  };
  slackOzone = pkgs.makeDesktopItem {
    name = "SlackOzone";
    desktopName = "Slack (Ozone Support)";
    exec = "${pkgs.slack}/bin/slack --enable-features=UseOzonePlatform --ozone-platform=wayland";
  };

in {
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
    slackOzone
    google-chrome
    googleChromeOzone
    spotify
    obsidian
    obsidianOzone
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
    #xfce.xfce4-notifyd
    xfce.thunar
    ruby # for a quick irb shell
  ];
}
