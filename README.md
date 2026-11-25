Advantech BSP for Texas Instruments based boards
================================================

This layer adds minimal changes on top of Texas Instruments Linux BSP to support Advantech boards, with the purpose of leveraging that for easier long term maintenance.

Real Time support (`PREEMPT_RT`) is enabled by exporting `ENABLE_RT=1` through `BB_ENV_PASSTHROUGH_ADDITIONS`.

This BSP is based on:
- https://github.com/saurontech/meta-ecu-1270

Supported Boards
================

Preliminary support:

 * ECU-1270-531A (2GB) (`ecu1270-2g`, TI AM6734 (J722S subset w/o GPU))


Simple build example
====================

```
WORKSPACE=$PWD
WTI=$WORKSPACE/ti
mkdir -p "$WTI"
CIMAGE=ghcr.io/texasinstruments/ubuntu-distro:latest
CIMAGE=crops/yocto:ubuntu-24.04-base
CARGS=(-v /etc/passwd:/etc/passwd:ro -v /etc/group:/etc/group:ro \
	-v "$HOME:$HOME" -e HOME="$HOME" -v "$WORKSPACE:$WORKSPACE" \
	-w "$WTI" --user "$(id -u):$(id -g)" \
)
docker run --rm -it ${CARGS[@]} "$CIMAGE" bash

MBSP=meta-modular-bsp-ti
git clone git@ssh.dev.azure.com:v3/AdvEECC/EECC_Internal/preprod-$MBSP $MBSP
cd "$MBSP"
git checkout scarthgap
cd ..
git clone https://git.ti.com/git/arago-project/oe-layersetup.git ti-yocto
cd ti-yocto
./oe-layertool-setup.sh -f configs/processor-sdk-linux/processor-sdk-linux-11_01_02_01.txt
cd build
source ./conf/setenv
bitbake-layers add-layer "../../$MBSP"
export MACHINE=ecu1270-2g
bitbake core-image-minimal
```

For Real Time Linux (`PREEMPT_RT`), propagate `ENABLE_RT=1` before calling BitBake:

```
export ENABLE_RT=1
export BB_ENV_PASSTHROUGH_ADDITIONS="${BB_ENV_PASSTHROUGH_ADDITIONS} ENABLE_RT"
bitbake core-image-minimal
```

Supported Linux Features
========

ECU-1270-531A (2GB) (`ecu1270-2g`)
--------

| Device   | Status | Comment |
|----------|--------|---------|
| SDHC0  |  ✅ | eMMC |
| SDHC1 |  ✅  | SD Card |
| ETH0 |  ✅  | 1 Gbps |
| ETH1 |  ✅  | 1 Gbps |
| USB  | ❌ | Pending (USB 3.0 5 Gbps) |
| UART0 | ✅ | Linux console via USB-C (/dev/ttyS2 - 0x2800000) |
| UART1 | ⚠️  | Not tested (/dev/ttyS3 - 0x2810000 |
| UART2 | ⚠️  | Not tested (/dev/ttyS4 - 0x2820000 |
| UART3 | ⚠️  | Not tested (/dev/ttyS5 - 0x2830000 |
| UART4 | ⚠️  | Not tested (/dev/ttyS6 - 0x2840000 |
| UART5 | ⚠️  | Not tested (/dev/ttyS7 - 0x2850000 |
| UART6 | ⚠️  | Not tested (/dev/ttyS8 - 0x2860000 |
| I2C1 | ✅ |  |
| I2C3 | ✅ |  |
| I2C4 | ❌ | Not yet supported (requires >= f1c5ba960ddddda26880304ba08db11e56d07002) |
| PCIE | ✅ | TI PCIE bridge |
| M.2 | ✅⚠️  | PCIE working (tested with M.2. Key E to NVME adapter; USB/UART not tested) |
| MPCIE | ⚠️  | Partially tested, device enumeration with Advantech EMW-W172H01E RTL8821BU worked (USB 2.0 signaling) |
| CAN | ⚠️  | Not tested (add-on module)  |
| RTC | ✅ | I2C RTC |
| TPM | ❌ | Pending (I2C TPM) |
| Watchdog | ✅ | GPIO-based watchdog |
