#!/bin/sh
#
# Generates .d64 and also a ascii text basic program.
#

rm -f alpa.d64

c1541 -format "alpa,01" d64 alpa.d64
c1541 -attach alpa.d64 -write alpa.prg alpa
c1541 -attach alpa.d64 -write alpa8.prg alpa8
c1541 -attach alpa.d64 -write alpatape.prg alpatape

petcat -h -o src/alpa.bas alpa.prg
petcat -h -o src/alpa8.bas alpa8.prg
petcat -h -o src/alpatape.bas alpatape.prg
petcat -h -o src/alpax16.bas alpax16.prg

#
# end-of-file
#
