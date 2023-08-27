
export MELP=~/mastering_beaglebone/Mastering-Embedded-Linux-Programming-Third-Edition/

PATH=${HOME}/x-tools/arm-cortex_a8-linux-gnueabihf/bin/:$PATH
export CROSS_COMPILE=arm-cortex_a8-linux-gnueabihf-
export ARCH=arm
export SYSROOT=$(arm-cortex_a8-linux-gnueabihf-gcc -print-sysroot)

export CC=arm-cortex_a8-linux-gnueabihf-gcc

export SCR=~/mastering_beaglebone/scr/


