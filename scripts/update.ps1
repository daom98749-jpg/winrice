Set-Location "$PSScriptRoot\.."
git pull
.\install.ps1 -SkipApps
komorebic reload-configuration
