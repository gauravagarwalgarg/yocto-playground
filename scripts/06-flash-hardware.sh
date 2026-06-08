#!/bin/bash
# =============================================================================
# Step 6: Flash Image to SD Card (for real hardware)
# Usage: ./scripts/06-flash-hardware.sh /dev/sdX [machine]
# =============================================================================
set -euo pipefail

DEVICE="${1:-}"
MACHINE="${2:-beaglebone-black}"

if [ -z "$DEVICE" ]; then
    echo "Usage: $0 /dev/sdX [machine]"
    echo ""
    echo "  machine: beaglebone-black, raspberrypi5"
    echo ""
    echo "Available devices:"
    lsblk -d -o NAME,SIZE,MODEL | grep -v loop
    exit 1
fi

# Safety check
if [[ "$DEVICE" == "/dev/sda" || "$DEVICE" == "/dev/nvme0n1" ]]; then
    echo "ERROR: $DEVICE looks like your system disk. Aborting."
    exit 1
fi

IMAGE_DIR="tmp/deploy/images/${MACHINE}"

if [ ! -d "$IMAGE_DIR" ]; then
    echo "ERROR: Image directory not found: $IMAGE_DIR"
    echo "Did you build the image? Run: bitbake auton-image-minimal"
    exit 1
fi

# Find the .wic image
WIC_FILE=$(find "$IMAGE_DIR" -name "*.wic" -o -name "*.wic.gz" | head -1)
BMAP_FILE=$(find "$IMAGE_DIR" -name "*.wic.bmap" | head -1)

if [ -z "$WIC_FILE" ]; then
    echo "ERROR: No .wic image found in $IMAGE_DIR"
    exit 1
fi

echo "=== Flash to Hardware ==="
echo "  Machine: $MACHINE"
echo "  Image:   $WIC_FILE"
echo "  Device:  $DEVICE"
echo ""
echo "  WARNING: This will ERASE ALL DATA on $DEVICE"
read -p "  Continue? (yes/NO) " confirm
[ "$confirm" != "yes" ] && exit 0

if command -v bmaptool &>/dev/null && [ -n "$BMAP_FILE" ]; then
    echo "  Using bmaptool (faster, sparse-aware)..."
    sudo bmaptool copy "$WIC_FILE" "$DEVICE"
else
    echo "  Using dd (slower, full write)..."
    if [[ "$WIC_FILE" == *.gz ]]; then
        gunzip -c "$WIC_FILE" | sudo dd of="$DEVICE" bs=4M status=progress
    else
        sudo dd if="$WIC_FILE" of="$DEVICE" bs=4M status=progress
    fi
fi

sync

echo ""
echo "✓ Flash complete. Insert SD card into $MACHINE and power on."
echo "  Serial console: 115200 baud"
echo "  Login: root (no password)"
