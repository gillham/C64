#
# Simple Makefile for a Prog8 program.
#

# Cross-platform removal command
ifeq ($(OS),Windows_NT)
    CLEAN = del /Q build\* 
    CP = copy
    RM = del /Q
    MD = mkdir
else
    CLEAN = rm -f build/*
    CP = cp -p
    RM = rm -f
    MD = mkdir -p
endif

# disk image settings
DISKTYPE=d64
DISKNAME=custchar
DISK=build/$(DISKNAME).$(DISKTYPE)

# Emulator settings
EMU_CMD=x64sc
EMU_BASE=-default -keymap 1 -model ntsc
EMU_DISK08=-8 $(DISK) -drive8type 1542
EMU_DISK10=-fs10 build -devicebackend10 1 -busdevice10 -trapdevice10
EMU_DISK=$(EMU_DISK08) $(EMU_DISK10)
#EMU_KERNAL=-kernal jiffykernal
EMU_REUSIZE=2048
#EMU_REUSIZE=256
EMU_REU=-reu -reusize $(EMU_REUSIZE) -reuimage build/reu-image.bin -reuimagerw
#EMU_REU=-reu -reusize $(EMU_REUSIZE)
EMU=$(EMU_CMD) $(EMU_BASE) $(EMU_KERNAL) $(EMU_DISK) $(EMU_REU)

PCC=prog8c
PCCARGSC64=-srcdirs src -asmlist -target c64 -out build

PROGS	= build/custchar.prg build/hello.prg build/tview.prg

all: build $(PROGS) disk

build:
	$(MD) build/

build/%.prg: src/%.p8 src/args.p8 src/c64oscharset.p8
	$(PCC) $(PCCARGSC64) $<

clean:
	$(RM) build/*

disk:	build $(PROGS)
	c1541 -format $(DISKNAME),52 $(DISKTYPE) $(DISK) > /dev/null
	c1541 -attach $(DISK) -write build/custchar.prg custchar,p > /dev/null
	c1541 -attach $(DISK) -write build/tview.prg tview,p > /dev/null
	c1541 -attach $(DISK) -write build/hello.prg hello,p > /dev/null
	c1541 -attach $(DISK) -write test/testfile.t testfile.t,s > /dev/null

emu:
	$(EMU)

#
# end-of-file
#
