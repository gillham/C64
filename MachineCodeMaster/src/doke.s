

;native/doke.asm 
{clr}
 10       prt
 20       getwrd = $c12c
 30       sym
 40       org $c04f
 50       wrd doke-1
 60       org $c212
 70       doke jsr getwrd
 80       ; check for a comma
 90       jsr $aefd
 100       ; put address on stack while getting the data
 110       lda $14
 120       pha
 130       lda $15
 140       pha
 150       ; get value to be doked
 160       jsr getwrd
 170       ; put address into temporary pointer
 180       ldx $15
 190       ldy $14
 200       pla
 210       sta $15
 220       pla
 230       sta $14
 240       tya
 250       ; use rom routine to set y to zero & put first byte in memory
 260       jsr $b828
 270       iny
 280       txa
 290       sta ($14).y
 300       rts
 310       end

end


