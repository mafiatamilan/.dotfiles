{ config, pkgs, lib, ... }:

{
  imports = [
    ./modules/packages.nix
    ./modules/git.nix
    ./modules/neovim.nix
    ./modules/cursor.nix
    ./modules/alacritty.nix
    ./modules/waybar.nix
    ./modules/tmux.nix
    ./modules/zellij.nix
  ];

  home.username = "pdx";
  home.homeDirectory = "/home/pdx";
  home.stateVersion = "25.05";

  programs.home-manager.enable = true;
}

