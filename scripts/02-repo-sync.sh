#!/bin/bash
# =============================================================================
# Step 2: Initialize and Sync Yocto Sources
# Usage: ./scripts/02-repo-sync.sh [machine]
#   machine: qemu-arm64 (default), qemu-arm, beaglebone-black, raspberrypi5
# =============================================================================
set -euo pipefail

MACHINE="${1:-qemu-arm64}"
REPO_URL="https://github.com/GauravAgarwalGarg/MyYoctoPlayground.git"
WORKSPACE="$HOME/yocto-${MACHINE}"

# Select manifest based on machine
case "$MACHINE" in
    qemu-arm64|qemu-arm)
        MANIFEST="manifests/qemu.xml"
        ;;
    beaglebone-black)
        MANIFEST="manifests/beaglebone-black.xml"
        ;;
    raspberrypi5)
        MANIFEST="manifests/raspberrypi5.xml"
        ;;
    *)
        echo "ERROR: Unknown machine '$MACHINE'"
        echo "Available: qemu-arm64, qemu-arm, beaglebone-black, raspberrypi5"
        exit 1
        ;;
esac

echo "=== Yocto Source Sync ==="
echo "  Machine:   $MACHINE"
echo "  Manifest:  $MANIFEST"
echo "  Workspace: $WORKSPACE"
echo ""

# Check disk space (need 50GB+)
AVAILABLE_GB=$(df -BG "$HOME" | awk 'NR==2 {print $4}' | tr -d 'G')
if [ "$AVAILABLE_GB" -lt 50 ]; then
    echo "WARNING: Only ${AVAILABLE_GB}GB free. Yocto builds need 50-100GB."
    echo "Consider expanding your WSL2 vhdx disk."
    read -p "Continue anyway? (y/N) " confirm
    [ "$confirm" != "y" ] && exit 1
fi

# Warn if building on Windows filesystem
if [[ "$WORKSPACE" == /mnt/* ]]; then
    echo "ERROR: Do NOT build on /mnt/c/ (Windows filesystem)."
    echo "Use native Linux path: ~/yocto-${MACHINE}"
    exit 1
fi

mkdir -p "$WORKSPACE" && cd "$WORKSPACE"

if [ ! -d ".repo" ]; then
    echo "=== Initializing repo ==="
    repo init -u "$REPO_URL" -m "$MANIFEST" -b main
fi

echo "=== Syncing sources (this may take 10-30 minutes) ==="
repo sync -j4

echo ""
echo "✓ Sources synced to: $WORKSPACE"
echo "  Next: cd $WORKSPACE && source scripts/03-setup-env.sh $MACHINE"
