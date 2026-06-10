# Learning Path: Yocto Project & Embedded Linux

A structured path from beginner to proficient Yocto developer.

---

## Phase 1: Foundations (Week 1-2)

### Goal: Understand embedded Linux concepts

1. **Read Bootlin Embedded Linux Slides** (free)
   - [Download slides](https://bootlin.com/doc/training/embedded-linux/)
   - Focus on: cross-compilation, root filesystem, bootloaders, kernel basics
   - Time: ~8 hours of reading

2. **Understand the Boot Process**
   - ROM → SPL/MLO → U-Boot → Kernel → Init → Userspace
   - Device Trees: what they are and why they exist
   - [Device Tree for Dummies (Bootlin)](https://bootlin.com/pub/conferences/2014/elc/petazzoni-device-tree-dummies/)

3. **Linux Kernel Basics**
   - Kernel vs userspace
   - Kernel modules
   - `/proc` and `/sys` filesystems
   - [KernelNewbies](https://kernelnewbies.org/)

---

## Phase 2: Yocto Fundamentals (Week 3-4)

### Goal: Understand the Yocto build system

1. **Bootlin Yocto Training** (free)
   - [Download slides](https://bootlin.com/doc/training/yocto/)
   - [Download labs](https://bootlin.com/doc/training/yocto/yocto-labs.pdf)
   - Covers: BitBake, recipes, layers, images, SDK
   - Time: ~16 hours

2. **Key Concepts to Master**
   - BitBake: tasks, recipes (.bb), append files (.bbappend)
   - Layers: what they are, priority, dependencies
   - Variables: `MACHINE`, `DISTRO`, `IMAGE_INSTALL`, overrides
   - Classes: `inherit`, `core-image`, `autotools`, `cmake`
   - Shared state cache and reproducibility

3. **Official Documentation Deep Dive**
   - [Yocto Quick Build](https://docs.yoctoproject.org/brief-yoctoprojectqs/index.html)
   - [Development Tasks Manual](https://docs.yoctoproject.org/dev-manual/index.html)
   - [Variable Glossary](https://docs.yoctoproject.org/ref-manual/variables.html)

---

## Phase 3: Hands-On with QEMU (Week 5)

### Goal: Build and run without hardware

1. **Build for QEMU ARM**
   ```bash
   git clone -b scarthgap git://git.yoctoproject.org/poky
   source poky/oe-init-build-env build-qemu
   # Edit conf/local.conf: MACHINE = "qemuarm"
   bitbake core-image-minimal
   runqemu qemuarm
   ```

2. **Exercises**
   - Add a package to the image (`IMAGE_INSTALL:append`)
   - Create a simple "hello world" recipe
   - Use `devtool add` to create a recipe from source
   - Modify the kernel config with `devtool modify virtual/kernel`
   - Build and test an SDK: `bitbake -c populate_sdk core-image-minimal`

3. **Debugging Skills**
   - `bitbake -e <recipe>` new_textexamine variable expansion
   - `bitbake -c devshell <recipe>` new_textinteractive shell in build env
   - `bitbake-layers show-layers` new_textverify layer setup
   - `bitbake -DDD <recipe>` new_textverbose debug output

---

## Phase 4: Real Hardware - BeagleBone Black (Week 6-7)

### Goal: Deploy to physical hardware

1. **Follow the [Getting Started Guide](getting-started.md)** for BeagleBone Black

2. **Understand the Machine Configuration**
   - Read [machine-configs.md](machine-configs.md)
   - Study `meta-garg/conf/machine/beaglebone-black.conf`
   - Understand: DEFAULTTUNE, KERNEL_DEVICETREE, UBOOT_MACHINE

3. **Exercises**
   - Boot the minimal image via SD card
   - Connect via serial console (115200 baud)
   - SSH into the board over Ethernet
   - Add a custom systemd service
   - Toggle a GPIO from userspace
   - Read an I2C sensor with `i2c-tools`

4. **Kernel Customization**
   - Add a kernel module to the build
   - Modify the device tree to enable a peripheral
   - Use kernel fragments (`.cfg` files)

---

## Phase 5: Raspberry Pi 5 (Week 8)

### Goal: Work with a different BSP

1. **Build for RPi5** using the manifest and configs in this repo

2. **Compare BSP Differences**
   - Different bootloader flow (RPi firmware → U-Boot → kernel)
   - Different device tree structure
   - WiFi/BT firmware requirements

3. **Exercises**
   - Enable WiFi with `wpa_supplicant` or NetworkManager
   - Set up Bluetooth
   - Use the camera interface (if available)
   - Configure HDMI output

---

## Phase 6: Custom Distribution (Week 9-10)

### Goal: Create production-quality images

1. **Study `garg-distro.conf`**
   - Understand DISTRO_FEATURES
   - systemd vs sysvinit
   - Package management (ipk, deb, rpm)

2. **Advanced Topics**
   - Create a custom packagegroup
   - Implement an update mechanism (SWUpdate, RAUC, or Mender)
   - Set up read-only rootfs with overlay
   - Implement secure boot chain
   - Optimize boot time (< 5 seconds)

3. **Production Hardening**
   - Remove `debug-tweaks`
   - Set up user accounts and passwords
   - Enable SELinux or AppArmor
   - Configure firewall rules
   - Sign packages and verify integrity

---

## Phase 7: Advanced Topics (Ongoing)

### Custom BSP Development
- Write a machine configuration from scratch
- Port U-Boot to a new board
- Create device tree overlays

### CI/CD for Embedded
- Automate builds with Jenkins or GitLab CI
- Use `kas` for reproducible build configurations
- Implement automated testing with LAVA or pytest

### Linaro & Arm Ecosystem
- [Linaro Connect recordings](https://connect.linaro.org/) new_textDeep technical talks
- [Arm Architecture Reference Manual](https://developer.arm.com/documentation/) new_textISA details
- [Trusted Firmware](https://www.trustedfirmware.org/) new_textSecure boot

### Performance & Optimization
- Boot time optimization (Bootlin training)
- Runtime profiling with `perf`
- Memory optimization for constrained devices
- Kernel size reduction

---

## Recommended Reading Order

| Priority | Resource | Time |
|----------|----------|------|
| 1 | Bootlin Yocto slides | 16h |
| 2 | Yocto Quick Build (official) | 2h |
| 3 | This repo's getting-started.md | 4h |
| 4 | Bootlin Embedded Linux slides | 8h |
| 5 | Yocto Dev Tasks Manual | 8h |
| 6 | Linaro Connect talks (selected) | 4h |
| 7 | *Mastering Embedded Linux Programming* (book) | 20h |

---

## Key Takeaways

- **Start with QEMU** new_textno hardware needed, fast iteration
- **Read the Bootlin materials** new_textbest free training available
- **Use `devtool`** new_textit's the modern workflow for recipe development
- **Understand variables and overrides** new_textthis is 80% of Yocto debugging
- **Keep layers clean** new_textnever modify upstream layers directly
- **Share `DL_DIR` and `SSTATE_DIR`** new_textsaves hours on rebuilds
