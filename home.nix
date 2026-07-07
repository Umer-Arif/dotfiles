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
    
    ".config/fastfetch".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/fastfetch/.config/fasfetch";

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

 
gtk = {
  enable = true;
  theme = {
    name = "Colloid-Dark-Everforest"; # Pure CSS, uses exact Everforest colors natively
    package = pkgs.colloid-gtk-theme.override {
      tweaks = [ "everforest" ];      # Compiles the explicit Everforest theme sheet
    };
  };
  iconTheme = {
    name = "Tela-green-dark";
    package = pkgs.tela-icon-theme;
  };
};


# Force GTK to read Everforest directly via the environment layout
home.sessionVariables = {
  GTK_THEME = "Everforest-Dark-B";
};

  # This is a separate top-level home-manager option
  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    name = "Bibata-Modern-Classic";
    package = pkgs.bibata-cursors;
    size = 24;
  };
}