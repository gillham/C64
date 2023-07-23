

;native/rkill.asm 
{clr}
 10       prt
 20       sym
 30       qflag = $f
 40       remtok = $8f
 50       asave = $c105
 60       xsave = $c106
 70       org $c051
 80       wrd rkill-1
 90       org $c160
 100       rkill lda #$ff
 110       sta $14
 120       sta $15
 130       ; save present basic warm start link
 140       lda $302
 150       ldx $303
 160       sta temp
 170       stx temp+1
 180       ; put new warm start link in
 190       lda #lbl003-lbl003/256*256
 200       ldx #lbl003/256
 210       sta $302
 220       stx $303
 230       ; get next line no to be treated
 240       lbl003 inc $14
 250       bne lbl004
 260       inc $15
 270       ; use rom routine to get add of line in $5f & $60
 280       lbl004 jsr $a613
 290       ; if hi link byte = 0 then exit
 300       ldy #1
 310       lda ($5f).y
 320       beq lbl009
 330       ; get this line no. into $14 & $15
 340       iny
 350       lda ($5f).y
 360       sta $14
 370       iny
 380       lda ($5f).y
 390       sta $15
 400       ; copy line to input buffer deleting spaces-except in quotes
 410       ldx #4
 420       stx qflag
 430       lbl005 iny
 440       lda ($5f).y
 450       ; if byte = 0 this is the end of the line so input it
 460       beq lbl007
 470       ; if its a quote then toggle the quotes flag
 480       cmp #34
 490       bne lbl006
 500       lda qflag
 510       eor #$ff
 520       sta qflag
 530       lda #34
 540       ;if the quotflag is set dont delete anything
 550       lbl006 bit qflag
 560       bmi lbl008
 570       ; test for space & delete it if found
 580       cmp #$20
 590       beq lbl005
 600       ;transfer first non-space even if its a rem
 610       cmp #remtok
 620       bne lbl008
 630       cpx #4
 640       bne lbl002
 650       inx
 660       sta $1fb.x
 670       inx
 680       lbl002 dex
 690       lbl007 lda #0
 700       inx
 710       sta $1fb.x
 720       stx $b
 730       jmp $a4a4
 740       lbl008 inx
 750       sta $1fb.x
 760       jmp lbl005
 770       lbl009 lda temp
 780       ldx temp+1
 790       sta $302
 800       stx $303
 810       jmp $a474
 820       temp wrd 0
 830       end

end


