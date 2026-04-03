{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # base packages
    waybar
    wezterm
    fuzzel
    wofi
    rofi
    hyprlock
    hypridle
    swaynotificationcenter
    wlogout
    wl-clipboard
    networkmanagerapplet
    blueman
    gnome-session
    gnome-shell
    hyprshot
    hyprpaper
    thunar
    tumbler
    ffmpegthumbnailer
    wireguard-tools
    gh
    lazygit
    neovim
    zsh
    git
    git-filter-repo
    cifs-utils
    inotify-tools
    ffmpeg-full
    unzip
    input-remapper
    waypipe
    libnotify
    fastfetch

    # runtime
    python3
    gcc
    go
    gnumake

    # LSP
    typescript-language-server # TS/JS
    clang-tools # C/C++ (LSP+Formatter)
    vscode-langservers-extracted # HTML/CSS/JSON/ESLint
    pyright # Python
    bash-language-server # Shell
    phpactor # PHP
    solargraph # ruby
    sqls # SQL
    jdt-language-server # Java
    nixd # Nix
    lua-language-server # Lua

    # formatter
    nodePackages.prettier # TS/JS/HTML/CSS/JSON
    csharpier # C_Sharp
    google-java-format # Java
    phpPackages.php-cs-fixer # PHP
    rubyPackages.rubocop # Ruby
    black # Python
    shfmt # Shell
    sqruff # SQL
    nixfmt # Nix
    stylua # Lua

  ];

}
