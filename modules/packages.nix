{ pkgs, ... }:

{
  home.packages = with pkgs; [
    htop
    gh
    vscode
    spotify
    lua-language-server
    seclists
    python313Packages.dirsearch
    pyright
    nodePackages.typescript-language-server
    figma-linux
    unityhub
    burpsuite
    discord
    obsidian
    nerd-fonts.fira-code

    wl-clipboard
    xclip
  ];
}

