{
  description = "NixOS + Hyprland + Dotfiles";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05"; 
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # 自分の dotfiles はここがベース flake
    # このファイル自体が repo のルート flake.nix
    self = { };

  };

  outputs = { nixpkgs, hyprland, ... }:
  let
    system = "x86_64-linux";
    pkgs   = nixpkgs.legacyPackages.${system};
  in {
    nixosConfigurations.NCP-2602 = nixpkgs.lib.nixosSystem {
      inherit system;

      modules = [
        ./nixos/configuration.nix                      # 自分の config
        home-manager.nixosModules.home-manager         # Home-Manager module

        hyprland.nixosModules.default
        {
          programs.hyprland = {
            enable = true;
            xwayland.enable = true;
          };
        }
      ];

      # Home-Manager のユーザー設定を inject
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.users."raia" = import ./home-manager/home.nix;

    };
    
    # --- Home-Manager 単独でも switch 可能 ---
    homeConfigurations."raia" =
      home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ ./home-manager/home.nix ];
      };
  };
}


