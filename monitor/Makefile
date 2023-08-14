#
# Simplistic Makefile for the monitor and extension.
#

PROGS	= monitorc.prg monext.prg

all: $(PROGS) cksum

monitorc.prg: monitor.s
	cl65 -g -Ln monitorc.vice -o monitorc.prg -t c64 -C c64-asm.cfg --start-addr 0xc000 monitor.s

monext.prg: monext.s
	cl65 -g -Ln monext.vice -o monext.prg -t c64 -C c64-asm.cfg --start-addr 0x8f00 monext.s

clean:
	rm -f monitorc.prg monitorc.o monext.prg monext.o

cksum:
	@echo ""
	@echo "Generating checksums....(you should confirm the checksums below match)"
	@md5sum Monitor_C000.prg monitorc.prg


