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

        background = "#da222222";
        foreground = "#eee";

        underline-size = 2;
        underline-color = "#eee";

        spacing = 0;
        padding-left = 0;
        padding-right = 0;
        module-margin-left = 0;
        module-margin-right = 3;

        font-0 = "Roboto Mono:size=14;0";
        font-1 = "FontAwesome:size=14;0";
        font-2 = "Weather Icons:size=18;0";

        tray-position = "right";
        tray-padding = 2;
        tray-background = "#da222222";
        tray-offset-y=1;

        modules-left = "i3";
        modules-right = "battery cpu date";
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

        full-at = 99;

        battery = "BAT0";
        adapter = "AC0";

        poll-interval = 5;

        format-charging = "<animation-charging><label-charging>";
        format-discharging = "<ramp-capacity><label-discharging>";
        format-full = "<ramp-capacity><label-full>";
        label-charging = "%percentage%";
        label-discharging = "%percentage%";
        label-full = "%percentage%";
        format-charging-padding = 3;
        format-discharging-padding = 3;
        format-full-padding = 3;

        ramp-capacity-0 = "";
        ramp-capacity-1 = "";
        ramp-capacity-2 = "";
        ramp-capacity-3 = "";
        ramp-capacity-4 = "";

        animation-charging-0 = "";
        animation-charging-1 = "";
        animation-charging-2 = "";
        animation-charging-3 = "";
        animation-charging-4 = "";
        animation-charging-framerate = 750;
      };

    };

    script = ''
    polybar main &
    '';
  };
}


