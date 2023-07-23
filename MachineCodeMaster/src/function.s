

;native/function.asm 
{clr}
 10       prt
 20       sym
 30       org $c44a
 40       ; extend expression evaluator
 50       ; to use poke $afaa with 'jmp funevl'
 60       funevl cpx #$8f
 70       bcc lbl002
 80       cpx #$98
 90       bcc lbl001
 100       cpx #$9f
 110       bcs lbl001
 120       jsr $aef1
 130       pla
 140       tax
 150       cpx #$98
 160       beq deek
 170       cpx #$9a
 180       beq ypos
 190       bne varptr
 200       lbl001 jmp $afb1
 210       lbl002 jmp $afd1
 220       varptr lda 72
 230       ldy 71
 240       lbl003 jsr $b391
 250       lda $66
 260       bpl lbl004
 270       ldy #const/256
 280       lda #const-const/256*256
 290       jsr $ba8c
 300       jsr $b86a
 310       lbl004 jmp $ad8d
 320       ypos sec
 330       jsr $fff0
 340       txa
 350       tay
 360       lda #$0
 370       jmp lbl003
 380       ; perform deek
 390       deek jsr $b7f7
 400       ldy #1
 410       lda ($14).y
 420       pha
 430       dey
 440       lda ($14).y
 450       tay
 460       pla
 470       jmp lbl003
 480       const byt 145.0.0.0.0
 490       end

end


