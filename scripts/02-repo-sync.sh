#!/bin/bash
# =============================================================================
# Step 2: Initialize and Sync Yocto Sources (ALL machines)
# Usage: ./scripts/02-repo-sync.sh [workspace_path]
#
# Uses default.xml manifest which includes ALL BSP layers.
# One sync supports: qemu-arm64, beaglebone-black, raspberrypi5
# =============================================================================
set -euo pipefail

REPO_URL="https://github.com/GauravAgarwalGarg/MyYoctoPlayground.git"
WORKSPACE="${1:-$HOME/yocto-auton}"

echo "=== Yocto Source Sync (All Machines) ==="
echo "  Manifest:  manifests/default.xml"
echo "  Workspace: $WORKSPACE"
echo ""

# Check disk space
AVAILABLE_GB=$(df -BG "$HOME" | awk 'NR==2 {print $4}' | tr -d 'G')
if [ "$AVAILABLE_GB" -lt 50 ]; then
    echo "WARNING: Only ${AVAILABLE_GB}GB free. Need 50-100GB."
    read -p "Continue? (y/N) " confirm
    [ "$confirm" != "y" ] && exit 1
fi

# Warn about Windows filesystem
if [[ "$WORKSPACE" == /mnt/* ]]; then
    echo "ERROR: Do NOT build on /mnt/c/ (10x slower)."
    echo "Use: $HOME/yocto-auton"
    exit 1
fi

mkdir -p "$WORKSPACE" && cd "$WORKSPACE"

if [ ! -d ".repo" ]; then
    echo "=== Initializing repo ==="
    repo init -u "$REPO_URL" -m manifests/default.xml -b main
fi

echo "=== Syncing sources ==="
repo sync -j4

echo ""
echo "Done. Sources at: $WORKSPACE"
echo ""
echo "Next:"
echo "  cd $WORKSPACE"
echo "  source sources/meta-auton-repo/auton-init-build-env qemu-arm64"
echo ""
echo "  Or for all machines:"
echo "  source sources/meta-auton-repo/auton-init-build-env all"
