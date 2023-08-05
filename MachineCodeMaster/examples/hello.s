

;HELLO.ASM 
{clr}
 10       sym
 20       org $8000
 30       chrout = $ffd2
 40       ldx #0
 50       loop lda string.x
 60       cmp #0
 70       beq done
 80       jsr chrout
 90       inx
 100       jmp loop
 110       done rts
 120       string byt 72.69.76.76.79.32
 130       byt 87.79.82.76.68.33.0
 140       end

end


