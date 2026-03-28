{
  inputs,
  config,
  pkgs,
  ...
}:

{
  home.username = "raia";
  home.homeDirectory = "/home/raia";

  # ← 必ず書く
  home.stateVersion = "25.05";

  #mouse cursor
  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;

    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Ice";
    size = 24;
  };

  # --- ~/.config 配下 ---

  xdg.configFile."fuzzel" = {
    source = config.lib.file.mkOutOfStoreSymlink "${inputs.self}/config/fuzzel";
    recursive = true;
  };

  xdg.configFile."kitty" = {
    source = config.lib.file.mkOutOfStoreSymlink "${inputs.self}/config/kitty";
    recursive = true;
  };

  xdg.configFile."swaync" = {
    source = config.lib.file.mkOutOfStoreSymlink "${inputs.self}/config/swaync";
    recursive = true;
  };

  xdg.configFile."nvim" = {
    source = config.lib.file.mkOutOfStoreSymlink "${inputs.self}/config/nvim";
    recursive = true;
  };

  xdg.configFile."nvim-lite" = {
    source = config.lib.file.mkOutOfStoreSymlink "${inputs.self}/config/nvim-lite";
    recursive = true;
  };

  xdg.configFile."rofi" = {
    source = config.lib.file.mkOutOfStoreSymlink "${inputs.self}/config/rofi";
    recursive = true;
  };

  xdg.configFile."snippet-source" = {
    source = config.lib.file.mkOutOfStoreSymlink "${inputs.self}/config/snippet-source";
    recursive = true;
  };

  xdg.configFile."wofi" = {
    source = config.lib.file.mkOutOfStoreSymlink "${inputs.self}/config/wofi";
    recursive = true;
  };

  # --- hypr ---
  xdg.configFile."hypr/common" = {
    source = config.lib.file.mkOutOfStoreSymlink "${inputs.self}/config/hypr/common";
    recursive = true;
  };

  xdg.configFile."hypr/hyprland.conf" = {
    source = config.lib.file.mkOutOfStoreSymlink "${inputs.self}/hosts/NCP-2602/hypr/hyprland.conf";
    recursive = true;
  };

  # --- ~/ 配下 ---
  home.file.".zshrc" = {
    source = config.lib.file.mkOutOfStoreSymlink "${inputs.self}/shell/zsh/.zshrc";
  };

}
