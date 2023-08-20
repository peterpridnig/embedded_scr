#!/bin/sh

cd ../rootfs_staging
find . | cpio -H newc -ov --owner root:root > ../initramfs.cpio
cd ..
gzip initramfs.cpio

mkimage -A arm -O linux -T ramdisk -d initramfs.cpio.gz uRamdisk
