;3-Key Rollover-128 by Craig Bruce 18-Jun-93 for C= Hacking magazine

;.org $1500
*=$1500
;.obj "@0:keyscan128"

scanrows = 11
rollover = 3

pa = $dc00
pb = $dc01
pk = $d02f

jmp initialInstall

;ugly IRQ patch code.

irq = *  ;$1503
   .byte $d8,$20,$0a,$15,$4c,$69,$fa,$38,$ad,$19,$d0,$29,$01,$f0,$07,$8d
   .byte $19,$d0,$a5,$d8,$c9,$ff,$f0,$6f,$2c,$11,$d0,$30,$04,$29,$40,$d0
   .byte $31,$38,$a5,$d8,$f0,$2c,$24,$d8,$50,$06,$ad,$34,$0a,$8d,$12,$d0
   .byte $a5,$01,$29,$fd,$09,$04,$48,$ad,$2d,$0a,$48,$ad,$11,$d0,$29,$7f
   .byte $09,$20,$a8,$ad,$16,$d0,$24,$d8,$30,$03,$29,$ef,$2c,$09,$10,$aa
   .byte $d0,$28,$a9,$ff,$8d,$12,$d0,$a5,$01,$09,$02,$29,$fb,$05,$d9,$48
   .byte $ad,$2c,$0a,$48,$ad,$11,$d0,$29,$5f,$a8,$ad,$16,$d0,$29,$ef,$aa
   .byte $b0,$08,$a2,$07,$ca,$d0,$fd,$ea,$ea,$aa,$68,$8d,$18,$d0,$68,$85
   .byte $01,$8c,$11,$d0,$8e,$16,$d0,$b0,$13,$ad,$30,$d0,$29,$01,$f0,$0c
   .byte $a5,$d8,$29,$40,$f0,$06,$ad,$11,$d0,$10,$01,$38,$58,$90,$07,$20
   .byte $aa,$15,$20,$e7,$c6,$38,$60

;keyscanning entry point

main = *
   lda #0               ;check if any keys are held down
   sta pa
   sta pk
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
   lda $033e            ;set up for and dispatch to Kernal
   sta $cc
   lda $033f
   sta $cd
   ldx #$ff
   bit ignoreKeys
   bmi ++
   lda prevKeys+0
   cmp #$ff
   bne +
   lda $d3
   beq ++
   lda #88
+  sta $d4
   tay
   jmp ($033a)

   noKeyPressed = *     ;no keys pressed; select default scan row
   lda #$7f
   sta pa
   lda #$ff
   sta pk

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

+  lda #88              ;present "no key held" to Kernal
   sta $d4
   tay
   jmp $c697

initialInstall = *      ;install wedge: set restore vector, print message
   jsr install
   lda #<reinstall
   ldy #>reinstall
   sta $0a00
   sty $0a01
   ldx #0
-  lda installMsg,x
   beq +
   jsr $ffd2
   inx
   bne -
+  rts

   installMsg = *
   .byte 13
   .text "KEYSCAN128 INSTALLED"
   .byte 0

reinstall = *           ;re-install wedge after a RUN/STOP+RESTORE
   jsr install
   jmp $4003

install = *             ;guts of installation: set IRQ vector to patch code
   sei                  ;  and initialize scanning variables
   lda #<irq
   ldy #>irq
   sta $0314
   sty $0315
   cli
   ldx #rollover-1
   lda #$ff
-  sta prevKeys,x
   dex
   bpl -
   lda #0
   sta ignoreKeys
   rts

mask = $cc

keyscan = *             ;scan the (extended) keyboard using the forward
   ldx #$ff             ;  row-wise "slow" technique
   ldy #$ff
   lda #$fe
   sta mask+0
   lda #$ff
   sta mask+1
   jmp +
   nextRow = *
-  lda pb
   cmp pb
   bne -
   sty pa
   sty pk
   eor #$ff
   sta scanTable,x
   sec
   rol mask+0
   rol mask+1
+  lda mask+0
   sta pa
   lda mask+1
   sta pk
   inx
   cpx #scanrows
   bcc nextRow
   rts

shiftValue = $d3

shiftRows .byte $01,$06,$07,$07,$0a
shiftBits .byte $80,$10,$20,$04,$01
shiftMask .byte $01,$01,$02,$04,$08

shiftdecode = *         ;see which "shift" keys are held down, put them into
   jsr scanCaps         ;  proper positions in $D3 (shift flags), and remove
   ldy #4               ;  them from the scan matrix
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
-  lda $1
   cmp $1
   bne -
   eor #$ff
   and #$40
   lsr
   lsr
   sta shiftValue
   rts

newpos = $cc
keycode = $d4
xsave = $cd

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
   sta pk
-  lda pb
   cmp pb
   bne -
   cmp #$ff
   lda #$7f             ;restore to default Kernal row selected (to the one
   sta pa               ;  containing the STOP key)
   lda #$ff
   sta pk
   rts

;global variables

scanTable  .fill scanrows,0         ;values of the eleven keyboard scan rows
newKeys    .fill rollover,0         ;codes of up to three keys held simultaneously
ignoreKeys .fill 1,0                ;flag: if an old key has been released and no
                                    ;  new key has been pressed, stop all key
                                    ;  repeating
prevKeys   .fill rollover+2,0       ;keys held on previous scan
