#!/bin/sh

PCC="prog8c"
${PCC} -target c64 -asmlist p2mtext.p8

# For test file:
# petcat -text -w2 -o tags.seq -- tags_test.md
