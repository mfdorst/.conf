{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = {nixpkgs, home-manager, sops-nix, nixos-generators, ...}:
  let
    pkgs = import nixpkgs {
      system = "x86_64-linux";
      config.allowUnfree = true;
    };
  in {
    nixosConfigurations = {
      nixos-linode = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit home-manager; };
        modules = [ ./nixos/linode/configuration.nix ];
      };
      nixos-desktop = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit home-manager; };
        modules = [ ./nixos/desktop/configuration.nix ];
      };
      nixos-home-server = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit home-manager sops-nix; };
        modules = [ ./nixos/home-server/configuration.nix ];
      };
    };
    packages.x86_64-linux = {
      iso = nixos-generators.nixosGenerate {
        system = "x86_64-linux";
        format = "install-iso";
        modules = [
          home-manager.nixosModules.home-manager
          ./iso
        ];
      };
    };
  };
}
