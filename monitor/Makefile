#
# Simplistic Makefile for the monitor and extension.
#
#

# find the correct md5 checksum tool
MD5	:=
MD5OPT	:=
ifeq ($(OS),Windows_NT)
	MD5 = "certutil -hashfile"
	MD5OPT = "MD5"
else
	UNAME_S := $(shell uname -s)
	ifeq ($(UNAME_S),Linux)
		MD5 = "md5sum"
	endif
	ifeq ($(UNAME_S),Darwin)
		MD5 = "md5"
	endif
endif

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
	@$(MD5) Monitor_C000.prg monitorc.prg $(MD5OPT)

