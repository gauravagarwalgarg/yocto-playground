#!/bin/bash
# =============================================================================
# Step 4: Build the Image
# Run AFTER sourcing 03-setup-env.sh (bitbake must be in PATH)
# =============================================================================
set -euo pipefail

IMAGE="${1:-auton-image-minimal}"

# Check bitbake is available
if ! command -v bitbake &>/dev/null; then
    echo "ERROR: bitbake not in PATH."
    echo "Did you source the environment?"
    echo "  source scripts/03-setup-env.sh qemu-arm64"
    exit 1
fi

echo "=== Building: $IMAGE ==="
echo "  This will take 1-3 hours on first build."
echo "  Subsequent builds are cached (minutes)."
echo ""

# If linux-auton kernel fails (sha256 mismatch), fall back to linux-yocto
# Uncomment the next line if the custom kernel recipe isn't ready:
# echo 'PREFERRED_PROVIDER_virtual/kernel = "linux-yocto"' >> conf/local.conf

bitbake "$IMAGE"

echo ""
echo "✓ Build complete: $IMAGE"
echo "  Image location: tmp/deploy/images/"
echo "  Next: ./scripts/05-run-qemu.sh"
