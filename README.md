# MyYoctoPlayground

A hands-on Yocto Project playground for building custom embedded Linux images. Features the **Auton** distribution with Linux 6.12 LTS, targeting BeagleBone Black and Raspberry Pi 5.

---

## What's Inside

| Component | Description |
|-----------|-------------|
| **meta-auton** | Custom layer: distro, machines, kernel 6.12, images |
| **manifests/** | Google repo manifests for reproducible builds |
| **build/** | Pre-configured local.conf + bblayers.conf per machine |
| **docs/** | Getting started, learning path, curated resources |

---

## Quick Start

### Single Command Setup (All Machines)

```bash
# 1. Install deps (once)
cd ~/Projects/GauravAgarwalGarg/MyYoctoPlayground
./scripts/01-install-deps.sh && source ~/.bashrc

# 2. Sync ALL sources (one workspace, all BSP layers)
./scripts/02-repo-sync.sh

# 3. Setup + Build (pick your machine)
cd ~/yocto-auton
source sources/meta-auton-repo/auton-init-build-env qemu-arm64
bitbake core-image-minimal

# 4. Run in QEMU
runqemu qemu-arm64 nographic slirp
```

### Multiconfig (Build All Machines from One Workspace)

```bash
source sources/meta-auton-repo/auton-init-build-env all
bitbake mc:qemu-arm64:auton-image-minimal
bitbake mc:beaglebone-black:auton-image-minimal
bitbake mc:raspberrypi5:auton-image-minimal
```

---

## Auton Distribution

| Feature | Value |
|---------|-------|
| Init system | systemd |
| Kernel | Linux 6.12 LTS (mainline) |
| Package format | IPK |
| WiFi/BT | Enabled |
| Security | FORTIFY_SOURCE, stack protector, RELRO |
| Yocto release | Scarthgap (5.0 LTS) |

---

## Images

| Image | Contents |
|-------|----------|
| `auton-image-minimal` | SSH, nano, htop, i2c-tools, Python 3, NetworkManager |
| `auton-image-dev` | + GDB, strace, valgrind, perf, cmake, build-essential |

---

## Target Boards

| Board | SoC | Arch | Kernel DT | Manifest |
|-------|-----|------|-----------|----------|
| QEMU AArch64 | virt | ARMv8-A Cortex-A57 | N/A | `qemu.xml` |
| QEMU ARM | vexpress-a15 | ARMv7-A Cortex-A15 | N/A | `qemu.xml` |
| BeagleBone Black | TI AM335x | ARMv7-A Cortex-A8 | `am335x-boneblack.dtb` | `beaglebone-black.xml` |
| Raspberry Pi 5 | BCM2712 | ARMv8.2-A Cortex-A76 | `bcm2712-rpi-5-b.dtb` | `raspberrypi5.xml` |

---

## Documentation

| Document | Content |
|----------|---------|
| [QEMU on WSL](docs/qemu-wsl-guide.md) | Build and run images in QEMU on WSL2 |
| [Getting Started](docs/getting-started.md) | Full build-from-scratch guide |
| [Learning Path](docs/learning-path.md) | Structured Yocto learning (Bootlin, Linaro, official) |
| [Machine Configs](docs/machine-configs.md) | Every variable explained |
| [Awesome Yocto](docs/awesome-yocto.md) | Curated Yocto resources |
| [Awesome Embedded Linux](docs/awesome-embedded-linux.md) | Curated embedded Linux resources |

---

## Prerequisites

```bash
# Ubuntu 22.04+
sudo apt install gawk wget git diffstat unzip texinfo gcc build-essential \
    chrpath socat cpio python3 python3-pip python3-pexpect xz-utils \
    debianutils iputils-ping python3-git python3-jinja2 python3-subunit \
    zstd liblz4-tool file locales libacl1 repo
```

---

## License

MIT
