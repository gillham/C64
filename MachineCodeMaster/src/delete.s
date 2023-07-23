

;native/delete.asm 
{clr}
 10       prt
 20       ; block delete of lines
 30       sym
 40       org $c053
 50       wrd del-1
 60       org $c400
 70       getwrd = $c12c
 80       del jsr getwrd
 90       ; convert to address
 100       jsr $a613
 110       bcc ulerr
 120       ; save pointer on stack
 130       lda $5f
 140       pha
 150       lda $60
 160       pha
 170       ; check that a - sign follows
 180       lda #45
 190       jsr $aeff
 200       ; get last no. to be deleted
 210       jsr getwrd
 220       jsr $a613
 230       bcc ulerr
 240       ; get address of end of last line to be deleted
 250       ldy #1
 260       lda ($5f).y
 270       tax
 280       dey
 290       lda ($5f).y
 300       tay
 310       ; now store these bytes in first line to be deleteed
 320       pla
 330       sta $60
 340       pla
 350       sta $5f
 360       tya
 370       ldy #0
 380       sta ($5f).y
 390       iny
 400       txa
 410       sta ($5f).y
 420       ; get line no. to be deleted
 430       iny
 440       lda ($5f).y
 450       sta $14
 460       iny
 470       lda ($5f).y
 480       sta $15
 490       ; put zero into basic input buffer -- tell file ed. to delete line
 500       lda #0
 510       sta $200
 520       ; tidy up return stack
 530       pla
 540       pla
 550       ; use rom routine to delete line
 560       jmp $a4a4
 570       ulerr jmp $a8e3
 580       end

end


