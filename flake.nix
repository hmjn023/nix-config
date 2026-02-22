{
  description = "My NixOS Flake Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-latest.url = "github:nixos/nixpkgs/master";
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    pre-commit-hooks = {
      url = "github:cachix/pre-commit-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-latest,
    chaotic,
    home-manager,
    pre-commit-hooks,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    pkgs-latest = import nixpkgs-latest {
      system = "${system}";
      config.allowUnfree = true;
    };
    compressExtensions = import ./modules/nixos/f2fs-extensions.nix;
  in {
    formatter.${system} = pkgs-latest.writeShellScriptBin "alejandra" ''
      if [ $# -eq 0 ]; then
        exec ${pkgs-latest.alejandra}/bin/alejandra .
      else
        exec ${pkgs-latest.alejandra}/bin/alejandra "$@"
      fi
    '';

    checks.${system}.pre-commit-check = pre-commit-hooks.lib.${system}.run {
      src = ./.;
      hooks = {
        alejandra.enable = true;
        statix.enable = true;
        deadnix.enable = true;
      };
    };

    devShells.${system} = import ./nix/devshell.nix {
      inherit (nixpkgs.legacyPackages.${system}) pkgs;
      inherit (self.checks.${system}) pre-commit-check;
      inherit compressExtensions;
    };

    nixosConfigurations.thinkpad = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs compressExtensions;};
      modules = [
        ./hosts/thinkpad/default.nix
        {nixpkgs.overlays = [chaotic.overlays.default];}

        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            backupFileExtension = "backup";
            extraSpecialArgs = {inherit inputs pkgs-latest compressExtensions;};
            users.hmjn = import ./hosts/thinkpad/home.nix;
          };
        }
      ];
    };

    nixosConfigurations.desk-dell = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs compressExtensions;};
      modules = [
        ./hosts/desk-dell/default.nix
        {nixpkgs.overlays = [chaotic.overlays.default];}

        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            backupFileExtension = "backup";
            extraSpecialArgs = {inherit inputs pkgs-latest compressExtensions;};
            users.hmjn = import ./hosts/desk-dell/home.nix;
          };
        }
      ];
    };
  };
}
