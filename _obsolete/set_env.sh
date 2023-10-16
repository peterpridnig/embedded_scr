
echo export WORKAREA
export WORKAREA=$(pwd)

echo export MELP
export MELP=~/mastering_beaglebone/Mastering-Embedded-Linux-Programming-Third-Edition/

echo enhance PATH
PATH=${HOME}/x-tools/arm-cortex_a8-linux-gnueabihf/bin/:$PATH

echo export CROSS_COMPILE
export CROSS_COMPILE=arm-cortex_a8-linux-gnueabihf-
echo export ARCH
export ARCH=arm
echo export SYSROOT
export SYSROOT=$(arm-cortex_a8-linux-gnueabihf-gcc -print-sysroot)

echo export CC
export CC=arm-cortex_a8-linux-gnueabihf-gcc

echo export SCR
export SCR=~/mastering_beaglebone/scr/


