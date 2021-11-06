{
  description = "Dominic's system config";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, ... }: 
  let
    system = "x86_64-linux";

    inherit (nixpkgs) lib;

    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };

  in {
    nixosConfigurations = {
      desktop = lib.nixosSystem {
        inherit system;

        modules = [
          ./system/configuration.nix
        ];
      };
    };
  };
}
