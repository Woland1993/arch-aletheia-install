---
name: aletheia
description: >
  REQUIRED for end-user customization of Linux desktop, window manager, or system config.
  Use when editing ~/.config/hypr/, ~/.config/waybar/, ~/.config/walker/,
  ~/.config/alacritty/, ~/.config/kitty/, ~/.config/ghostty/, ~/.config/mako/,
  or ~/.config/aletheia/. Triggers: Hyprland, window rules, animations, keybindings,
  monitors, gaps, borders, blur, opacity, waybar, walker, terminal config, themes,
  wallpaper, night light, idle, lock screen, screenshots, layer rules, workspace
  settings, display config, and user-facing aletheia commands. Excludes Aletheia
  source development in ~/.local/share/aletheia/ and aletheia-dev-* workflows.
---

# Aletheia Skill

Manage Aletheia Linux systems - a modern, opinionated Arch Linux distribution with Hyprland.

This skill is for end-user customization on installed systems.
It is not for contributing to Aletheia source code.

## When This Skill MUST Be Used

**ALWAYS invoke this skill for end-user requests involving ANY of these:**

- Editing ANY file in `~/.config/hypr/` (window rules, animations, keybindings, monitors, etc.)
- Editing ANY file in `~/.config/waybar/`, `~/.config/walker/`, `~/.config/mako/`
- Editing terminal configs (alacritty, kitty, ghostty)
- Editing ANY file in `~/.config/aletheia/`
- Window behavior, animations, opacity, blur, gaps, borders
- Layer rules, workspace settings, display/monitor configuration
- Themes, wallpapers, fonts, appearance changes
- User-facing `aletheia-*` commands (`aletheia-theme-*`, `aletheia-refresh-*`, `aletheia-restart-*`, etc.)
- Screenshots, screen recording, night light, idle behavior, lock screen

**If you're about to edit a config file in ~/.config/ on this system, STOP and use this skill first.**

**Do NOT use this skill for Aletheia development tasks** (editing files in `~/.local/share/aletheia/`, creating migrations, or running `aletheia-dev-*` workflows).

## Critical Safety Rules

**For end-user customization tasks, NEVER modify anything in `~/.local/share/aletheia/`** - but READING is safe and encouraged.

This directory contains Aletheia's source files managed by git. Any changes will be:
- Lost on next `aletheia-update`
- Cause conflicts with upstream
- Break the system's update mechanism

```
~/.local/share/aletheia/     # READ-ONLY - NEVER EDIT (reading is OK)
├── bin/                    # Source scripts (symlinked to PATH)
├── config/                 # Default config templates
├── themes/                 # Stock themes
├── default/                # System defaults
├── migrations/             # Update migrations
└── install/                # Installation scripts
```

**Reading `~/.local/share/aletheia/` is SAFE and useful** - do it freely to:
- Understand how aletheia commands work: `cat $(which aletheia-theme-set)`
- See default configs before customizing: `cat ~/.local/share/aletheia/config/waybar/config.jsonc`
- Check stock theme files to copy for customization
- Reference default hyprland settings: `cat ~/.local/share/aletheia/default/hypr/*`

**Always use these safe locations instead:**
- `~/.config/` - User configuration (safe to edit)
- `~/.config/aletheia/themes/<custom-name>/` - Custom themes (must be real directories)
- `~/.config/aletheia/hooks/` - Custom automation hooks

If the request is to develop Aletheia itself, this skill is out of scope. Follow repository development instructions instead of this skill.

## System Architecture

Aletheia is built on:

| Component | Purpose | Config Location |
|-----------|---------|-----------------|
| **Arch Linux** | Base OS | `/etc/`, `~/.config/` |
| **Hyprland** | Wayland compositor/WM | `~/.config/hypr/` |
| **Waybar** | Status bar | `~/.config/waybar/` |
| **Walker** | App launcher | `~/.config/walker/` |
| **Alacritty/Kitty/Ghostty** | Terminals | `~/.config/<terminal>/` |
| **Mako** | Notifications | `~/.config/mako/` |
| **SwayOSD** | On-screen display | `~/.config/swayosd/` |

## Command Discovery

Aletheia provides ~145 commands following `aletheia-<category>-<action>` pattern.

```bash
# List all aletheia commands
compgen -c | grep -E '^aletheia-' | sort -u

# Find commands by category
compgen -c | grep -E '^aletheia-theme'
compgen -c | grep -E '^aletheia-restart'

# Read a command's source to understand it
cat $(which aletheia-theme-set)
```

### Command Categories

| Prefix | Purpose | Example |
|--------|---------|---------|
| `aletheia-refresh-*` | Reset config to defaults (backs up first) | `aletheia-refresh-waybar` |
| `aletheia-restart-*` | Restart a service/app | `aletheia-restart-waybar` |
| `aletheia-toggle-*` | Toggle feature on/off | `aletheia-toggle-nightlight` |
| `aletheia-theme-*` | Theme management | `aletheia-theme-set <name>` |
| `aletheia-install-*` | Install optional software | `aletheia-install-docker-dbs` |
| `aletheia-launch-*` | Launch apps | `aletheia-launch-browser` |
| `aletheia-cmd-*` | System commands | `aletheia-cmd-screenshot` |
| `aletheia-pkg-*` | Package management | `aletheia-pkg-install <pkg>` |
| `aletheia-setup-*` | Initial setup tasks | `aletheia-setup-fingerprint` |
| `aletheia-update-*` | System updates | `aletheia-update` |

## Configuration Locations

### Hyprland (Window Manager)

```
~/.config/hypr/
├── hyprland.conf      # Main config (sources others)
├── bindings.conf      # Keybindings
├── monitors.conf      # Display configuration
├── input.conf         # Keyboard/mouse settings
├── looknfeel.conf     # Appearance (gaps, borders, animations)
├── envs.conf          # Environment variables
├── autostart.conf     # Startup applications
├── hypridle.conf      # Idle behavior (screen off, lock, suspend)
├── hyprlock.conf      # Lock screen appearance
└── hyprsunset.conf    # Night light / blue light filter
```

**Key behaviors:**
- Hyprland auto-reloads on config save (no restart needed for most changes)
- Use `hyprctl reload` to force reload
- Use `aletheia-refresh-hyprland` to reset to defaults

### Waybar (Status Bar)

```
~/.config/waybar/
├── config.jsonc       # Bar layout and modules (JSONC format)
└── style.css          # Styling
```

**Waybar does NOT auto-reload.** You MUST run `aletheia-restart-waybar` after any config changes.

**Commands:** `aletheia-restart-waybar`, `aletheia-refresh-waybar`, `aletheia-toggle-waybar`

### Terminals

```
~/.config/alacritty/alacritty.toml
~/.config/kitty/kitty.conf
~/.config/ghostty/config
```

**Command:** `aletheia-restart-terminal`

### Other Configs

| App | Location |
|-----|----------|
| btop | `~/.config/btop/btop.conf` |
| fastfetch | `~/.config/fastfetch/config.jsonc` |
| lazygit | `~/.config/lazygit/config.yml` |
| starship | `~/.config/starship.toml` |
| git | `~/.config/git/config` |
| walker | `~/.config/walker/config.toml` |

## Safe Customization Patterns

### Pattern 1: Edit User Config Directly

For simple changes, edit files in `~/.config/`:

```bash
# 1. Read current config
cat ~/.config/hypr/bindings.conf

# 2. Backup before changes
cp ~/.config/hypr/bindings.conf ~/.config/hypr/bindings.conf.bak.$(date +%s)

# 3. Make changes with Edit tool

# 4. Apply changes
# - Hyprland: auto-reloads on save (no restart needed)
# - Waybar: MUST restart with aletheia-restart-waybar
# - Walker: MUST restart with aletheia-restart-walker
# - Terminals: MUST restart with aletheia-restart-terminal
```

### Pattern 2: Make a new theme

1. Create a directory under ~/.config/aletheia/themes.
2. See how an existing theme is done via ~/.local/share/aletheia/themes/catppuccin.
3. Download a matching background (or several) from the internet and put them in ~/.config/aletheia/themes/[name-of-new-theme]
4. When done with the theme, run aletheia-theme-set "Name of new theme"

### Pattern 3: Use Hooks for Automation

Create scripts in `~/.config/aletheia/hooks/` to run automatically on events:

```bash
# Available hooks (see samples in ~/.config/aletheia/hooks/):
~/.config/aletheia/hooks/
├── theme-set        # Runs after theme change (receives theme name as $1)
├── font-set         # Runs after font change
└── post-update      # Runs after aletheia-update
```

Example hook (`~/.config/aletheia/hooks/theme-set`):
```bash
#!/bin/bash
THEME_NAME=$1
echo "Theme changed to: $THEME_NAME"
# Add custom actions here
```

### Pattern 4: Reset to Defaults -- ALWAYS SEEK USER CONFIRMATION BEFORE RUNNING

When customizations go wrong:

```bash
# Reset specific config (creates backup automatically)
aletheia-refresh-waybar
aletheia-refresh-hyprland

# The refresh command:
# 1. Backs up current config with timestamp
# 2. Copies default from ~/.local/share/aletheia/config/
# 3. Restarts the component
```

## Common Tasks

### Themes

```bash
aletheia-theme-list              # Show available themes
aletheia-theme-current           # Show current theme
aletheia-theme-set <name>        # Apply theme (use "Tokyo Night" not "tokyo-night")
aletheia-theme-next              # Cycle to next theme
aletheia-theme-bg-next           # Cycle wallpaper
aletheia-theme-install <url>     # Install from git repo
```

### Keybindings

Edit `~/.config/hypr/bindings.conf`. Format:
```
bind = SUPER, Return, exec, xdg-terminal-exec
bind = SUPER, Q, killactive
bind = SUPER SHIFT, E, exit
```

View current bindings: `aletheia-menu-keybindings --print`

**IMPORTANT: When re-binding an existing key:**

1. First check existing bindings: `aletheia-menu-keybindings --print`
2. If the key is already bound, you MUST add an `unbind` directive BEFORE your new `bind`
3. Inform the user what the key was previously bound to

Example - rebinding SUPER+F (which is bound to fullscreen by default):
```
# Unbind existing SUPER+F (was: fullscreen)
unbind = SUPER, F
# New binding for file manager
bind = SUPER, F, exec, nautilus
```

Always tell the user: "Note: SUPER+F was previously bound to fullscreen. I've added an unbind directive to override it."

### Display/Monitors

Edit `~/.config/hypr/monitors.conf`. Format:
```
monitor = eDP-1, 1920x1080@60, 0x0, 1
monitor = HDMI-A-1, 2560x1440@144, 1920x0, 1
```

List monitors: `hyprctl monitors`

### Window Rules

**CRITICAL: Hyprland window rules syntax changes frequently between versions.**

Before writing ANY window rules, you MUST fetch the current documentation from the official Hyprland wiki:
- https://github.com/hyprwm/hyprland-wiki/blob/main/content/Configuring/Window-Rules.md

DO NOT rely on cached or memorized window rule syntax. The format has changed multiple times and using outdated syntax will cause errors or unexpected behavior.

Window rules go in `~/.config/hypr/hyprland.conf` or a sourced file. Always verify the current syntax from the wiki first.

### Fonts

```bash
aletheia-font-list               # Available fonts
aletheia-font-current            # Current font
aletheia-font-set <name>         # Change font
```

### System

```bash
aletheia-update                  # Full system update
aletheia-version                 # Show Aletheia version
aletheia-debug --no-sudo --print # Debug info (ALWAYS use these flags)
aletheia-lock-screen             # Lock screen
aletheia-system-shutdown         # Shutdown
aletheia-system-reboot           # Reboot
```

**IMPORTANT:** Always run `aletheia-debug` with `--no-sudo --print` flags to avoid interactive sudo prompts that will hang the terminal.

## Troubleshooting

```bash
# Get debug information (ALWAYS use these flags to avoid interactive prompts)
aletheia-debug --no-sudo --print

# Upload logs for support
aletheia-upload-log

# Reset specific config to defaults
aletheia-refresh-<app>

# Refresh specific config file
# config-file path is relative to ~/.config/
# eg. aletheia-refresh-config hypr/hyprlock.conf will refresh ~/.config/hypr/hyprlock.conf
aletheia-refresh-config <config-file>

# Full reinstall of configs (nuclear option)
aletheia-reinstall
```

## Decision Framework

When user requests system changes:

1. **Is it a stock aletheia command?** Use it directly
2. **Is it a config edit?** Edit in `~/.config/`, never `~/.local/share/aletheia/`
3. **Is it a theme customization?** Create a NEW custom theme directory
4. **Is it automation?** Use hooks in `~/.config/aletheia/hooks/`
5. **Is it a package install?** Use `aletheia-pkg-add` (or `aletheia-pkg-aur-add` for AUR-only packages)
6. **Unsure if command exists?** Search with `compgen -c | grep aletheia`

## Out of Scope

This skill intentionally does not cover Aletheia source development. Do not use this skill for:
- Editing files in `~/.local/share/aletheia/` (`bin/`, `config/`, `default/`, `themes/`, `migrations/`, etc.)
- Creating or editing migrations
- Running `aletheia-dev-*` commands

## Example Requests

- "Change my theme to catppuccin" -> `aletheia-theme-set catppuccin`
- "Add a keybinding for Super+E to open file manager" -> Check existing bindings first, add `unbind` if needed, then add `bind` in `~/.config/hypr/bindings.conf`
- "Configure my external monitor" -> Edit `~/.config/hypr/monitors.conf`
- "Make the window gaps smaller" -> Edit `~/.config/hypr/looknfeel.conf`
- "Set up night light to turn on at sunset" -> `aletheia-toggle-nightlight` or edit `~/.config/hypr/hyprsunset.conf`
- "Customize the catppuccin theme colors" -> Create `~/.config/aletheia/themes/catppuccin-custom/` by copying from stock, then edit
- "Run a script every time I change themes" -> Create `~/.config/aletheia/hooks/theme-set`
- "Reset waybar to defaults" -> `aletheia-refresh-waybar`
