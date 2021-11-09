{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      <nixos-hardware/dell/xps/15-9500>
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

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
      device = "/dev/disk/by-uuid/03dc3304-73b4-4871-9da3-1b0f760d8f36";
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

  services.xserver = {
    enable = true;

    dpi = 150;

    autoRepeatDelay = 200;
    autoRepeatInterval = 35;

    displayManager = {
      defaultSession = "none+i3";
      gdm = {
        enable = true;
        wayland = false;
      };
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

    windowManager.i3.enable = true;
  };

  nixpkgs.config.allowUnfree = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  users.users.grant = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    shell = pkgs.zsh;
  };
  users.users."grant-work" = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    shell = pkgs.zsh;
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    networkmanager
    networkmanagerapplet
    zsh
    git
    vim
  ];

  system.stateVersion = "21.11";
}

