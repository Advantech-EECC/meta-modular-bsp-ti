LCONFIGS = " \
    can.cfg \
    eeprom.cfg \
    gpio_wdt.cfg \
    nvme.cfg \
    rtc.cfg \
    tpm.cfg \
    uarts.cfg \
"

SRC_URI:append = " \
    file://${MACHINE}.dts \
    ${@' '.join(['file://%s' % x for x in d.getVar('LCONFIGS').split()])} \
"

KERNEL_CONFIG_FRAGMENTS:append = " \
    ${@' '.join(['${WORKDIR}/%s' % x for x in d.getVar('LCONFIGS').split()])} \
"

do_configure:prepend() {
    cp "${WORKDIR}/${MACHINE}.dts" "${S}/arch/arm64/boot/dts/ti/"
}
