# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "NCP-2602"; # Define your hostname.

  # Configure network connections interactively with nmcli or nmtui.
  networking.networkmanager.enable = true;
  networking.wireguard.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Tokyo";

  # Select internationalisation properties.
  i18n = {
    defaultLocale = "ja_JP.UTF-8";

    supportedLocales = [
      "ja_JP.UTF-8/UTF-8"
      "en_US.UTF-8/UTF-8"
    ];

    extraLocaleSettings = {
      LC_ADDRESS = "ja_JP.UTF-8";
      LC_IDENTIFICATION = "ja_JP.UTF-8";
      LC_MEASURMENT = "ja_JP.UFT-8";
      LC_MONETARY = "ja_JP.UTF-8";
      LC_NAME = "ja_JP.UFT-8";
      LC_NUMERIC = "ja_JP.UTF-8";
      LC_PAPER = "ja_JP.UTF-8";
      LC_TELEPHONE = "ja_JP.UTF-8";
      LC_TIME = "ja_JP.UTF-8";
    };
  };
  console.keyMap = "jp106";
  services.xserver.xkb = {
    layout = "jp";
  };

  system.stateVersion = "25.11"; # Did you read the comment?

  #flake
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  #boot
  boot.loader.efi.efiSysMountPoint = "/boot";

  #btrfs
  fileSystems."/".options = [ "compress=zstd" "noatime" ];


  #Waybar/base tools
  environment.systemPackages = with pkgs; [
    waybar
    kitty
    fuzzel
    mako
    wlogout
    wl-clipboard
    networkmanagerapplet
    blueman
    gnome-session
    gnome-shell
    hyprshot
    hyprpaper
    xfce.thunar
    xfce.tumbler
    ffmpegthumbnailer
    wireguard-tools
    gh
    lazygit
    neovim
    zsh
    git
    home-manager
  ];

  #fonts
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
  ];

  #BT
  services.blueman.enable = true;
  hardware.bluetooth.enable = true;

  #Flatpak
  services.flatpak.enable = true;

  #Fcitx5+Hazkey+Zenzai
  i18n.inputMethod = {
    type = "fcitx5";
    enable = true;
    fcitx5.waylandFrontend = true;
    fcitx5.addons = with pkgs; [
      fcitx5-gtk
      kdePackages.fcitx5-qt
    ];
  };

  #tumbnail
  services.tumbler.enable = true;
  services.gvfs.enable = true;

  #zsh
  programs.zsh = {
    enable = true;
    enableCompletion = true;

    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;

    ohMyZsh = {
      enable = true;

      plugins = [ "git" "docker" "z" ];
      theme = "self";
      custom = "/etc/zsh-custom";
    };

  };

  environment.etc = {
    "zsh-custom/themes/self.zsh-theme".source = "${inputs.dotfiles}/others/self.zsh-theme";
  };

  users.defaultUserShell = pkgs.zsh;

  #neovim
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };

  #XDG autostart
  services.xserver.desktopManager.runXdgAutostartIfNone = true;

  #GDM
  services.xserver.enable = true;
  services.xserver.displayManager.gdm = {
    enable = true;
    wayland = true;
    autoSuspend = false;
    settings = {
      daemon = {
        DefaultSession = "hyprland";
      };
    };
  };
  services.xserver.desktopManager.gnome.enable = false;
  services.xserver.displayManager.sessionPackages = [
    pkgs.hyprland
  ];
  systemd.services.display-manager.environment = {
    LANG = "ja_JP.UTF-8";
    LC_ALL = "ja_JP.UTF-8";
  };

  #lung
  environment.variables = {
    LANG = "ja_JP.UTF-8";
    LC_ALL = "ja_JP.UTF-8";
  };
  environment.sessionVariables = {
    LANG = "ja_JP.UTF-8";
    XDG_CURRENT_DESKTOP = "Hyprland";
  };
  services.dbus.enable = true;
  programs.dconf.enable = true;

  #user
  users.users.raia = {
    isNormalUser = true;
    description = "Raia";
    extraGroups = [ "wheel" "networkmanager" "video" "audio" ];
  };

  #sudo
  security.sudo.enable = true;
  security.sudo.wheelNeedsPassword = true;

  #ssh
  programs.ssh.startAgent = true;

}

