{ config, pkgs, lib, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  ########################################
  # Boot Configuration
  ########################################
  boot = {
    loader = {
      efi.canTouchEfiVariables = true;
      grub = {
        enable = true;
        devices = [ "nodev" ];
        efiSupport = true;
        useOSProber = true;
      };
    };
    kernelPatches = [{
      name = "DMIC";
      patch = /etc/nixos/patches/DMI.patch;
    }];
    kernelModules = [ "snd_pci_acp6x" ];
    blacklistedKernelModules = [ "kvm_amd" "kvm" ];
  };

  ########################################
  # Hardware
  ########################################
  hardware = {
    firmware = [ pkgs.firmwareLinuxNonfree ];
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
    nvidia = {
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
    amdgpu.amdvlk.enable = true;
    alsa.enable = true;
  };

  ########################################
  # Networking
  ########################################
  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
  };

  services.create_ap = {
  enable = true;
  settings = {
    INTERNET_IFACE = "eth0";
    WIFI_IFACE = "wlan0";
    SSID = "My Wifi Hotspot";
    PASSPHRASE = "87654321";
   };
  };

  ########################################
  # Localization
  ########################################
  time.timeZone = "Asia/Kolkata";

  i18n = {
    defaultLocale = "en_IN";
    extraLocaleSettings = {
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
  };

  ########################################
  # Display / Desktop
  ########################################
  services.xserver = {
    enable = true;
    desktopManager.plasma6.enable = true;
    xkb.layout = "us";
    videoDrivers = [ "nvidia" ];
  };

  services.displayManager.sddm.enable = true;

  ########################################
  # Printing
  ########################################
  services.printing.enable = true;

  ########################################
  # Audio
  ########################################
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
  # Users
  ########################################
  users.users.yogs = {
    isNormalUser = true;
    description = "Yogs";
    shell = pkgs.zsh;
    extraGroups = [ "networkmanager" "wheel" "audio" "docker" ];
    packages = with pkgs; [
      firefox obs-studio neovim steam spotify discord alacritty
      cmake mitmproxy qt6.qtbase qt6.full qtcreator telegram-desktop
      burpsuite qemu vscode vlc    ];
  };

  users.extraGroups.vboxusers.members = [ "user-with-access-to-virtualbox" ];

  ########################################
  # Virtualization
  ########################################
  virtualisation = {
    virtualbox.host.enable = true;
    docker = {
      enable = true;
      storageDriver = "overlay2";
      rootless = {
        enable = true;
        setSocketVariable = true;
      };
    };
  };

  ########################################
  # Shell and Prompt
  ########################################
  programs.zsh = {
    enable = true;
    enableBashCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    ohMyZsh = {
      enable = true;
      theme = "powerlevel10k/powerlevel10k";
      plugins = [ "git" ];
      custom = "$HOME/.oh-my-zsh/custom/";
    };
  };

  ########################################
  # Programs
  ########################################
  programs = {
    nix-ld.enable = true;
    appimage = {
      enable = true;
      binfmt = true;
    };
    firefox.enable = true;
    steam = {
      enable = true;
      gamescopeSession.enable = true;
    };
    gamemode.enable = true;
  };

  ########################################
  # Environment Variables
  ########################################
  environment = {
    variables = {
      QT_PLUGIN_PATH = "${pkgs.qt6.qtbase}/lib/qt-6/plugins";
      QML2_IMPORT_PATH = "${pkgs.qt6.qtdeclarative}/lib/qt-6/qml";
      PATH = "${pkgs.qt6.qtbase}/bin:${pkgs.qt6.qttools}/bin:${pkgs.qtcreator}/bin:\${PATH}";
    };

    systemPackages = with pkgs; [
      zsh zsh-powerlevel10k android-tools git gh go tmux cmake gcc
      gdb python310Full openjdk8 pciutils usbutils inxi
    ];
  };

  ########################################
  # Fonts
  ########################################
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  ########################################
  # Misc
  ########################################
  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "25.05";
}
