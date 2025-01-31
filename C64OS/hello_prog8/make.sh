#!/bin/sh

PCC="prog8c"

${PCC} -asmlist -sourcelines -target c64os.properties -out build/ main.p8

# make a disk.
MYDISK="test/hello.d64"
rm -f ${MYDISK}
c1541 -format hello,52 d64 ${MYDISK}
c1541 -attach ${MYDISK} -write build/main.prg main.o,p
c1541 -attach ${MYDISK} -write test/go.prg go,p

#
# end-of-file
#
