#PowerShell
mkdir ~/Documents/PowerShell -Force
mv $PROFILE "$PROFILE.bak"
New-Item `
  -ItemType SymbolicLink `
  -Path $PROFILE `
  -Target C:\Users\shini/Dotfiles/shell/powershell/Microsoft.PowerShell_profile.ps1

#NeoVim
mv ~/AppData/Local/nvim ~/AppData/Local/nvim.bak
New-Item `
  -ItemType SymbolicLink `
  -Path ~/AppData/Local/nvim `
  -Target C:\Users\shini/Dotfiles/config/nvim

