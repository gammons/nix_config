{ config, lib, pkgs, ... }:
let
  mod = "Mod1";
  term = "kitty";
in {
  xsession.windowManager.i3 = {
    enable = true;
    package = pkgs.i3-gaps;

    config = rec {
      modifier = "Mod1";
      terminal = term;

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

        "${modifier}+F11" = "exec --no-startup-id brightnessctl set 5%-";
        "${modifier}+F12" = "exec --no-startup-id brightnessctl set +5%";

        "${modifier}+u" = ''[title="dropdown-terminal"] scratchpad show; move position center'';
        "${modifier}+Shift+u" = ''exec --no-startup-id ${term} --title=dropdown-terminal'';
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
          command = "pasystray";
          always = false;
          notification = false;
        }
      ];
    };

    extraConfig = ''
      smart_gaps on
      hide_edge_borders both

      bindsym --release F12 exec --no-startup-id flameshot gui

      for_window [class="zoom"] floating enable
      for_window [class="zoom"] sticky enable
      for_window [class="VirtualBox"] floating enable
      for_window [class="Gnome-control-center"] floating enable

      assign [class="Slack"] 2
      assign [class="Spotify"] 4
      for_window [title="dropdown-terminal"] floating enable
      for_window [title="dropdown-terminal"] resize set 925 700
      for_window [title="dropdown-terminal"] move position center
      for_window [title="dropdown-terminal"] move scratchpad
      for_window [title="Meet - "] sticky enable
      exec --no-startup-id ${term} --title=dropdown-terminal
    '';
  };
}
