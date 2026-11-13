komorebic stop --whkd 2>$null
komorebic disable-autostart 2>$null
Get-Process yasb -ErrorAction SilentlyContinue | Stop-Process -Force
Remove-ItemProperty "HKCU:\Software\Microsoft\Windows\CurrentVersion\Run" -Name "YASB" -ErrorAction SilentlyContinue
[Environment]::SetEnvironmentVariable("KOMOREBI_CONFIG_HOME", $null, "User")
[Environment]::SetEnvironmentVariable("WHKD_CONFIG_HOME", $null, "User")
Get-ChildItem "$HOME" -Recurse -Filter "*.winrice.bak" -ErrorAction SilentlyContinue | ForEach-Object {
  Move-Item $_.FullName ($_.FullName -replace "\.winrice\.bak$", "") -Force
}
Write-Host "Done." -ForegroundColor Green
