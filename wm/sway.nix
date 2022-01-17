{ config, lib, pkgs, ... }:
let
  mod = "Mod1";
  term = "kitty";
  lockCmd = "~/.config/nixpkgs/wm/sway/swaylock/lock.sh";
  sleepCmd = "~/.config/nixpkgs/wm/sway/swaylock/sleep.sh";

  googleChromeOzone = pkgs.makeDesktopItem {
    name = "Chrome";
    desktopName = "Google Chrome (Ozone Support)";
    exec = "${pkgs.google-chrome}/bin/google-chrome-stable --enable-features=UseOzonePlatform --ozone-platform=wayland";
  };
  obsidianOzone = pkgs.makeDesktopItem {
    name = "ObsidianOzone";
    desktopName = "Obsidian (Ozone Support)";
    exec = "${pkgs.obsidian}/bin/obsidian --enable-features=UseOzonePlatform --ozone-platform=wayland --disable-gpu";
  };
  slackOzone = pkgs.makeDesktopItem {
    name = "SlackOzone";
    desktopName = "Slack (Ozone Support)";
    exec = "${pkgs.slack}/bin/slack --enable-features=UseOzonePlatform --ozone-platform=wayland";
  };
in {

  imports = [
    ./sway/mako.nix
  ];

  fonts.fontconfig.enable = true;

  systemd.user.targets.sway-session = {
    Unit = {
      Description = "sway compositor session";
      Documentation = [ "man:systemd.special(7)" ];
      BindsTo = [ "graphical-session.target" ];
      Wants = [ "graphical-session-pre.target" ];
      After = [ "graphical-session-pre.target" ];
    };
  };

  systemd.user.services.mako = {
    Unit.PartOf = [ "sway-session.target" ];
    Install.WantedBy = [ "sway-session.target" ];

    Service = {
      ExecStart = "${pkgs.mako}/bin/mako";
      Restart = "on-failure";
    };
  };

  services.gammastep = {
    enable = true;
    latitude = "40.06";
    longitude = "-75.30";
    temperature = {
      day = 6500;
      night = 3500;
    };
  };

  home.keyboard = {
    layout = "us, us";
    options = [
      "caps:ctrl_modifier"
    ];
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    TERM = "xterm-256color";
  };

  lib.sytemd.user = {
    startServices = true;

    services = {
      setxkbmap.Service.ExecStart = pkgs.lib.mkForce "${pkgs.coreutils}/bin/true";
    };
  };

  home.sessionVariables = {
    WLR_DRM_NO_MODIFIERS= 1;
    WLR_NO_HARDWARE_CURSORS = 1;
    GDK_BACKEND = "wayland";
    GDK_DPI_SCALE = 1;
    MOZ_ENABLE_WAYLAND = 1;
    QT_QPA_PLATFORM = "wayland-egl";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = 1;
    SDL_VIDEODRIVER = "wayland";
    _JAVA_AWT_WM_NONREPARENTING = 1;
  };

  home.packages = with pkgs; [
    # applications
    slackOzone
    googleChromeOzone
    obsidianOzone

    # sway things
    waybar
    swayidle
    wl-clipboard
    wofi
    wdisplays
    swaylock-effects
    grim
    slurp

    # themes
    gnome-themes-standard
    gnome3.adwaita-icon-theme

    gtk-engine-murrine
    gtk_engines
    gsettings-desktop-schemas
    lxappearance
  ];

  wayland.windowManager.sway = {
    enable = true;
    package = pkgs.i3-gaps;
    wrapperFeatures.gtk = true;

    config = rec {
      modifier = "Mod1";
      terminal = term;

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
        "*" = {
          bg = "~/.config/nixpkgs/wm/wallpapers/10-15-Day.jpg fill";
        };
        "eDP-1" = {
          scale = "1.65";
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
        "${modifier}+bracketleft" = "move workspace to output eDP-1";
        "${modifier}+bracketright" = "move workspace to output DP-3";

        "${modifier}+F4" = "exec --no-startup-id playerctl previous";
        "${modifier}+F5" = "exec --no-startup-id playerctl play-pause";
        "${modifier}+F6" = "exec --no-startup-id playerctl next";

        "${modifier}+F7" = "exec --no-startup-id ~/.config/nixpkgs/bin/mobile.sh";
        "${modifier}+F8" = "exec --no-startup-id ~/.config/nixpkgs/bin/dock.sh";

        "${modifier}+F11" = "exec --no-startup-id brightnessctl set 5%-";
        "${modifier}+F12" = "exec --no-startup-id brightnessctl set +5%";

        "${modifier}+Shift+F12" = ''exec --no-startup-id grim -g "$(slurp -d)" - | wl-copy'';

        "${modifier}+u" = ''[title="dropdown-terminal"] scratchpad show; move position center'';
        "${modifier}+Shift+u" = ''exec --no-startup-id ${term} --title=dropdown-terminal'';
      };

      startup = [
        {
          command = "nm-applet --indicator";
          always = true;
        }
        {
          command = "waybar -c ~/.config/nixpkgs/wm/sway/waybar/config -s ~/.config/nixpkgs/wm/sway/waybar/style.css";
          always = true;
        }
        {
          command = ''swayidle timeout 300 "${lockCmd}" timeout 1800 ${sleepCmd} before-sleep "${lockCmd}"'';
          always = false;
        }
      ];
    };

    extraConfig = ''
      smart_gaps on

      seat seat0 xcursor_theme Adwaita 24

      hide_edge_borders smart

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
