� 10       PRT 20       SYM 25       GETWRD = $C12C 30       ORG $C061 40       WRD BLOAD-1.BVER-1 50       ORG $C2F2 60       BVER LDA #1 70       BYT $2C 80       BLOAD LDA #0 90       STA $A 100       JSR $E1D4 110       JSR $AEFD 120       JSR GETWRD 130       LDA $A 140       LDX $14 150       LDY $15 160       JMP $E175 170       ENDEND