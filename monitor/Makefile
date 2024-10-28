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
CL65=cl65 -g -t c64 -C c64-asm.cfg

PROGS	= monitor2.prg monitor8.prg monitorc.prg monext.prg

all: $(PROGS) cksum

monitor2.prg: monitor.s
	$(CL65) --listing $(@:.prg=).list -Ln $(@:.prg=).vice -o $(@) --start-addr 0x2000 $<

monitor8.prg: monitor.s
	$(CL65) --asm-define NOMONEXT --listing $(@:.prg=).list -Ln $(@:.prg=).vice -o $(@) --start-addr 0x8000 $<

monitorc.prg: monitor.s
	$(CL65) --listing $(@:.prg=).list -Ln $(@:.prg=).vice -o $(@) --start-addr 0xc000 $<

monext.prg: monext.s
	cl65 -g -Ln monext.vice -o monext.prg -t c64 -C c64-asm.cfg --start-addr 0x8f00 monext.s

clean:
	rm -f monitor2.prg monitor2.list monitor2.vice
	rm -f monitor8.prg monitor8.list monitor8.vice
	rm -f monitorc.prg monitorc.list monitorc.vice
	rm -f monext.prg monext.o monext.vice monitor.o

cksum:
	@echo ""
	@echo "Generating checksums....(you should confirm the checksums below match)"
	@$(MD5) dist/Monitor_C000.prg monitorc.prg $(MD5OPT)

