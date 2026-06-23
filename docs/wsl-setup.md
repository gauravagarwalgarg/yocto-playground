# WSL2 Setup Guide Tested & Working

> Build and boot embedded Linux on WSL2 Ubuntu 22.04. Verified June 2026.

---

## Proven Workflow

```
01-install-deps.sh → 02-repo-sync.sh → source auton-init-build-env → bitbake → runqemu
```

---

## Step 1: Install Dependencies

```bash
cd ~/Projects/GauravAgarwalGarg/MyYoctoPlayground
./scripts/01-install-deps.sh
source ~/.bashrc
```

## Step 2: Sync Sources

```bash
./scripts/02-repo-sync.sh
```

Creates `~/yocto-auton/` with all layers (poky, meta-oe, meta-ti, meta-raspberrypi, meta-auton).

## Step 3: Setup Environment

```bash
cd ~/yocto-auton
sed -i 's/\r$//' sources/meta-auton-repo/auton-init-build-env
source sources/meta-auton-repo/auton-init-build-env qemux86-64
```

Machine options: `qemux86-64`, `qemu-arm64`, `beaglebone-black`, `raspberrypi5`

## Step 4: Build

```bash
bitbake core-image-minimal
```

First build: ~1.5 hours. Subsequent: ~5 minutes (sstate cached).

## Step 5: Run in QEMU

```bash
runqemu qemux86-64 nographic slirp wic
```

Login: `root` (no password). Exit: `Ctrl+A` then `X`.

---

## Key Design Decisions (Lessons Learned)

### One machine at a time (NO multiconfig)

Multiconfig requires ALL BSP layers and their dependencies to be fully resolved at parse time. This means:
- `meta-ti` needs `meta-arm`
- `meta-raspberrypi` needs specific kernel configs
- Custom machine configs get parsed even if you're building QEMU

**Solution**: The env script generates `local.conf` and `bblayers.conf` for ONE machine only. Switch machines by re-sourcing with a different argument.

### Stock QEMU uses `poky` distro, not `auton`

The `auton` distro forces `PREFERRED_PROVIDER_virtual/kernel = "linux-auton"` which is only compatible with our custom machines. Stock QEMU machines (`qemux86-64`) need `linux-yocto`.

**Solution**: The env script auto-selects:
- `qemux86-64` → `DISTRO=poky` + `linux-yocto` (guaranteed to work)
- `qemu-arm64` → `DISTRO=auton` + `linux-yocto` (custom distro, stock kernel)
- `beaglebone-black` / `raspberrypi5` → `DISTRO=auton` + `linux-yocto` (for now)

### IMAGE_FSTYPES must include ext4 for runqemu

`runqemu` expects `.ext4` rootfs by default. Our distro was only producing `.wic`. Fixed: `IMAGE_FSTYPES += "ext4"` in generated local.conf.

### CRLF line endings break everything

Files created from Windows/Kiro get `\r\n`. Bash scripts fail with `$'in\r'` errors. Fixed with:
- `.gitattributes` enforcing LF
- `sed -i 's/\r$//'` after each sync until git propagates

### BSP layers only for selected machine

`bblayers.conf` only includes BSP layers relevant to the current machine:
- `qemux86-64` / `qemu-arm64`: no BSP layers needed
- `beaglebone-black`: adds `meta-arm` + `meta-ti`
- `raspberrypi5`: adds `meta-raspberrypi`

---

## Switching Machines

```bash
# Delete current build config
rm -rf ~/yocto-auton/build/conf

# Re-source with different machine
cd ~/yocto-auton
source sources/meta-auton-repo/auton-init-build-env raspberrypi5

# Build
bitbake core-image-minimal
```

---

## What CAN'T Be Scripted

| Item | Why | Manual Step |
|------|-----|-------------|
| WSL2 memory config | Windows file | Edit `%USERPROFILE%\.wslconfig` |
| WSL2 disk expansion | PowerShell admin | `wsl --shutdown` + diskpart |
| CRLF fix after sync | Git attr propagation | `sed -i 's/\r$//' sources/meta-auton-repo/auton-init-build-env` |
| SD card device path | Hardware-dependent | `lsblk` to find `/dev/sdX` |
| USB serial console | WSL limitation | Use usbipd-win or PuTTY on Windows |

---

## Troubleshooting

| Problem | Solution |
|---------|----------|
| `repo: command not found` | `source ~/.bashrc` |
| `bitbake: command not found` | Re-source the env script |
| `Nothing PROVIDES virtual/kernel` | Check MACHINE and DISTRO match in local.conf |
| `meta-ti requires meta-arm` | Only include meta-ti for beaglebone-black builds |
| `ti-soc.inc not found` | meta-ti in bblayers but building QEMU remove it |
| `runqemu ERROR - Failed to find rootfs` | Add `IMAGE_FSTYPES += "ext4"` or use `wic` flag |
| `$'in\r'` syntax error | CRLF: `sed -i 's/\r$//' <file>` |
| Build takes 3+ hours | Check `.wslconfig` memory/CPU allocation |
| `No space left` | Clean: `bitbake -c cleansstate core-image-minimal` |

---

## Next Steps (After QEMU Works)

1. **Raspberry Pi 5**: Re-source with `raspberrypi5`, build, flash to SD
2. **BeagleBone Black**: Re-source with `beaglebone-black`, build, flash
3. **Custom kernel**: Fix `linux-auton` recipe sha256, test on QEMU ARM64
4. **Custom distro**: Add packages to `auton-image-minimal.bb`
5. **CI**: Add GitHub Actions workflow for automated QEMU builds
