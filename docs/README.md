# Documentation

## Contents

| Document | Description |
|----------|-------------|
| [WSL2 Setup (End-to-End)](wsl-setup.md) | Scripts + full workflow: install → build → QEMU → hardware |
| [QEMU on WSL Guide](qemu-wsl-guide.md) | Detailed QEMU usage, networking, debugging, CI |
| [Getting Started](getting-started.md) | Manual step-by-step build guide |
| [Learning Path](learning-path.md) | Structured Yocto & embedded Linux learning |
| [Machine Configs](machine-configs.md) | Explanation of every machine variable |
| [Awesome Yocto](awesome-yocto.md) | Curated Yocto resources, training, docs |
| [Awesome Embedded Linux](awesome-embedded-linux.md) | Curated embedded Linux resources |

## Scripts

All scripts are in `../scripts/` and are numbered for execution order:

```
01-install-deps.sh     Install build dependencies (run once)
02-repo-sync.sh        Clone Yocto sources for a target machine
03-setup-env.sh        Source build environment (MUST be sourced)
04-build.sh            Build the image with bitbake
05-run-qemu.sh         Boot image in QEMU
06-flash-hardware.sh   Flash image to SD card for real hardware
```
| [machine-configs.md](machine-configs.md) | Explanation of BeagleBone Black and RPi5 machine configurations |
| [awesome-yocto.md](awesome-yocto.md) | Curated links for Yocto Project resources |
| [awesome-embedded-linux.md](awesome-embedded-linux.md) | Curated links for embedded Linux resources |

## Quick Start

If you're new here, start with:

1. **[learning-path.md](learning-path.md)** new_textunderstand what to learn and in what order
2. **[getting-started.md](getting-started.md)** new_textget a build running on real hardware
3. **[machine-configs.md](machine-configs.md)** new_textunderstand what the config files do
