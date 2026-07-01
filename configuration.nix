# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Essential kernel & hardware configurations for Kanata to function
  boot.kernelModules = [ "uinput" ];
  hardware.uinput.enable = true;

  # Networking configuration
  networking.hostName = "nixos"; # Define your hostname.
  networking.networkmanager.enable = true; # Enable networking

  # Enable Bluetooth support hardware layer
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true; # Powers up the controller immediately upon system startup
  };

  # Set your time zone.
  time.timeZone = "Asia/Karachi";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Enable the X11 windowing system & KDE Plasma Desktop
  services.xserver.enable = false;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # Add this line to manage audio routing properly
    wireplumber.enable = true; 
  };

  # Enable the Syncthing system service
 services.syncthing = {
    enable = true;
    user = "omer";
    dataDir = "/home/omer";
    configDir = "/home/omer/.config/syncthing";
    openDefaultPorts = true;
    overrideDevices = false;
    overrideFolders = false;
  };


  # systemd service configuration for Syncthing
   systemd.services.syncthing.wantedBy = pkgs.lib.mkForce [ ];
 
  # Define a user account. Don't forget to set a password with ‘passwd’.
   users.users."omer" = {
    isNormalUser = true;
    description = "omer-sama";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  # Define a user group for the user account.
  users.groups.omer = {};

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Install Niri
  programs.niri.enable = true ;

  # Install the hyprlock package
  programs.hyprlock.enable = true;

  # Require PAM authentication for hyprlock to safely verify your password
  security.pam.services.hyprlock = {};

  # List packages installed in system profile.
  environment.systemPackages = with pkgs; [
    git
    vim
    ghostty
    mpv
    kdePackages.kdenlive
    rclone
    syncthing
    pkgs.fastfetch
    aria2
    yt-dlp
    pkgs.emacs-pgtk
	  waybar
	  fuzzel
	  xwayland-satellite
	  mako          
    wl-clipboard
    blueman
    kdePackages.ark        
	  neovim     
	  gnumake    
    gcc       
	  pkgs.awww
    pkgs.home-manager
    arc-theme
    papirus-icon-theme
    bibata-cursors
    thunar                 
    thunar-volman           
    tumbler
    vscode
    pavucontrol
    blueman
    networkmanagerapplet
    loupe
    zathura
    firefox
    brightnessctl
  ];

    # Make sure everything is enclosed inside fonts = { ... };
  fonts = {
    packages = with pkgs; [
      iosevka-bin
      inter
      noto-fonts
      font-awesome
      nerd-fonts.symbols-only
      nerd-fonts.jetbrains-mono
    ];

    # This MUST be inside fonts, not floating on its own
    fontconfig = {
      enable = true;
      antialias = true;

      defaultFonts = {
        monospace = [ "Iosevka" ];
        sansSerif = [ "Inter" ];
        serif     = [ "Noto Serif" ];
      };

      hinting = {
        enable = true;
        style = "slight";
      };

      subpixel = {
        rgba = "rgb";
        lcdfilter = "default";
      };
    }; # End of fontconfig
  }; # End of fonts

# Enable xdg-desktop-portal and configure it to use GTK for file chooser dialogs
xdg.portal = {
  enable = true;
  # Add the lightweight gnome portal alongside your current gtk one
  extraPortals = [ pkgs.xdg-desktop-portal-gtk pkgs.xdg-desktop-portal-gnome ];

  config = {
    common = {
      default = [ "gtk" ];
    };
    # Route screencasting directly to GNOME so Kooha can capture the screen
    niri = {
      # Use pkgs.lib.mkForce here to override the niri module's built-in default
      default = pkgs.lib.mkForce [ "gtk" ];
      "org.freedesktop.impl.portal.ScreenCast" = [ "gnome" ];
      "org.freedesktop.impl.portal.Screenshot" = [ "gnome" ];
    };
  };
};



   # zsh shell configuration
  programs.zsh = {
    enable = true;
    enableCompletion = true; 

    # Clean double-quoted string completely eliminates the "unmatched '" bug
    promptInit = ''
      # 1. Force your custom star symbol fallback
      PROMPT_SYMBOL="✨" 

      # 2. Force the full path to show while omitting the Git metadata
      # The ''$ tells Nix to output a literal $ symbol into /etc/zshrc
      PROMPT=''${PROMPT_SYMBOL:-"✨"}' %{$fg_bold[cyan]%}%~%{$reset_color%} '
    '';

    # Declarative Oh My Zsh Framework Settings
    ohMyZsh = {
      enable = true;
      theme = "robbyrussell";  
      plugins = [ "git" "sudo" "colored-man-pages" ]; 
    };

    autosuggestions.enable = true; 
    syntaxHighlighting.enable = true; 
  };

     # Add to home.nix:
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  
  # Dconf
  programs.dconf.enable = true;

  # Set Zsh as the default shell for your user
  users.users.omer.shell = pkgs.zsh;

  # Enable GVfs service for mounting internal storage networks
  services.gvfs.enable = true;

  # Add hardware registration definitions for phone USB connections
  services.udev.packages = [ pkgs.libmtp ];


  # Kanata service setup
  services.kanata = {
    enable = true;
    keyboards = {
      default = {
        devices = [ ];
        config = ''
          (defsrc
            caps
          )
          (defalias
            capsec (tap-hold 200 100 esc lctl)
          )
          (deflayer default
            @capsec
          )
        '';
      };
    };
  };

  # System baseline settings and Flake features
  system.stateVersion = "26.05";
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
