# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  unstable-pkgs,
  zest-pkgs,
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

  boot.supportedFilesystems = ["ntfs" "btrfs"];

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
      allowedTCPPorts = [25565 9225 5005];
      allowedUDPPorts = [5005];
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
    extraGroups = ["wheel" "docker" "libvirtd"];
    packages = with pkgs; [
      nitrogen
      vlc
      system-config-printer
      libreoffice
      xclip
      xsel
      obs-studio
      pavucontrol
      htop
      spotify
      playerctl
      kitty
      rofi
      dmenu
    ] ++ [
        unstable-pkgs.blender
        unstable-pkgs.firefox
        unstable-pkgs.thunderbird
        unstable-pkgs.zscroll
        unstable-pkgs.ripgrep
        zest-pkgs.godot-bin
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
    pulseaudio # Install the helper functions for pipewire-pulse
    python310
    python310Packages.pip
    nodejs
    rustup
    julia-bin
    ntfs3g
    exfat
    exfatprogs
    virt-manager
    pamixer
    neovim
    emacs
    vim
    wget
    git
    stdenvNoCC
    gcc
    zsh
    zip
    unzip
  ];
  xdg.portal = {
    enable = true;
    extraPortals = [pkgs.xdg-desktop-portal-gtk];
  };

  services = {
    flatpak.enable = true;
    openssh = {
      enable = true;
      startWhenNeeded = true;
      ports = [22];
      permitRootLogin = "no";
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
        lightdm = {
          enable = true;
          greeters.enso.enable = true;
        };
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
    avahi = {
      enable = true;
      nssmdns = true;
      openFirewall = true;
    };
    printing = {
      drivers = [pkgs.cnijfilter2 pkgs.gutenprint];
      enable = true;
    };
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };
  };
  programs.dconf.enable = true;

  virtualisation = {
    docker = {
      enable = true;
      storageDriver = "btrfs";
    };
    libvirtd.enable = true;
  };

  system.stateVersion = stateVersion;
  system.name = config.networking.hostName;
  nixpkgs.config.packageOverrides = pkgs: {
    vaapiIntel = pkgs.vaapiIntel.override {enableHybridCodec = true;};
  };

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
    extraPackages32 = with pkgs.pkgsi686Linux; [vaapiIntel];
  };
}
