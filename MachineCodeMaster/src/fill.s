

;native/fill.asm 
{clr}
 10       prt
 20       sym
 30       org $c067
 40       wrd fill-1
 50       getwrd = $c12c
 60       mvedwn = $c37f
 70       declen = $c30b
 80       org $c392
 90       fill jsr getwrd
 100       lda $14
 110       pha
 120       lda $15
 130       pha
 140       jsr $aefd
 150       jsr getwrd
 160       lda $14
 170       pha
 180       lda $15
 190       pha
 200       jsr $aefd
 210       jsr getwrd
 220       lda $15
 230       bne iqerr
 240       ldx $14
 250       pla
 260       sta $15
 270       pla
 280       sta $14
 290       pla
 300       sta $62
 310       sta $64
 320       pla
 330       sta $61
 340       sta $63
 350       inc $61
 360       bne lbl000
 370       inc $62
 380       lbl000 ldy #0
 390       txa
 400       sta ($63).y
 410       jsr declen
 420       beq exit
 430       jmp mvedwn
 440       iqerr jmp $b248
 450       exit rts
 460       end

end


