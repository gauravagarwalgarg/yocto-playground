# Multiconfig Design

> One workspace, one sync, all machines.

---

## Architecture

```
~/yocto-auton/                          ← Single workspace
├── sources/
│   ├── poky/                           ← Yocto core (Scarthgap LTS)
│   ├── meta-openembedded/              ← OE layers
│   ├── meta-raspberrypi/               ← RPi5 BSP
│   ├── meta-ti/                        ← BeagleBone BSP
│   └── meta-auton-repo/                ← This repo
│       ├── auton-init-build-env        ← THE setup script
│       └── meta-auton/                 ← Custom layer (distro + machines + kernel)
├── build/
│   ├── conf/
│   │   ├── local.conf                  ← Shared config + BBMULTICONFIG
│   │   ├── bblayers.conf               ← All layers (BSP auto-detected)
│   │   └── multiconfig/
│   │       ├── qemu-arm64.conf         ← MACHINE=qemu-arm64, separate TMPDIR
│   │       ├── beaglebone-black.conf   ← MACHINE=beaglebone-black
│   │       └── raspberrypi5.conf       ← MACHINE=raspberrypi5
│   ├── tmp-qemu-arm64/                 ← Build output for QEMU
│   ├── tmp-beaglebone-black/           ← Build output for BBB
│   └── tmp-raspberrypi5/               ← Build output for RPi5
├── downloads/                          ← Shared source tarballs
└── sstate-cache/                       ← Shared build cache
```

## How It Works

1. **One manifest** (`default.xml`) syncs ALL BSP layers
2. **One distro** (`auton.conf`) shared across all machines
3. **Multiconfig** lets bitbake build any machine without re-sourcing:
   - `BBMULTICONFIG = "qemu-arm64 beaglebone-black raspberrypi5"`
   - Each multiconfig file sets `MACHINE` and a separate `TMPDIR`
4. **BSP auto-detection**: `bblayers.conf` only adds `meta-ti` or `meta-raspberrypi` if they exist after sync

## What Changed

| Before | After |
|--------|-------|
| 3 separate workspaces | 1 workspace |
| 3 separate `repo sync` | 1 `repo sync` |
| Per-machine manifests required | Single `default.xml` |
| Re-source env to switch machine | `bitbake mc:<machine>:image` |
| Separate downloads/sstate | Shared (saves 10-20GB) |

## Build Matrix

| Command | What it builds |
|---------|---------------|
| `bitbake auton-image-minimal` | Default machine (from env selection) |
| `bitbake mc:qemu-arm64:auton-image-minimal` | QEMU AArch64 |
| `bitbake mc:beaglebone-black:auton-image-minimal` | BeagleBone Black |
| `bitbake mc:raspberrypi5:auton-image-minimal` | Raspberry Pi 5 |
| `bitbake mc:qemu-arm64:core-image-minimal` | Stock Yocto on QEMU (for testing) |

## Yocto Release

- **Baseline**: Scarthgap (5.0 LTS, April 2024)
- **Layer compat**: `scarthgap styhead`
- **Kernel**: linux-auton 6.12 LTS (or fallback to linux-yocto)
