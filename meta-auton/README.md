# meta-auton

Custom Yocto meta-layer providing the **Auton Embedded Linux** distribution, machine configurations, and Linux 6.12 LTS kernel recipe.

## Layer Contents

```
meta-auton/
├── conf/
│   ├── layer.conf                  # Layer metadata (scarthgap + styhead + walnascar)
│   ├── distro/
│   │   └── auton.conf              # Auton distro: systemd, WiFi, BT, security hardening
│   └── machine/
│       ├── beaglebone-black.conf   # TI AM335x Cortex-A8
│       └── raspberrypi5.conf       # BCM2712 Cortex-A76
├── recipes-kernel/
│   └── linux/
│       ├── linux-auton_6.12.bb     # Mainline Linux 6.12 LTS recipe
│       ├── linux-auton_6.12.bbappend  # Machine-specific config fragments
│       └── linux-auton/
│           ├── defconfig           # Base kernel config (systemd-ready)
│           ├── bbb.cfg             # BeagleBone Black fragment
│           └── rpi5.cfg            # Raspberry Pi 5 fragment
└── recipes-core/
    └── images/
        ├── auton-image-minimal.bb  # SSH, htop, i2c-tools, Python, NetworkManager
        └── auton-image-dev.bb      # + GDB, strace, valgrind, perf, cmake
```

## Dependencies

- `poky` (meta, meta-poky)
- `meta-openembedded` (meta-oe, meta-networking, meta-python)
- `meta-ti` (for BeagleBone Black)
- `meta-raspberrypi` (for Raspberry Pi 5)

## Compatibility

- Yocto Scarthgap (5.0 LTS)
- Yocto Styhead (5.1)
- Yocto Walnascar (next)
