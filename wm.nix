{ config, lib, pkgs, ... }:
let
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
    ./wm/sway.nix
    ./wm/kitty.nix
    ./wm/mako.nix
  ];

  fonts.fontconfig.enable = true;

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

  home.packages = with pkgs; [
    # applications
    slack
    slackOzone

    google-chrome
    googleChromeOzone

    obsidian
    obsidianOzone

    spotify
    pavucontrol
    jdk11

    # fonts
    roboto-mono
    font-awesome-ttf
    material-icons
    weather-icons

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

    # desktop env things
    playerctl
    keychain
    pasystray
    flameshot
    brightnessctl
    gammastep
    xfce.thunar
    ruby # for a quick irb shell
  ];
}
