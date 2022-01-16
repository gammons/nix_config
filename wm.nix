{ config, pkgs, ... }:
{
  imports = [
    ./wm/kitty.nix
    ./wm/wm-of-choice.nix
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
    zoom-us
    ruby # for a quick irb shell

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
  ];
}
