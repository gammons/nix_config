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
  ];

  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    # applications
    slack
    slackOzone

    google-chrome
    googleChromeOzone

    obsidian
    obsidianOzone

    spotify
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

    # sway things
    waybar
    swaylock
    swayidle
    wl-clipboard
    mako # notification daemon
    wofi

    # themes
    gnome-themes-standard
    gnome3.adwaita-icon-theme

    gtk-engine-murrine
    gtk_engines
    gsettings-desktop-schemas
    lxappearance

    # desktop env things
    playerctl
    keychain
    pasystray
    flameshot
    brightnessctl
    xfce.thunar
    ruby # for a quick irb shell
  ];
}
