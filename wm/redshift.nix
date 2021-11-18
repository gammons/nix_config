{ pkgs, ... }:
{
  services.redshift = {
    enable = true;

    temperature = {
      day = 6500;
      night = 4200;
    };

    latitude = "40.07";
    longitude = "-75.30";
  };
}
