{ config, pkgs, ... }:
let
  mod = "Mod1";
in {
  xsession.enable = true;
  xsession.windowManager.i3 = {
    enable = true;
    package = pkgs.i3-gaps;
    config = {
      modifier = mod;
      fonts = ["pango:monospace 8"];
    };
  };
}
