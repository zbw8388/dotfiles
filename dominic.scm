(use-package-modules admin
                     chromium
		     disk
		     emacs
		     emacs-xyz
		     file
		     fonts
		     gnome
		     libreoffice
		     llvm
		     maths
		     node
		     rust
		     rust-apps
		     terminals
		     tls)

;; Nonfree packages
(use-modules (nongnu packages mozilla))

(packages->manifest
  (list
    ;; CLI tools
    htop
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
    gnome-themes-standard
    gnome-themes-extra
    gnome-icon-theme
    adwaita-icon-theme))

