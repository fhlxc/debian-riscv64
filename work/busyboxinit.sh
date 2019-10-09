#!/bin/busybox ash
/bin/busybox --install -s
touch /etc/mtab
fsck.ext4 -p -f -v /dev/rda2
echo Mounting SD root
mount -t ext4 /dev/rda2 /mnt || (echo mount -t ext4 /dev/rda2 /mnt failed, dropping to ash; /bin/ash)
mkdir -p /mnt/proc
mount -t proc none /mnt/proc
mkdir -p /mnt/sys
mount -t sysfs none /mnt/sys
mkdir -p /mnt/dev
mount -t devtmpfs udev /mnt/dev
mkdir -p /mnt/run
mount -t tmpfs tmpfs /mnt/run
echo Executing switch_root for mmc
exec switch_root /mnt /sbin/init
