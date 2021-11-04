{ config, pkgs, ... }:
{
  imports = [
    #./wm/i3.nix
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
  ];

  xsession.enable = true;
  xsession.windowManager.i3 = {
    enable = true;
    package = pkgs.i3-gaps;
  };
}
