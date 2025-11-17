{ config, pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    withNodeJs = true;
    withPython3 = true;
    withRuby = true;
  };


  #######################################
  # Install Kickstart.nvim configuration
  #######################################
  home.file."${config.xdg.configHome}/nvim".source = pkgs.fetchFromGitHub {
    owner = "nvim-lua";
    repo = "kickstart.nvim";
    rev = "master";
    sha256 = "0gs3c43f9liyf50a5ycdrzgfldn2rx24yfryr1qm8hfrnzrp97s7";
  };

  #######################################
  # Add compiler and build tools for Neovim plugins
  #######################################
  home.packages = with pkgs; [
    gcc          # C compiler
    gnumake      # For make-based builds
    pkg-config   # For detecting system libs
  ];
}

