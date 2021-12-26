(define-module (base system))

(use-modules (gnu)
             (gnu system nss)
             (gnu packages gnome)
             (gnu packages xorg)
             (gnu packages linux)
             (nongnu packages linux)
             (nongnu system linux-initrd)

             ;; Packages
             (gnu packages version-control)
             (gnu packages vim)
             (gnu packages file-systems)
             (gnu packages disk)
             (gnu packages ssh)
             (gnu packages tls)
             (gnu packages file)
             (gnu packages ncurses))

(use-service-modules cups desktop networking xorg)
(use-package-modules certs gnome)

(define %colemak-layout (keyboard-layout "us" "colemak_dh"))

(define-public %base-operating-system
  (operating-system
   (host-name "guix")
   (timezone "America/New_York")
   (locale "en_US.utf8")

   ;; Use non-free linux kernel
   (kernel linux)
   (initrd microcode-initrd)
   (firmware (list linux-firmware))

   ;; Use Colemak DH layout
   (keyboard-layout %colemak-layout)

   ;; Create personal user account
   (users (cons (user-account
                 (name "dominic")
                 (comment "Dominic Martinez")
                 ;; create an initial password
                 ;; change this with passwd
                 (password (crypt "pass" "$6$abc"))
                 (group "users")
                 (supplementary-groups '("wheel" "netdev"
                                         "audio" "video")))
                %base-user-accounts))

   ;; Use the UEFI variant of GRUB
   (bootloader (bootloader-configuration
                (bootloader grub-efi-bootloader)
                (targets (list "/boot/efi"))))

   (file-systems (append
                  (list (file-system
                         ;; Guix root partition
                         (device (file-system-label "guix"))
                         (mount-point "/")
                         (type "btrfs"))
                        (file-system
                         ;; Boot partition
                         (device (file-system-label "BOOT"))
                         (mount-point "/boot/efi")
                         (type "vfat")))
                  %base-file-systems))

   (name-service-switch %mdns-host-lookup-nss)))

(define-public %system-packages (cons*
                                 ;; Essentials
                                 git
                                 file
                                 openssl
                                 openssh
                                 kmod
                                 vim
                                 xterm
                                 gparted
                                 ncurses

                                 ;; File system utils
                                 btrfs-progs
                                 ntfs-3g
                                 exfat-utils
                                 fuse-exfat
                                 dosfstools

                                 ;; Gnome
                                 gnome-tweaks
                                 gnome-themes-extra
                                 gnome-icon-theme
                                 adwaita-icon-theme

                                 ;; HTTPS access
                                 nss-certs

                                 ;; User mounts
                                 gvfs

                                 %base-packages))

(define-public %system-services (cons*
                                 ;; Activate Gnome desktop
                                 (service gnome-desktop-service-type)

                                 ;; Xorg keyboard layout
                                 (set-xorg-configuration
                                  (xorg-configuration
                                   (keyboard-layout %colemak-layout)))

                                 %desktop-services))
