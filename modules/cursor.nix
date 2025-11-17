# Save this as: ./modules/cursor.nix
{ config, pkgs, ... }:

{
  # Install Catppuccin cursor theme
  home.packages = with pkgs; [
    catppuccin-cursors.mochaDark
    # Alternative options:
    # catppuccin-cursors.mochaPeach
    # catppuccin-cursors.latteDark
    # catppuccin-cursors.latteRosewater
  ];

  # Set cursor theme system-wide
  home.pointerCursor = {
    package = pkgs.catppuccin-cursors.mochaDark;
    name = "catppuccin-mocha-dark-cursors";
    size = 24; # Adjust size: 16, 24, 32, or 48
    gtk.enable = true;
    x11.enable = true;
  };

  # Set GTK cursor theme (for GTK apps)
  gtk = {
    enable = true;
    cursorTheme = {
      package = pkgs.catppuccin-cursors.mochaDark;
      name = "catppuccin-mocha-dark-cursors";
      size = 24;
    };
  };
}
