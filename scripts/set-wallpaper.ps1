param([string]$Path = "$PSScriptRoot\..\wallpapers\mocha.png")
$full = (Resolve-Path $Path).Path
Add-Type -TypeDefinition @"
using System.Runtime.InteropServices;
public class Wall {
  [DllImport("user32.dll", CharSet = CharSet.Auto)]
  public static extern int SystemParametersInfo(int a, int b, string c, int d);
}
"@
[Wall]::SystemParametersInfo(20, 0, $full, 3) | Out-Null
