;****************************
; Extension for "Monitor"
; 
; Implements additional commands.
; Currently:
; Inspect memory (display characters)
;    .I A000 A0FF
;
; Read disk error channel:
;    .@
; 
;****************************

; cc65 kernal labels
.include "cbm_kernal.inc"

;
; labels from monitorc and disassembly setup.
;
.include "monext.inc"

    .setcpu "6502x"

; Automatically calculate size.
EXTCMDTABLESIZE = EXTCMDVECTORTABLE - EXTCMDTABLE - 1

;
; This gives ~250 bytes for this demo.
; This can be set to whatever.
; Not currently adjusting any BASIC memory
; variables for this.
;
    .org $8F00

EXTENTRY:
    ; Get the single-letter command arg off stack.
    ; To dispatch with it and so we don't leak stack.
	PLA

EXTHANDLECMD:
    LDX #EXTCMDTABLESIZE
EXTFINDVALIDCMD:
    CMP EXTCMDTABLE,X
    BNE EXTCHECKNEXTCMD
    STA CMDREQUESTED
    TXA
    ASL
    TAX
    LDA EXTCMDVECTORTABLE,X
    STA ZP1STADDR_C1
    LDA EXTCMDVECTORTABLE+1,X
    STA ZP1STADDR_C2
    JMP (ZP1STADDR_C1)
EXTCHECKNEXTCMD:
    DEX
    BPL EXTFINDVALIDCMD
    JMP SYNTAXERROR

;
; Unhandled commands. Added to the table for testing.
; Just echo back the command requested.
;
NOCMD:
    LDA CMDREQUESTED
    JSR INDIRECTCHROUT
    JMP SYNTAXERROR

;
; '@' does disk commands.
; by itself it gets the error channel of the active drive.
; currently that is all we have.
;
DODISK:
    JSR INDIRECTCHRIN
    CMP #$0D ; check for line feed.
    BEQ NOPRINT
    CMP #$20 ; check for space
    BEQ DODISK ; eat spaces?
;    JSR PRINTSPACE
    JSR PRINTHEXBYTE
;    JSR INDIRECTCHROUT ; debug
;    JSR GETARGCMDLINE_C866
;    JSR SAVEVARSDONEC810
    JSR PRINTSPACE

NOPRINT:
    JSR CLALL
    LDA #0
    JSR SETNAM
    LDA #15
    LDX $BA ; last used device
    BNE DRIVESET
    LDX #$08
DRIVESET:
    LDY #15
    JSR SETLFS
    JSR OPEN
    BCS DISKOUT
    LDX #15
    JSR CHKIN
    ; relocate cursor here?
CCLOOP:
    JSR READST
    BNE DISKOUT
    JSR INDIRECTCHRIN
    JSR INDIRECTCHROUT
    JMP CCLOOP
DISKOUT:
    LDA #15
    JSR CLOSE
    JSR CLRCHN
    JSR CLALL

    ; Return to main monitor...
    JMP EARLYEXIT_C25F
    ;JMP DOFULLPROMPT


;
; Inspect shows 32 bytes as characters
; like SSv5 / Code Inspector. Not reversed.
; Continuing scrolling via 'down arrow' doesn't
; work as that is being done in the core monitor's
; irq handler. we might have to patch something.
;
DOINSPECT:
    ;
    ; Gets both address args into C1/C2 & C3/C4
    ; So 'I 1000 10FF' is '00 10 FF 10'
    ;
    JSR GET1STADDRCMDL_C42D

    ; CALCRANGESIZE returns difference in memory addresses
    ; in A & Y as low-byte (A) / high-byte (Y)
    ; So 'I 1000 17FF' returns A:FF Y:07
    ; It seems to calculate wrapped ranges ok.
    ; So 'I FFFF 0000' returns A:01 Y:00
    ; This is really "get length of memory range specified"
    ; GETMEMARGSIZE?
    ;
LOOP:
    LDA #'i'            ; hack
    STA CMDREQUESTED    ; hack
    LDX VAR0167WRAPFLAG          ; incremented when we wrap past $FFFF
    BNE EARLYEXIT
    JSR CALCRANGESIZE
    BCC EARLYEXIT             ; Carry is set until we reach the end of range.
    ; NOT: disabling as we are printing a full line (and it gets NL automatically?)
    JSR PRINTNEWLINE
    JSR INSPECTMEM
    JSR STOP
    BNE LOOP
EARLYEXIT:
    JMP EARLYEXIT_C25F

;
; Inspect memory function.
;

INSPECTMEM:
    LDX  #$2E                         ; Load X with '.' for prompt.
    ;LDA  #$3A                         ; Load A with ':' for prompt.
    LDA  #$27                         ; Load A with "'" (single-quote) for prompt.
    JSR  PRINTTWOCHARS                ; Print ".'" prompt.

; We need to remove this space so we don't use all 40 characters
; Otherwise we get some auto newline or other wrapping in different spots.
; Inspect output looks just slightly different than the other commands as a result.
;    JSR  PRINTSPACE                   
    JSR  PRTADDRHEX_C82D               ; Print memory address in hex.
    JSR  PRINTSPACE                   

    ; We print 32 characters per line. Just barely fits.
    LDY  #$20                         ; Print 32 bytes per line.
    LDX  #$00                         
EXTWC3FB:
    LDA  (ZP1STADDR_C1,x)        ; I/O starting address
    AND  #$7F                         
    CMP  #$20                         
    BCC  EXTWC407                        
    CMP  #$22                         
    BNE  EXTWC409                        
EXTWC407:
    LDA  #$2E                         ; '.' prompt char?
EXTWC409:
    JSR  INDIRECTCHROUT               
    JSR  INCREMENTADDR_C93B            ; increments C1 then C2, then flag stackvar.
    DEY                               
    BNE  EXTWC3FB                        
    RTS

;
; Handle single-quote which is a line of "inspect"
; data.  Currently we do nothing with it.
; We just don't return an error.
DOQUOTE:
    ; We do nothing here.
    JMP DOFULLPROMPT
;
; Data tables.
;
EXTCMDTABLE:
    ; IJKOPUVYZ'@* (lower case in table itself)
    .byte 'i', 'j', 'k', 'o', 'p', 'u'
    .byte 'v', 'y', 'z', "'", '@', '*'

EXTCMDVECTORTABLE:
    .word DOINSPECT, NOCMD, NOCMD, NOCMD
    .word NOCMD, NOCMD, NOCMD, NOCMD
    .word NOCMD, DOQUOTE, DODISK, NOCMD
;
; padding to to vector/signature
;
	.res $8FF8-*

;
; Extension JMP Vector is at $8FF8
; Extension signature it as $8FFA
;
	.org $8FF8
EXTVECT:
    .word EXTENTRY
EXTTEXTMONEXT:
	.byte "monext"
;
; end-of-file
;
