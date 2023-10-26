# pridnig, 26.10.2023

# ---------------------
# -- Serial2USB
# ---------------------

lsusb
Bus 001 Device 015: ID 0403:6001 Future Technology Devices International, Ltd FT232 USB-Serial (UART) IC
Bus 001 Device 016: ID 0403:6001 Future Technology Devices International, Ltd FT232 USB-Serial (UART) IC
2
peter@elvwatt:~$ ls -al /dev/serial/by-id/
Debug console:
lrwxrwxrwx 1 root root  13 Oct 26 10:47 usb-FTDI_FT232R_USB_UART_A50285BI-if00-port0 -> ../../ttyUSB1
Serial I/O
lrwxrwxrwx 1 root root  13 Oct 26 10:48 usb-FTDI_FT232R_USB_UART_A50285BI-if00-port0 -> ../../ttyUSB0

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
# -- GIT
# ---------------------

git log -n 3

$ git commit -m 'initial commit'
$ git add forgotten_file
$ git commit --amend

You end up with a single commit – the second commit replaces the results of the first.

Undo last commit
git checkout -- CONTRIBUTING.md
git status


git remote -v
git remote add scr https://github.com/peterpridnig/scr

git fetch scr
git push scr

git push origin master
(origin=remote, master=branch)

git remote show origin


github fine grained token
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

github personal access token
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

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
master
* v2023.07.02.myuboot

git checkout v2023.07.02
git checkout -b v2023.07.02.myuboot


# ---------------------
# -- EVM board
# ---------------------

./board/ti/am335x
./configs/am335x_evm_defconfig

make am335x_evm_defconfig
make menuconfig
.config.20230831


# ---------------------
# --  NOVA board
# ---------------------

p. 168
git status
On branch v2023.07.02.myuboot
Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git checkout -- <file>..." to discard changes in working directory)

	modified:   arch/arm/Kconfig
	modified:   arch/arm/mach-omap2/am33xx/Kconfig

Untracked files:
  (use "git add <file>..." to include in what will be committed)

	board/ti/nova/
    board.c board.h MAINTAINERS Makefile mux.c u-boot.lds
    FIX:
    board/ti/nova/Kconfig if TARGET_NOVA

	configs/nova_defconfig
	include/configs/nova.h

make distclean
make nova_defconfig

???CONFIG_TIMESTAMP redefined???


make
=> MLO u-boot.img

sh $MELP/format-sdcard.sh
lsblk
umount /dev/sdh1

cp MLO u-boot.img /media/peter/boot

=>
U-Boot 2023.07.02-00002-gab674ffb7e-dirty (Sep 24 2023 - 17:35:51 +0200)
[...]
Hit any key to stop autoboot:  0 
nova!>    


# ---------------------
# -- u-boot commandline
# ---------------------

gtkterm -p /dev/ttyUSB0 -s 115200 &

env default -f -a
print bootcmd
setenv botcmd cmd1\;cmd2
saveenv
reset

U-Boot 2023.07.02-00001-g17c4ea4e9b (Aug 26 2023 - 15:57:19 +0200)

print bootcmd

boot 
=> boot default (bootcmd)


# ################
# ## kernel linux 5.15.133
# ################

https://www.kernel.org/
https://en.wikipedia.org/wiki/Linux_kernel_version_history

./linux-stable

wget ...?
tar xf ...?

git branch
* linux-5.15.y.peter
  master

make ARCH=arm CROSS_COMPILE=arm-cortex_a8-linux-gnueabihf- mrproper
make ARCH=arm multi_v7_defconfig
make menuconfig

.config.20230831 includes /sys/class/gpio

make -j4 ARCH=arm CROSS_COMPILE=arm-cortex_a8-linux-gnueabihf- zImage
make -j4 ARCH=arm CROSS_COMPILE=arm-cortex_a8-linux-gnueabihf- modules
make -j4 ARCH=arm CROSS_COMPILE=arm-cortex_a8-linux-gnueabihf- dtbs
(make ARCH=arm am335x-boneblack.dtb)

=>
arch/arm/boot/zImage
arch/arm/boot/dts/am335x-boneblack.dtb

cp arch/arm/boot/dts/am335x-boneblack.dts arch/arm/boot/dts/nova.dts
make ARCH=arm nova.dtb
=> arch/arm/boot/dts/nova.dtb

# ---------------------
# -- tftp to load the Kernel & DeviceTree
# -- nfs to load rootfs
# ---------------------

SERVER TFTP:
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

U-BOOT:
setenv serverip 10.0.0.18
setenv ipaddr 10.0.0.117
setenv npath /home/peter/mastering_beaglebone/userland/rootfs_nfs
setenv bootargs console=ttyO0,115200 debug earlycon root=/dev/nfs rw nfsroot=${serverip}:${npath},tcp,vers=3 ip=${ipaddr}

setenv bootcmd tftpboot 0x80200000 zImage\;tftpboot 0x80f00000 am335x-boneblack.dtb\;bootz 0x80200000 - 0x80f00000

setenv bootcmd tftpboot 0x80200000 zImage\;tftpboot 0x80f00000 nova.dtb\;bootz 0x80200000 - 0x80f00000



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

poweroff
reboot

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

Note: use -E option to log on stderr

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
# -- Kernel & DeviceTree via TFTP
# -- rootfs mount via NFS 
# ---------------------

SERVER NFS:

/etc/exports
 /home/peter/mastering_beaglebone/userland/rootfs_nfs *(rw,sync,no_subtree_check,no_root_squash)

https://linuxways.net/mint/how-to-configure-nfs-server-and-client-on-linux-mint-20/

dpkg -l | grep nfs-kernel-server
sudo exportfs -av
sudo systemctl restart nfs-kernel-server
sudo systemctl status nfs-kernel-server

sudo ufw status

fix rights in local target folder:
sudo chown -R 0:0 *

U-BOOT:

setenv serverip 10.0.0.18
setenv ipaddr 10.0.0.117
setenv npath /home/peter/mastering_beaglebone/userland/rootfs_nfs
setenv bootargs console=ttyO0,115200 debug earlycon root=/dev/nfs rw nfsroot=${serverip}:${npath},tcp,vers=3 ip=${ipaddr}
fatload mmc 0:1 0x80200000 zImage
fatload mmc 0:1 0x80f00000 am335x-boneblack.dtb
bootz 0x80200000 - 0x80f00000

setenv bootcmd fatload mmc 0:1 0x80200000 zImage\;fatload mmc 0:1 0x80f00000 am335x-boneblack.dtb\;bootz 0x80200000 - 0x80f00000




# ################
# ## gpio
# ################


pinctl information is avalable under /sys/kernel/debug/pinctrl/*
To have it avalable your kernel must be configered for debugging and the debugfs must be mounted:
CONFIG_DEBUG_KERNEL
mount -t debugfs none /sys/kernel/debug

http://derekmolloy.ie/gpios-on-the-beaglebone-black-using-device-tree-overlays/

cd /sys/kernel/debug/pinctrl/44e10800.pinmux-pinctrl-single

# ---------------------
# -- GPIO control output
# ---------------------
e.g. Pin  14 on the P8 Header
=> BB_Pinmux.ods

=> GPIO0_26  = 0 x 32 + 26 = GPIO 26
=> Offset 0x028, P8-14 GPIO0_26
=> 44e10800+028 = 44e10828

/sys/kernel/debug/pinctrl/44e10800.pinmux
cat pins | grep 44e10828
pin 10 (PIN10) 26:gpio-96-127 44e10828 00000027 pinctrl-single
more gpio-ranges  | grep 10
26: gpio-96-127 GPIOS [122 - 123] PINS [10 - 11]
=> pin10 = gpio122

Well to understand this you need the document to beat all documents – the AM3359 Technical Reference Manual. http://www.ti.com/product/am3359 and you can see the link for this document. The version I am using is called the “AM335x ARM Cortex-A8 Microprocessors (MPUs) Technical Reference Manual (Rev.H). It is a 18.5MB document with 4,727 pages (no typo there – 4,700 pages!). The current direct link is: http://www.ti.com/lit/ug/spruh73j/spruh73j.pdf


Bit Description
6   Slew Control
5   Receiver active (0 for output, 1 for also input) 
4   Pad Type Pullup=1/down=0
3   Pad Enable Pullup/down
2-0 mux select

0x27 = 010 0111
2-0 mmode=111 => muxmode=7
3 pad pull disabled
4 putypesel=0 => Pulldn
5 rxactive=0 => Receiver disable = output

cd /sys/class/gpio
echo 122 > export

cd gpio122
sudo echo out > direction 
sudo echo 1 > value
sudo echo 0 > value

cat pingroups = registered pingroups


# ---------------------
# -- DeviceTree configuration / GPIO control output
# ---------------------

am335x-bone-common.dtsi :
&am33xx_pinmux {
[..]
	/* pullup */
	mygpio1_pins_default: mygpio1_pins_default {
		pinctrl-single,pins = <
			AM33XX_IOPAD(0x88C, PIN_INPUT_PULLUP | MUX_MODE7) /* P8_18 GPIO33 */
		>;
	};
[..]

nova.dtb :
/ {
	model = "Nova";
	compatible = "ti,am335x-bone-black", "ti,am335x-bone", "ti,am33xx";

	/* set input pins pullup */
	mygpio1_pins {
	compatible = "gpio-keys";
	/* compatible = "bone-pinmux-helper"; */
	pinctrl-names = "default";
	pinctrl-0 = <&mygpio1_pins_default>;
	status = "okay";
	};
};

make ARCH=arm nova.dtb
sudo cp arch/arm/boot/dts/nova.dtb  /var/lib/tftpboot/


# ---------------------
# -- LED control
# ---------------------



# ################
# ## UART
# ################

serial debug interface:
 UART0
 /dev/ttyS0

/etc/inittab:
 ::sysinit:/etc/init.d/rcS
 ::respawn:/sbin/getty 115200 console <=REMOVE

pin loopback / gtkterm
 microcom -s 115200 /dev/ttyS0

# ---------------------
# -- I/O
# ---------------------

UART1
UART1_TXD P9_24 0x184
UART1_RXD P9_26 0x180

~ # cat /sys/kernel/debug/pinctrl/44e10800.pinmux-pinctrl-single/pins | grep 984
pin 97 (PIN97) 15:gpio-96-127 44e10984 00000037 pinctrl-single 

~ # cat /sys/kernel/debug/pinctrl/44e10800.pinmux-pinctrl-single/pins | grep 980
pin 96 (PIN96) 14:gpio-96-127 44e10980 00000037 pinctrl-single 

=> pinmux = 7

am335x-bone-common.dtsi :
[..]
	uart1_pins: pinmux_uart1_pins {
		pinctrl-single,pins = <
			AM33XX_PADCONF(AM335X_PIN_UART1_RXD, PIN_INPUT_PULLUP, MUX_MODE0)
			AM33XX_PADCONF(AM335X_PIN_UART1_TXD, PIN_OUTPUT_PULLDOWN, MUX_MODE0)
		>;
	};
[..]
&uart1 {
	pinctrl-names = "default";
	pinctrl-0 = <&uart1_pins>;

	status = "okay";
};
[..]

[    3.559772] 48022000.serial: ttyS1 at MMIO 0x48022000 (irq = 24, base_baud = 3000000) is a 8250
[    5.813839] 44e09000.serial: ttyS0 at MMIO 0x44e09000 (irq = 18, base_baud = 3000000) is a 8250

cat /sys/class/tty/ttyS1/dev
4:65 (major:minor)

echo peter > /dev/ttyS1
microcom -s 115200 /dev/ttyS1

microcom /dev/ttyS1


# ---------------------
# -- GPS
 # ---------------------

UART4
UART4_TXD P9_13 0x074
UART4_RXD P9_11 0x070

~ # cat /sys/kernel/debug/pinctrl/44e10800.pinmux-pinctrl-single/pins | grep 874
pin 29 (PIN29) 31:gpio-96-127 44e10874 00000037 pinctrl-single 

~ # cat /sys/kernel/debug/pinctrl/44e10800.pinmux-pinctrl-single/pins | grep 870
pin 28 (PIN28) 30:gpio-96-127 44e10870 00000037 pinctrl-single 

=> pinmux = 7

am335x-bone-common.dtsi :
[..]
	uart4_pins: pinmux_uart4_pins {
		pinctrl-single,pins = <
			AM33XX_PADCONF(AM335X_PIN_GPMC_WAIT0, PIN_INPUT_PULLUP, MUX_MODE6)
                        AM33XX_PADCONF(AM335X_PIN_GPMC_WPN, PIN_OUTPUT_PULLDOWN, MUX_MODE6)
		>;
	};
[..]
&uart4 {
	pinctrl-names = "default";
	pinctrl-0 = <&uart4_pins>;

	status = "okay";
};
[..]

www.ti.com
https://dev.ti.com/sysconfig/#/start

GPS-Baudrate: 9600
microcom /dev/ttyS4
microcom -s 9600 /dev/ttyS4

nmea parser: https://github.com/kosma/minmea

# ################
# ## I2C
# ################

i2cdetect -l

i2c-2   i2c             OMAP I2C adapter                        I2C adapter
i2c-0   i2c             OMAP I2C adapter                        I2C adapter

I2C interface #2
i2c2_pins: pinmux_i2c2_pins {
		pinctrl-single,pins = <
			AM33XX_PADCONF(AM335X_PIN_UART1_CTSN, PIN_INPUT_PULLUP, MUX_MODE3)	/* uart1_ctsn.i2c2_sda */
			AM33XX_PADCONF(AM335X_PIN_UART1_RTSN, PIN_INPUT_PULLUP, MUX_MODE3)	/* uart1_rtsn.i2c2_scl */
		>;
	};

 i2cdetect -y -r 2


# ################
# ## buildroot "2023.02.3"
# ################


https://buildroot.org/download.html

git clone git://git.buildroot.net/buildroot
git checkout -b 2023.02.3.mybuildroot

make list-defconfigs


