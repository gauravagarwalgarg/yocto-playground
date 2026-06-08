SUMMARY = "Auton minimal embedded Linux image"
DESCRIPTION = "Base system with SSH, essential tools, and Python 3"
LICENSE = "MIT"

inherit core-image

IMAGE_INSTALL:append = " \
    openssh-sftp-server \
    openssh-sshd \
    nano \
    htop \
    i2c-tools \
    python3 \
    networkmanager \
    iw \
"

IMAGE_FEATURES += "ssh-server-openssh"

# Ensure systemd is the init
IMAGE_INSTALL:append = " systemd-analyze"
