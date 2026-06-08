#!/bin/bash
# =============================================================================
# Step 5: Run the Image in QEMU
# Run AFTER sourcing 03-setup-env.sh AND 04-build.sh
# =============================================================================
set -euo pipefail

MACHINE="${1:-qemu-arm64}"

# Check runqemu is available
if ! command -v runqemu &>/dev/null; then
    echo "ERROR: runqemu not in PATH."
    echo "Did you source the environment?"
    echo "  source scripts/03-setup-env.sh $MACHINE"
    exit 1
fi

echo "=== Running QEMU: $MACHINE ==="
echo ""
echo "  Login:  root (no password)"
echo "  Exit:   Ctrl+A, then X"
echo ""
echo "  Starting in 3 seconds..."
sleep 3

# nographic: serial console (works in WSL, no X11 needed)
# slirp: user-mode networking (no root/TAP needed in WSL)
runqemu "$MACHINE" nographic slirp
