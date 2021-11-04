{ config, pkgs, ... }:
{
  imports = [
    ./base/vim.nix
    ./base/fzf.nix
    ./base/tmux.nix
    ./base/starship.nix
    ./base/zsh.nix
  ];

  home.packages = with pkgs; [
    git
    curl
    wget
    tig
    sudo
  ]
}
