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

    # Zsh Plugins
    ni-zsh = {
      url = "github:azu/ni.zsh";
      flake = false;
    };
    zsh-romaji-complete = {
      url = "github:aoyama-val/zsh-romaji-complete";
      flake = false;
    };
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-latest,
    chaotic,
    home-manager,
    pre-commit-hooks,
    ni-zsh,
    zsh-romaji-complete,
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

    homeConfigurations.thinkpad = home-manager.lib.homeManagerConfiguration {
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = [chaotic.overlays.default];
      };
      extraSpecialArgs = {inherit inputs pkgs-latest ni-zsh zsh-romaji-complete;};
      modules = [
        ./hosts/thinkpad/home.nix
      ];
    };

    homeConfigurations.dell-desk = home-manager.lib.homeManagerConfiguration {
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = [chaotic.overlays.default];
      };
      extraSpecialArgs = {inherit inputs pkgs-latest ni-zsh zsh-romaji-complete;};
      modules = [
        ./hosts/dell-desk/home.nix
      ];
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
            extraSpecialArgs = {inherit inputs pkgs-latest compressExtensions ni-zsh zsh-romaji-complete;};
            users.hmjn = import ./hosts/thinkpad/home.nix;
          };
        }
      ];
    };

    nixosConfigurations.dell-desk = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs compressExtensions;};
      modules = [
        ./hosts/dell-desk/default.nix
        {nixpkgs.overlays = [chaotic.overlays.default];}

        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            backupFileExtension = "backup";
            extraSpecialArgs = {inherit inputs pkgs-latest compressExtensions ni-zsh zsh-romaji-complete;};
            users.hmjn = import ./hosts/dell-desk/home.nix;
          };
        }
      ];
    };
  };
}
