#!/bin/sh

echo TFTPD
/etc/init.d/tftpd-hpa restart

echo GTKTERM
gtkterm -p /dev/ttyUSB2 -s 115200 &
ls /dev/ttyUSB*

#echo debug console
#gtkterm -p /dev/serial/by-id/usb-FTDI_FT232R_USB_UART_A50285BI-if00-port0 -s 115200 &

#echo serial i/o
#gtkterm -p /dev/serial/by-id/usb-FTDI_FT232R_USB_UART_A50285BI-if00-port0 -s 115200 &


#emacs readme.md &
