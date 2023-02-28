{
  config,
  lib,
  pkgs,
  ...
}: let background_colour = "#262626"; in {
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
          left = "i3";
          right = "network audio date";
        };
        font = ["Hurmit Medium Nerd Font Complete Mono:size=14;2"];
        padding = {
          left = 3;
          right = 3;
        };
      };
      "module/network" = {
        type = "internal/network";
        interface-type = "wired";
        interval = 10.0;
        label = {
            connected = {
                text = "歷%local_ip%  龍%netspeed%";
                foreground = "#59ff64"
            };
            disconnected = {
                text = "轢No connection";
                foreground = "#ff8059"
            };
        };
      };
      "module/date" = {
        type = "internal/date";
        internal = 5;
        date = "%d.%m.%y";
        time = "%H:%M";
        label = " %date%  %time%";
        label-foreground = "#ffffff";
      };
      "module/audio" = {
        type = "internal/pulseaudio";
        use.ui.max = true;
        label = {
            volume = {text = " %percentage%"; foreground = "#00f28d";};
            muted = {text = " %percentage%"; foreground = "#f22000"};
        };
      };
      "module/i3" = {
        type = "internal/i3";
        index.sort = true;
        enable.click = true;
        enable.scroll = true;
        label = {
          focused = {
            text = "%index%";
            foreground = "#ff1764";
            background = background_colour;
          };
          unfocused = {
            text = "%index%";
            foreground = "#606060";
            background = background_colour;
          };
          urgent = {
            text = "%index%";
            foreground = "#ff0000";
            background = background_colour;
          };
          separator = {
            text = "|";
            padding = 3;
            foreground = "#ffb52a";
            background = background_colour;
          };
        };
      };
    };
  };
}
