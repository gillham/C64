� 10       PRT 20       SYM 30       ORG $C05D 40       WRD UNDEAD-1 50       ORG $C1E3 60       UNDEAD LDA #$FF 70       LDY #1 80       STA ($2B).Y 90       JSR $A533 100       LDA $22 110       CLC 120       CLD 130       ADC #2 140       STA $2D 150       LDA $23 160       ADC #0 170       STA $2E 180       JMP $A65E 190       ENDEND