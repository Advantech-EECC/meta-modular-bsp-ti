FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:${THISDIR}/${PN}/${MACHINE}:${THISDIR}/${PN}/common:"
FILESEXTRAPATHS:prepend:ecu1270-2g-k3r5 := "${THISDIR}/${PN}/ecu1270-2g:"

include recipes-bsp/u-boot/u-boot-ti-staging/${MACHINE}.inc
