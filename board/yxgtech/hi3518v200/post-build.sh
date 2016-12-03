#!/bin/sh

BOARD_DIR="$(dirname $0)"

# update build time to /etc/version
sed -e '/build=.*/d' ${BOARD_DIR}/fs-overlay/etc/version > \
	${TARGET_DIR}/etc/version
date "+build=%Y%m%d%H%M" >> ${TARGET_DIR}/etc/version
