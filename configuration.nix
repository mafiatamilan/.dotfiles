{ config, pkgs, lib, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  ########################################
  # Boot Configuration
  ########################################
  boot.loader.efi.canTouchEfiVariables = true;

  boot.loader.grub = {
    enable = true;
    devices = [ "nodev" ];
    efiSupport = true;
    useOSProber = true;
  };

  boot.kernelPatches = [
    {
      name = "DMIC";
      patch = /etc/nixos/patches/DMI.patch;
    }
  ];

  boot.kernelModules = [ "snd_pci_acp6x" ];
  hardware.firmware = [ pkgs.firmwareLinuxNonfree ];
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  ########################################
  # Networking
  ########################################
  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
  };

  ########################################
  # Localization and Time
  ########################################
  time.timeZone = "Asia/Kolkata";

  i18n.defaultLocale = "en_IN";
  i18n.extraLocaleSettings = {
    LC_ADDRESS        = "en_IN";
    LC_IDENTIFICATION = "en_IN";
    LC_MEASUREMENT    = "en_IN";
    LC_MONETARY       = "en_IN";
    LC_NAME           = "en_IN";
    LC_NUMERIC        = "en_IN";
    LC_PAPER          = "en_IN";
    LC_TELEPHONE      = "en_IN";
    LC_TIME           = "en_IN";
  };

  ########################################
  # Display and Desktop Environment
  ########################################
  services.xserver = {
    enable = true;
    desktopManager.plasma6.enable = true;
    xkb.layout = "us";
    videoDrivers = [ "nvidia" ];
  };
  services.displayManager.sddm.enable = true;

  ########################################
  # NVIDIA and AMD GPU Configuration
  ########################################
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    open = false;
    nvidiaSettings = true;

    prime = {
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };
      amdgpuBusId = "PCI:6:0:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };

  hardware.amdgpu.amdvlk.enable = true;

  ########################################
  # Printing
  ########################################
  services.printing.enable = true;

  ########################################
  # Audio Configuration
  ########################################
  hardware.alsa.enable = true;
  services.pulseaudio.enable = false;

  security.rtkit.enable = true;

  services.pipewire = {
    enable = lib.mkForce true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;

    extraConfig.pipewire."context.properties" = {
      "alsa.use-ucm" = false;
    };
  };

  ########################################
  # User Configuration
  ########################################
  users.users.yogs = {
    isNormalUser = true;
    description = "Yogs";
    shell = pkgs.zsh;
    extraGroups = [ "networkmanager" "wheel" "audio" ];

    packages = with pkgs; [
      firefox
      obs-studio
      neovim
      steam
      spotify
      discord
      alacritty
      cmake
      qt6.qtbase
      qt6.full
      qtcreator
      telegram-desktop
    ];
  };

  ########################################
  # Zsh and Powerlevel10k Configuration
  ########################################
  programs.zsh = {
    enable = true;
    enableBashCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
  };
  programs.zsh.ohMyZsh = {
    enable = true;
    plugins = [ "git" ];
    custom = "$HOME/.oh-my-zsh/custom/";
    theme = "powerlevel10k/powerlevel10k";
  };

  ########################################
  # Misc Programs and Features
  ########################################
  programs.appimage = {
    enable = true;
    binfmt = true;
  };

  programs.firefox.enable = true;

  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
  };

  programs.gamemode.enable = true;

  ########################################
  # Global Environment Variables for Qt6
  ########################################
  environment.variables = {
    QT_PLUGIN_PATH = "${pkgs.qt6.qtbase}/lib/qt-6/plugins";
    QML2_IMPORT_PATH = "${pkgs.qt6.qtdeclarative}/lib/qt-6/qml";
    PATH = "${pkgs.qt6.qtbase}/bin:${pkgs.qt6.qttools}/bin:${pkgs.qtcreator}/bin:\${PATH}";
  };

  ########################################
  # System Packages and Options
  ########################################
  environment.systemPackages = with pkgs; [
    zsh
    zsh-powerlevel10k

    # Dev tools
    android-tools
    git
    gh
    go
    tmux
    cmake
    gcc
    gdb
    python310Full

    pciutils
    usbutils
    inxi
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "25.05";
}
