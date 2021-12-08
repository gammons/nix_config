{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
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
      device = "/dev/disk/by-uuid/861d3515-e145-4d97-9229-8b7562d169ea";
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

    autoRepeatDelay = 200;
    autoRepeatInterval = 35;

    videoDrivers = [ "amdgpu" ];

    windowManager.i3.enable = true;

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
      amdvlk
    ];
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
    extraOptions = ''
      experimental-features = nix-command
      '';
  };

  system.stateVersion = "21.11";
}

