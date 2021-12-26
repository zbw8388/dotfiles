(use-modules (base home))

(home-environment
 (packages %home-packages)
 (services (cons*
            (make-machine-service "xps-9700")
            %home-services)))
