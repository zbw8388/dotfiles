{ config, pkgs, ... }:

let
  customNodePackages = import ./node/default.nix {};
in
  {
    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;

    # Home Manager needs a bit of information about you and the
    # paths it should manage.
    home.username = "dominic";
    home.homeDirectory = "/home/dominic";

    
      
    home.packages = with pkgs; [
      customNodePackages

      # CLI tools
      htop
      gh
      scc
      thefuck
      zellij
      ripgrep
      fzf
      openssl

      # Encrypted git files
      git-crypt
      gnupg
      pinentry
      
      # Rust
      rustup

      # Javascript
      nodejs
      yarn

      # C
      valgrind
      gdb
      gcc

      # Python
      python38

      # Coding tools
      alacritty
      vscode
      gitkraken
      filezilla
      docker
      docker-compose
      racket

      # Doom Emacs
      emacs
      fd
      nixfmt
      rustracer
      shellcheck

      # Communication
      discord
      slack
      zoom-us
      element-desktop

      # Productivity
      speedcrunch
      mailspring
      libreoffice
      todoist-electron
      pdfmixtool

      # Media
      inkscape
      gimp
      handbrake
      ffmpeg
      vlc
      audacity

      # Other apps
      _1password-gui
      google-chrome
      spotify

      # Fonts
      hack-font
      source-han-sans
      source-han-serif
      source-han-mono

      # Gnome extensions
      gnomeExtensions.ddterm
    ];

    # fish Shell
    programs.fish = {
      enable = true;
      plugins = [
        {
          name = "plugin-foreign-env";
          src = pkgs.fetchFromGitHub {
            owner = "oh-my-fish";
            repo = "plugin-foreign-env";
            rev = "dddd9213272a0ab848d474d0cbde12ad034e65bc";
            sha256 = "00xqlyl3lffc5l0viin1nyp819wf81fncqyz87jx8ljjdhilmgbs";
          };
        }
        {
          name = "pure";
          src = pkgs.fetchFromGitHub {
            owner = "pure-fish";
            repo = "pure";
            rev = "v4.1.1";
            sha256 = "1x1h65l8582p7h7w5986sc9vfd7b88a7hsi68dbikm090gz8nlxx";
          };
        }
        {
          name = "forgit";
          src = pkgs.fetchFromGitHub {
            owner = "wfxr";
            repo = "forgit";
            rev = "b727321f2bd3d79c1dae805441261c45888cbb41";
            sha256 = "1fb77a8j3pmpqih62x2ik0px04wdac6m9hl7gaf5jh07qbqygfld";
          };
        }
      ];
    };

    # GPG
    programs.gpg.enable = true;
    services.gpg-agent = {
      enable = true;
      pinentryFlavor = "gnome3";
    };

    # Doom emacs
    home.file.".doom.d" = {
      source = ./doom-emacs;
      onChange = "~/.emacs.d/bin/doom sync";
    };

    # Theming
    gtk.theme.name = "Adwaita-dark";
  }
