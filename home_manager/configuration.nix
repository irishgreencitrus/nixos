{
  config,
  pkgs,
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
    };
  };
  programs = import ./programs.nix;
}
