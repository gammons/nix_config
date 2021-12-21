{ config, pkgs, ... }:
{
  imports = [
    ./base/git.nix
    ./base/vim.nix
    ./base/fzf.nix
    ./base/tmux.nix
    ./base/starship.nix
    ./base/zsh.nix
    #./wm/kitty.nix
  ];

  home.packages = with pkgs; [
    gcc
    curl
    wget
    tig
    htop
    ag
    fd
    fzf
    exa
    jq
    killall
    unzip
    direnv
    stdenv

    alacritty
    nerdfonts
  ];
}
