# Linux kernel 6.12 LTS for Auton distribution
#
# This recipe builds mainline Linux 6.12.x from kernel.org.
# Machine-specific defconfigs and device tree patches are applied
# via .bbappend files or KERNEL_DEVICETREE in machine configs.

SUMMARY = "Linux kernel 6.12 LTS for Auton targets"
DESCRIPTION = "Mainline Linux kernel 6.12 LTS with minimal patches for BeagleBone Black and Raspberry Pi 5"
LICENSE = "GPL-2.0-only"
LIC_FILES_CHKSUM = "file://COPYING;md5=6bc538ed5bd9a7fc9398086aedcd7e46"

inherit kernel

LINUX_VERSION = "6.12.8"
LINUX_VERSION_EXTENSION = "-auton"

SRC_URI = " \
    https://cdn.kernel.org/pub/linux/kernel/v6.x/linux-${LINUX_VERSION}.tar.xz \
    file://defconfig \
"

SRC_URI[sha256sum] = "FIXME_ADD_SHA256_AFTER_DOWNLOAD"

S = "${WORKDIR}/linux-${LINUX_VERSION}"

# Allow out-of-tree module builds
KERNEL_EXTRA_FEATURES ?= ""

# Default config - machines override via .bbappend or defconfig fragments
KBUILD_DEFCONFIG = "defconfig"

# Ensure modules are built
KERNEL_MODULE_AUTOLOAD += ""

# Compatible machines
COMPATIBLE_MACHINE = "beaglebone-black|raspberrypi5|qemu-arm|qemu-arm64"

# Version
PV = "${LINUX_VERSION}"

do_configure:prepend() {
    # If a machine-specific defconfig exists, use it
    if [ -f "${WORKDIR}/defconfig" ]; then
        cp "${WORKDIR}/defconfig" "${B}/.config"
    fi
}
