

;native/bsave.asm 
{clr}
 10       prt
 20       getwrd = $c12c
 30       sym
 40       org $c065
 50       wrd bsave-1
 60       org $c234
 70       bsave jsr $e1d4
 80       jsr $aefd
 90       jsr getwrd
 100       lda $14
 110       pha
 120       lda $15
 130       pha
 140       jsr $aefd
 150       jsr getwrd
 160       ldx $14
 170       ldy $15
 180       pla
 190       sta $15
 200       pla
 210       sta $14
 220       lda #$14
 230       jmp $e15f
 240       end

end


