#!/bin/sh

rm -f disk_mtext.d64
c1541 -format mtextdisk,12 d64 disk_mtext.d64
#c1541 -attach disk_mtext.d64 -write share/file file,s
c1541 -attach disk_mtext.d64 -write tags.seq tags,s
c1541 -attach disk_mtext.d64 -write p2mtext.prg p2mtext,p

