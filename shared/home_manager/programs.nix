{
  home-manager.enable = true;
  bash = {
    enable = true;
    bashrcExtra = "source ~/.profile";
  };
  zsh = {
    enable = true;
    autocd = true;
  };
  kitty = {
    enable = true;
    font = {
      name = "Hurmit Medium Nerd Font Complete Mono";
      size = 11;
    };
  };
  starship = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
  };
  nushell = {
    enable = true;
  };
}
