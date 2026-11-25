FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:${THISDIR}/${PN}/${MACHINE}:${THISDIR}/${PN}/common:"

include recipes-kernel/linux/linux-ti-staging/${MACHINE}.inc
