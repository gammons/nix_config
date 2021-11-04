{ config, pkgs, ... }:
let
  mod = "Mod1";
in {
  home.packages = with pkgs; [
    picom
    xautolock
    flameshot
  ]

  xsession.enable = true;
  xsession.windowManager.i3 = {
    enable = true;
    package = pkgs.i3-gaps;
    config = {
      modifier = "Mod1";
      fonts = ["pango:monospace 8"];
      floating_modifier = mod;

    };
  };
}
