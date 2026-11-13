oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\catppuccin_mocha.omp.json" | Invoke-Expression
Set-Alias vim nvim
Set-Alias ll Get-ChildItem
function .. { Set-Location .. }
function dots { Set-Location "$HOME\winrice" }
fastfetch
