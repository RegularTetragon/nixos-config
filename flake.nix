{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  inputs.nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
  inputs.nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-23.11";
  inputs.nixos-hardware.url = "github:NixOS/nixos-hardware";
  inputs.agenix.url = "github:ryantm/agenix";
  inputs.nur.url = "github:nix-community/NUR";
  inputs.home-manager.url = github:nix-community/home-manager;

  outputs = { self, agenix, nur, nixpkgs, nixpkgs-unstable, nixpkgs-stable, nixos-hardware, ... }@attrs:
    let
      system = "x86_64-linux";
      overlay-nixpkgs-unstable = final: prev: {
        unstable = import nixpkgs-unstable {
          inherit system;
	        config.allowUnfree = true;
	      };
        stable = import nixpkgs-stable {
          inherit system;
	        config.allowUnfree = true;
        };
      };
    in {
      nixosConfigurations.callisto = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = attrs;
        modules = [
          ({config, pkgs, ...}: {nixpkgs.overlays = [overlay-nixpkgs-unstable];})
          nur.nixosModules.nur
	  agenix.nixosModules.default
          # nixos-hardware.nixosModules.framework-13-7040-amd
          ./configuration.nix
	  ./callisto.nix
        ];
    };
  };
}
