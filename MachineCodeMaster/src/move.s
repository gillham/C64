

;native/move.asm 
{clr}
 10       prt
 20       getwrd = $c12c
 30       sym
 40       org $c055
 50       wrd move-1
 60       org $c30b
 70       ; block move of memory - no protection against moving vital sections
 80       ; syntax of command 'move a1.a2.l'
 90       ; where a1 = original address
 100       ;       a2 = fianl address
 110       ;      l  = length of block
 120       ; also note 32k blocks max
 130       newadd = $61
 140       oldadd = newadd+2
 150       length = $14
 160       ; subroutine to decrement & test length
 170       declen lda length
 180       bne lbl000
 190       dec length+1
 200       lbl000 dec length
 210       lda length
 220       ora length+1
 230       rts
 240       ; main routine
 250       move jsr getwrd
 260       lda $14
 270       pha
 280       lda $15
 290       pha
 300       jsr $aefd
 310       jsr getwrd
 320       lda $14
 330       pha
 340       lda $15
 350       pha
 360       jsr $aefd
 370       jsr getwrd
 380       ; decide which direction to move in
 390       ldy #3
 400       lbl001 pla
 410       sta newadd.y
 420       dey
 430       bpl lbl001
 440       lda length
 450       ora length+1
 460       beq lbl002
 470       lda newadd+1
 480       cmp oldadd+1
 490       bcc mvedwn
 500       bne mveup
 510       lda newadd
 520       cmp oldadd
 530       bcc mvedwn
 540       ; move block upwards in memory
 550       mveup cld
 560       clc
 570       lda newadd
 580       adc length
 590       sta newadd
 600       lda newadd+1
 610       adc length+1
 620       sta newadd+1
 630       clc
 640       lda oldadd
 650       adc length
 660       sta oldadd
 670       lda oldadd+1
 680       adc length+1
 690       sta oldadd+1
 700       ldy #0
 710       lbl003 lda (oldadd).y
 720       sta (newadd).y
 730       tya
 740       bne lbl004
 750       dec oldadd+1
 760       dec newadd+1
 770       lbl004 dey
 780       jsr declen
 790       bne lbl003
 800       lbl002 rts
 810       ; move block down the memory
 820       mvedwn ldy #0
 830       lbl005 lda (oldadd).y
 840       sta (newadd).y
 850       iny
 860       bne lbl006
 870       inc oldadd+1
 880       inc newadd+1
 890       lbl006 jsr declen
 900       bne lbl005
 910       rts

end


