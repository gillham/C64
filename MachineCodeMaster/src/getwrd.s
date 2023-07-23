

;native/getwrd.asm 
{clr}
 10       prt
 20       sym
 30       org $c12c
 40       ; routine to get 16 bit unsigned integer from basic into $14 & $15
 50       getwrd jsr $ad8a
 60       jmp $b7f7
 70       end

end


