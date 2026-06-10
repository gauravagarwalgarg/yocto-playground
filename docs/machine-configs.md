# Machine Configuration Reference

This document explains the machine configuration files in `meta-garg/conf/machine/`.

---

## BeagleBone Black (`beaglebone-black.conf`)

The BeagleBone Black uses a TI AM335x SoC (ARM Cortex-A8).

### Header Comments

```
#@TYPE: Machine
#@NAME: BeagleBone Black
#@DESCRIPTION: Machine configuration for BeagleBone Black (AM335x)
```

These are metadata comments used by tools like the layer index to describe the machine.

### SoC and Architecture

```
require conf/machine/include/ti-soc.inc
SOC_FAMILY = "ti-am335x"
DEFAULTTUNE = "cortexa8hf-neon"
require conf/machine/include/arm/armv7a/tune-cortexa8.inc
```

| Variable | Meaning |
|----------|---------|
| `require conf/machine/include/ti-soc.inc` | Pulls in TI-specific SoC defaults from meta-ti |
| `SOC_FAMILY` | Identifies the SoC family for BSP layer matching |
| `DEFAULTTUNE` | Compiler tuning: Cortex-A8, hard-float, NEON SIMD |
| `tune-cortexa8.inc` | Sets GCC flags: `-mcpu=cortex-a8 -mfpu=neon -mfloat-abi=hard` |

### Kernel Configuration

```
PREFERRED_PROVIDER_virtual/kernel = "linux-yocto"
PREFERRED_VERSION_linux-yocto = "6.6%"
KERNEL_IMAGETYPE = "zImage"
KERNEL_DEVICETREE = "am335x-boneblack.dtb"
```

| Variable | Meaning |
|----------|---------|
| `PREFERRED_PROVIDER_virtual/kernel` | Which kernel recipe to use (linux-yocto is the Yocto-maintained kernel) |
| `PREFERRED_VERSION_linux-yocto` | Pin to 6.6.x LTS kernel (% is wildcard) |
| `KERNEL_IMAGETYPE` | `zImage` = compressed ARM 32-bit kernel image |
| `KERNEL_DEVICETREE` | Device tree blob describing the BeagleBone Black hardware |

### Bootloader

```
UBOOT_MACHINE = "am335x_evm_defconfig"
SPL_BINARY = "MLO"
UBOOT_SUFFIX = "img"
```

| Variable | Meaning |
|----------|---------|
| `UBOOT_MACHINE` | U-Boot defconfig to build (AM335x EVM covers BeagleBone) |
| `SPL_BINARY` | Secondary Program Loader filename (first-stage bootloader loaded by ROM) |
| `UBOOT_SUFFIX` | U-Boot binary extension (produces `u-boot.img`) |

**Boot flow:** ROM → MLO (SPL) → u-boot.img → zImage + DTB

### Machine Features

```
MACHINE_FEATURES = "usbgadget usbhost vfat ext2 screen alsa ethernet wifi"
MACHINE_EXTRA_RRECOMMENDS = "kernel-modules kernel-devicetree"
```

| Feature | What it enables |
|---------|----------------|
| `usbgadget` | USB device mode (BeagleBone can appear as USB device) |
| `usbhost` | USB host mode (connect USB devices) |
| `vfat` | FAT filesystem support (for boot partition) |
| `ext2` | ext2/3/4 filesystem support |
| `screen` | Display/framebuffer support |
| `alsa` | Audio support |
| `ethernet` | Wired networking |
| `wifi` | Wireless networking |

`MACHINE_EXTRA_RRECOMMENDS` installs kernel modules and device tree into the image.

### Serial Console & Image

```
SERIAL_CONSOLES = "115200;ttyS0"
IMAGE_FSTYPES = "tar.xz wic wic.bmap"
WKS_FILE = "beaglebone-yocto.wks"
```

| Variable | Meaning |
|----------|---------|
| `SERIAL_CONSOLES` | Baud rate and serial device for getty |
| `IMAGE_FSTYPES` | Output formats: tarball, WIC disk image, bmap for fast flashing |
| `WKS_FILE` | Wic kickstart file defining partition layout |

---

## Raspberry Pi 5 (`raspberrypi5.conf`)

The Raspberry Pi 5 uses a BCM2712 SoC (ARM Cortex-A76, quad-core).

### Architecture

```
DEFAULTTUNE = "cortexa76"
require conf/machine/include/arm/armv8-2a/tune-cortexa76.inc
```

| Variable | Meaning |
|----------|---------|
| `DEFAULTTUNE` | Compiler tuning for Cortex-A76 (ARMv8.2-A, 64-bit) |
| `tune-cortexa76.inc` | Sets GCC flags for A76: `-mcpu=cortex-a76` with crypto extensions |

The RPi5 is significantly more powerful than the BeagleBone new_text64-bit, out-of-order, superscalar.

### Kernel Configuration

```
PREFERRED_PROVIDER_virtual/kernel = "linux-yocto"
PREFERRED_VERSION_linux-yocto = "6.6%"
KERNEL_IMAGETYPE = "Image"
KERNEL_DEVICETREE = "broadcom/bcm2712-rpi-5-b.dtb"
```

| Variable | Meaning |
|----------|---------|
| `KERNEL_IMAGETYPE` | `Image` = uncompressed AArch64 kernel (RPi firmware handles decompression) |
| `KERNEL_DEVICETREE` | BCM2712 device tree for RPi 5 Model B |

### Bootloader

```
UBOOT_MACHINE = "rpi_arm64_defconfig"
RPI_USE_U_BOOT = "1"
ENABLE_UART = "1"
DISABLE_OVERSCAN = "1"
```

| Variable | Meaning |
|----------|---------|
| `UBOOT_MACHINE` | U-Boot config for RPi 64-bit |
| `RPI_USE_U_BOOT` | Use U-Boot instead of direct kernel boot from RPi firmware |
| `ENABLE_UART` | Enable serial console on GPIO pins |
| `DISABLE_OVERSCAN` | Disable TV overscan compensation (for monitors) |

**Boot flow:** RPi Firmware (GPU) → U-Boot → Image + DTB

Note: The Raspberry Pi has a unique boot process where the VideoCore GPU loads firmware from the SD card's FAT partition, which then loads U-Boot (or the kernel directly).

### Machine Features

```
MACHINE_FEATURES = "usbhost wifi bluetooth alsa screen ethernet"
MACHINE_EXTRA_RRECOMMENDS = "kernel-modules kernel-devicetree linux-firmware-rpidistro-bcm43455"
```

The `linux-firmware-rpidistro-bcm43455` package provides WiFi/BT firmware blobs needed for the onboard wireless chip.

### Serial Console & Image

```
SERIAL_CONSOLES = "115200;ttyAMA10"
IMAGE_FSTYPES = "tar.xz rpi-sdimg wic wic.bmap"
```

| Variable | Meaning |
|----------|---------|
| `SERIAL_CONSOLES` | `ttyAMA10` is the PL011 UART exposed on GPIO 14/15 on RPi5 |
| `rpi-sdimg` | RPi-specific SD card image format with boot partition |

---

## Key Differences Summary

| Aspect | BeagleBone Black | Raspberry Pi 5 |
|--------|-----------------|----------------|
| Architecture | ARMv7-A (32-bit) | ARMv8.2-A (64-bit) |
| CPU | Cortex-A8, single core | Cortex-A76, quad core |
| Kernel image | zImage (compressed) | Image (uncompressed) |
| Boot flow | ROM → MLO → U-Boot | GPU FW → U-Boot |
| Serial port | ttyS0 | ttyAMA10 |
| WiFi firmware | External (cape) | Onboard (needs blob) |
| Image format | wic | rpi-sdimg / wic |

---

## Adding a New Machine

To add support for another board:

1. Create `meta-garg/conf/machine/<machine-name>.conf`
2. Set `DEFAULTTUNE` and include the appropriate tune file
3. Configure kernel, bootloader, and device tree
4. Define `MACHINE_FEATURES` for available hardware
5. Set `SERIAL_CONSOLES` and `IMAGE_FSTYPES`
6. Add the BSP layer to `bblayers.conf`
7. Create a manifest XML if using repo
