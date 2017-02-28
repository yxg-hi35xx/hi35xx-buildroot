#!/bin/sh

VERSION="$(sed -nre "s/version=(.*)/\1/p" ${TARGET_DIR}/etc/version)"
LOCALVER="$(sed -nre "s/localver=(.*)/\1/p" ${TARGET_DIR}/etc/version)"
BUILD="$(sed -nre "s/build=(.*)/\1/p" ${TARGET_DIR}/etc/version)"
OUTFILE="ipcam-${VERSION}-${LOCALVER}-${BUILD::8}.fw.bin"
IMAGEDIR=$1
shift

declare -A items

(
  cd ${IMAGEDIR} 2>/dev/null || exit 1

  echo "# BUILD=$(sed -nre 's/build=(.*)/\1/p' ${TARGET_DIR}/etc/version)" > .manifest
  echo "# partition:filename:checksum" >> .manifest
  while [ $# -ge 2 ]; do
    items[$1]=$2
    part=$1
    file=$2
    [ -f $file ] || { echo "file $file not found"; exit 1; }
    csum=$(sha1sum $file | cut -d' ' -f1)
    echo "$part:$file:$csum" >> .manifest
    shift; shift
  done

  tar -cf "$OUTFILE" .manifest ${items[@]} 2>/dev/null

  rm -f .manifest
)

printf "Firmware ${IMAGEDIR}/${OUTFILE} generated.\n"

