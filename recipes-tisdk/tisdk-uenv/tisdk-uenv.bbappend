FILESEXTRAPATHS:prepend := "${THISDIR}/files/${MACHINE}:"

SRC_URI:append:ecu1770-2g = "\
    file://uEnv.txt \
"
