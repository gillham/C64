#!/bin/sh
#
# Simple script to launch VICE.
#
# It will enable the VICE FS on device 10.
# Also an ascii printer is enabled on device 4 as
# the code from the book generates listings to the printer.
# Removing the 'PRT' (Typically '10 PRT') before assembling
# will disable the printer output.
#
# USAGE: ./run.sh [disk08_image] [disk09_image]
#

if [ "$1" != "" ]; then
    DRIVE08="-8 $1 -drive8type 1542"
fi
if [ "$2" != "" ]; then
    DRIVE09="-9 $2 -drive9type 1542"
fi
DRIVE10="-fs10 . -device10 1 -iecdevice10 -virtualdev10"

KEYMAP="-keymap 1"
MODEL="-model ntsc"
PRINTER="-virtualdev4 -iecdevice4 -device4 1"

#
# Use -default to eliminate any saved config.
#
x64sc -default ${KEYMAP} ${MODEL} ${PRINTER} ${DRIVE08} ${DRIVE09} ${DRIVE10}

#
# end-of-file
#
