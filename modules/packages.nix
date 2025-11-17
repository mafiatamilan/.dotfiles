{ pkgs, ... }:

{
  home.packages = with pkgs; [
    htop
    gh
    vscode
    spotify
    lua-language-server
    vlc
    seclists
    python313Packages.dirsearch
    pyright
    nodePackages.typescript-language-server
    figma-linux
    burpsuite
    discord
    obsidian
    nerd-fonts.fira-code

    wl-clipboard
    xclip
  ];
}

