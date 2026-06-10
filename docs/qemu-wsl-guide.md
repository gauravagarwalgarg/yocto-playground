# Building and Running with QEMU on WSL

> No hardware needed. Build and boot a full embedded Linux image inside WSL2.

---

## Why QEMU?

- **No hardware required** -- iterate on recipes, images, and configs without flashing
- **Fast feedback loop** -- build once, boot in seconds
- **CI-friendly** -- automate builds and tests in GitHub Actions
- **WSL2 compatible** -- runs natively on Windows via WSL2

---

## Prerequisites (WSL2 Ubuntu 22.04+)

```bash
# Yocto build dependencies
sudo apt install gawk wget git diffstat unzip texinfo gcc build-essential \
    chrpath socat cpio python3 python3-pip python3-pexpect xz-utils \
    debianutils iputils-ping python3-git python3-jinja2 python3-subunit \
    zstd liblz4-tool file locales libacl1

# QEMU for running images
sudo apt install qemu-system-arm qemu-system-aarch64 qemu-utils

# Google repo tool
mkdir -p ~/.local/bin
curl https://storage.googleapis.com/git-repo-downloads/repo > ~/.local/bin/repo
chmod a+x ~/.local/bin/repo
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
```

---

## Build: QEMU AArch64 (Recommended)

```bash
# 1. Initialize workspace
mkdir ~/yocto-qemu && cd ~/yocto-qemu
repo init -u https://github.com/GauravAgarwalGarg/MyYoctoPlayground.git \
    -m manifests/qemu.xml -b main
repo sync

# 2. Setup build environment
source sources/meta-auton-repo/auton-init-build-env qemu-arm64

# 3. Build minimal image (~1-2 hours first time)
bitbake auton-image-minimal

# 4. Run in QEMU
runqemu qemu-arm64 nographic
```

---

## Build: QEMU ARM 32-bit

```bash
source sources/meta-auton-repo/auton-init-build-env qemu-arm
bitbake auton-image-minimal
runqemu qemu-arm nographic
```

---

## Running QEMU

### Basic (serial console, no graphics)

```bash
runqemu qemu-arm64 nographic
```

### With networking (TAP device, requires root)

```bash
runqemu qemu-arm64 nographic slirp
```

### With KVM acceleration (if WSL2 supports it)

```bash
# Check KVM availability
ls /dev/kvm 2>/dev/null && echo "KVM available" || echo "KVM not available"

# Run with KVM
runqemu qemu-arm64 nographic kvm
```

### Login credentials

- **User**: `root`
- **Password**: (none, debug-tweaks enabled)

---

## QEMU Machine Details

| Machine | Arch | QEMU Target | CPU | RAM |
|---------|------|-------------|-----|-----|
| `qemu-arm64` | AArch64 | `qemu-system-aarch64 -machine virt` | Cortex-A57 | 2GB |
| `qemu-arm` | ARMv7 | `qemu-system-arm -machine vexpress-a15` | Cortex-A15 | 1GB |

---

## WSL2 Tips

### Disk space

Yocto builds need 50-100GB. Ensure your WSL2 vhdx has enough space:

```powershell
# From PowerShell (admin)
wsl --shutdown
diskpart
# select vdisk file="C:\Users\<you>\AppData\Local\Packages\...\ext4.vhdx"
# expand vdisk maximum=150000
```

### Performance

```bash
# In WSL2 ~/.wslconfig (Windows side: %USERPROFILE%\.wslconfig)
[wsl2]
memory=16GB
processors=8
swap=8GB
```

### Build in ext4 (not /mnt/c)

Always build in the native WSL2 filesystem (`/home/...`), never in `/mnt/c/...`. The Windows filesystem is 10x slower for Yocto builds.

---

## Debugging the Image

### Inside QEMU

```bash
# Check kernel version
uname -a

# Check systemd status
systemctl status

# Check network
ip addr
ping 8.8.8.8

# Check installed packages
opkg list-installed
```

### From host (SSH into QEMU)

```bash
# If using slirp networking with port forward
ssh -p 2222 root@localhost
```

---

## Common Issues

| Issue | Fix |
|-------|-----|
| `runqemu: command not found` | Re-source the build env: `source auton-init-build-env qemu-arm64` |
| `Could not access KVM kernel module` | Normal on WSL2 without nested virt. Remove `kvm` flag. |
| `No space left on device` | Expand WSL2 vhdx or clean sstate: `bitbake -c cleansstate auton-image-minimal` |
| `do_fetch failed` | Network issue. Retry: `bitbake -c fetch auton-image-minimal` |
| QEMU hangs at boot | Check kernel config has `CONFIG_VIRTIO_BLK=y` and correct console |

---

## CI Integration (GitHub Actions)

```yaml
name: Build QEMU Image
on: [push]
jobs:
  build:
    runs-on: ubuntu-22.04
    steps:
      - uses: actions/checkout@v4
      - name: Install dependencies
        run: |
          sudo apt-get update
          sudo apt-get install -y gawk wget git diffstat unzip texinfo gcc \
            build-essential chrpath socat cpio python3 python3-pip xz-utils \
            debianutils python3-git python3-jinja2 zstd liblz4-tool file locales
      - name: Setup repo
        run: |
          mkdir -p ~/.local/bin
          curl https://storage.googleapis.com/git-repo-downloads/repo > ~/.local/bin/repo
          chmod a+x ~/.local/bin/repo
      - name: Build
        run: |
          mkdir build && cd build
          ~/.local/bin/repo init -u ${{ github.server_url }}/${{ github.repository }} \
              -m manifests/qemu.xml -b ${{ github.ref_name }}
          ~/.local/bin/repo sync
          source sources/meta-auton-repo/auton-init-build-env qemu-arm64
          bitbake auton-image-minimal
```

---

*Cross-references: [Getting Started](getting-started.md) | [Machine Configs](machine-configs.md) | [README](../README.md)*
