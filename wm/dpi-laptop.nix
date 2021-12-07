{ pkgs, ... }:
{
  xresources.properties = {
    "Xft.dpi" = 150; # laptop
  };

  xsession.pointerCursor = {
    package = pkgs.capitaine-cursors;
    name = "capitaine-cursors";
    size = 36;
  };

  services.polybar = {
    config = {
      "bar/main" = {
        height = 50;

        font-0 = "DejaVu Sans:size=14;0";
        font-1 = "Font Awesome 5 Free Regular:size=14;0:style=Solid";
        font-2 = "Font Awesome 5 Free Solid:size=14;0:style=Solid";
        font-3 = "Font Awesome 5 Brands Regular:size=14;0:style=Solid";
        font-4 = "Weather Icons:size=14;0";
        font-5 = "Material Icons:size=14;2";

        modules-right = "power_now backlight battery cpuhz cpu volume whoami date";
      }
    }
  }
}
