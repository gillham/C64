

;native/bload.asm 
{clr}
 10       prt
 20       sym
 25       getwrd = $c12c
 30       org $c061
 40       wrd bload-1.bver-1
 50       org $c2f2
 60       bver lda #1
 70       byt $2c
 80       bload lda #0
 90       sta $a
 100       jsr $e1d4
 110       jsr $aefd
 120       jsr getwrd
 130       lda $a
 140       ldx $14
 150       ldy $15
 160       jmp $e175
 170       end

end


