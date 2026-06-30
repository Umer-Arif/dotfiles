{ config, pkgs, ... }:

{
  # The initial state version installation baseline
  home.stateVersion = "26.05";

  programs.home-manager.enable = true;


  home.packages = with pkgs; [
    # Add your personal CLI tools here later!
  ];

  home.file = {
    ".emacs.d".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/emacs/.emacs.d";
    ".config/ghostty".source = ./ghostty/.config/ghostty;
    ".config/mpv".source = ./mpv/.config/mpv;
    ".config/nvim".source = ./nvim/.config/nvim;
    ".config/waybar".source = ./waybar/.config/waybar;
    ".config/mako".source = ./mako/.config/mako;
    ".config/fuzzel".source = ./fuzzel/.config/fuzzel;
    ".config/niri".source = ./niri/.config/niri;
    ".config/hypr".source = ./hypr/.config/hypr;
  };

  programs.emacs = {
    enable = true;
    package = pkgs.emacs; # No more custom symlinkJoin wrapper!

    extraPackages = epkgs: [
      epkgs.treesit-grammars.with-all-grammars
      epkgs.envrc       
    ];
  };


  # Add to home.nix:
programs.direnv = {
  enable = true;
  nix-direnv.enable = true;
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