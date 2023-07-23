� 10       PRT 20       SYM 30       QFLAG = $F 40       REMTOK = $8F 50       ASAVE = $C105 60       XSAVE = $C106 70       ORG $C051 80       WRD RKILL-1 90       ORG $C160 100       RKILL LDA #$FF 110       STA $14 120       STA $15 130       ; SAVE PRESENT BASIC WARM START LINK 140       LDA $302 150       LDX $303 160       STA TEMP 170       STX TEMP+1 180       ; PUT NEW WARM START LINK IN 190       LDA #LBL003-LBL003/256*256 200       LDX #LBL003/256 210       STA $302 220       STX $303 230       ; GET NEXT LINE NO TO BE TREATED 240       LBL003 INC $14 250       BNE LBL004 260       INC $15 270       ; USE ROM ROUTINE TO GET ADD OF LINE IN $5F & $60 280       LBL004 JSR $A613 290       ; IF HI LINK BYTE = 0 THEN EXIT 300       LDY #1 310       LDA ($5F).Y 320       BEQ LBL009 330       ; GET THIS LINE NO. INTO $14 & $15 340       INY 350       LDA ($5F).Y 360       STA $14 370       INY 380       LDA ($5F).Y 390       STA $15 400       ; COPY LINE TO INPUT BUFFER DELETING SPACES-EXCEPT IN QUOTES 410       LDX #4 420       STX QFLAG 430       LBL005 INY 440       LDA ($5F).Y 450       ; IF BYTE = 0 THIS IS THE END OF THE LINE SO INPUT IT 460       BEQ LBL007 470       ; IF ITS A QUOTE THEN TOGGLE THE QUOTES FLAG 480       CMP #34 490       BNE LBL006 500       LDA QFLAG 510       EOR #$FF 520       STA QFLAG 530       LDA #34 540       ;IF THE QUOTFLAG IS SET DONT DELETE ANYTHING 550       LBL006 BIT QFLAG 560       BMI LBL008 570       ; TEST FOR SPACE & DELETE IT IF FOUND 580       CMP #$20 590       BEQ LBL005 600       ;TRANSFER FIRST NON-SPACE EVEN IF ITS A REM 610       CMP #REMTOK 620       BNE LBL008 630       CPX #4 640       BNE LBL002 650       INX 660       STA $1FB.X 670       INX 680       LBL002 DEX 690       LBL007 LDA #0 700       INX 710       STA $1FB.X 720       STX $B 730       JMP $A4A4 740       LBL008 INX 750       STA $1FB.X 760       JMP LBL005 770       LBL009 LDA TEMP 780       LDX TEMP+1 790       STA $302 800       STX $303 810       JMP $A474 820       TEMP WRD 0 830       ENDEND