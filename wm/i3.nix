{ config, lib, pkgs, ... }:
let
  mod = "Mod1";
  term = "kitty";
in {
  imports = [
    ./i3/picom.nix
    ./i3/polybar.nix
    ./i3/rofi.nix
    ./i3/redshift.nix
    ./i3/dpi.nix
  ];

  xsession.windowManager.i3 = {
    enable = true;
    package = pkgs.i3-gaps;

    config = rec {
      modifier = "Mod1";
      terminal = term;

      bars = [];

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
        "${modifier}+p" = "exec ${pkgs.rofi}/bin/rofi -theme ${pkgs.rofi}/share/rofi/themes/android_notification.rasi -show run";

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
          command = "nm-applet";
          always = false;
          notification = false;
        }
        {
          command = "pasystray";
          always = false;
          notification = false;
        }
        {
          command = "${pkgs.xfce.xfce4-notifyd}/usr/lib/xfce4/notifyd/xfce4-notifyd";
          always = false;
          notification = false;
        }
        {
          command = "systemctl --user restart polybar.service";
          always = false;
          notification = false;
        }
      ];
    };

    extraConfig = ''
      smart_gaps on
      hide_edge_borders smart

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
      exec --no-startup-id feh --bg-scale ~/.config/nixpkgs/wm/wallpapers

      exec --no-startup-id sleep 1; xset dpms 0 600 0
      exec --no-startup-id sleep 1; xset s 300
      exec --no-startup-id xss-lock ~/.config/nixpkgs/wm/lockers/lock.sh

      exec --no-startup-id i3-msg workspace 1
    '';
  };

  xsession.enable = true;

  home.packages = with pkgs; [
    pasystray
    xautolock
    flameshot
    brightnessctl
    autorandr
    xfce.xfce4-notifyd
    xfce.thunar
    feh
    xss-lock
    i3lock-fancy-rapid
  ];
}
