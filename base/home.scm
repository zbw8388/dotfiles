(define-module (base home)
  #:export (make-home-module
            home-module?

            home-module-packages
            home-module-services))

(use-modules (gnu)
             (gnu services)
             (gnu home)
             (gnu home services)
             (srfi srfi-1)
             (srfi srfi-9))

(define-record-type <home-module>
  (make-home-module packages services)
  home-module?
  (packages home-module-packages)
  (services home-module-services))

(define-public (append-home-modules modules)
  (make-home-module
   (reduce append '() (map home-module-packages modules))
   (reduce append '() (map home-module-services modules))))

(define-public (make-machine-service machine)
  (simple-service 'dotfile-machine-name-environment-service
                  home-environment-variables-service-type
                  `(("DOTFILES_MACHINE" . ,machine))))

(use-modules (gnu packages shells)
             (gnu packages shellutils)
             (gnu home services shells))

(define %shell-packages (list
                         zsh
                         zsh-syntax-highlighting
                         zsh-autosuggestions))

(define %shell-services
  (list
   (service home-zsh-service-type
            (home-zsh-configuration
             (zshrc (list (plain-file "nix-env"
                                      "source /run/current-system/profile/etc/profile.d/nix.sh")))))

   (simple-service 'zsh-shell-service
                   home-environment-variables-service-type
                   `(("SHELL" . ,(file-append zsh "/bin/zsh"))))

   (simple-service 'dotfile-script-service
                   home-environment-variables-service-type
                   `(("PATH" . "$PATH:$HOME/.dotfiles/bin")))))

(define-public %shell-home-module
  (make-home-module %shell-packages %shell-services))

(use-modules (gnu packages admin)
             (gnu packages code)
             (gnu packages rust-apps)
             (gnu packages terminals))

(define-public %utilities-home-module
  (make-home-module (list
                     ;; CLI tools
                     htop
                     cloc
                     thefuck
                     ripgrep
                     fzf)
                    '()))

(use-modules (gnu packages emacs)
             (gnu packages emacs-xyz)
             (gnu packages haskell-xyz)
             (gnu packages haskell-apps)
             (gnu packages python-xyz)
             (gnu packages aspell))

(define-public %emacs-packages (list
                                emacs
                                ;; Doom extension dependencies
                                pandoc
                                python-isort
                                emacs-py-isort
                                nixfmt
                                ;; TODO: The rust analyzer package is broken as of 2021-12-25
                                ;; rust-analyzer
                                shellcheck
                                ispell))

(define-public %emacs-services
  (list
   ;; We're temporarily using doom-emacs until we roll a custom config.
   ;; Doom sync/init currently must be run manually.
   (simple-service 'doom-config-service
                   home-files-service-type
                   `(("doom.d/init.el" ,(local-file "../doom-emacs/init.el"))
                     ("doom.d/config.el" ,(local-file "../doom-emacs/config.el"))
                     ("doom.d/packages.el" ,(local-file "../doom-emacs/packages.el"))))))

(define-public %emacs-home-module
  (make-home-module %emacs-packages %emacs-services))

(use-modules (gnu packages rust))

(define-public %rust-home-module
  (make-home-module (list rust) '()))

(use-modules (gnu packages node))

(define-public %node-home-module
  (make-home-module (list node) '()))

(use-modules (gnu packages llvm))

(define-public %c-home-module
  (make-home-module (list clang-toolchain) '()))

(use-modules (gnu packages python))

(define-public %python-home-module
  (make-home-module (list python) '()))

(use-modules (gnu packages haskell)
             (gnu packages haskell-apps))

(define-public %haskell-home-module
  (make-home-module (list ghc hoogle) '()))

(use-modules (gnu packages racket))

(define-public %racket-home-module
  (make-home-module (list racket) '()))

(define-public %full-languages-home-module
  (append-home-modules (list
                        %rust-home-module
                        %node-home-module
                        %c-home-module
                        %python-home-module
                        %haskell-home-module
                        %racket-home-module)))

(define %nix-services
  (list
   (simple-service 'nix-unfree-config-service
                   home-files-service-type
                   `(("config/nixpkgs/config.nix" ,(plain-file "nix-unfree-config"
                                                                "{ allowUnfree = true; }"))))

   (simple-service 'nix-env-service
                   home-environment-variables-service-type
                   `(("PATH" . "$PATH:$HOME/.nix-profile/bin")
                     ("XDG_DATA_DIRS" . "$XDG_DATA_DIRS:$HOME/.nix-profile/share")
                     ("XDG_CONFIG_DIRS" . "$XDG_CONFIG_DIRS:$HOME/.nix-profile/etc/xdg")))))

(define-public %nix-home-module
  (make-home-module '() %nix-services))

(use-modules (nongnu packages mozilla)
             (gnu packages maths)
             (gnu packages libreoffice)
             (gnu packages inkscape)
             (gnu packages gimp)
             (gnu packages video)
             (gnu packages audio))

(define-public %applications-home-module
  (make-home-module (list
                     firefox
                     speedcrunch
                     libreoffice
                     inkscape
                     gimp
                     vlc
                     handbrake
                     ffmpeg
                     audacity)
                    '()))

(use-modules (gnu packages fonts)
             (gnu packages gnome))

(define-public %fonts-home-module
  (make-home-module (list
                     font-hack
                     font-adobe-source-han-sans
                     gnome-icon-theme
                     adwaita-icon-theme)
                    '()))

(use-modules (gnu packages ibus))

(define %jpn-input-packages (list
                             ibus
                             ibus-anthy))

(define %jpn-input-services
  (list
   (simple-service 'jpn-input-service
                   home-environment-variables-service-type
                   `(("GUIX_GTK2_IM_MODULE_FILE" . "$HOME/.guix-home/profile/lib/gtk-2.0/2.10.0/immodules-gtk2.cache")
                     ("GUIX_GTK3_IM_MODULE_FILE" . "$HOME/.guix-home/profile/lib/gtk-3.0/3.0.0/immodules-gtk3.cache")))))

(define-public %jpn-input-home-module
  (make-home-module %jpn-input-packages %jpn-input-services))

(use-modules (gnu packages education))

;; TODO: Can we set Anki up declaratively?
(define-public %jpn-study-home-module
  (make-home-module (list
                     anki)
                    '()))

(define-public %full-jpn-home-module
  (append-home-modules (list
                        %jpn-input-home-module
                        %jpn-study-home-module)))

(define-public %full-home-module
  (append-home-modules (list
                        %shell-home-module
                        %utilities-home-module
                        %emacs-home-module
                        %full-languages-home-module
                        %nix-home-module
                        %applications-home-module
                        %fonts-home-module
                        %full-jpn-home-module)))

(define-public %home-packages (home-module-packages %full-home-module))
(define-public %home-services (home-module-services %full-home-module))
