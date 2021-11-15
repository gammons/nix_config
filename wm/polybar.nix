{ pkgs, ... }:
{
  services.polybar = {
    enable = true;

    package = pkgs.polybar.override {
      i3Support = true;
      githubSupport = true;
    };

    config = {
      "bar/main" = {
        width = "100%";
        height = 50;
        "offset-x" = 0;
        "offset-y" = -1;

        background = "#1f1f1f";
        foreground = "#eee";

        underline-size = 2;
        underline-color = "#eee";

        spacing = 0;
        padding-left = 0;
        padding-right = 0;
        module-margin-left = 0;
        module-margin-right = 3;

        font-0 = "DejaVu Sans:size=14;0";
        font-1 = "Font Awesome 5 Free Regular:size=14;0:style=Solid";
        font-2 = "Font Awesome 5 Free Solid:size=14;0:style=Solid";
        font-3 = "Font Awesome 5 Brands Regular:size=14;0:style=Solid";
        font-4 = "Weather Icons:size=18;0";
        font-5 = "Material Icons:size=14;2";

        tray-position = "right";
        tray-padding = 2;
        tray-background = "#da222222";
        tray-offset-y=1;

        modules-left = "i3";
        modules-center = "weather docn_stonk";
        modules-right = "power_now backlight battery cpuhz cpu volume whoami date";
      };

      "module/i3" = {
        type = "internal/i3";
        label-focused = "%index%";
        label-focused-background = "#da555555";
        label-focused-padding = "2";

        label-unfocused = "%index%";
        label-unfocused-padding = "2";
      };

      "module/cpu" = {
        type = "internal/cpu";
        interval = 2;
        format = "<label> <ramp-coreload>";

        label = "CPU";
        label-font = 3;
        label-foreground = "#99";

        ramp-coreload-0 = "▁";
        ramp-coreload-0-font = 2;
        ramp-coreload-0-foreground = "#aaff77";
        ramp-coreload-1 = "▂";
        ramp-coreload-1-font = 2;
        ramp-coreload-1-foreground = "#aaff77";
        ramp-coreload-2 = "▃";
        ramp-coreload-2-font = 2;
        ramp-coreload-2-foreground = "#aaff77";
        ramp-coreload-3 = "▄";
        ramp-coreload-3-font = 2;
        ramp-coreload-3-foreground = "#aaff77";
        ramp-coreload-4 = "▅";
        ramp-coreload-4-font = 2;
        ramp-coreload-4-foreground = "#fba922";
        ramp-coreload-5 = "▆";
        ramp-coreload-5-font = 2;
        ramp-coreload-5-foreground = "#fba922";
        ramp-coreload-6 = "▇";
        ramp-coreload-6-font = 2;
        ramp-coreload-6-foreground = "#ff5555";
        ramp-coreload-7 = "█";
        ramp-coreload-7-font = 2;
        ramp-coreload-7-foreground = "#ff5555";
      };

      "module/temperature" = {
        type = "internal/temperature";
        interval = 2;
        label-padding = 5;
      };

      "module/date" = {
        type = "internal/date";
        interval = "2.0";
        date = "%a %b %d,";
        time = "%H:%M";
        date-alt = "%A, %d %B %Y";
        time-alt = "%H:%M:%S";
        label = "%date% %time%";
        format = "   <label>";
        format-padding = 5;
      };

      "module/battery" = {
        type = "internal/battery";
        time-format = "%H:%M";

        full-at = 98;

        battery = "BAT0";
        adapter = "AC0";

        poll-interval = 5;

        format-charging = "<animation-charging> <label-charging>";
        format-discharging = "<ramp-capacity> <label-discharging>";
        format-full = "<ramp-capacity> <label-full>";

        label-charging = "%percentage%% %time%h";
        label-discharging = "%percentage%% %time%h ";
        ramp-capacity-0 = "";
        ramp-capacity-0-foreground = "#f53c3c";
        ramp-capacity-1 = "";
        ramp-capacity-1-foreground = "#ffa900";
        ramp-capacity-2 = "";
        ramp-capacity-3 = "";
        ramp-capacity-4 = "";

        bar-capacity-width = 10;
        bar-capacity-format = "%{+u}%{+o}%fill%%empty%%{-u}%{-o}";
        bar-capacity-fill = "█";
        bar-capacity-fill-foreground = "#ddffffff";
        bar-capacity-fill-font = 3;
        bar-capacity-empty = "█";
        bar-capacity-empty-font = 3;
        bar-capacity-empty-foreground = "#44ffffff";

        animation-charging-0 = "";
        animation-charging-1 = "";
        animation-charging-2 = "";
        animation-charging-3 = "";
        animation-charging-4 = "";
        animation-charging-framerate = 750;
      };

      "module/backlight" = {
        type = "internal/backlight";
        card = "intel_backlight";
        format = "<ramp> <label>";
        label = "%percentage%";

        ramp-0 = "";
        ramp-1 = "";
        ramp-2 = "";
      };

      "module/volume" = {
        type = "internal/volume";

        format-volume = "<ramp-volume><label-volume>";
        format-muted = "<label-muted>";
        label-volume = "%percentage%";
        label-muted = "  muted";
        label-muted-foreground = "#aaa";
        format-volume-padding = 3;
        format-muted-padding = 3;

        ramp-volume-0 = "";
        ramp-volume-1 = "";
        ramp-volume-2 = "";
        ramp-headphones-0 = "";
      };

      "module/cpuload" = {
        type = "custom/script";
        interval = 5;
        exec = "~/.config/nixpkgs/wm/polybar/cpuload.sh";
      };

      "module/power_now" = {
        type = "custom/script";
        interval = 5;
        exec = "~/.config/nixpkgs/wm/polybar/power_now";
      };

      "module/docn_stonk" = {
        type = "custom/script";
        interval = 5;
        exec = "~/.nix-profile/bin/ruby ~/.config/nixpkgs/wm/polybar/stonks.rb DOCN";
      };

      "module/cpuhz" = {
        type = "custom/script";
        interval = 5;
        exec = "~/.config/nixpkgs/wm/polybar/cpupower.sh";
      };

      "module/weather" = {
        type = "custom/script";
        label = "%{T3}%output%";
        interval = 200;
        exec = "~/.nix-profile/bin/ruby ~/.config/nixpkgs/wm/polybar/polyweather.rb";
      };

      "module/whoami" = {
        type = "custom/script";
        label = "%{T3}%output%";
        exec = "/run/current-system/sw/bin/whoami";
        format = " <label>";
      };

    };

    script = ''
    polybar main &
    '';
  };
}


