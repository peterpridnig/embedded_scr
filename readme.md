# pridnig, 22.8.2023


# #######################
# ## toolchain "master" -> remotes/origin.1.25
# ######################

https://crosstool-ng.github.io
git clone https://github.com/crosstool-ng/crosstool-ng.git
cd crosstool-ng
git branch

*master
./bootstrap
./configure –prefix=${PWD}
make
make install


bin/ct-ng
bin/ct-ng list-samples
bin/ct-ng show-arm-cortex_a8-linux-gnueabi
bin/ct-ng distclean

bin/ct-ng arm-cortex_a8-linux-gnueabi
bin/ct-ng menuconfig
 Paths and misc options: disable Render the toolchain read-only
 Target options / Floating point: hardware (FPU)
 Target optinos: Use specific FPU=neon

bin/ct-ng build

=>  ~/x-tools/arm-cortex_a8-linux-gnueabhif

arm-cortex_a8-linux-gnueabhif-gcc --version
arm-cortex_a8-linux-gnueabhif-gcc -print-sysroot

 

 
# ################
# ## u-boot "2023.07.02"
# ################

git clone git://git.denx.de/u-boot.git
cd u-boot
git branch
master *

git checkout v2023.07.02
git checkout -b v2023.07.02.myuboot

make am335x_evm_defconfig
make menuconfig
make
=> MLO u-boot.img

u-boot/include/environment/ti/mmc.h


sh $MELP/format-sdcard.sh
cp MLO u-boot.img /media/peter/boot



gtkterm -p /dev/ttyUSB0 -s 115200 &


env default -f -a
print bootcmd
setenv botcmd cmd1\;cmd2
saveenv
reset

U-Boot 2023.07.02-00001-g17c4ea4e9b (Aug 26 2023 - 15:57:19 +0200)


# ################
# ## kernel linux 5.15.126
# ################

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



# ##################
# ## rootfs
# ##################

sudo chown -R root:root *
mkdir /dev/pts
mount -t devpts devpts /dev/pts

# ---------------------
# --  busybox "1_36_stable"
# ---------------------
https://busybox.net/tinyutils.html


# ---------------------
# --  dropbear "2022_83"
# ---------------------

https://matt.ucc.asn.au/dropbear/
wget https://matt.ucc.asn.au/dropbear/releases/

tar xjf 

new terminal, fresh "CC"
cd dropbear

localoptions.h:
 #if !HAVE_CRYPT
 #define DROPBEAR_SVR_PASSWORD_AUTH 0
 #endif
 
./configure --help
source set_env.sh
./configure --enable-static --disable-zlib --prefix=/home/peter/mastering_beaglebone/userland/dropbear_staging --host=arm-cortex_a8-linux-gnueabihf
make
make install


https://gist.github.com/mad4j/7983719

Manual installation
1. copy dropbearmultin in /usr/sbin
2. create dropbearmulti aliases (call ./dropbearmulti)

  Dropbear multi-purpose version 0.51
  Make a symlink pointing at this binary with one of the following names:
  'dropbear' - the Dropbear server
  'dbclient' or 'ssh' - the Dropbear client
  'dropbearkey' - the key generator
  'dropbearconvert' - the key converter
  'scp' - secure copy

Note: scp mayby needed to be created in /usr/bin

  ln -s /usr/sbin/dropbearmulti /usr/bin/scp

3. create rsa keys in /etc/dropbear (e.g. /etc/dropbear/dropbear_rsa_host_key)

  mkdir -p /etc/dropbear
  dropbearkey -t rsa -f /etc/dropbear/dropbear_rsa_host_key
  dropbearkey -t dss -f /etc/dropbear/dropbear_dss_host_key
  dropbearkey -t ecdsa -f /etc/dropbear/dropbear_ecdsa_host_key
  dropbearkey -t ed25519 -f /etc/dropbear/dropbear_ed25519_host_key

if needed create /dev/random device
1. mknod -m 644 /dev/random c 1 8
2. mknod -m 644 /dev/urandom c 1 9
3. chown root:root /dev/random /dev/urandom

Running dropbear server in foreground (on default port)
./dropbear

Note: use -E option to log on sdterr

/etc/init.d/rcS
dropbear -R -E -b dropbear -R -b /etc/dropbear/dropbear.banner

client
ssh-keygen -f ~/id_rsa -t rsa
ssh-copy-id -f -i ~/.ssh/id_rsa.pub peter@10.0.0.117
https://wiki.termux.com/wiki/Remote_Access

server:
~/.ssh # more authorized_keys 
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDFdNJP5jvQz83BHerNXup6ReYeIGoQnKyaYGdxfcnw6EYOhNUky+y0jZzkXgHQBbYKld2JgexmE8blGjaMz09bFi/Jao/lj/MjwTnkYSmhJQHUqf1HwM8AgFPRtlcTcwzfQghL36Ksww//6KhSugRt0vSMF4hvwPSH+iZHpNIjzZPBSqPzzxKBy/yTyl9fi3hqwG7SXN0tKEHyUz82m0nxzj64/gAyX1fv59eJq0KgUsZN3b0i8VnwUyfaRrQWEJkw567cWtp0B0HXPEnFimOpKTW9Rmp4yC7+FMjQEhWf+zWhrB2+JHtzW8pGgkgl9iwwN2KmcvbR1WGDtOfUOumf peter@elvwatt


ssh 10.0.0.117 -l peter


pkill dropbear

# ---------------------
# -- ramdisk
# ---------------------

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


# ---------------------
# -- rootfs mount from sdcard
# ---------------------

device-table.txt
/dev d 755 0 0 - - - - -
/dev/null c 666  0 1 3 0 0 -
/dev/console c 600 0 0 5 1 0 0 -
/dev/ttyO0 c 600 0 0 252 0 0 0 -

genext2fs -b 4096 -d rootfs_staging -D device-table.txt -U rootfs.ext2
e2fsck rootfs.ext2
sudo dd if=rootfs.ext2 of=/dev/sdh2

fatload mmc 0:1 0x80200000 zImage
fatload mmc 0:1 0x80f00000 am335x-boneblack.dtb
setenv bootargs console=ttyO0,115200 debug earlycon root=/dev/mmcblk0p2 rw rootfstype=ext2 rootwait
bootz 0x80200000 - 0x80f00000



/dev/mmcblk0p1
-rwxr-xr-x  1 root root   67127 Aug 12 15:25 am335x-boneblack.dtb
-rwxr-xr-x  1 root root  110680 Aug 13 19:36 MLO
-rwxr-xr-x  1 root root 1449348 Aug 13 19:36 u-boot.img
-rwxr-xr-x  1 root root     227 Aug 17 19:01 uEnv.txt
-rwxr-xr-x  1 root root 1362701 Aug 17 19:40 uRamdisk
-rwxr-xr-x  1 root root 9990656 Aug 12 15:24 zImage


# ---------------------
# -- fstab
# ---------------------

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


# ---------------------
# -- rootfs mount via NFS
# ---------------------

/etc/exports
 /home/peter/mastering_beaglebone/userland/rootfs_nfs *(rw,sync,no_subtree_check,no_root_squash)


https://linuxways.net/mint/how-to-configure-nfs-server-and-client-on-linux-mint-20/

dpkg -l | grep nfs-kernel-server
sudo exportfs -av
sudo systemctl restart nfs-kernel-server
sudo systemctl status nfs-kernel-server

sudo ufw status

sudo chown -R 0:0 *

setenv serverip 10.0.0.18
setenv ipaddr 10.0.0.117
setenv npath /home/peter/mastering_beaglebone/userland/rootfs_nfs
setenv bootargs console=ttyO0,115200 debug earlycon root=/dev/nfs rw nfsroot=${serverip}:${npath},tcp,vers=3 ip=${ipaddr}
fatload mmc 0:1 0x80200000 zImage
fatload mmc 0:1 0x80f00000 am335x-boneblack.dtb
bootz 0x80200000 - 0x80f00000

setenv bootcmd fatload mmc 0:1 0x80200000 zImage\;fatload mmc 0:1 0x80f00000 am335x-boneblack.dtb\;bootz 0x80200000 - 0x80f00000


# ---------------------
# -- tftp to load the kernel
# ---------------------

sudo apt install tftpd-hpa

more /etc/default/tftpd-hpa 
 TFTP_USERNAME="tftp"
 TFTP_DIRECTORY="/var/lib/tftpboot"
 TFTP_ADDRESS=":69"
 TFTP_OPTIONS="--secure"

/var/lib/tftpboot
cp arch/arm/boot/zImage /var/lib/tftpboot
cp arch/arm/boot/dts/am335x-boneblack.dtb /var/lib/tftpboot

/etc/init.d/tftpd-hpa restart

setenv serverip 10.0.0.18
setenv ipaddr 10.0.0.117
setenv npath /home/peter/mastering_beaglebone/userland/rootfs_nfs
setenv bootargs console=ttyO0,115200 debug earlycon root=/dev/nfs rw nfsroot=${serverip}:${npath},tcp,vers=3 ip=${ipaddr}

setenv bootcmd tftpboot 0x80200000 zImage\;tftpboot 0x80f00000 am335x-boneblack.dtb\;bootz 0x80200000 - 0x80f00000


# ################
# ## buildroot "2023.02.3"
# ################

https://buildroot.org/download.html

git clone git://git.buildroot.net/buildroot
git checkout -b 2023.02.3.mybuildroot

make list-defconfigs


