{ config, pkgs, ... }:

{
  # The initial state version installation baseline
  home.stateVersion = "26.05";

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    # Add your personal CLI tools here later!
  ];

  home.file = {
    ".config/emacs".source = ./emacs;
    ".config/ghostty".source = ./ghostty;
    ".config/mpv".source = ./mpv;
    ".config/nvim".source = ./nvim;
    ".config/waybar".source = ./waybar;
    ".config/mako".source = ./mako;
    ".config/fuzzel".source = ./fuzzel;
  };


# Missing:
xdg.portal.wlr.enable = true; # For Wayland screen sharing

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

# Add to home.nix:
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
  cursorTheme = {
    name = "Bibata-Modern-Classic";
    package = pkgs.bibata-cursors;
  };
};


  programs.firefox = {
    enable = true;
    profiles.default = {
      isDefault = true;

      # 1. Nix pulls the core Betterfox v142 file automatically from GitHub
      extraConfig = ''
        ${builtins.readFile (pkgs.fetchFromGitHub {
          owner = "yokoffing";
          repo = "Betterfox";
          rev = "142.0";
          sha256 = "sha256-3xvZAMPdGfj8w2AaepWW5xAX05Ry+pN8peLMORKNTIc=";
        } + "/user.js")}

        // ====================================================
        // OMER'S CLEANED PERSONAL OVERRIDES
        // ====================================================

        // Allow websites to request location & notifications natively
        user_pref("permissions.default.geo", 0);
        user_pref("permissions.default.desktop-notification", 0);

        // Keep search suggestions active in the URL bar
        user_pref("browser.search.suggest.enabled", true);

        // Turn off Firefox Account Sync
        user_pref("identity.fxaccounts.enabled", false);

        // Always ask you where you want to download files
        user_pref("browser.download.useDownloadDir", false);

        // Strict HTTPS-Only handling for Private Browsing
        user_pref("dom.security.https_only_mode_pbm", true);
        user_pref("dom.security.https_only_mode_error_page_user_suggestions", true);

        // Prevent history from being cleared blindly on shutdown
        user_pref("privacy.clearOnShutdown.history", false);

        // Skip tracking parameters specifically for Reddit & Twitter embeds
        user_pref("urlclassifier.trackingSkipURLs", "embed.reddit.com, *.twitter.com, *.twimg.com");
        user_pref("urlclassifier.features.socialtracking.skipURLs", "*.twitter.com, *.twimg.com");
      '';
    };
  };
}
