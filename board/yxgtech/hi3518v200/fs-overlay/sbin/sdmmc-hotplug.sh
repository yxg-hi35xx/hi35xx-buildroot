#!/bin/sh

[ -n "$ACTION" -a -n "$MDEV" ] || exit 1

case ${ACTION} in
  add)
    (
      mount | grep -q "^/dev/$MDEV" && exit 0
      usleep 100000
      mount | grep -q "^/dev/$MDEV" && exit 0
      [ -b "/dev/$MDEV" ] || exit 1
      mnt=/run/media/$MDEV
      [ -d "$mnt" ] || mkdir -p "$mnt"
      fstype=$(blkid "/dev/${MDEV}" | sed -nr 's/.*TYPE=\"([^\"]*)\".*/\1/p')
      mount -t "$fstype" "/dev/${MDEV}" "${mnt}" || exit 1
    ) &
    ;;
  remove)
    (
      mnt=$(mount | awk "(\$1 ~ /\/dev\/$MDEV/) { print \$3 }")
      [ -n "$mnt" ] && umount "$mnt" && rm -r "$mnt"
    ) &
    ;;
esac
