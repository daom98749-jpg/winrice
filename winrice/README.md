# winrice

Windows 10 desktop setup: tiling WM, status bar, terminal, editor, Catppuccin Mocha everywhere.

| Component | Tool |
|---|---|
| Tiling WM | komorebi + whkd |
| Bar | YASB |
| Launcher | Flow Launcher |
| Taskbar | TranslucentTB |
| Terminal | Windows Terminal |
| Prompt | oh-my-posh |
| System info | fastfetch |
| Editors | neovim, VS Code |
| Theme | Catppuccin Mocha |

## Install

```powershell
git clone https://github.com/daom98749-jpg/winrice $HOME\winrice
cd $HOME\winrice
Set-ExecutionPolicy -Scope CurrentUser RemoteSigned
.\install.ps1
```

Run as a normal user, not admin. Needs `winget` (App Installer).
Existing configs are backed up next to the originals as `*.winrice.bak`.

## Layout

```
config/
  komorebi/     komorebi.json
  whkd/         whkdrc
  yasb/         config.yaml, styles.css
  terminal/     settings.json
  powershell/   profile.ps1
  fastfetch/    config.jsonc
  nvim/         init.lua
  vscode/       settings.json
  git/          gitconfig
wallpapers/     mocha.png
scripts/        update.ps1, uninstall.ps1, set-wallpaper.ps1
install.ps1
```

## Scripts

| Script | What it does |
|---|---|
| `install.ps1` | install apps, copy configs, set wallpaper |
| `install.ps1 -SkipApps` | copy configs only |
| `scripts/update.ps1` | git pull, re-apply configs, reload komorebi |
| `scripts/uninstall.ps1` | stop services, restore backups |
| `scripts/set-wallpaper.ps1 <path>` | set any wallpaper |

## Keybinds

| Key | Action |
|---|---|
| Alt + h/j/k/l | focus |
| Alt + Shift + h/j/k/l | move window |
| Alt + 1..4 | workspace |
| Alt + Shift + 1..4 | send to workspace |
| Alt + Enter | terminal |
| Alt + d | launcher |
| Alt + q | close |
| Alt + f | maximize |
| Alt + Shift + f | float |
| Alt + t | retile |
| Alt + Shift + r | reload |

Hide the default taskbar: right click taskbar, Taskbar settings, Automatically hide the taskbar.
