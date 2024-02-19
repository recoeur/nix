{
  description = "AlexG's NixOS configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixpkgs-unstable";
    nixos.url = "nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, nixos, home-manager, ... }@inputs:
    let
      overlays = [ inputs.neovim-nightly-overlay.overlay ];
      config = { allowUnfree = true; };
      pkgs = import nixpkgs { inherit overlays config; };
      system = "x86_64-linux";
    in
    {
      nixosConfigurations.huggin = nixos.lib.nixosSystem {
          modules = [
            ./nixos/desktop.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.alexg = import ./home/alexg.nix;
            }
            ({ nix.registry.nixpkgs.flake = nixpkgs; })
          ];
      };
    };
}
