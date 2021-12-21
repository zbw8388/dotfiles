(use-modules (gnu home)
	     (gnu home services)
	     (gnu home services shells)
	     (gnu services)
	     (guix gexp)
	     (gnu packages admin)
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
	     (gnu packages terminals)
	     (gnu packages tls)
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
    openssl
    file

    ;; Languages
    rust
    node
    clang-toolchain

    ;; Editors
    emacs
    emacs-all-the-icons

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
		 (guix-defaults? #t))))))

