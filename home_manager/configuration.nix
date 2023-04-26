{
  stateVersion,
  username,
  ...
}: {
  imports = [
    ./polybar.nix
    ./i3.nix
  ];
  home = {
    homeDirectory = "/home/${username}";
    inherit stateVersion;
    sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
      BUN_INSTALL = "$HOME/.bun";
    };
    sessionPath = [
      "$HOME/.bun/bin"
    ];
  };
  programs = import ./programs.nix;
}
