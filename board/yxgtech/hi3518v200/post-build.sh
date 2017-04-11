#!/bin/sh

BOARD_DIR="$(dirname $0)"
MKIMAGE=$HOST_DIR/usr/bin/mkimage

# update build time to /etc/version
version=`sed -nr 's/^version=(.*)$/\1/p' \
	${BOARD_DIR}/fs-overlay/etc/version`
echo "version=${version}" > ${TARGET_DIR}/etc/version
localver=`support/scripts/setlocalversion`
echo "localver=${localver#-}" >> ${TARGET_DIR}/etc/version
build=`date "+%Y%m%d%H%M%S"`
echo "build=${build}" >> ${TARGET_DIR}/etc/version

# Generate firmware update script for U-Boot
$MKIMAGE -C none -A arm -T script -d ${BOARD_DIR}/update.txt \
	${BINARIES_DIR}/update.scr
