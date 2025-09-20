{ pkgs, ... }:

{
  programs.alacritty = {
    enable = true;

    settings = {
      env.TERM = "xterm-256color";

      window = {
        padding = { x = 6; y = 6; };
        dynamic_padding = true;
        decorations = "full";
        opacity = 0.95;
        startup_mode = "Maximized";
      };

      font = {
        size = 12;
        normal = {
          family = "FiraCode Nerd Font";
          style = "Regular";
        };
      };

      colors = {
        primary = {
          background = "0x1d2021";
          foreground = "0xebdbb2";
        };
        normal = {
          black = "0x282828";
          red = "0xcc241d";
          green = "0x98971a";
          yellow = "0xd79921";
          blue = "0x458588";
          magenta = "0xb16286";
          cyan = "0x689d6a";
          white = "0xa89984";
        };
      };

      shell.program = "${pkgs.zsh}/bin/zsh";
    };
  };
}

