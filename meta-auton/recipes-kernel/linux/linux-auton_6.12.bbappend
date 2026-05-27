# Machine-specific kernel configuration fragments
#
# Add defconfig fragments per machine here.
# Example: SRC_URI:append:beaglebone-black = " file://bbb.cfg"

FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

# BeagleBone Black specifics
SRC_URI:append:beaglebone-black = " \
    file://bbb.cfg \
"

# Raspberry Pi 5 specifics
SRC_URI:append:raspberrypi5 = " \
    file://rpi5.cfg \
"
