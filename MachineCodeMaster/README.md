# BASIC source code for `Mastercode`

## Intro

This directory has the source code, written in BASIC, for a Commodore 64 assembler.  This was typed in from the book "Commodore 64 Machine Code Master" written by David Lawrence & Mark England.  It was published in 1984 by Sunshine Books in London.  I found this book on eBay and noticed it was only being offered by UK & Australian sellers.  I ended up getting my copy from Australia.

This book presents a full development environment, but since it is written in BASIC it is fairly slow.

It provides:
 - Mastercode Monitor
 - Mastercode Disassembler
 - Mastercode File Editor
 - Mastercode Assembler

## Usage

## BASIC Extender

Assembly order:
```
mcpatch.asm
undead.asm
subex.asm
rkill.asm
getwrd.asm
doke.asm
plot.asm
delete.asm
bsave.asm
bload.asm
move.asm
fill.asm
restore.asm
function.asm
fast.asm
```

## Type-In Issues

There are a few lines that don't match the book checksum tables.  Many of these are related to print statements where it is somewhat tricky to get the formatting perfect.  The lines all appear correct and probably could be corrected via trial and error.

Mismatches:
P.12  10031 should be 164 not 116   # This appears swapped with 10032. Otherwise the line appears correct.

P.12  10032 should be 116 not 164   # This appears swapped with 10031. Otherwise the line appears correct.

P.13  10230 should be 192 not 182   # Probably issue in print layout.  Otherwise the line appears correct.

P.25  14320 should be 84 not 174    # The line appears correct.

P.42  24820 should be 125 not 251   # Probably issue in print layout.  Otherwise the line appears correct.

P.61  20090 should be 244 not 63    # Probably issue in print layout.  Otherwise the line appears correct.

P.74  28020 should be 12 not 63     # The line appears correct.


