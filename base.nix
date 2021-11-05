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
    gcc
    git
    curl
    wget
    tig
    sudo
    ag
    fd
    fzf
    exa
  ];

  programs.git = {
    enable = true;
    userEmail = "gammons@gmail.com";
    userName = "Grant Ammons";
  };
}
