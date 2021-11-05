{ config, pkgs, lib, ... }:
{
  programs.zsh = {
    enable = true;
    shellAliases = {
      vim = "nvim";
      dots = "cd ~/.dotfiles";
      lc = "cd ~/local_code";

      g = "git status";
      gd = "git diff";
      gdc="gd --cached";
      push="git push";
      gco = "git checkout";
      gca = "git commit --all";

      l="exa --long --header -a -s modified";
    };
    history = {
      size = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
    };

    profileExtra = ''
    . "/etc/profile.d/nix.sh"
    '';

    # NIX_PATH=/home/nixgrant/.nix-defexpr/channels:nixpkgs=/nix/var/nix/profiles/per-user/root/channels/nixpkgs:/nix/var/nix/profiles/per-user/root/channels
    # NIX_PATH=nixpkgs=/nix/var/nix/profiles/per-user/root/channels/nixpkgs:/nix/var/nix/profiles/per-user/root/channels
  };

}
