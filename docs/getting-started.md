# Getting Started

Build a custom embedded Linux image from scratch using this playground.

## Prerequisites

- Ubuntu 22.04 or later (native or WSL2)
- At least 50 GB free disk space (100 GB recommended)
- At least 8 GB RAM (16 GB recommended)
- Internet connection for initial source download

## Step 1: Install Dependencies

```bash
sudo apt update
sudo apt install -y \
    gawk wget git diffstat unzip texinfo gcc build-essential \
    chrpath socat cpio python3 python3-pip python3-pexpect \
    xz-utils debianutils iputils-ping python3-git python3-jinja2 \
    python3-subunit zstd liblz4-tool file locales libacl1 \
    mesa-common-dev lz4
sudo locale-gen en_US.UTF-8
```

Install the `repo` tool for managing multiple git repositories:

```bash
mkdir -p ~/.local/bin
curl https://storage.googleapis.com/git-repo-downloads/repo > ~/.local/bin/repo
chmod a+x ~/.local/bin/repo
echo 'export PATH="${HOME}/.local/bin:${PATH}"' >> ~/.bashrc
source ~/.bashrc
```

## Step 2: Initialize with Repo Manifest

Choose your target board and initialize:

### BeagleBone Black

```bash
mkdir -p ~/yocto-bbb && cd ~/yocto-bbb
repo init -u https://github.com/GauravAgarwalGarg/MyYoctoPlayground.git \
    -m manifests/beaglebone-black.xml -b main
repo sync
```

### Raspberry Pi 5

```bash
mkdir -p ~/yocto-rpi5 && cd ~/yocto-rpi5
repo init -u https://github.com/GauravAgarwalGarg/MyYoctoPlayground.git \
    -m manifests/raspberrypi5.xml -b main
repo sync
```

## Step 3: Set Up the Build Environment

```bash
source sources/poky/oe-init-build-env build
```

This creates a `build/` directory and drops you into it. Copy the pre-configured conf files:

### For BeagleBone Black

```bash
cp ../sources/meta-garg/../build/beaglebone-black/conf/local.conf conf/local.conf
cp ../sources/meta-garg/../build/beaglebone-black/conf/bblayers.conf conf/bblayers.conf
```

Or use the setup script from the repo root:

```bash
../setup.sh beaglebone-black
```

### For Raspberry Pi 5

```bash
../setup.sh raspberrypi5
```

## Step 4: Build the Image

```bash
bitbake garg-image-minimal
```

This will take 1-4 hours on first build depending on your hardware. Subsequent builds use shared state cache and are much faster.

For a development image with debugging tools:

```bash
bitbake garg-image-dev
```

## Step 5: Flash to SD Card

After a successful build, images are in `tmp/deploy/images/<machine>/`.

### BeagleBone Black

```bash
# Find your SD card device (e.g., /dev/sdb)
lsblk

# Flash the WIC image
sudo bmaptool copy tmp/deploy/images/beaglebone-black/garg-image-minimal-beaglebone-black.wic.bmap /dev/sdX
```

If `bmaptool` is not available:

```bash
sudo dd if=tmp/deploy/images/beaglebone-black/garg-image-minimal-beaglebone-black.wic of=/dev/sdX bs=4M status=progress
sync
```

### Raspberry Pi 5

```bash
sudo bmaptool copy tmp/deploy/images/raspberrypi5/garg-image-minimal-raspberrypi5.wic.bmap /dev/sdX
```

## Step 6: Boot and Connect via Serial

### BeagleBone Black

Connect a USB-to-serial cable to the J1 header (pins: GND, TX, RX). Then:

```bash
sudo apt install -y minicom
sudo minicom -D /dev/ttyUSB0 -b 115200
```

Insert the SD card, hold the boot button (S2), and power on. You should see U-Boot and then Linux booting.

Default login: `root` (no password, debug-tweaks enabled)

### Raspberry Pi 5

Connect a USB-to-serial adapter to GPIO pins 8 (TX) and 10 (RX) on the 40-pin header:

```bash
sudo minicom -D /dev/ttyUSB0 -b 115200
```

Insert the SD card and power on.

## Troubleshooting

| Problem | Solution |
|---------|----------|
| Build fails with disk space error | Need at least 50 GB free |
| `do_fetch` failures | Check internet connection, retry with `bitbake -c cleansstate <recipe> && bitbake <recipe>` |
| No serial output | Verify cable connections, check baud rate is 115200 |
| SD card not booting | Ensure correct device (`/dev/sdX`), try re-flashing |

## Next Steps

- Read [machine-configs.md](machine-configs.md) to understand the hardware configuration
- Explore [learning-path.md](learning-path.md) for deeper Yocto knowledge
- Try adding your own recipe to `meta-garg/recipes-apps/`
