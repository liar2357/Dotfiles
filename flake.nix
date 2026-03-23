{
  description = "NixOS + Hyprland + Dotfiles";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    agenix.url = "github:ryantm/agenix";
    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-hazkey.url = "github:aster-void/nix-hazkey";
    self = {};
  };

  outputs = inputs@{ self, nixpkgs, home-manager, hyprland, ... } :
  let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    nixosConfigurations.NCP-2602 = nixpkgs.lib.nixosSystem {
      inherit system;

      # ここで specialArgs を設定
      specialArgs = { inherit inputs; };

      modules = [
	./nixos/hardware-configuration.nix 
        ./nixos/configuration.nix

	{
          _module.args = {
            inherit inputs;
	  };
	}

        # ① Home-Manager を NixOS モジュールとして読み込ませる
        home-manager.nixosModules.home-manager
        {
          # ② ここで Home-Manager の設定をひとまとまりで渡す
          home-manager.useGlobalPkgs  = true;
          home-manager.useUserPackages = true;

          # ↓ ここが重要
	  home-manager.extraSpecialArgs = { inherit inputs; };

          # ③ ユーザー側の home.nix をここで読み込む
          home-manager.users."raia" = import ./home-manager/home.nix;
        }

        # ④ Hyprland のモジュール
        hyprland.nixosModules.default
        {
          programs.hyprland = {
            enable = true;
            xwayland.enable = true;
          };
        }
      ];

      # optional: ここに system-level options を書ける
    };

    # (オプション) Home-Manager を standalone でも動かせるようにする
    homeConfigurations."raia" =
      home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ ./home-manager/home.nix ];
      };
  };
}
