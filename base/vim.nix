{ config, pkgs, lib, ... }:

let
  vimConfig = lib.fileContents ./init.lua;
in
{
  programs.neovim.viAlias = true;

  programs.neovim = {
    enable = true;
    plugins = with pkgs.vimPlugins;
      [
        packer-nvim
      ];

    extraPackages = [
      pkgs.tree-sitter
    ];

    extraConfig = ''
      lua << EOF
        ${vimConfig}
      EOF
    '';
  };
}
