# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, inputs, ... }:

{
  
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      inputs.nix-hazkey.nixosModules.hazkey
    ];


  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "NCP-2602"; # Define your hostname.

  # Configure network connections interactively with nmcli or nmtui.
  networking.networkmanager.enable = true;

  #Wiregurd
  networking.wireguard.enable = true;
  networking.wg-quick.interfaces.wg0 = {
    autostart = false;
    address = [ "10.0.0.5/32" ];
    privateKeyFile = "/etc/wireguard/client.key";
 
    peers = [
      {
        publicKey = "WJYhu8XPiAXMqeUV0Mu+js/UElxwQ25mQmOdW5vrXQQ=";
        endpoint = "60.93.169.133:51820";
        allowedIPs = [ "192.168.3.0/24" "10.0.0.0/24" ];
        persistentKeepalive = 25;
      }
    ];
  };

  systemd.services.wg-autostart-control = {
    description = "WireGuard conditional start";

    wantedBy = [ "multi-user.target" ];

    after = [
      "network-online.target"
      "NetworkManager-wait-online.service"
    ];

    wants = [
      "network-online.target"
      "NetworkManager-wait-online.service"
    ];

    serviceConfig.Type = "oneshot";

    script = ''
      # ネットワーク確立待ち
      for i in $(seq 1 10); do
        if ${pkgs.iproute2}/bin/ip route | grep -q default; then
          break
        fi
        sleep 1
      done

      # LAN判定
      for i in $(seq 1 5); do
        if ${pkgs.iputils}/bin/ping -c1 -W1 192.168.3.100 > /dev/null; then
          exit 0
        fi
        sleep 1
      done

      systemctl start wg-quick-wg0
    '';
  };

  networking.firewall = {
    enable = true;
    allowedUDPPorts = [ 51820 ];
    checkReversePath = "loose";
  };


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
    # base packages
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
    cifs-utils
    inotify-tools
    ffmpeg-full
    unzip
    
    # runtime
    python3
    gcc
    go
    gnumake

    # LSP
    typescript-language-server
    clang-tools
    vscode-langservers-extracted
    pyright
    bash-language-server
    phpactor
    solargraph
    sqls
    jdt-language-server

    # formatter
    nodePackages.prettier
    clang-tools
    csharpier
    google-java-format
    phpPackages.php-cs-fixer
    rubyPackages.rubocop
    black
    shfmt
    sqruff
    nodePackages.sql-formatter
       
  ];

  #fonts
  fonts = {
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      noto-fonts-color-emoji
    ];

    fontconfig = {
      defaultFonts = {
        sansSerif = [
          "Noto Sans"
          "Noto Sans CJK JP"
        ];

        serif = [
          "Noto Serif"
          "Noto Serif CJK JP"
        ];

        monospace = [
          "JetBrains Mono"
          "Noto Sans Mono CJK JP"
        ];

        emoji = [
          "Noto Color Emoji"
        ];
      };

      allowBitmaps = false;
    };
  };

  #environment variables
  environment.sessionVariables = {
  };

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

  services.hazkey.enable = true;

  #thunar
  programs.thunar.enable = true;
  programs.xfconf.enable = true;
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
    "zsh-custom/themes/self.zsh-theme".source = "${inputs.self}/others/self.zsh-theme";
  };

  users.defaultUserShell = pkgs.zsh;

  #neovim
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };

  #XDG 
  services.xserver.desktopManager.runXdgAutostartIfNone = true;
  xdg.portal.enable = true;

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
    description = "raia";
    extraGroups = [ "wheel" "networkmanager" "video" "audio" ];
  };

  #sudo
  security.sudo.enable = true;
  security.sudo.wheelNeedsPassword = true;

  #ssh
  programs.ssh.startAgent = true;

  #samba
  fileSystems."/mnt/HDD1Share" = {
    device = "//192.168.3.100/HDD1Share";
    fsType = "cifs";
    options = let
      automount_opts = "x-systemd.automount,x-systemd.require=network-online,x-systemd.idle-timeout=10,x-systemd.device-timeout=5,x-systemd.mount-timeout=30";
    in [
      # automount + credentials
      "${automount_opts},credentials=/etc/samba/credentials_HDD1Share,uid=1000,gid=1000,rw"
      "nofail"
    ];

  };
 
}

