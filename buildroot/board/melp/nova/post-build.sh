#!/bin/sh
BOARD_DIR="$(dirname $0)"

cp $BOARD_DIR/uEnv.txt $BINARIES_DIR/uEnv.txt

install -m 0644 -D $BOARD_DIR/extlinux.conf $BINARIES_DIR/extlinux/extlinux.conf

# $1 = buildroot/output/target

# enhance /etc/network/interfaces
# original
# # interface file auto-generated by buildroot
# auto lo
# iface lo inet loopback

echo "#generated by posbuild script: " > $1/etc/network/interfaces
echo " " >> $1/etc/network/interfaces
echo "auto lo" >> $1/etc/network/interfaces
echo " iface lo inet loopback"  >> $1/etc/network/interfaces
echo " " >> $1/etc/network/interfaces
echo "auto eth0" >> $1/etc/network/interfaces
echo " iface eth0 inet static" >> $1/etc/network/interfaces
echo "   address 10.0.0.117" >> $1/etc/network/interfaces
echo "   netmask 255.255.255.0" >> $1/etc/network/interfaces
echo "   network 10.0.0.0" >> $1/etc/network/interfaces

# enhance /root
mkdir -p $1/root/.ssh
touch $1/root/.ssh/authorized_keys
echo "#generated by posbuild script: " > $1/root/.ssh/authorized_keys
echo " " >> $1/root/.ssh/authorized_keys
echo "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIO9xr1NOjapEzY2vmRkxKOk0GTqnt8t0gbK2DWiefjY8 peter@elvwatt" >> $1/root/.ssh/authorized_keys
echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDFdNJP5jvQz83BHerNXup6ReYeIGoQnKyaYGdxfcnw6EYOhNUky+y0jZzkXgHQBbYKld2JgexmE8blGjaMz09bFi/Jao/lj/MjwTnkYSmhJQHUqf1HwM8AgFPRtlcTcwzfQghL36Ksww//6KhSugRt0vSMF4hvwPSH+iZHpNIjzZPBSqPzzxKBy/yTyl9fi3hqwG7SXN0tKEHyUz82m0nxzj64/gAyX1fv59eJq0KgUsZN3b0i8VnwUyfaRrQWEJkw567cWtp0B0HXPEnFimOpKTW9Rmp4yC7+FMjQEhWf+zWhrB2+JHtzW8pGgkgl9iwwN2KmcvbR1WGDtOfUOumf peter@elvwatt" >> $1/root/.ssh/authorized_keys
echo "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMrUit/euWrT97lu13V9wBuhT8AupKLLdIZ5jaz31ERk peter@11watt" >> $1/root/.ssh/authorized_keys

# enhance /etc/fstab
if grep debugfs $1/etc/fstab > /dev/null
then
    echo debugfs already in fstab
else
    echo "debugfs		/sys/kernel/debug	debugfs		defaults	0	0" >> $1/etc/fstab
fi