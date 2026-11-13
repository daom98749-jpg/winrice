param([switch]$SkipApps)

$ErrorActionPreference = "Stop"
$root = $PSScriptRoot

if (-not $SkipApps) {
  $apps = @(
    "LGUG2Z.komorebi",
    "LGUG2Z.whkd",
    "AmN.yasb",
    "Flow-Launcher.Flow-Launcher",
    "Fastfetch-cli.Fastfetch",
    "JanDeDobbeleer.OhMyPosh",
    "Microsoft.WindowsTerminal",
    "CharlesMilette.TranslucentTB",
    "Microsoft.VisualStudioCode",
    "Git.Git",
    "Neovim.Neovim"
  )
  foreach ($a in $apps) {
    winget install -e --id $a --accept-source-agreements --accept-package-agreements
  }
  oh-my-posh font install JetBrainsMono
}

function Install-File($from, $to) {
  New-Item -ItemType Directory -Force (Split-Path $to) | Out-Null
  if ((Test-Path $to) -and -not (Test-Path "$to.winrice.bak")) {
    Copy-Item $to "$to.winrice.bak"
  }
  Copy-Item $from $to -Force
}

function Install-Dir($from, $to) {
  New-Item -ItemType Directory -Force $to | Out-Null
  Get-ChildItem "$root\config\$from" -File | ForEach-Object { Install-File $_.FullName "$to\$($_.Name)" }
}

$cfg = "$HOME\.config"
Install-Dir "komorebi"  "$cfg\komorebi"
Install-Dir "yasb"      "$cfg\yasb"
Install-Dir "fastfetch" "$cfg\fastfetch"
Install-Dir "nvim"      "$env:LOCALAPPDATA\nvim"
Install-File "$root\config\whkd\whkdrc" "$cfg\whkdrc"
Install-File "$root\config\powershell\profile.ps1" $PROFILE

$wt = "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState"
if (Test-Path $wt) { Install-File "$root\config\terminal\settings.json" "$wt\settings.json" }

$vs = "$env:APPDATA\Code\User"
Install-File "$root\config\vscode\settings.json" "$vs\settings.json"
$code = Get-Command code -ErrorAction SilentlyContinue
if ($code) {
  code --install-extension Catppuccin.catppuccin-vsc 2>$null
  code --install-extension Catppuccin.catppuccin-vsc-icons 2>$null
}

git config --global include.path "$root\config\git\gitconfig".Replace("\", "/")

$wp = "$HOME\Pictures\winrice"
New-Item -ItemType Directory -Force $wp | Out-Null
Copy-Item "$root\wallpapers\*" $wp -Force
& "$root\scripts\set-wallpaper.ps1" -Path "$wp\mocha.png"

[Environment]::SetEnvironmentVariable("KOMOREBI_CONFIG_HOME", "$cfg\komorebi", "User")
[Environment]::SetEnvironmentVariable("WHKD_CONFIG_HOME", $cfg, "User")
$env:KOMOREBI_CONFIG_HOME = "$cfg\komorebi"
$env:WHKD_CONFIG_HOME = $cfg

komorebic enable-autostart --whkd 2>$null
komorebic start --whkd

$yasbExe = Get-ChildItem "$env:ProgramFiles\YASB", "$env:LOCALAPPDATA\Programs\YASB" -Filter yasb.exe -Recurse -ErrorAction SilentlyContinue | Select-Object -First 1
if ($yasbExe) {
  Start-Process $yasbExe.FullName
  Set-ItemProperty "HKCU:\Software\Microsoft\Windows\CurrentVersion\Run" -Name "YASB" -Value "`"$($yasbExe.FullName)`""
}

Write-Host "Done." -ForegroundColor Green
