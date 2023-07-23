

;native/fast.asm 
{clr}
 10       prt
 20       sym
 30       org $c057
 40       wrd fast-1.slow-1
 45       org $c4a3
 50       slow ldy #0
 60       byt $2c
 70       fast ldy #4
 80       ldx #0
 90       lbl000 lda $e3af.y
 100       sta $80.x
 110       inx
 120       iny
 130       cpy #$b
 140       bcc lbl000
 150       rts

end


