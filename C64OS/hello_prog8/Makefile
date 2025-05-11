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
DISKNAME=hello
DISK=test/$(DISKNAME).$(DISKTYPE)

# Emulator settings
EMU_CMD=x64sc
EMU_CMD128=x128
EMU_BASE=-default -keymap 1 -model ntsc
EMU_DISK08=-8 $(DISK) -drive8type 1542
EMU_DISK10=-fs10 build -device10 1 -iecdevice10 -virtualdev10
EMU_DISK=$(EMU_DISK08) $(EMU_DISK10)
#EMU_KERNAL=-kernal jiffykernal
EMU_REUSIZE=2048
#EMU_REUSIZE=256
EMU_REU=-reu -reusize $(EMU_REUSIZE) -reuimage build/reu-image.bin -reuimagerw
#EMU_REU=-reu -reusize $(EMU_REUSIZE)
EMU=$(EMU_CMD) $(EMU_BASE) $(EMU_KERNAL) $(EMU_DISK) $(EMU_REU)
EMU128=$(EMU_CMD128) $(EMU_BASE) $(EMU_KERNAL) $(EMU_DISK) $(EMU_REU)

PCC=prog8c
PCCARGSC64=-srcdirs src -asmlist -target c64os.properties -out build
PCCARGSC128=-srcdirs src -asmlist -target c128 -out build

PROGS	= build/main.prg
SRCS	= src/main.p8

all: build $(PROGS) disk

build:
	$(MD) build/

build/main.prg: $(SRCS)
	$(PCC) $(PCCARGSC64) $<

build/main128.prg: $(DEMO128)
	$(PCC) $(PCCARGSC128) $<

clean:
	$(RM) build/*

disk:
	c1541 -format $(DISKNAME),52 $(DISKTYPE) $(DISK) > /dev/null
	c1541 -attach $(DISK) -write build/main.prg main.o,p > /dev/null
	c1541 -attach $(DISK) -write test/go.prg go,p > /dev/null

emu:
	$(EMU)

emu128:
	$(EMU128)

#
# end-of-file
#
