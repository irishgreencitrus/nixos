# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  ...
}: let
  username = "lime";
  stateVersion = "22.11";
in {
  nix.settings.experimental-features = ["nix-command" "flakes"];
  nixpkgs.config.allowUnfree = true;

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  imports = [
    ./hardware-configuration.nix
  ];

  networking = {
    hostName = "pomegranate";
    hosts = {
      "192.168.1.70" = ["tangelo"];
    };
    firewall = {
      enable = true;
      allowPing = true;
      allowedTCPPorts = [];
      allowedUDPPorts = [];
    };
    networkmanager.enable = true;
  };

  time.timeZone = "Europe/London";

  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true;
  };

  sound.enable = true;

  users.users.${username} = {
    isNormalUser = true;
    extraGroups = ["wheel"];
    packages = with pkgs; [
      firefox
      nitrogen
      spotify
      playerctl
      kitty
      rofi
      dmenu
    ];
  };

  fonts = {
    fonts = with pkgs; [
      (nerdfonts.override {
        fonts = ["Hermit"];
      })
    ];
    fontDir.enable = true;
    enableDefaultFonts = true;
  };

  environment.systemPackages = with pkgs; [
    vim
    neovim
    wget
    git
    stdenvNoCC
    gcc
    zsh
    zip
    unzip
  ];

  services = {
    openssh = {
      enable = true;
      startWhenNeeded = true;
      ports = [22];
      settings.permitRootLogin = "no";
      openFirewall = true;
    };
    picom = {
      enable = true;
      vSync = true;
    };
    xserver = {
      enable = true;
      libinput.enable = true;
      displayManager = {
        sddm.enable = false;
        gdm.enable = true;
        lightdm.enable = false;
        defaultSession = "none+i3";
      };
      windowManager.i3 = {
        enable = true;
        extraPackages = with pkgs; [
          i3status
          i3lock
        ];
      };
      videoDrivers = ["intel" "modesetting"];
      layout = "gb";
      exportConfiguration = true;
    };
    printing.enable = true;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };
  };

  system.stateVersion = stateVersion;
  system.name = config.networking.hostName;

  hardware.opengl = {
    enable = true;
    driSupport = true;
    extraPackages = with pkgs; [
      intel-compute-runtime
      intel-media-driver
      vaapiIntel
      vaapiVdpau
      libvdpau-va-gl
    ];
  };
}
