

;native/plot.asm 
{clr}
 10       prt
 20       sym
 30       getwrd = $c12c
 40       org $c05b
 50       wrd plot-1
 60       org $c3da
 70       plot jsr getwrd
 80       jsr $aefd
 90       lda $15
 100       bne iqerr
 110       lda $14
 120       cmp #25
 130       bcs iqerr
 140       pha
 150       jsr getwrd
 160       pla
 170       tax
 180       lda $15
 190       bne iqerr
 200       ldy $14
 210       cpy #40
 220       bcs iqerr
 230       jmp $fff0
 240       iqerr jmp $b248
 250       end

end


