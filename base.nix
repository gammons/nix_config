{ config, pkgs, ... }:
{
  imports = [
    ./base/git.nix
    ./base/vim.nix
    ./base/fzf.nix
    ./base/tmux.nix
    ./base/starship.nix
    ./base/zsh.nix
    ./base/dev.nix
  ];

  home.packages = with pkgs; [
    gcc
    curl
    wget
    tig
    sudo
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
  ];
}
