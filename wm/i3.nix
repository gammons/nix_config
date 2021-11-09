{ config, lib, pkgs, ... }:
let
  mod = "Mod1";
in {
  xsession.enable = true;
  xsession.windowManager.i3 = {
    enable = true;
    package = pkgs.i3-gaps;


    config = rec {
      modifier = "Mod1";
      terminal = "kitty";

      focus.followMouse = false;

      gaps = {
        inner = 15;
        outer = 15;
      };

      keybindings = lib.mkOptionDefault {
        "${modifier}+h" = "focus left";
        "${modifier}+j" = "focus down";
        "${modifier}+k" = "focus up";
        "${modifier}+l" = "focus right";

        "${modifier}+f" = "fullscreen toggle";
        "${modifier}+p" = "exec ${pkgs.dmenu}/bin/dmenu_run";
      };

      startup = [
        {
          command = "nm-applet";
          always = false;
          notification = false;
        }
        {
          command = "picom -D 0 -b -i 1";
          always = false;
          notification = false;
        }
        {
          command = "setxkbmap -option caps:ctrl_modifier";
          always = false;
          notification = false;
        }
      ];
    };

    extraConfig = ''
      smart_gaps on
    '';
  };
}
