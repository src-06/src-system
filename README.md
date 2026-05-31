# NixOS Configuration

NixOS flake-based configuration for a personal laptop using `nixos-unstable` (state version 25.11), the **Niri** Wayland compositor, and the **Noctalia** shell environment.

## Structure

```
.
├── flake.nix              # Flake entry point (flake-parts, auto-import-tree)
├── flake.lock             # Pinned input revisions
├── hosts/
│   └── laptop/            # Machine-specific config (networking, hardware, imports)
│       ├── config.nix
│       └── hardware.nix
├── modules/
│   ├── base/              # Core: bluetooth, audio (PipeWire), shell (Fish), users,
│   │                      #   fonts, Nix daemon (flakes/cachix/nix-ld), zram, networking
│   ├── apps/              # Applications: browsers, editors, media, office, AI tools, games
│   ├── devs/              # Dev tooling: C++, Python, Rust, Node, Bun, PHP, SQL, DB scripts
│   ├── extra/             # Optional extras: printing, aria2c, VirtualBox, Flatpak, AppImage
│   ├── hardware/          # AMD CPU/GPU modules, kernel modules, microcode
│   └── manager/
│       ├── display/ly.nix # LY TUI display manager
│       ├── window/niri.nix# Niri scrollable-tiling Wayland compositor
│       └── desktop/       # LXQt and KDE Plasma 6 desktop environments
├── packages/
│   └── imouto.nix         # Imouto cursor theme package
├── wrappers/              # Wrapped apps with baked-in configs (nix-wrapper-modules)
│   ├── niri.nix           #   Niri (full keybinds, blur, shaders, cursor)
│   ├── kitty.nix          #   Kitty terminal
│   ├── imv.nix            #   Image viewer
│   ├── zathura.nix        #   PDF viewer
│   └── noctalia-shell.nix #   Noctalia shell
└── LICENSE                # GPL v3
```

## Requirements

- NixOS with flakes enabled (`experimental-features = flakes nix-command`)
- `x86_64-linux`

## Notes

- Username: `src-06` ("Violet Evergarden")
- Hostname: `laptop`
- State version: `25.11`
- Nixpkgs: `nixos-unstable`
- License: GPL-3.0

### Build

```bash
# Build and switch
sudo nixos-rebuild switch --flake .#laptop

# Dry run
sudo nixos-rebuild build --flake .#laptop
```

### Update

```bash
# Update flake inputs
nix flake update

# Rebuild with updated inputs
sudo nixos-rebuild switch --flake .#laptop
```

### Rollback

```bash
sudo nixos-rebuild switch --rollback
```

## Features

- **NixOS** with `nixos-unstable` via `flake-parts`
- **Niri** scrollable-tiling Wayland compositor (blur, GLSL shaders, Imouto cursor, XWayland Satellite)
- **Noctalia Shell** v4.7.7 — compositor companion (launcher, clipboard, lock screen, power profiles, status bar)
- **LY** TUI display manager
- **Desktop environments**: LXQt, KDE Plasma 6 (optional)
- **Display server**: XWayland via `xwayland-satellite`
- **Audio**: PipeWire (ALSA + JACK)
- **Shell**: Fish with Starship prompt
- **Nix**: flakes, auto-optimise, Cachix substituters, nix-ld, nix-index-database, `nh` auto-clean
- **Hardware**: AMD CPU/GPU, zram swap, systemd-tuned power profiles, LACT GPU control
- **Development**: C++, Python, Rust, Node.js, Bun, PHP, MariaDB, PostgreSQL (with local management scripts), Prisma, nginx
- **Applications**: Chromium, Firefox, Vesktop, VSCode, Zed, OnlyOffice, OBS, MPV, Pear Desktop (YT Music), Gemini CLI, opencode, Prism Launcher, Faugus Launcher
- **Extras**: CUPS printing (Optional), aria2c RPC daemon, VirtualBox, Flatpak, AppImage
- **Wrapped packages**: Pre-configured apps via `nix-wrapper-modules` (kitty, imv, zathura, niri, noctalia-shell)
- **Convention**: Module files prefixed with `_` are opt-in (not auto-imported), allowing selective inclusion
