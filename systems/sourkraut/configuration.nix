{
  config,
  pkgs,
  ...
}: {
  imports = [<nixpkgs/nixos/modules/virtualisation/qemu-vm.nix>];
  virtualisation.vmVariant.virtualisation = {
    memorySize = 4096; # Use 2048MiB memory.
    cores = 4; # Simulate 4 cores.
  };
  users.users.lime = {
    isNormalUser = true;
    initialPassword = "changeme";
    extraGroups = ["wheel"];
  };
  networking.hostName = "sourkraut";
  networking.networkmanager.enable = true;
  system.stateVersion = "22.11";
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };
  time.timeZone = "Europe/London";

  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true;
  };
}
