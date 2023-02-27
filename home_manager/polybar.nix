{
  config,
  lib,
  pkgs,
  ...
}: {
  services.polybar = {
    package = pkgs.polybar.override {
      i3Support = true;
      alsaSupport = true;
      pulseSupport = true;
    };
    enable = true;
    script = "polybar top &";
    settings = {
      "bar/top" = {
        width = "100%";
        height = "2%";
        radius = 3;
        modules = {
          right = "date";
          left = "i3";
        };
        font = ["Hurmit Medium Nerd Font Complete Mono:size=14;2"];
        padding = {
          left = 3;
          right = 3;
        };
      };
      "module/date" = {
        type = "internal/date";
        internal = 5;
        date = "%d.%m.%y";
        label = "%date%";
      };
      "module/i3" = {
        type = "internal/i3";
        index.sort = true;
        enable.click = true;
        enable.scroll = true;
        label = {
          focused = {
            text = "%index%";
            foreground = "#22ff22";
            background = "#000000";
          };
          unfocused = {
            text = "%index%";
            foreground = "#222222";
            background = "#000000";
          };
          urgent = {
            text = "%index%";
            foreground = "#ff0000";
            background = "#000000";
          };
          separator = {
            text = "|";
            padding = 3;
            foreground = "#ffb52a";
            background = "#000000";
          };
          #mode = "%index%| %mode";
          #padding = 2;
          #background = ""
        };
      };
    };
  };
}
