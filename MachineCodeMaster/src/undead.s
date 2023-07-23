

;native/undead.asm 
{clr}
 10       prt
 20       sym
 30       org $c05d
 40       wrd undead-1
 50       org $c1e3
 60       undead lda #$ff
 70       ldy #1
 80       sta ($2b).y
 90       jsr $a533
 100       lda $22
 110       clc
 120       cld
 130       adc #2
 140       sta $2d
 150       lda $23
 160       adc #0
 170       sta $2e
 180       jmp $a65e
 190       end

end


