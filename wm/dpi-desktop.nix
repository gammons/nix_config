{ pkgs, ... }:
{
  xresources.properties = {
    "Xft.dpi" = 95; # desktop
  };

  xsession.pointerCursor = {
    package = pkgs.capitaine-cursors;
    name = "capitaine-cursors";
    size = 28;
  };

  services.polybar = {
    config = {
      "bar/main" = {
        height = 35;

        font-0 = "DejaVu Sans:size=12;0";
        font-1 = "Font Awesome 5 Free Regular:size=12;0:style=Solid";
        font-2 = "Font Awesome 5 Free Solid:size=12;0:style=Solid";
        font-3 = "Font Awesome 5 Brands Regular:size=12;0:style=Solid";
        font-4 = "Weather Icons:size=12;0";
        font-5 = "Material Icons:size=12;2";

        modules-right = "backlight cpuhz cpu volume whoami date";
      };
    };
  };
}
