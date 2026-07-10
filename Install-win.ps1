#PowerShell
mkdir ~/Documents/PowerShell -Force
mv $PROFILE "$PROFILE.bak"
New-Item `
  -ItemType SymbolicLink `
  -Path $PROFILE `
  -Target $HOME/Dotfiles/shell/powershell/Microsoft.PowerShell_profile.ps1

#NeoVim
mv ~/AppData/Local/nvim ~/AppData/Local/nvim.bak
New-Item `
  -ItemType SymbolicLink `
  -Path ~/AppData/Local/nvim `
  -Target $HOME/Dotfiles/config/nvim

#fastfetch
mv ~/AppData/Roaming/fastfetch ~/AppData/Roaming/fastfetch.bak
New-Item `
  -ItemType SymbolicLink `
  -Path ~/AppData/Roaming/fastfetch `
  -Target $HOME/Dotfiles/config/fastfetch

