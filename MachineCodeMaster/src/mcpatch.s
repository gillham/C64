

;native/mcpatch.asm 
{clr}
 10       prt
 20       org $c000
 30       sym
 40       ;----------------------------------
 50       keywrd
 60       ; new function keywords
 70       ; deek
 80       byt 68.69.69.75+128
 90       ; ypos
 100       byt 89.80.79.83+128
 110       ; varptr
 120       byt 86.65.82.80.84.82+128
 130       ;---------------------------------
 140       ; new action keywords
 150       ; doke
 160       byt 68.79.75.69+128
 170       ; rkill
 180       byt 82.75.73.76.76+128
 190       ; delete
 200       byt 68.69.76.69.84.69+128
 210       ; move
 220       byt 77.79.86.69+128
 230       ; fast
 240       byt 70.65.83.84+128
 250       ; slow
 260       byt 83.76.79.87+128
 270       ; plot
 280       byt 80.76.79.84+128
 290       ; undead
 300       byt 85.78.68.69.65.68+128
 310       ; subex
 320       byt 83.85.66.69.88+128
 330       ; bload
 340       byt 66.76.79.65.68+128
 350       ; bverify
 360       byt 66.86.69.82.73.70.89+128
 370       ; bsave
 380       byt 66.83.65.86.69+128
 390       ; fill
 400       byt 70.73.76.76+128
 410       wrd 0
 420       ; this is the end of keyword table chr.
 430       ;--------------------------------
 440       ; new action vectors
 450       actvec
 460       wrd $a830
 470       wrd $a830
 480       wrd $a830
 490       wrd $a830
 500       wrd $a830
 510       wrd $a830
 520       wrd $a830
 530       wrd $a830
 540       wrd $a830
 550       wrd $a830
 560       wrd $a830
 570       wrd $a830
 580       wrd $a830
 590       ;--------------------------------
 600       ; normal is the normal number of basic keywords
 610       normal = 75
 620       ; newact is the number of new action keywords
 630       newact = 13
 640       ; newfun is the number of new function keywords
 650       newfun = 3
 660       ; use by pokeing a7e1 with jmp execute
 670       execut jsr $73
 680       jsr doex
 690       jmp $a7ae
 700       doex beq label
 710       sbc #$80
 720       bcc dolet
 730       cmp #normal+newfun+1
 740       bcc return
 750       cmp #normal+newfun+newact+1
 760       bcs return
 770       ; execute the new action keywords
 780       sbc #normal+newfun
 790       asl a
 800       tay
 810       lda actvec+1.y
 820       pha
 830       lda actvec.y
 840       pha
 850       jmp $73
 860       label rts
 870       dolet jmp $a9a5
 880       return jmp $a7f3
 890       ;--------------------------------
 900       ; print token routine to use poke 774 and 775 with prttok address
 910       prttok jsr putreg
 920       cmp #normal+129
 930       bcc prtnor
 940       ; print the new tokens
 950       lda asave
 960       sbc #normal+1
 970       sta asave
 980       lda #keywrd/256
 990       ldx #keywrd-keywrd/256*256
 1000       jmp lbl000
 1010       ; print normal tokens
 1020       prtnor lda #$a0
 1030       ldx #$9e
 1040       lbl000 sta $a732
 1050       stx $a731
 1060       sta $a73a
 1070       stx $a739
 1080       jsr getreg
 1090       jmp $a71a
 1100       ;-------------------------------
 1110       ; crunch tokens routine extra code
 1120       ; use by altering $a604 to jmp crunch
 1130       crunch jsr putreg
 1140       lda $a5fc
 1150       cmp #$a0
 1160       bne stand
 1170       lda #$c0
 1180       ldx #$00
 1190       jsr tokstr
 1200       jsr getreg
 1210       ldy #0
 1220       jmp $a5b8
 1230       stand lda #$a0
 1240       ldx #$9e
 1250       jsr tokstr
 1260       jsr getreg
 1270       lda $200.x
 1280       jmp $a607
 1290       ;-------------------------------
 1300       getreg lda psave
 1310       pha
 1320       lda asave
 1330       ldx xsave
 1340       ldy ysave
 1350       plp
 1360       rts
 1370       ;-------------------------------
 1380       putreg php
 1390       sta asave
 1400       stx xsave
 1410       sty ysave
 1420       pla
 1430       sta psave
 1440       lda asave
 1450       rts
 1460       ;-------------------------------
 1470       tokstr sta $a5be
 1480       cld
 1490       stx $a5bd
 1500       sta $a601
 1510       stx $a600
 1520       dex
 1530       cpx #$ff
 1540       bne lbl003
 1550       sec
 1560       sbc #1
 1570       lbl003 sta $a5fc
 1580       stx $a5fb
 1590       rts
 1600       ;-------------------------------
 1610       psave
 1620       asave = psave+1
 1630       xsave = asave+1
 1640       ysave = xsave+1

end


