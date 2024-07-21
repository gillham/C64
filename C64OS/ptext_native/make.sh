#!/bin/sh

PCC="java -jar $HOME/Applications/Prog8/prog8compiler.jar"
${PCC} -target c64 p2mtext.p8

# For test file:
# petcat -text -w2 -o tags.seq -- tags_test.md
