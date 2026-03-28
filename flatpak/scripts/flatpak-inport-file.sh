cat ~/Dotfiles/flatpak/flatpak-apps.txt | xargs -n1 flatpak install -y
cp -r ~/Dotfiles/flatpak/flatpak-overrides ~/.local/share/flatpak/overrides
