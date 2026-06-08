# WSL2 Setup Guide — End to End

> Build and boot a complete embedded Linux image on WSL2 Ubuntu 22.04.

---

## Overview

```
01-install-deps.sh  →  02-repo-sync.sh  →  source 03-setup-env.sh  →  04-build.sh  →  05-run-qemu.sh
```

Total time: ~2-3 hours (first build). Subsequent builds: ~5 minutes (cached).

---

## Prerequisites

- **WSL2** with Ubuntu 22.04 (not WSL1)
- **50GB+ free disk space** on WSL ext4 filesystem
- **8GB+ RAM** allocated to WSL (16GB recommended)
- **Internet connection** (downloads ~5GB of sources and toolchains)

### WSL2 Configuration

Create/edit `%USERPROFILE%\.wslconfig` on Windows:

```ini
[wsl2]
memory=16GB
processors=8
swap=8GB
```

Then restart WSL: `wsl --shutdown` from PowerShell.

---

## Step-by-Step

### Step 1: Install Dependencies

```bash
cd ~/Projects/GauravAgarwalGarg/MyYoctoPlayground
./scripts/01-install-deps.sh
source ~/.bashrc
```

Installs: build tools, QEMU, locale, Google repo tool.

### Step 2: Clone Sources

```bash
./scripts/02-repo-sync.sh qemu-arm64
```

Options: `qemu-arm64`, `qemu-arm`, `beaglebone-black`, `raspberrypi5`

This creates `~/yocto-qemu-arm64/` and downloads Poky + meta-openembedded + meta-auton.

### Step 3: Setup Environment

```bash
cd ~/yocto-qemu-arm64
source scripts/03-setup-env.sh qemu-arm64
```

⚠️ **MUST be sourced** (not executed) — it sets environment variables for bitbake.

### Step 4: Build

```bash
./scripts/04-build.sh
```

First build takes 1-3 hours. Go get coffee. Subsequent builds use sstate cache (~5 min).

### Step 5: Run in QEMU

```bash
./scripts/05-run-qemu.sh qemu-arm64
```

Login: `root` (no password). Exit: `Ctrl+A` then `X`.

---

## What CAN'T Be Scripted

| Item | Why | Manual Step |
|------|-----|-------------|
| WSL2 memory config | Windows-side file | Edit `%USERPROFILE%\.wslconfig` manually |
| WSL2 disk expansion | Needs PowerShell admin | `wsl --shutdown` + diskpart expand |
| Terminal font (Nerd Font) | Terminal app setting | Install font, set in Windows Terminal settings |
| Git SSH keys | Personal credentials | `ssh-keygen` + add to GitHub |
| First `repo sync` auth | May need GitHub token | `repo init` prompts if needed |
| SD card device path | Hardware-dependent | Run `lsblk` to find `/dev/sdX` |
| Serial console access | USB passthrough | WSL doesn't natively support USB-serial; use usbipd-win |

### USB Serial Console (for real hardware)

WSL2 doesn't have direct USB access. To connect to BeagleBone/RPi5 serial:

**Option A: usbipd-win** (recommended)
```powershell
# From PowerShell (admin)
winget install usbipd
usbipd list                    # Find your USB-serial adapter
usbipd bind --busid X-Y       # Bind it
usbipd attach --wsl --busid X-Y  # Attach to WSL
```

Then in WSL:
```bash
sudo apt install minicom
minicom -D /dev/ttyUSB0 -b 115200
```

**Option B: Use PuTTY on Windows directly** for serial console.

---

## Troubleshooting

| Problem | Solution |
|---------|----------|
| `repo: command not found` | `source ~/.bashrc` or re-run `01-install-deps.sh` |
| `bitbake: command not found` | Re-source: `source scripts/03-setup-env.sh qemu-arm64` |
| `No space left on device` | Expand WSL vhdx or clean: `bitbake -c cleansstate auton-image-minimal` |
| `do_fetch` network error | Retry: `bitbake -c fetch auton-image-minimal` |
| Kernel sha256 mismatch | Add `PREFERRED_PROVIDER_virtual/kernel = "linux-yocto"` to `conf/local.conf` |
| QEMU hangs at boot | Use `slirp` networking: `runqemu qemu-arm64 nographic slirp` |
| `locale` warnings | `sudo locale-gen en_US.UTF-8 && export LANG=en_US.UTF-8` |
| Build takes forever | Check CPU/RAM allocation in `.wslconfig`; use `BB_NUMBER_THREADS` |

---

## Expanding to Real Hardware

After QEMU works:

```bash
# BeagleBone Black
./scripts/02-repo-sync.sh beaglebone-black
cd ~/yocto-beaglebone-black
source scripts/03-setup-env.sh beaglebone-black
./scripts/04-build.sh
./scripts/06-flash-hardware.sh /dev/sdX beaglebone-black

# Raspberry Pi 5
./scripts/02-repo-sync.sh raspberrypi5
cd ~/yocto-raspberrypi5
source scripts/03-setup-env.sh raspberrypi5
./scripts/04-build.sh
./scripts/06-flash-hardware.sh /dev/sdX raspberrypi5
```

---

## Directory Layout After Setup

```
~/yocto-qemu-arm64/
├── sources/
│   ├── poky/                  # Yocto core (bitbake, meta, meta-poky)
│   ├── meta-openembedded/     # OE layers (meta-oe, networking, python)
│   └── meta-auton-repo/       # This repo (meta-auton layer + scripts)
├── build-qemu-arm64/
│   ├── conf/
│   │   ├── local.conf         # Machine, distro, parallelism settings
│   │   └── bblayers.conf      # Layer paths
│   └── tmp/
│       └── deploy/images/     # Built images land here
├── downloads/                 # Shared source tarballs (cached)
└── sstate-cache/              # Shared build cache (speeds up rebuilds)
```
