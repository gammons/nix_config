{ config, pkgs, lib, ... }:
{
  programs.zsh = {
    enable = true;
    shellAliases = {
      c = "cal -3";
      vim = "nvim";
      dots = "cd ~/.config/nixpkgs";
      lc = "cd ~/local_code";

      g = "git status";
      gc = "git commit";
      gd = "git diff";
      gdc = "gd --cached";
      gco = "git checkout";
      gca = "git commit --all";

      push = "git push";
      pull = "git fetch && git rebase";

      l = "exa --long --header -a -s modified";
    };

    envExtra = ''
      eval $(keychain --eval --quiet id_rsa)
    '';

    history = {
      size = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
    };
  };
}
