SUMMARY = "Auton development image with debugging and build tools"
DESCRIPTION = "Full development environment for on-target debugging and compilation"
LICENSE = "MIT"

require auton-image-minimal.bb

IMAGE_INSTALL:append = " \
    gdb \
    gdbserver \
    strace \
    ltrace \
    tcpdump \
    iperf3 \
    git \
    cmake \
    make \
    packagegroup-core-buildessential \
    valgrind \
    perf \
    kernel-devsrc \
"

IMAGE_FEATURES += "debug-tweaks dev-pkgs tools-debug tools-profile"
