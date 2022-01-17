{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      <nixos-hardware/dell/xps/15-9500>
      ./hardware-configuration.nix
    ];

  ####################################
  # Boot config
  ####################################

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  boot.loader.grub = {
    enable = true;
    efiSupport = true;
    version = 2;
    enableCryptodisk = true;
    device = "nodev";
  };

  boot.initrd.luks.devices = {
    crypted = {
      preLVM = true;
      device = "/dev/disk/by-uuid/a5b34ce5-7ecc-4e25-8e32-e612cc695415";
    };
  };

  # Set your time zone.
  time.timeZone = "America/New_York";

  ####################################
  # Networking setup
  ####################################

  networking.useDHCP = false;
  networking.interfaces.wlp0s20f3.useDHCP = false;
  networking.networkmanager.enable = true;

  ####################################
  # X11
  ####################################

  programs.sway.enable = true;

  services.xserver = {
    enable = true;

    autoRepeatDelay = 200;
    autoRepeatInterval = 35;

    windowManager.i3.enable = true;

    displayManager = {
      defaultSession = "sway"; # or "none+i3"

      lightdm.enable = true; # gdm doesn't work with sway for uknown reasons
    };

    libinput = {
      enable = true;

      touchpad = {
        disableWhileTyping = true;
        tapping = false;
        naturalScrolling = true;
        clickMethod = "clickfinger";
      };
    };
  };

  nixpkgs.config.allowUnfree = true;

  ####################################
  # Sound
  ####################################

  sound.enable = true;
  hardware.pulseaudio.enable = true;

  ####################################
  # Users
  ####################################

  users.users.grant = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ]; # Enable ‘sudo’ for the user.
    shell = pkgs.zsh;
  };
  users.users."grant-work" = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ]; # Enable ‘sudo’ for the user.
    shell = pkgs.zsh;
  };

  ####################################
  # System packages
  ####################################

  environment.systemPackages = with pkgs; [
    networkmanager
    networkmanagerapplet
    networkmanager-openconnect
    zsh
    git
    vim
  ];

  ####################################
  # Accelerated video playback
  ####################################

  hardware.opengl = {
    enable = true;
    driSupport = true;

    extraPackages = with pkgs; [
      intel-media-driver # LIBVA_DRIVER_NAME=iHD
      vaapiIntel         # LIBVA_DRIVER_NAME=i965 (older but works better for Firefox/Chromium)
      vaapiVdpau
      libvdpau-va-gl
    ];
  };

  nixpkgs.config.packageOverrides = pkgs: {
    vaapiIntel = pkgs.vaapiIntel.override { enableHybridCodec = true; };
  };

  ####################################
  # Libinput multiplier
  ####################################

  nixpkgs.overlays = [
    (self: super: {
     libinput = super.libinput.overrideAttrs (attrs: {
       patches = (attrs.patches or []) ++ [ ./multiplier.patch ];
     });
    })
  ];

  nix = {
    package = pkgs.nixUnstable; # or versioned attributes like nix_2_4
      extraOptions = ''
      experimental-features = nix-command flakes
      '';
  };

  system.stateVersion = "21.11";
}

