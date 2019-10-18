#!/bin/busybox ash
/bin/busybox --install -s
touch /etc/mtab
mount -t devtmpfs - /dev
mount -t proc - /proc
mount -t sysfs - /sys
mount -t tmpfs - /run
#ifconfig eth0 10.0.0.116 up
#rdate 10.0.0.1
#/bin/ash
#mount.nfs -o nolock 10.0.0.1:/local/scratch-legacy/debian-ariane /mnt
#echo Executing switch_root for NFS
#exec switch_root /mnt /sbin/init
#
#aoe-discover
#fsck.ext4 /dev/etherd/e0.1 || (echo fsck.ext4 /dev/etherd/e0.1 failed, dropping to ash; /bin/ash)
#mount -t ext4 /dev/etherd/e0.1 /mnt || (echo mount -t ext4 /dev/etherd/e0.1 /mnt failed, dropping to ash; /bin/ash)
#echo Executing switch_root for aoe
#exec switch_root /mnt /sbin/init
#
#nbd-client 10.0.0.1
#mount -t ext4 /dev/nbd0 /mnt || (echo mount -t ext4 /dev/rda2 /mnt failed, dropping to ash; /bin/ash)
#echo Executing switch_root for nbd
#exec switch_root /mnt /sbin/init

fsck.ext4 -p -f -v /dev/rda2 || (echo fsck.ext4 /dev/rda2 failed, dropping to ash; /bin/ash)
echo Mounting SD root
mount -t ext4 /dev/rda2 /mnt || (echo mount -t ext4 /dev/rda2 /mnt failed, dropping to ash; /bin/ash)
mkdir -p /mnt/proc /mnt/sys /mnt/dev /mnt/run
echo Executing switch_root for mmc
exec switch_root /mnt /sbin/init
