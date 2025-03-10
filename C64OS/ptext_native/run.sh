#!/bin/sh

rm -f disk_mtext.d64
c1541 -format mtextdisk,12 d64 disk_mtext.d64
c1541 -attach disk_mtext.d64 -write tags.seq tags,s
c1541 -attach disk_mtext.d64 -write p2mtext.prg p2mtext,p
c1541 -attach disk_mtext.d64 -write nova.prg nova,p

DRIVE08="-8 disk_mtext.d64 -drive8type 1542"
DRIVE10="-fs10 share -device10 1 -iecdevice10 -virtualdev10"

# JiffyDOS
KERNAL="-kernal jiffykernal"
DOS="-dos1541 jiffy1541II -dos1541II jiffy1541II -dos1571 jiffy1571 -dos1581 jiffy1581"
ROM="${KERNAL} ${DOS}"

#
# extra config
#
KEYMAP="-keymap 1"
MODEL="-model ntsc"
MOUSE="-controlport1device 3"
REU="-reu -reusize 512"
EXTRA="${KEYMAP} ${MODEL} ${MOUSE} ${REU} ${ROM}"


#
# Use -default to eliminate any saved config.
#
x64sc -default ${EXTRA} ${DRIVE08} ${DRIVE09} ${DRIVE10} ${DRIVE11} ${IDEHD} p2mtext.prg $*

#
# end-of-file
#
