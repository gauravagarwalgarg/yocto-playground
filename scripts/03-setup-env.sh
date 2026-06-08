#!/bin/bash
# =============================================================================
# Step 3: Setup Build Environment
# MUST BE SOURCED: source scripts/03-setup-env.sh [machine]
#
# This script:
#   1. Runs repo sync if sources aren't present
#   2. Sources the auton build environment for the selected machine
# =============================================================================

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    echo "ERROR: This script must be sourced, not executed."
    echo "Usage: source scripts/03-setup-env.sh [machine]"
    exit 1
fi

MACHINE="${1:-qemu-arm64}"
REPO_URL="https://github.com/GauravAgarwalGarg/MyYoctoPlayground.git"

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
        return 1
        ;;
esac

WORKSPACE="$HOME/yocto-${MACHINE}"

echo "=== Setting up build environment ==="
echo "  Machine:   $MACHINE"
echo "  Workspace: $WORKSPACE"
echo ""

# Step 1: Create workspace and sync if needed
if [ ! -d "$WORKSPACE/sources/poky" ]; then
    echo "  Sources not found. Running repo sync (10-30 min first time)..."
    mkdir -p "$WORKSPACE"
    cd "$WORKSPACE"

    if [ ! -d ".repo" ]; then
        repo init -u "$REPO_URL" -m "$MANIFEST" -b main
    fi

    repo sync -j4

    echo "  Sources synced."
else
    echo "  Sources already present."
    cd "$WORKSPACE"
fi

# Step 2: Source the auton build environment
AUTON_ENV="$WORKSPACE/sources/meta-auton-repo/auton-init-build-env"

if [ -f "$AUTON_ENV" ]; then
    source "$AUTON_ENV" "$MACHINE"
else
    # Fallback: use poky directly
    echo "  auton-init-build-env not found, using poky directly..."
    source "$WORKSPACE/sources/poky/oe-init-build-env" "$WORKSPACE/build"

    echo "  NOTE: Set MACHINE and DISTRO manually in conf/local.conf:"
    echo "    MACHINE = \"$MACHINE\""
    echo "    DISTRO = \"auton\""
fi

echo ""
echo "  Build dir: $(pwd)"
echo ""
echo "✓ Environment ready. Run: bitbake auton-image-minimal"
