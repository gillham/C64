;---------------------------------------
; REU detection
; based on a post from csdb.dk with
; a number of fixes to make it work
; plus invalid register checking
;
; this avoids false detectioon of an
; reu with an EasyFlash3 which has sram
; from $df00-$dfff
;
; a popular basic detection of writing
; a value or two and reading it back
; immediately fails when that page is
; actual sram
;
; this requests the reu to swap 255
; byte between the reu and main ram
; and back which should take time
;
; we check this by starting the swaps
; on raster line 0 and if we have an
; reu the swaps will take far longer
; than one raster line
;
; if we are still on the same raster
; line, no swap happened, no reu
;
; we confirm this by checking for $ff
; from invalid registers
;---------------------------------------
         *= $0810

; scratch memory area for swap
scratch  = $c000

; vic registers
raster   = $d012
border   = $d020
screen   = $d021

; reu registers
command  = $df01
c64base  = $df02
reubase  = $df04
translen = $df07
control  = $df0a

;---------------------------------------
; invalid registers always return $ff
; $df0b - $df1f are invalid
; we can write something to them and
; all should return $ff not what we
; wrote or another value
; memory (like EasyFlash3 SRAM) will
; return whatever we wrote so an easy
; way to double-check on an reu
;---------------------------------------

invalid  = $df0b
; 21 invalid registers
count    = $15


         sei
;---------------------------------------
; setup REU
; make C64&REU address both increment
; by setting control to zero
;---------------------------------------

         lda #0
         sta control

;---------------------------------------
; bank/memory all zero, first 255 bytes
; of reu will be swapped
;---------------------------------------
         sta reubase
         sta reubase+1
         sta reubase+2

;---------------------------------------
; transfer length $00ff
;---------------------------------------
         sta translen+1
         lda #$ff
         sta translen

;---------------------------------------
; setup some spot to swap 255 bytes
; between C64 and REU twice
; memory will be swapped twice so will
; end up as it started.
;---------------------------------------
         lda #<scratch
         sta c64base
         lda #>scratch
         sta c64base+1

;---------------------------------------
; wait for two different raster lines
; so we know we detect raster line 0 as
; close to the start of line as we can
; avoiding a case where this code runs
; mid raster line 0
;
; busy wait for raster line 240.
; (probably could wait on 255 also)
;---------------------------------------
         ldx #$f0
check1   cpx raster
         bne check1

;---------------------------------------
; now wait for raster line 0.
;---------------------------------------
         ldx #0
check2   cpx raster
         bne check2

;---------------------------------------
; swap 255 bytes of c64 and reu mem
; 1 byte per cycle, but swaps move 1
; byte from C64 and 1 byte from REU
; so 2 cycles per swap.
; So 255 byte swap is about 510 cycles
;---------------------------------------
         ldx #%10010010
         stx command
; swap back
         stx command
;---------------------------------------
; check if raster line is still 0.
; These swaps should take 1020 cycles
;---------------------------------------
         lda raster
         bne found
;---------------------------------------
; REU swap did not take any cycles
;---------------------------------------
noreu    lda #0
         sta border
         sta screen
         cli
         jmp *
;---------------------------------------
; REU took cycles
;---------------------------------------
found    lda #1
         sta border
         sta screen

;---------------------------------------
; write to invalid registers
;---------------------------------------
         ldx count
         lda #$bb
loop1    sta invalid,x
         dex
         bne loop1

;---------------------------------------
; check invalid registers for $ff
;---------------------------------------
         ldx count
loop2    lda invalid,x
         cmp #$ff
         bne noreu
         dex
         bne loop2
;---------------------------------------
;definitely found reu
;---------------------------------------
         lda #2
         sta border
         sta screen
         cli
         jmp *
;---------------------------------------





















