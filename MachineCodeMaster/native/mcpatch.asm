� 10       PRT 20       ORG $C000 30       SYM 40       ;---------------------------------- 50       KEYWRD 60       ; NEW FUNCTION KEYWORDS 70       ; DEEK 80       BYT 68.69.69.75+128 90       ; YPOS 100       BYT 89.80.79.83+128 110       ; VARPTR 120       BYT 86.65.82.80.84.82+128 130       ;--------------------------------- 140       ; NEW ACTION KEYWORDS 150       ; DOKE 160       BYT 68.79.75.69+128 170       ; RKILL 180       BYT 82.75.73.76.76+128 190       ; DELETE 200       BYT 68.69.76.69.84.69+128 210       ; MOVE 220       BYT 77.79.86.69+128 230       ; FAST 240       BYT 70.65.83.84+128 250       ; SLOW 260       BYT 83.76.79.87+128 270       ; PLOT 280       BYT 80.76.79.84+128 290       ; UNDEAD 300       BYT 85.78.68.69.65.68+128 310       ; SUBEX 320       BYT 83.85.66.69.88+128 330       ; BLOAD 340       BYT 66.76.79.65.68+128 350       ; BVERIFY 360       BYT 66.86.69.82.73.70.89+128 370       ; BSAVE 380       BYT 66.83.65.86.69+128 390       ; FILL 400       BYT 70.73.76.76+128 410       WRD 0 420       ; THIS IS THE END OF KEYWORD TABLE CHR. 430       ;-------------------------------- 440       ; NEW ACTION VECTORS 450       ACTVEC 460       WRD $A830 470       WRD $A830 480       WRD $A830 490       WRD $A830 500       WRD $A830 510       WRD $A830 520       WRD $A830 530       WRD $A830 540       WRD $A830 550       WRD $A830 560       WRD $A830 570       WRD $A830 580       WRD $A830 590       ;-------------------------------- 600       ; NORMAL IS THE NORMAL NUMBER OF BASIC KEYWORDS 610       NORMAL = 75 620       ; NEWACT IS THE NUMBER OF NEW ACTION KEYWORDS 630       NEWACT = 13 640       ; NEWFUN IS THE NUMBER OF NEW FUNCTION KEYWORDS 650       NEWFUN = 3 660       ; USE BY POKEING A7E1 WITH JMP EXECUTE 670       EXECUT JSR $73 680       JSR DOEX 690       JMP $A7AE 700       DOEX BEQ LABEL 710       SBC #$80 720       BCC DOLET 730       CMP #NORMAL+NEWFUN+1 740       BCC RETURN 750       CMP #NORMAL+NEWFUN+NEWACT+1 760       BCS RETURN 770       ; EXECUTE THE NEW ACTION KEYWORDS 780       SBC #NORMAL+NEWFUN 790       ASL A 800       TAY 810       LDA ACTVEC+1.Y 820       PHA 830       LDA ACTVEC.Y 840       PHA 850       JMP $73 860       LABEL RTS 870       DOLET JMP $A9A5 880       RETURN JMP $A7F3 890       ;-------------------------------- 900       ; PRINT TOKEN ROUTINE TO USE POKE 774 AND 775 WITH PRTTOK ADDRESS 910       PRTTOK JSR PUTREG 920       CMP #NORMAL+129 930       BCC PRTNOR 940       ; PRINT THE NEW TOKENS 950       LDA ASAVE 960       SBC #NORMAL+1 970       STA ASAVE 980       LDA #KEYWRD/256 990       LDX #KEYWRD-KEYWRD/256*256 1000       JMP LBL000 1010       ; PRINT NORMAL TOKENS 1020       PRTNOR LDA #$A0 1030       LDX #$9E 1040       LBL000 STA $A732 1050       STX $A731 1060       STA $A73A 1070       STX $A739 1080       JSR GETREG 1090       JMP $A71A 1100       ;------------------------------- 1110       ; CRUNCH TOKENS ROUTINE EXTRA CODE 1120       ; USE BY ALTERING $A604 TO JMP CRUNCH 1130       CRUNCH JSR PUTREG 1140       LDA $A5FC 1150       CMP #$A0 1160       BNE STAND 1170       LDA #$C0 1180       LDX #$00 1190       JSR TOKSTR 1200       JSR GETREG 1210       LDY #0 1220       JMP $A5B8 1230       STAND LDA #$A0 1240       LDX #$9E 1250       JSR TOKSTR 1260       JSR GETREG 1270       LDA $200.X 1280       JMP $A607 1290       ;------------------------------- 1300       GETREG LDA PSAVE 1310       PHA 1320       LDA ASAVE 1330       LDX XSAVE 1340       LDY YSAVE 1350       PLP 1360       RTS 1370       ;------------------------------- 1380       PUTREG PHP 1390       STA ASAVE 1400       STX XSAVE 1410       STY YSAVE 1420       PLA 1430       STA PSAVE 1440       LDA ASAVE 1450       RTS 1460       ;------------------------------- 1470       TOKSTR STA $A5BE 1480       CLD 1490       STX $A5BD 1500       STA $A601 1510       STX $A600 1520       DEX 1530       CPX #$FF 1540       BNE LBL003 1550       SEC 1560       SBC #1 1570       LBL003 STA $A5FC 1580       STX $A5FB 1590       RTS 1600       ;------------------------------- 1610       PSAVE 1620       ASAVE = PSAVE+1 1630       XSAVE = ASAVE+1 1640       YSAVE = XSAVE+1END