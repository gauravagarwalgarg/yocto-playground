#!/bin/bash
# =============================================================================
# Step 1: Install Yocto Build Dependencies (Ubuntu 22.04 / WSL2)
# =============================================================================
set -euo pipefail

echo "=== Installing Yocto build dependencies ==="

sudo apt-get update
sudo apt-get install -y \
    gawk wget git diffstat unzip texinfo gcc build-essential \
    chrpath socat cpio python3 python3-pip python3-pexpect xz-utils \
    debianutils iputils-ping python3-git python3-jinja2 python3-subunit \
    zstd liblz4-tool file locales libacl1

echo "=== Installing QEMU for ARM targets ==="
sudo apt-get install -y qemu-system-arm qemu-system-aarch64 qemu-utils

echo "=== Fixing locale (required by bitbake) ==="
sudo locale-gen en_US.UTF-8
export LANG=en_US.UTF-8

echo "=== Installing Google repo tool ==="
mkdir -p ~/.local/bin
if [ ! -f ~/.local/bin/repo ]; then
    curl -fsSL https://storage.googleapis.com/git-repo-downloads/repo > ~/.local/bin/repo
    chmod a+x ~/.local/bin/repo
fi

# Add to PATH if not already there
if ! grep -q 'local/bin' ~/.bashrc 2>/dev/null; then
    echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
fi
export PATH="$HOME/.local/bin:$PATH"

echo ""
echo "✓ Dependencies installed successfully."
echo "  Run: source ~/.bashrc (to get repo in PATH)"
echo "  Next: ./scripts/02-repo-sync.sh"
