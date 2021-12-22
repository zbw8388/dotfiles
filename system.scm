(use-modules (gnu)
             (gnu system nss)
             (gnu packages xorg)
             (gnu packages version-control)
             (gnu packages vim)
             (gnu packages linux)
             (gnu packages file-systems)
	         (gnu packages disk)
	         (gnu packages gnome)
	         (gnu packages audio)
	         (gnu packages pulseaudio)
	         (gnu packages ssh)
	         (gnu packages tls)
	         (gnu packages file)
             (nongnu packages linux)
             (nongnu system linux-initrd))

(use-service-modules cups desktop networking xorg)
(use-package-modules certs gnome)

;; Currently, building a kernel with custom options doesn't seem
;; to work. extra-options does nothing and this fails to build.
;;(define (config-linux package-linux config-path)
;;  (package
;;    (inherit package-linux)
;;    (native-inputs
;;     `(("kconfig" ,(local-file config-path))
;;     ,@(alist-delete "kconfig"
;;                     (package-native-inputs package-linux))))))

;;(define linux/xps17 (config-linux linux "./xps17.conf"))

(operating-system
 (host-name "guix")
 (timezone "America/New_York")
 (locale "en_US.utf8")

 ;; Use non-free linux kernel
 (kernel linux)
 (initrd microcode-initrd)
 (firmware (list linux-firmware sof-firmware))

 ;; Choose Colemak DH layout
 (keyboard-layout (keyboard-layout "us" "colemak_dh"))

 ;; Use the UEFI variant of GRUB with the EFI System
 ;; Partition mounted on /boot/efi.
 (bootloader (bootloader-configuration
              (bootloader grub-efi-bootloader)
              (targets (list "/boot/efi"))
              (keyboard-layout keyboard-layout)))

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

 ;; This is where we specify system-wide packages.
 (packages (append (list
		            ;; essentials
                    git
		            file
		            openssl
		            openssh
		            kmod
                    ;; file system tools
		            btrfs-progs
                    ntfs-3g
                    exfat-utils
                    fuse-exfat
		            dosfstools
                    ;; editors
                    vim
                    xterm
		            ;; gnome
		            gnome-tweaks
		            gnome-themes-extra
		            ;; audio
		            bluez
		            bluez-alsa
		            pulseaudio
                    ;; for HTTPS access
                    nss-certs
                    ;; for user mounts
                    gvfs)
                   %base-packages))

 ;; Add GNOME
 ;; Use the "desktop" services, which
 ;; include the X11 log-in service, networking with
 ;; NetworkManager, and more.
 (services (append (list (service gnome-desktop-service-type)
                         (set-xorg-configuration
                          (xorg-configuration
                           (keyboard-layout keyboard-layout)))
			             (bluetooth-service #:auto-enable? #t))
                   %desktop-services))

 ;; Allow resolution of '.local' host names with mDNS.
 (name-service-switch %mdns-host-lookup-nss))
