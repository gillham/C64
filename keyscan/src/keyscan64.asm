;3-Key Rollover-128 by Craig Bruce 18-Jun-93 for C= Hacking magazine

;.org $1500
*=$c500

scanrows = 8
rollover = 3

pa = $dc00
pb = $dc01

; kernal calls
STOP = $ffe1

jmp initialInstall
jmp reinstall
jmp install

;ugly IRQ patch code.

irq = *  ;$xx09
   .byte $20,$ea,$ff,$a5,$cc,$d0,$29,$c6,$cd,$d0,$25,$a9,$14,$85,$cd,$a4
   .byte $d3,$46,$cf,$ae,$87,$02,$b1,$d1,$b0,$11,$e6,$cf,$85,$ce,$20,$24
   .byte $ea,$b1,$f3,$8d,$87,$02,$ae,$86,$02,$a5,$ce,$49,$80,$20,$1c,$ea
   .byte $a5,$01,$29,$10,$f0,$0a,$a0,$00,$84,$c0,$a5,$01,$09,$20,$d0,$08
   .byte $a5,$c0,$d0,$06,$a5,$01,$29,$1f,$85,$01,$20
   .word main       ; this allows changing the load address.
   .byte $4c,$7e,$ea

;keyscanning entry point
main = *
   lda #0               ;check if any keys are held down
   sta pa
-  lda pb
   cmp pb
   bne -
   cmp #$ff
   beq noKeyPressed     ;if not, then don't scan keyboard, goto Kernal

   jsr checkJoystick    ;if so, make sure joystick not pressed
   bcc joystickPressed
   jsr keyscan          ;scan the keyboard and store results
   jsr checkJoystick    ;make sure joystick not pressed again
   bcc joystickPressed
   jsr shiftdecode      ;decode the shift keys
   jsr keydecode        ;decode the first 3 regular keys held down
   jsr keyorder         ;see which new keys pressed, old keys released, and
                        ;  determine which key to present to the Kernal
   lda #$81             ; set up for and dispatch to Kernal (low-byte of rom table)
   sta $f5              ; pointer to keyboard conversion table (low-byte)
   lda #$EB             ; high byte of rom keyboard table
   sta $f6              ; pointer to keyboard conversion table (high-byte)
   ldx #$ff
   bit ignoreKeys
   bmi ++
   lda prevKeys+0
   cmp #$ff
   bne +
   lda $028d            ; shift key indicator
   beq ++
   lda #$40
+  sta $cb
   tay
   jmp ($028f)          ; shift key table vector

   noKeyPressed = *     ;no keys pressed; select default scan row
   lda #$7f
   sta pa

joystickPressed = *
   lda #$ff             ;record that no keys are down in old 3-key array
   ldx #rollover-1
-  sta prevKeys,x
   dex
   bpl -
   jsr scanCaps         ;scan the CAPS LOCK key
   ldx #$ff
   lda #0
   sta ignoreKeys

+  lda #$40              ;present "no key held" to Kernal
   sta $cb
   tay
   jmp $eb26

initialInstall = *      ;install wedge: set restore vector, print message
   jsr install
   ldx #0
-  lda installMsg,x
   beq +
   jsr $ffd2            ; CHROUT
   inx
   bne -
+  rts

installMsg = *
   .text "KEYSCAN64 INSTALLED"
   .byte 13
   .byte 0

install = *             ;guts of installation: set IRQ vector to patch code
   sei                  ;  and initialize scanning variables
   lda #<irq
   ldy #>irq
   sta $0314
   sty $0315
   lda #<nmi
   ldy #>nmi
   sta $0318
   sty $0319
   cli
   ldx #rollover-1
   lda #$ff
-  sta prevKeys,x
   dex
   bpl -
   lda #0
   sta ignoreKeys
   rts

reinstall = *       ; restore original IRQ & NMI handlers
   sei
   lda #$31
   ldy #$ea
   sta $0314
   sty $0315
   lda #$47
   ldy #$fe
   sta $0318
   sty $0319
   cli
   rts

nmi:
   pha
   txa
   pha
   tya
   pha
   lda #$7f
   sta $dd0d
   ldy $dd0d
   bmi ++
   jsr $fd02    ; look for autostart cartridge ROM
   bne +
   jmp ($8002)  ; jump to cartridge rom init
+  jsr $f6bc
   jsr STOP
   bne +
   jsr $fd15    ; kernal RESTOR
   jsr $fda3
   jsr $e518
   jsr install
   jmp ($a002)  ; jump to basic rom init
+
   jmp $fe72


mask = $f5

keyscan = *             ;scan the (extended) keyboard using the forward
   ldx #$ff             ;  row-wise "slow" technique
   ldy #$ff
   lda #$fe
   sta mask
   jmp +

nextRow = *
-  lda pb
   cmp pb
   bne -
   sty pa
   eor #$ff
   sta scanTable,x
   sec
   rol mask
+  lda mask
   sta pa
   inx
   cpx #scanrows
   bcc nextRow
   rts

shiftValue = $028d

shiftRows .byte $01,$06,$07,$07
shiftBits .byte $80,$10,$20,$04
shiftMask .byte $01,$01,$02,$04

shiftdecode = *         ;see which "shift" keys are held down, put them into
   jsr scanCaps         ;  proper positions in $D3 (shift flags), and remove
   ldy #3               ;  them from the scan matrix
-  ldx shiftRows,y
   lda scanTable,x
   and shiftBits,y
   beq +
   lda shiftMask,y
   ora shiftValue
   sta shiftValue
   lda shiftBits,y
   eor #$ff
   and scanTable,x
   sta scanTable,x
+  dey
   bpl -
   rts

scanCaps = *            ;scan the CAPS LOCK key from the processor I/O port
   lda #$00
   sta $028d
   rts

newpos = $f5
keycode = $cb
xsave = $f6

keydecode = *           ;get the scan codes of the first three keys held down
   ldx #rollover-1      ;initialize: $ff means no key held
   lda #$ff
-  sta newKeys,x
   dex
   bpl -
   ldy #0
   sty newpos
   ldx #0
   stx keycode

decodeNextRow = *    ;decode a row, incrementing the current scan code
   lda scanTable,x
   beq decodeContinue
                        ;at this point, we know that the row has a key held
   ldy keycode
-  lsr
   bcc ++
   pha                  ;here we know which key it is, so store its scan code,
   stx xsave            ;  up to 3 keys
   ldx newpos
   cpx #rollover
   bcs +
   tya
   sta newKeys,x
   inc newpos
+  ldx xsave
   pla
+  iny
   cmp #$00
   bne -

decodeContinue = *
   clc
   lda keycode
   adc #8
   sta keycode
   inx
   cpx #scanrows
   bcc decodeNextRow
   rts

;keyorder: determine what key to present to the Kernal as being logically the
;only one pressed, based on which keys previously held have been released and
;which new keys have just been pressed

keyorder = *
   ;** remove old keys no longer held from old scan code array
   ldy #0
nextRemove = *
   lda prevKeys,y       ;get current old key
   cmp #$ff
   beq ++
   ldx #rollover-1      ;search for it in the new scan code array
-  cmp newKeys,x
   beq +
   dex
   bpl -
   tya                  ;here, old key no longer held; remove it
   tax
-  lda prevKeys+1,x
   sta prevKeys+0,x
   inx
   cpx #rollover-1
   bcc -
   lda #$ff
   sta prevKeys+rollover-1
   sta ignoreKeys
+  iny                  ;check next old key
   cpy #rollover
   bcc nextRemove

   ;** insert new keys at front of old scan code array 
+  ldy #0
nextInsert = *
   lda newKeys,y        ;get current new key
   cmp #$ff
   beq ++
   ldx #rollover-1      ;check old scan code array for it
-  cmp prevKeys,x
   beq +
   dex
   bpl -
   pha                  ;it's not there, so insert new key at front, exit
   ldx #rollover-2
-  lda prevKeys+0,x
   sta prevKeys+1,x
   dex
   bpl -
   lda #0
   sta ignoreKeys
   pla
   sta prevKeys+0
   ldy #rollover        ;(trick to exit)
+  iny
   cpy #rollover
   bcc nextInsert
+  rts                  ;now, the head of the old scan code array contains
                        ;  the scan code to present to the Kernal, and other
                        ;  positions represent keys that are also held down
                        ;  that have already been processed and therefore can
                        ;  be ignored until they are released

checkJoystick = *       ;check if joystick is pushed: un-select all keyboard
   lda #$ff             ;  rows and see if there are any "0"s in the scan
   sta pa               ;  status register
-  lda pb
   cmp pb
   bne -
   cmp #$ff
   lda #$7f             ;restore to default Kernal row selected (to the one
   sta pa               ;  containing the STOP key)
   rts

;global variables

scanTable  .fill scanrows,0         ;values of the eight keyboard scan rows
newKeys    .fill rollover,0         ;codes of up to three keys held simultaneously
ignoreKeys .fill 1,0                ;flag: if an old key has been released and no
                                    ;  new key has been pressed, stop all key
                                    ;  repeating
prevKeys   .fill rollover+2,0       ;keys held on previous scan
