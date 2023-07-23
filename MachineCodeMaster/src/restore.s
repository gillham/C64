

;native/restore.asm 
{clr}
 10       prt
 20       sym
 30       org $c132
 40       ; alter to restore line nos.
 50       ; to use transfer rom to ram and alter restore vector to 'start-1'
 60       ; restore vector at $a022
 70       getwrd = $c12c
 80       start lda #0
 90       sta $14
 100       sta $15
 110       jsr $73
 120       lda $7a
 130       bne lbl000
 140       dec $7b
 150       lbl000 dec $7a
 160       bcs lbl001
 170       jsr getwrd
 180       lbl001 jsr $a613
 190       lda $14
 200       ora $15
 210       beq lbl002
 220       bcc ulerr
 230       lbl002 lda $5f
 240       ldy $60
 250       sec
 260       sbc #1
 270       jmp $a824
 280       ulerr jmp $a8e3
 290       end

end


