{
    config,
    pkgs,
    ...
}: {
      imports = [ <nixpkgs/nixos/modules/virtualisation/qemu-vm.nix> ];
      virtualisation.vmVariant = {
        virtualisation = {
        memorySize = 4096; # Use 2048MiB memory.
        cores = 4;         # Simulate 4 cores.
        };
      };
    users.users.lime = {
        isNormalUser = true;
    };
    system.stateVersion = "22.11";
    system.name = "sourkraut";

}
