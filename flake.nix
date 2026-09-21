{
  description = "NixOS + Hyprland + Dotfiles";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-waypipe.url = "github:NixOS/nixpkgs/567a49d1913ce81ac6e9582e3553dd90a955875f";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    agenix.url = "github:ryantm/agenix";
    nix-hazkey.url = "github:aster-void/nix-hazkey";
    emu-board.url = "github:liar2357/EmuBoard";
    self = { };
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      nixpkgs-waypipe,
      home-manager,
      emu-board,
      ...
    }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      nixosConfigurations.NCP-2602 = nixpkgs.lib.nixosSystem {
        inherit system;

        # ここで specialArgs を設定
        specialArgs = { inherit inputs; };

        modules = [
          ./nix/nixos/configuration.nix
          ./nix/nixos/system-packages.nix
          ./nix/nixos/hardware-configuration.nix

          {
            _module.args = {
              inherit inputs;
            };
          }

          {
            nixpkgs.overlays = [
              (final: prev: {
                waypipe = nixpkgs-waypipe.legacyPackages.${final.system}.waypipe;
              })
            ];
          }

          # ① Home-Manager を NixOS モジュールとして読み込ませる
          home-manager.nixosModules.home-manager
          {
            # ② ここで Home-Manager の設定をひとまとまりで渡す
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            # ↓ ここが重要
            home-manager.extraSpecialArgs = { inherit inputs; };

            # ③ ユーザー側の home.nix をここで読み込む
            home-manager.users."raia" = import ./nix/home-manager/home.nix;
          }

        ];

        # optional: ここに system-level options を書ける
      };

      # (オプション) Home-Manager を standalone でも動かせるようにする
      homeConfigurations."raia" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ ./nix/home-manager/home.nix ];
      };
    };
}
