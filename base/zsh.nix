{ config, pkgs, lib, ... }:
{
  programs.zsh = {
    enable = true;
    shellAliases = {
      vim = "nvim";
      dots = "cd ~/.dotfiles";
      lc = "cd ~/local_code";

      g = "git status";
      gc = "git commit";
      gd = "git diff";
      gdc = "gd --cached";
      gco = "git checkout";
      gca = "git commit --all";

      push = "git push";

      l = "exa --long --header -a -s modified";
    };

    history = {
      size = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
    };
  };
}
