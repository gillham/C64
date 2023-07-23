#!/bin/sh
#
# Generates .d64 and also extracts text from native C64 files.
#
ASMFILES="mcpatch.asm undead.asm subex.asm rkill.asm getwrd.asm \
    doke.asm plot.asm delete.asm bsave.asm bload.asm \
    move.asm fill.asm restore.asm function.asm fast.asm"

rm -f mastercode.d64

c1541 -format "master code,01" d64 mastercode.d64
c1541 -attach mastercode.d64 -write mastercode.prg mastercode
c1541 -attach mastercode.d64 -write "basicloader.prg" "basicloader"
c1541 -attach mastercode.d64 -write "basicextender.seq" "basicextender",s

for f in $ASMFILES
do
    filebase=$(basename ${f} .asm)
    c1541 -attach mastercode.d64 -write native/${f} ${f},s
    petcat -h -o src/${filebase}.s native/${f}
done

#
# end-of-file
#
