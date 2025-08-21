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
AS=64tass

PROGS	= build/keyscan64.prg build/keyscan128.prg

all: build $(PROGS) cksum

build:
	mkdir -p build/

build/keyscan64.prg: src/keyscan64.asm
	$(AS) --list=$(@:.prg=).list -o $(@) $<

build/keyscan128.prg: src/keyscan128.asm
	$(AS) --list=$(@:.prg=).list -o $(@) $<

clean:
	rm -f build/*

cksum:
	@echo ""
	@echo "Generating checksums....(you should confirm the checksums below match)"
	@$(MD5) original/keyscan64.prg build/keyscan64.prg $(MD5OPT)
	@$(MD5) original/keyscan128.prg build/keyscan128.prg $(MD5OPT)

