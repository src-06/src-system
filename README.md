# src-system NixOS Configuration

NixOS flake-based configuration for `src-system` using NixOS 25.11 and Home Manager.

## Structure

```
.
├── flake.nix          # Main flake entry point
├── modules/           # NixOS system modules
│   ├── desktop/       # Desktop environments (LXQt, Plasma)
│   ├── manager/        # Display managers (LightDM, SDDM)
│   ├── systems/        # System configuration (boot, packages, users, shell, networking)
│   └── window/         # Window managers (Niri)
└── home/              # Home Manager user configuration
    ├── browsers/       # Browser configurations
    ├── development/    # Dev environments (C++, Python, Node, PHP, Nix, DB, Bun)
    ├── editors/        # Editor configs (VS Code)
    ├── games/          # Game-related configs
    ├── media/          # Media applications
    ├── office/         # Office productivity
    ├── tools/          # Utility tools
    └── ui/             # UI theming (icons, etc.)
```

## Usage

## Requirements

- NixOS 25.11 or newer
- Flakes enabled (`experimental-features = flakes nix-command` in `/etc/nix/nix.conf`)

## Notes

- Username: `src-06`
- Hostname: `src-system`
- State version: `25.11`

### Build

```bash
# Build system configuration
sudo nixos-rebuild switch --flake .#

# Build without switching (dry run)
sudo nixos-rebuild build --flake .#
```

### Update

```bash
# Update flake inputs
nix flake update

# Upgrade packages
sudo nixos-rebuild switch --upgrade --flake .#
```

### Rollback

```bash
# Rollback to previous generation
sudo nixos-rebuild switch --rollback
```

## Features

- **NixOS 25.11** with unstable nixpkgs
- **Home Manager** for user environment
- **Display Managers**: LightDM
- **Desktop Environments**: KDE Plasma
- **Window Managers**: Niri
- **Shells**: Fish, Zsh with Starship prompt
- **Development**: C++, Python, Node.js, PHP, Bun, Nix
- **Tools**: Thunderbird and various utilities
