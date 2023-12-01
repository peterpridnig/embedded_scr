#!/bin/sh

echo TFTPD
#https://www.cyberciti.biz/faq/bash-check-if-process-is-running-or-notonlinuxunix/
# pgrep tftpd
# echo "$?" = 0
#
# pgrep tftpdFAIL
# echo "$?" = 1
#
if pgrep tftpd > /dev/null
then
    echo "tftfp already running"
else
    echo "start tftpd"
    /etc/init.d/tftpd-hpa restart
fi
    

echo GTKTERM
#gtkterm -p /dev/ttyUSB2 -s 115200 &
#ls /dev/ttyUSB*

echo Start terminal debug console
gtkterm -p /dev/serial/by-path/pci-0000:00:14.0-usb-0:6:1.0-port0 -s 115200 &

echo Start terminal i/o
gtkterm -p /dev/serial/by-path/pci-0000:00:14.0-usb-0:5:1.0-port0 -s 115200 &

# https://linuxize.com/post/bash-check-if-file-exists/
# https://www.cyberciti.biz/faq/bash-check-if-process-is-running-or-notonlinuxunix/



