# Awesome Embedded Linux

A curated list of resources for embedded Linux development.

## Training & Learning

### Bootlin (Free Training Materials)

- [Embedded Linux Training](https://bootlin.com/training/embedded-linux/) new_textComplete embedded Linux course
- [Embedded Linux Slides (PDF)](https://bootlin.com/doc/training/embedded-linux/) new_textDownloadable slides
- [Embedded Linux Labs](https://bootlin.com/doc/training/embedded-linux/embedded-linux-labs.pdf) new_textHands-on exercises
- [Linux Kernel Training](https://bootlin.com/training/kernel/) new_textKernel development course
- [Linux Kernel Slides](https://bootlin.com/doc/training/linux-kernel/) new_textKernel internals
- [Device Tree Training](https://bootlin.com/training/device-tree/) new_textDevice tree for hardware description
- [Buildroot Training](https://bootlin.com/training/buildroot/) new_textAlternative build system
- [Boot Time Optimization](https://bootlin.com/training/boot-time/) new_textFast boot techniques
- [Linux Graphics Training](https://bootlin.com/training/graphics/) new_textDRM/KMS, Wayland

### Linaro Resources

- [Linaro Connect](https://connect.linaro.org/) new_textConference presentations and videos
- [Linaro Resources Hub](https://www.linaro.org/resources/) new_textTechnical articles and whitepapers
- [Linaro Developer Cloud](https://www.linaro.org/services/developer-cloud/) new_textArm development infrastructure
- [Linaro Toolchain](https://www.linaro.org/downloads/) new_textGCC and LLVM for Arm
- [96Boards](https://www.96boards.org/) new_textOpen hardware specifications

### Other Courses

- [Linux Foundation Training](https://training.linuxfoundation.org/) new_textProfessional certifications
- [Coursera - Introduction to Embedded Systems](https://www.coursera.org/learn/introduction-embedded-systems) new_textUniversity course
- [edX - Embedded Linux](https://www.edx.org/learn/embedded-systems) new_textOnline courses

## Books

- *Mastering Embedded Linux Programming* new_textFrank Vasquez, Chris Simmonds (Packt)
- *Linux Device Drivers, 3rd Edition* new_textCorbet, Rubini, Kroah-Hartman (free online at lwn.net)
- *Embedded Linux Primer* new_textChristopher Hallinan
- *Building Embedded Linux Systems* new_textKarim Yaghmour
- *Linux Kernel Development* new_textRobert Love
- *The Linux Programming Interface* new_textMichael Kerrisk

## Kernel Resources

- [kernel.org](https://www.kernel.org/) new_textOfficial Linux kernel source
- [Linux Kernel Documentation](https://docs.kernel.org/) new_textIn-tree documentation
- [LWN.net](https://lwn.net/) new_textLinux Weekly News (kernel development)
- [KernelNewbies](https://kernelnewbies.org/) new_textGetting started with kernel development
- [Bootlin Elixir Cross-Referencer](https://elixir.bootlin.com/) new_textBrowse kernel source online
- [Linux Driver Verification](http://linuxtesting.org/ldv/) new_textStatic analysis for drivers

## Build Systems

- [Yocto Project](https://www.yoctoproject.org/) new_textIndustry-standard embedded Linux build system
- [Buildroot](https://buildroot.org/) new_textSimple, fast embedded Linux build system
- [OpenWrt](https://openwrt.org/) new_textRouter/networking focused build system
- [PTXdist](https://www.ptxdist.org/) new_textPengutronix build system
- [ELBE](https://elbe-rfs.org/) new_textDebian-based embedded Linux builder

## Bootloaders

- [U-Boot](https://www.denx.de/wiki/U-Boot) new_textUniversal Boot Loader
- [U-Boot Documentation](https://docs.u-boot.org/) new_textOfficial docs
- [Barebox](https://www.barebox.org/) new_textModern bootloader (U-Boot fork)
- [ARM Trusted Firmware (TF-A)](https://www.trustedfirmware.org/) new_textSecure world firmware
- [UEFI/EDK2](https://github.com/tianocore/edk2) new_textUEFI firmware

## Hardware Platforms

### BeagleBone

- [BeagleBoard.org](https://www.beagleboard.org/) new_textOfficial site
- [BeagleBone Black System Reference Manual](https://github.com/beagleboard/beaglebone-black/wiki/System-Reference-Manual)
- [AM335x Technical Reference Manual](https://www.ti.com/lit/ug/spruh73q/spruh73q.pdf) new_textTI SoC documentation

### Raspberry Pi

- [Raspberry Pi Documentation](https://www.raspberrypi.com/documentation/) new_textOfficial docs
- [Raspberry Pi Linux Kernel](https://github.com/raspberrypi/linux) new_textRPi kernel fork
- [Raspberry Pi Firmware](https://github.com/raspberrypi/firmware) new_textGPU firmware blobs

### Other Platforms

- [STM32MP1 Wiki](https://wiki.st.com/stm32mpu) new_textSTMicroelectronics MPU
- [i.MX Reference Manuals](https://www.nxp.com/products/processors-and-microcontrollers/arm-processors/i-mx-applications-processors:IMX_HOME) new_textNXP i.MX
- [NVIDIA Jetson](https://developer.nvidia.com/embedded-computing) new_textGPU-accelerated embedded
- [RISC-V](https://riscv.org/) new_textOpen ISA

## Tools & Debugging

- [GDB](https://www.sourceware.org/gdb/) new_textGNU Debugger
- [OpenOCD](https://openocd.org/) new_textOn-chip debugging
- [strace](https://strace.io/) new_textSystem call tracer
- [perf](https://perf.wiki.kernel.org/) new_textLinux performance tools
- [ftrace](https://docs.kernel.org/trace/ftrace.html) new_textFunction tracer
- [LTTng](https://lttng.org/) new_textLinux Trace Toolkit
- [Buildroot/Yocto SDK](https://docs.yoctoproject.org/sdk-manual/index.html) new_textCross-compilation toolchains
- [QEMU](https://www.qemu.org/) new_textHardware emulation

## Device Trees

- [Device Tree Specification](https://www.devicetree.org/specifications/) new_textOfficial spec
- [Device Tree for Dummies (ELC 2014)](https://bootlin.com/pub/conferences/2014/elc/petazzoni-device-tree-dummies/) new_textIntro talk
- [Kernel Device Tree Bindings](https://docs.kernel.org/devicetree/bindings/) new_textBinding documentation

## Networking & IoT

- [NetworkManager](https://networkmanager.dev/) new_textNetwork configuration
- [systemd-networkd](https://www.freedesktop.org/software/systemd/man/systemd-networkd.html) new_textLightweight networking
- [Eclipse IoT](https://iot.eclipse.org/) new_textIoT frameworks
- [Zephyr Project](https://www.zephyrproject.org/) new_textRTOS for constrained devices
- [MQTT](https://mqtt.org/) new_textLightweight messaging protocol

## Security

- [Yocto Security Hardening](https://docs.yoctoproject.org/dev-manual/security.html) new_textBuild-time security
- [meta-security](https://git.yoctoproject.org/meta-security) new_textSecurity recipes
- [OWASP Embedded Security](https://owasp.org/www-project-embedded-application-security/) new_textSecurity guidelines
- [Secure Boot with U-Boot](https://docs.u-boot.org/en/latest/usage/verified-boot.html) new_textVerified boot chain
- [dm-verity](https://docs.kernel.org/admin-guide/device-mapper/verity.html) new_textRead-only filesystem verification
- [OP-TEE](https://www.op-tee.org/) new_textTrusted Execution Environment

## Community & News

- [LWN.net](https://lwn.net/) new_textLinux Weekly News
- [Embedded Linux Wiki](https://elinux.org/) new_textCommunity wiki
- [Linux Foundation Events](https://events.linuxfoundation.org/) new_textConferences
- [Embedded.fm Podcast](https://embedded.fm/) new_textEmbedded systems podcast
- [/r/embedded](https://www.reddit.com/r/embedded/) new_textReddit community

## Conferences

- [Embedded Linux Conference (ELC)](https://events.linuxfoundation.org/) new_textPremier embedded Linux event
- [Linaro Connect](https://connect.linaro.org/) new_textArm ecosystem conference
- [FOSDEM - Embedded Track](https://fosdem.org/) new_textFree open source conference
- [Embedded World](https://www.embedded-world.de/) new_textIndustry trade show
- [Linux Plumbers Conference](https://lpc.events/) new_textKernel/plumbing focused
