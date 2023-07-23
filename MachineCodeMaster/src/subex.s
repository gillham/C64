

;native/subex.asm 
{clr}
 10       prt
 20       sym
 30       org $c05f
 40       wrd subex-1
 50       org $c1fd
 60       subex lda #$ff
 70       sta $4a
 80       jsr $a38a
 90       txs
 100       cmp #$8d
 110       bne reterr
 120       pla
 130       pla
 140       pla
 150       pla
 160       pla
 170       rts
 180       reterr jmp $abe0
 190       end

end


