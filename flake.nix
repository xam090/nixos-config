{
  description = "NixOS Flake";

  inputs = {
    # nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";
    # https://github.com/NixOS/nixpkgs/issues/244159
    nixpkgs.url = "github:NixOS/nixpkgs/b6bbc53029a31f788ffed9ea2d459f0bb0f0fbfc";
    home-manager.url = "github:nix-community/home-manager/release-23.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: {
    nixosConfigurations = {
      "nixos" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";

        specialArgs = inputs;

        modules = [
          ./configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.max = import ./max/home.nix;
          }
        ];
      };
    };
  };
}
