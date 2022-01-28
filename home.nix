{ config, pkgs, ... }:

{
  imports = [
    ./base.nix
    #./wm/kitty.nix
    #./wm.nix
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "grant";
  home.homeDirectory = "/Users/grantammons";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "21.11";

  home.keyboard = {
    layout = "us, us";
    options = [
      "caps:ctrl_modifier"
    ];
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    TERM = "xterm-256color";
  };

  lib.sytemd.user = {
    startServices = true;

    services = {
      setxkbmap.Service.ExecStart = pkgs.lib.mkForce "${pkgs.coreutils}/bin/true";
    };
  };
}
