{
    config,
    pkgs,
    ...
}: {
    users.users.lime = {
        isNormalUser = true;
    };
    system.stateVersion = "22.11";
    system.name = "sourkraut";

}
