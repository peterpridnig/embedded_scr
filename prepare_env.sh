#!/bin/sh

echo TFTPD
/etc/init.d/tftpd-hpa restart

echo GTKTERM
gtkterm -p /dev/ttyUSB0 -s 115200 &


