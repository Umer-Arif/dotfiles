{ config, pkgs, ... }:

{
  # The initial state version installation baseline
  home.stateVersion = "26.05";

  programs.home-manager.enable = true;


  home.packages = with pkgs; [
    # Add your personal CLI tools here later!
    cmake
    pkg-config
    gcc
  ];

 home.file = {
    ".emacs.d".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/emacs/.emacs.d";
    
    ".config/ghostty".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/ghostty/.config/ghostty";
    
    ".config/mpv".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/mpv/.config/mpv";
    
    ".config/nvim".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/nvim/.config/nvim";
    
    ".config/waybar".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/waybar/.config/waybar";
    
    ".config/mako".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/mako/.config/mako";
    
    ".config/fuzzel".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/fuzzel/.config/fuzzel";
    
    ".config/niri".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/niri/.config/niri";
    
    ".config/hypr".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/hypr/.config/hypr";
    
    ".config/zathura".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/zathura/.config/zathura";
};

  
 programs.emacs = {
    enable = true;
    # Bug Fix: Changed from pkgs.emacs to pkgs.emacs-pgtk
    package = pkgs.emacs-pgtk; 

    extraPackages = epkgs: [
      epkgs.treesit-grammars.with-all-grammars
      epkgs.envrc   
      epkgs.vterm    
    ];
};

programs.fastfetch = {
  enable = true;
  settings = {
    logo = {
      type = "small";
    };
    display = {
      separator = "  ";
    };
    modules = [
      {
        type = "title";
        key = "  user ";
        keyColor = "31";
      }
      {
        type = "host";
        key = "    hname";
        keyColor = "32";
      }
      {
        type = "uptime";
        key = "    uptime";
        keyColor = "33";
      }
      {
        type = "os";
        key = "    distro";
        keyColor = "34";
      }
      {
        type = "kernel";
        key = "    kernel";
        keyColor = "35";
      }
      {
        type = "terminal";
        key = "  term  ";
        keyColor = "36";
      }
      {
        type = "shell";
        key = "  shell ";
        keyColor = "37";
      }
      {
        type = "cpu";
        key = "  cpu   ";
        keyColor = "34";
      }
      {
        type = "disk";
        key = "    disk  ";
        keyColor = "35";
      }
      {
        type = "memory";
        key = "  memory";
        keyColor = "36";
      }
    ];
  };
};


 
  gtk = {
    enable = true;
    theme = {
      name = "Arc-Dark";
      package = pkgs.arc-theme;
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
  }; # <--- Make sure this semicolon closes the GTK block!

  # This is a separate top-level home-manager option
  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    name = "Bibata-Modern-Classic";
    package = pkgs.bibata-cursors;
    size = 24;
  };
}