(use-modules (base system))

(operating-system
 (inherit %base-operating-system)
 (packages %system-packages)
 (services %system-services))
