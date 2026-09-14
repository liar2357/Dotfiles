# Dotfiles

> [日本語版](README.jp.md)

Personal dotfiles and configuration files collection for Linux environments.

## Overview

This repository is a collection of configuration files for managing development environments and system settings across Linux systems. It can be used as a Nix Flake or by running scripts to create symbolic links.

## Directory Structure

```
.
├── config/          # Configuration files for ~/.config directory
│                    # Contains settings for hypr, nvim, and other tools
├── shell/           # Shell environment configurations (zsh, pwsh)
├── scripts/         # Custom scripts
├── hosts/           # Host-specific environment configurations
├── nix/             # Nix Flake and NixOS configurations (including HomeManager)
├── tmux/            # tmux configuration
├── packages/        # Package management related configurations
├── share/           # Shared resources
├── notes/           # Documentation and notes
├── flake.nix        # Nix Flake definition
└── Install.sh       # Installation script for Linux
```

## Installation

### Method 1: Using Shell Script (Linux/macOS)

The simplest method using an installation script that automatically creates symbolic links:

```bash
git clone https://github.com/liar2357/Dotfiles.git ~/.dotfiles
cd ~/.dotfiles
chmod +x Install.sh
./Install.sh
```

`Install.sh` creates symbolic links from configuration files in the `config` directory to `~/.config`.

### Method 2: Using Nix Flake (NixOS Recommended)

For NixOS or environments that support Nix Flakes, you can use Home Manager for configuration management:

```bash
git clone https://github.com/liar2357/Dotfiles.git ~/.dotfiles
cd ~/.dotfiles
nix flake update  # (Optional) Update the Flake lock file
nix flake show    # Check available configurations
```

For details, refer to the Home Manager configuration in the `nix/` directory.

### Method 3: Windows PowerShell Script (Limited Support)

For partial support on Windows environments, use `Install-win.ps1` to install some configurations.

## Important Notes

### Personal Environment Optimizations

The configurations in `hosts/` and `nix/` directories are optimized for the author's personal operational environment. When using these:

- **Use them as a reference**, or
- **Modify them to fit your environment after cloning**

We strongly recommend this approach. Particularly, host-specific settings and NixOS system configurations may cause issues if applied directly to your machine.

### Script Dependencies

Custom scripts in the `scripts/` directory depend on specific commands and packages (e.g., `ffmpeg`, `imagemagick`, etc.).

Before using any script, please:

- Check the script header or comments for required dependencies
- Install necessary tools beforehand
- Test that the script works correctly in your environment

## Supported Tools

Examples of main configurations included in the `config/` directory:

- **Hyprland** - Wayland window manager
- **Neovim** - Text editor configuration
- Various other CLI tools and applications

You can identify available tools by the directory names within `config/`.

## After Setup

After installation, verify the following:

1. Check that symbolic links were created correctly: `ls -la ~/.config`
2. Verify that configuration files are correctly loaded by their respective tools
3. Ensure that `shell/` configurations are sourced in your `.bashrc`, `.zshrc`, etc.

## Troubleshooting

If configurations are not applied:

- Verify symbolic link targets: `ls -la ~/.config`
- Check if tool configuration paths have changed
- Check for conflicting environment variables or shell configurations

## License

This repository is free to use. For details, see the LICENSE file in the repository.

## Reference

- [Nix Flakes Documentation](https://nixos.wiki/wiki/Flakes)
- [Home Manager Manual](https://nix-community.github.io/home-manager/)
- [Hyprland Documentation](https://hyprland.org/)

---

For questions or issues, please open an issue on this repository.
