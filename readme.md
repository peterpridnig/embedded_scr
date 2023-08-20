
#toolchain

https://crosstool-ng.github.io
git clone https://github.com/crosstool-ng/crosstool-ng.git
cd crosstool-ng
git branch

*master

./bootstratp

./configure –prefix=${PWD}

make

make install

 

bin/ct-ng

bin/ct-ng list-samples

bin/ct-ng show-arm-cortex_a8-linux-gnueabi

 

bin/ct-ng arm-cortex_a8-linux-gnueabi

bin/ct-ng menuconfig

 

Paths and misc options: disable Render the toolchain read-only

Target options / Floating point: hardware (FPU)

Target optinos: Use specific FPU=neon

 

bin/ct-ng build

 

 ~/x-tools/arm-cortex_a8-linux-gnueabhif

 

arm-cortex_a8-linux-gnueabhif-gcc --version

arm-cortex_a8-linux-gnueabhif-gcc -print-sysroot

 

 

# u-boot

git clone git://git.denx.de/u-boot.git
cd u-boot
git branch
master *

make am335x_evm_defconfig
make
=> MLO u-boot.img

u-boot/include/environment/ti/mmc.h


sh $MELP/format-sdcard.sh
cp MLO u-boot.img /media/peter/boot

 

gtkterm -p /dev/ttyUSB0 -s 115200





# kernel linux 5.15.126
make ARCH=arm CROSS_Compile=arm-unknown-linux-gnueabi- mrproper
make ARCH=arm multi_v7_defconfig
make menuconfig
cp .config ...
make -j4 ARCH=arm CROSS_COMPILE=arm-cortex_a8-linux-gnueabihf- zImage
make -j4 ARCH=arm CROSS_COMPILE=arm-cortex_a8-linux-gnueabihf- modules
make -j4 ARCH=arm CROSS_COMPILE=arm-cortex_a8-linux-gnueabihf- dtbs

=>
arch/arm/boot/zImage
arch/arm/boot/dts/am335x-boneblack.dtb

=> zImage am335x-boneblack.dtb


# rootfs

sudo chown -R root:root *

## busybox

no ssh client: dropbear

## ramdisk

gen_ramdisk.sh
=> uRamdisk

fatload mmc 0:1 0x80200000 zImage
fatload mmc 0:1 0x80f00000 am335x-boneblack.dtb
fatload mmc 0:1 0x81000000 uRamdisk
setenv bootargs console=ttyO0,115200 debug earlycon rdinit=/sbin/init
bootz 0x80200000 0x81000000 0x80f00000


/etc/init.d/rcS:
ifup -a

ifconfig

ifconfig lo
ifconfig eth0 10.0.0.117

## rootfs

device-table.txt
/dev d 755 0 0 - - - - -
/dev/null c 666  0 1 3 0 0 -
/dev/console c 600 0 0 5 1 0 0 -
/dev/ttyO0 c 600 0 0 252 0 0 0 -

genext2fs -b 4096 -d rootfs_staging -D device-table.txt -U rootfs.ext2
sudo dd if=rootfs.ext2 of=/dev/sdh2

fatload mmc 0:1 0x80200000 zImage
fatload mmc 0:1 0x80f00000 am335x-boneblack.dtb
setenv bootargs console=ttyO0,115200 debug earlycon root=/dev/mmcblk0p2
                                                    root=/dev/mmcblk0p2 rw rootfstype=ext2 rootwait
						    root=/dev/mmcblk1p1 ro 
bootz 0x80200000 - 0x80f00000


/dev/mmcblk0p1
-rwxr-xr-x  1 root root   67127 Aug 12 15:25 am335x-boneblack.dtb
-rwxr-xr-x  1 root root  110680 Aug 13 19:36 MLO
-rwxr-xr-x  1 root root 1449348 Aug 13 19:36 u-boot.img
-rwxr-xr-x  1 root root     227 Aug 17 19:01 uEnv.txt
-rwxr-xr-x  1 root root 1362701 Aug 17 19:40 uRamdisk
-rwxr-xr-x  1 root root 9990656 Aug 12 15:24 zImage


/dev/sdb1 on /media/peter/11WATT_0.5T type fuseblk (rw,nosuid,nodev,relatime,user_id=0,group_id=0,default_permissions,allow_other,blksize=4096,uhelper=udisks2)
/dev/sdc2 on /media/peter/STORAGE_Volume_11WATT type fuseblk (rw,nosuid,nodev,relatime,user_id=0,group_id=0,default_permissions,allow_other,blksize=4096,uhelper=udisks2)
/dev/sda4 on /media/peter/11WATT_SSD0.5T type fuseblk (rw,nosuid,nodev,relatime,user_id=0,group_id=0,default_permissions,allow_other,blksize=4096,uhelper=udisks2)

/dev/sdb1: LABEL="11WATT_0.5T" UUID="662872F92872C817" TYPE="ntfs" PARTUUID="0512b30a-01"
/dev/sdc2: LABEL="STORAGE_Volume_11WATT" UUID="96604E02604DE997" TYPE="ntfs" PARTLABEL="Basic data partition" PARTUUID="5bd3007e-e68d-4eb0-a795-1fa2bcdc0a20"
/dev/sda4: LABEL="11WATT_SSD0.5T" UUID="D2CA0BF4CA0BD39F" TYPE="ntfs" PARTLABEL="Basic data partition" PARTUUID="89a179fc-ca6b-468b-a2e9-63a04f4a2b57"

/dev/sdb1: /mnt/backup_0.5t  UUID=662872F92872C817 ntfs
/dev/sdc2: /mnt/storage_1.0t" UUID=96604E02604DE997 "ntfs
/dev/sda4: /mnt/win_ssd0.5t" UUID=D2CA0BF4CA0BD39F ntfs

/etc/fstab
UUID=662872F92872C817 /mnt/backup_0.5t ntfs
UUID=96604E02604DE997 /mnt/storage_1.0t ntfs
UUID=D2CA0BF4CA0BD39F /mnt/win_ssd0.5t ntfs