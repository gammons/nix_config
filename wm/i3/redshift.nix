{ pkgs, ... }:
{
  services.redshift = {
    enable = true;

    # package = pkgs.redshift-wlr;
    #extraOptions = [ "-v" "-m" "wayland" ];

    temperature = {
      day = 6500;
      night = 4200;
    };

    latitude = "40.07";
    longitude = "-75.30";
  };
}
