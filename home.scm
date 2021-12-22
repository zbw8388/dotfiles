(use-modules (gnu home)
	         (gnu home services)
	         (gnu home services shells)
	         (gnu services)
	         (guix gexp)
	         (gnu packages admin)
	         (gnu packages code)
	         (gnu packages chromium)
	         (gnu packages disk)
	         (gnu packages emacs)
	         (gnu packages emacs-xyz)
	         (gnu packages file)
	         (gnu packages fonts)
	         (gnu packages gnome)
	         (gnu packages libreoffice)
	         (gnu packages llvm)
	         (gnu packages maths)
	         (gnu packages node)
	         (gnu packages rust)
	         (gnu packages rust-apps)
	         (gnu packages ssh)
	         (gnu packages terminals)
	         (gnu packages tls)
	         (gnu packages package-management)
	         (gnu packages haskell-apps)
	         (gnu packages python)
	         (gnu packages python-xyz)
	         (gnu packages haskell)
	         (gnu packages haskell-xyz)
	         (gnu packages racket)
	         ;; Non-free packages
             (nongnu packages mozilla))

(home-environment
  (packages 
    (list
     ;; CLI tools
     htop
     cloc
     thefuck
     ripgrep
     fzf

     ;; Languages
     rust
     node
     clang-toolchain
     nix
     nixfmt
     python
     ghc
     hoogle
     racket

     ;; Emacs
     emacs
     emacs-all-the-icons
     pandoc
     python-isort
     emacs-py-isort
     rust-analyzer
     shellcheck

     ;; Browsers
     ungoogled-chromium
     firefox

     ;; Productivity
     speedcrunch
     libreoffice

     ;; Utilities
     gparted

     ;; Fonts
     font-hack
     font-adobe-source-han-sans

     ;; Gnome
     gnome-icon-theme
     adwaita-icon-theme))
  (services
   (list
    (service home-bash-service-type
	         (home-bash-configuration
		      (guix-defaults? #t)))

    (simple-service 'doom-config-service
		            home-files-service-type
		            (list `("doom.d/init.el" ,(local-file "./doom-emacs/init.el"))
			              `("doom.d/config.el" ,(local-file "./doom-emacs/config.el"))
			              `("doom.d/packages.el" ,(local-file "./doom-emacs/packages.el"))))

    (simple-service 'doom-sync-service
		            home-run-on-change-service-type
		            (list `("files/doom.d/" ,(system* "~/.emacs.d/bin/doom" "sync")))))))
