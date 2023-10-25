#!/bin/sh

echo TFTPD
/etc/init.d/tftpd-hpa restart

echo GTKTERM
gtkterm -p /dev/ttyUSB2 -s 115200 &
ls /dev/ttyUSB*

#emacs readme.md &
