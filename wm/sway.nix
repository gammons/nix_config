{ config, lib, pkgs, ... }:
let
  mod = "Mod1";
  term = "kitty";
in {
  wayland.windowManager.sway = {
    enable = true;
    package = pkgs.i3-gaps;
    wrapperFeatures.gtk = true;

    config = rec {
      modifier = "Mod1";
      terminal = term;

      bars = [{
        statusCommand = "~/.config/nixpkgs/bin/waybar.sh";
        command = "${pkgs.sway}/bin/swaybar";
        position = "top";
        trayOutput = "primary";

      }];

      focus.followMouse = false;

      input = {
        "type:keyboard" = {
          repeat_delay = "200";
          repeat_rate = "55";
          xkb_options = "ctrl:nocaps";
        };
        "type:touchpad" = {
          natural_scroll = "enabled";
          dwt = "enabled";
          scroll_method  = "two_finger";
          tap = "disabled";
          scroll_factor = "1.0";
          tap_button_map = "lrm";
          middle_emulation = "enabled";
          click_method = "clickfinger";
        };
        "type:pointer" = {
          scroll_factor = "3.0";
        };
      };

      output = {
        "eDP-1" = {
          scale = "1.72";
          pos = "0 0";
          res = "3840x2400";
        };
        "DP-3" = {
          scale = "1";
          pos = "3840 0";
          res = "3840x2160";
        };
      };

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
        "${modifier}+p" = "exec ${pkgs.wofi}/bin/wofi --show drun ";

        "${modifier}+F4" = "exec --no-startup-id playerctl previous";
        "${modifier}+F5" = "exec --no-startup-id playerctl play-pause";
        "${modifier}+F6" = "exec --no-startup-id playerctl next";

        "${modifier}+F7" = "exec --no-startup-id ~/.config/nixpkgs/bin/mobile.sh";
        "${modifier}+F8" = "exec --no-startup-id ~/.config/nixpkgs/bin/dock.sh";

        "${modifier}+F11" = "exec --no-startup-id brightnessctl set 5%-";
        "${modifier}+F12" = "exec --no-startup-id brightnessctl set +5%";

        "${modifier}+u" = ''[title="dropdown-terminal"] scratchpad show; move position center'';
        "${modifier}+Shift+u" = ''exec --no-startup-id ${term} --title=dropdown-terminal'';
      };

      startup = [
        {
          command = "nm-applet --indicator";
          always = true;
        }
        {
          command = "mako";
          always = false;
        }
      ];
    };

    extraConfig = ''
      smart_gaps on

      seat seat0 xcursor_theme Adwaita 24

      bindsym --release F12 exec --no-startup-id flameshot gui

      for_window [class="zoom"] floating enable
      for_window [class="zoom"] sticky enable
      for_window [class="VirtualBox"] floating enable
      for_window [class="Gnome-control-center"] floating enable

      assign [class="Slack"] 2
      assign [class="Spotify"] 4

      for_window [title="dropdown-terminal"] floating enable
      for_window [title="dropdown-terminal"] sticky enable
      for_window [title="dropdown-terminal"] resize set 925 700
      for_window [title="dropdown-terminal"] move position center
      for_window [title="dropdown-terminal"] move scratchpad

      exec --no-startup-id ${term} --title=dropdown-terminal
      exec --no-startup-id i3-msg workspace 1
    '';
  };
}
