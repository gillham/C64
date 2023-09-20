;****************************
;  JC64dis version 2.6
;  
;  Source in CA65 format
;****************************

      .setcpu "6502x"

W0000 = $00                       
ZPVAR_AE = $AE                    
ZPVAR_AF = $AF                    
ZPVAR_C0 = $C0                    
ZP1STADDR_C1 = $C1                
ZP1STADDR_C2 = $C2                
ZP2NDADDR_C3 = $C3                
ZP2NDADDR_C4 = $C4                
LENKEYBUFF = $C6                  
ZPVAR_CC = $CC                    
ZPVAR_CD = $CD                    
ZPVAR_CE = $CE                    
ZPVAR_CF = $CF                    
STACKVAR_0104 = $0104             
PCLOWSTACKVAR_014E = $014E        
PCHIGHSTACKVAR_014F = $014F       
STACKVAR_0150 = $0150             
STACKVAR_0151 = $0151             
STACKVAR_0152 = $0152             
STACKVAR_0153 = $0153             
SAVESTATUS_0154 = $0154           
STACKVAR_0155 = $0155             
STACKVAR_0156 = $0156             
STACKVAR_0158 = $0158             
STACKVAR_0159 = $0159             
STACKVAR_015A = $015A             
CMDREQUESTED = $015B              
STACKVAR_015C = $015C             
NEGATIVEFLAGVAR = $015D           
STACKVAR_015E = $015E             
STACKVAR_015F = $015F             
STACKVAR_0160 = $0160             
STACKVAR_0161 = $0161             
STACKVAR_0162 = $0162             
STACKVAR_0163 = $0163             
STACKVAR_0164 = $0164             
STACKVAR_0165 = $0165             
STACKVAR_0166 = $0166             
VAR0167WRAPFLAG = $0167           
STACKVAR_0168 = $0168             
STACKVAR_0169 = $0169             
STACKVAR_016A = $016A             
STACKVAR_016B = $016B             
STACKVAR_016C = $016C             
STACKVAR_016D = $016D             
STACKVAR_016E = $016E             
STACKVAR_016F = $016F             
STACKVAR_0170 = $0170             
STACKVAR_0171 = $0171             
STACKVAR_0172 = $0172             
STACKVAR_0173 = $0173             
STACKVAR_0174 = $0174             
STACKVAR_0175 = $0175             
XTRARGSTABLE_0176 = $0176         
STACKVAR_0177 = $0177             
SAVEDVECTORTABLE = $01B0          
TOPBASICMEM = $0283               
HWINTVECT = $0314                 
BRKINTVECT = $0316                
W4DBA = $4DBA                     
W4DC5 = $4DC5                     
W4E4D = $4E4D                     
W4E4F = $4E4F                     
W4F4D = $4F4D                     
MONEXTVECTOR = $8FF8              
MONEXTSIGNATURE = $8FFA           
WBAC5 = $BAC5                     
KCHROUT = $F1CA                   
KCLOSE = $F291                    
KOPEN = $F34A                     
CINT = $FF81                      
IOINIT = $FF84                    
RAMTAS = $FF87                    
RESTOR = $FF8A                    
VECTOR = $FF8D                    
SETMSG = $FF90                    
SECOND = $FF93                    
TKSA = $FF96                      
MEMTOP = $FF99                    
MEMBOT = $FF9C                    
SCNKEY = $FF9F                    
SETTMO = $FFA2                    
ACPTR = $FFA5                     
CIOUT = $FFA8                     
UNTLK = $FFAB                     
UNLSN = $FFAE                     
LISTEN = $FFB1                    
TALK = $FFB4                      
READST = $FFB7                    
SETLFS = $FFBA                    
SETNAM = $FFBD                    
OPEN = $FFC0                      
CLOSE = $FFC3                     
CHKIN = $FFC6                     
CHKOUT = $FFC9                    
CLRCHN = $FFCC                    
CHRIN = $FFCF                     
CHROUT = $FFD2                    
LOAD = $FFD5                      
SAVE = $FFD8                      
SETTIM = $FFDB                    
RDTIM = $FFDE                     
STOP = $FFE1                      
GETIN = $FFE4                     
CLALL = $FFE7                     
UDTIM = $FFEA                     
SCREEN = $FFED                    
PLOT = $FFF0                      
IOBASE = $FFF3                    

      .org $C000

ENTRY:
      jmp  START                        ; Normal SYS 49152 entry point.

WARMSTARTMAYBE:
      jmp  UPDPCSTACKVAR                ; SYS 49155 entry point.  Warm start?

INDIRECTCHRIN:
      jmp  CHRIN                        ; Call KERNAL CHRIN.

INDIRECTCHROUT:
      jmp  CHROUT                       ; Call KERNAL CHROUT.

START:
      sei                               
      jsr  SETCOLORS                    
      ldx  #$03                         ; Saving two vectors, two bytes each.
SAVEVECTORS:
      lda  HWINTVECT,x                  ; Vector: Hardware Interrupt (IRQ)
      sta  SAVEDVECTORTABLE,x           ; CPU stack
      dex                               
      bpl  SAVEVECTORS                  
      lda  BRKHNDRADD                   
      ldx  BRKHNDRADD+1                 
      sta  BRKINTVECT                   ; Vector: Break Interrupt
      stx  $0317                        ; Vector: Break Interrupt
      lda  HWINTVECT                    ; Vector: Hardware Interrupt (IRQ)
      ldx  $0315                        ; Vector: Hardware Interrupt (IRQ)
      cmp  IRQHNDRADD                   
      bne  SETUPIRQVECTOR               
      cpx  IRQHNDRADD+1                 
      beq  ADJUSTBASICMEMTOP            
SETUPIRQVECTOR:
      sta  STACKVAR_0171                ; CPU stack
      stx  STACKVAR_0172                ; CPU stack
      lda  IRQHNDRADD                   
      ldx  IRQHNDRADD+1                 
      sta  HWINTVECT                    ; Vector: Hardware Interrupt (IRQ)
      stx  $0315                        ; Vector: Hardware Interrupt (IRQ)
ADJUSTBASICMEMTOP:
      lda  LOADADD                      
      ldx  LOADADD+1                    
      cpx  #$A0                         ; Check if we are loaded to $A000 not $C000
      bcs  INITVARS                     
      sta  TOPBASICMEM                  ; Pointer: Memory top for  Operative System
      stx  $0284                        ; Pointer: Memory top for  Operative System
INITVARS:
      lda  #$10                         
      sta  STACKVAR_0158                ; CPU stack
      sta  STACKVAR_0159                ; CPU stack
      lda  #$00                         
      sta  STACKVAR_015F                ; CPU stack
      sta  STACKVAR_015A                ; CPU stack
      sta  STACKVAR_0175                ; CPU stack
      cli                               ; We are all setup, clear interrupts.
      brk                               ; Generate a BRK to engage our handler.
UPDPCSTACKVAR:
      sec                               
      lda  PCHIGHSTACKVAR_014F          ; CPU stack
      sbc  #$01                         
      sta  PCHIGHSTACKVAR_014F          ; CPU stack
      lda  PCLOWSTACKVAR_014E           ; CPU stack
      sbc  #$00                         
      sta  PCLOWSTACKVAR_014E           ; CPU stack
      jsr  PRINTNEWLINE                 
      ldx  #$42                         ; Load X with 'B'
PRINTBSTAR:
      lda  #$2A                         ; Load A with '*'.
      jsr  PRINTTWOCHARS                ; Print X & A.
      lda  #$52                         ; Load A with 'R' (Registers command)
      bne  HANDLECMD                    ; Print initial Registers when entering Monitor.
SYNTAXERROR:
      lda  #$3F                         ; Load A with '?', used to indicate syntax errors.
      jsr  INDIRECTCHROUT               
DOFULLPROMPT:
      jsr  PRINTNEWLINE                 
PRINTDOTPROMPT:
      lda  #$2E                         ; Print the period '.' prompt.
      jsr  INDIRECTCHROUT               
      lda  #$00                         
      sta  VAR0167WRAPFLAG              ; CPU stack
      sta  STACKVAR_0175                ; CPU stack
      ldx  #$FF                         
      txs                               
GETCMD:
      jsr  CHRINPRINTNEWLINE            
      cmp  #$2E                         ; Skip over '.' prompt.
      beq  GETCMD                       
      cmp  #$20                         ; Skip over any spaces.
      beq  GETCMD                       
HANDLECMD:
      ldx  #$17                         ; $17 is the size of the CMDTABLE
FINDVALIDCMD:
      cmp  CMDTABLE,x                   
      bne  CHECKNEXTCMD                 
      sta  CMDREQUESTED                 ; CPU stack
      txa                               ; Transfer X to A
      asl                               ; Multiple A times 2.
      tax                               ; Transfer A back to X as an index into a vector table.
      lda  CMDVECTORTABLE,x             ; Load low byte
      sta  ZP1STADDR_C1                 ; Store low byte to C1
      lda  CMDVECTORTABLE+1,x           ; Load high byte.
      sta  ZP1STADDR_C2                 ; Store high byte to C2.
      jmp  (ZP1STADDR_C1)               ; Jump to the function pointed to by C1/C2

CHECKNEXTCMD:
      dex                               
      bpl  FINDVALIDCMD                 
      pha                               ; Push cmd to stack as no internal command found.
      ldx  #$05                         ; Will be checking 6 bytes ("MONEXT")
CHECKFORMONEXT:
      lda  MONEXTSIGNATURE,x            ; Look at extension location for signature.
      cmp  TEXTMONEXT,x                 
      bne  UNKNOWNCMD                   ; No extension installed so command is unknown.
      dex                               
      bpl  CHECKFORMONEXT               ; Look for next character in signature.
      jmp  (MONEXTVECTOR)               ; There must be an extension so call it.

UNKNOWNCMD:
      pla                               
      jmp  SYNTAXERROR                  

DECC1C2OFFSET02:
      ldx  #$02                         
      bne  DOC1C2DEC                    
DECC1C2OFFSET00:
      ldx  #$00                         
DOC1C2DEC:
      ldy  ZP1STADDR_C1,x               ; I/O starting address
      bne  DECC1ONLY                    
      ldy  ZP1STADDR_C2,x               ; I/O starting address
      bne  DECBOTH_C1C2                 
      inc  VAR0167WRAPFLAG              ; CPU stack
DECBOTH_C1C2:
      dec  ZP1STADDR_C2,x               ; I/O starting address
DECC1ONLY:
      dec  ZP1STADDR_C1,x               ; I/O starting address
      rts                               

PRTSOMETHING_C0F8:
      lda  #$00                         
      sta  STACKVAR_0161                ; CPU stack
      jsr  PRTDISLINE_C264              
PRINT8SPACES_C100:
      ldx  #$09                         
LOOP_C102:
      jsr  PRINTSPACE                   
      dex                               
      bne  LOOP_C102                    
      rts                               

SWPZPSTACKVARS_C109:
      ldx  #$02                         
LOOP_C10B:
      lda  ZPVAR_C0,x                   ; Stop motor of tape
      pha                               
      lda  STACKVAR_0164,x              ; CPU stack
      sta  ZPVAR_C0,x                   ; Stop motor of tape
      pla                               
      sta  STACKVAR_0164,x              ; CPU stack
      dex                               
      bne  LOOP_C10B                    
      rts                               

CALCRANGESIZE_C11B:
      lda  STACKVAR_0165                ; CPU stack
      ldy  STACKVAR_0166                ; CPU stack
      jmp  CALCRANGESIZE2               

CALCRANGESIZE:
      lda  ZP2NDADDR_C3                 ; Transient tape load
      ldy  ZP2NDADDR_C4                 ; Transient tape load
CALCRANGESIZE2:
      sec                               
      sbc  ZP1STADDR_C1                 ; I/O starting address
      sta  STACKVAR_0164                ; CPU stack
      tya                               
      sbc  ZP1STADDR_C2                 ; I/O starting address
      tay                               
      ora  STACKVAR_0164                ; CPU stack
      rts                               

CMDCOMPARE:
      lda  #$00                         
      beq  DOCMDTRNSFCMP_C13C           
CMDTRANSFER:
      lda  #$01                         
DOCMDTRNSFCMP_C13C:
      sta  STACKVAR_0168                ; CPU stack
      jsr  PARSEMORESTUFF_C7FA          
      jsr  PRINTNEWLINE                 
      jsr  CALCRANGESIZE                
      jsr  MAYBESWPVARS_C856            
      bcc  DOC3C4ADJUST_C168            
DOTRNSSTUFF_C14D:
      jsr  CALCRANGESIZE_C11B           
      bcs  DOC3C4INCRMT_C155            
      jmp  RETURNTOPROMPT_C1DA          

DOC3C4INCRMT_C155:
      jsr  LOOKTHRUMEMRY_C190           
      inc  ZP2NDADDR_C3                 ; Transient tape load
      bne  DOSTCKHIADJST_C15E           
      inc  ZP2NDADDR_C4                 ; Transient tape load
DOSTCKHIADJST_C15E:
      jsr  INCREMENTADDR_C93B           
      ldy  VAR0167WRAPFLAG              ; CPU stack
      bne  RETURNTOPROMPT_C1AB          
      beq  DOTRNSSTUFF_C14D             
DOC3C4ADJUST_C168:
      jsr  CALCRANGESIZE_C11B           
      clc                               
      lda  STACKVAR_0164                ; CPU stack
      adc  ZP2NDADDR_C3                 ; Transient tape load
      sta  ZP2NDADDR_C3                 ; Transient tape load
      tya                               
      adc  ZP2NDADDR_C4                 ; Transient tape load
      sta  ZP2NDADDR_C4                 ; Transient tape load
      jsr  SWPZPSTACKVARS_C109          
LOOP_C17B:
      jsr  LOOKTHRUMEMRY_C190           
      jsr  CALCRANGESIZE_C11B           
      bcs  RETURNTOPROMPT_C1DA          
      jsr  DECC1C2OFFSET02              
      jsr  DECC1C2OFFSET00              
      ldy  VAR0167WRAPFLAG              ; CPU stack
      bne  RETURNTOPROMPT_C1AB          
      beq  LOOP_C17B                    
LOOKTHRUMEMRY_C190:
      ldx  #$00                         
      lda  (ZP1STADDR_C1,x)             ; I/O starting address
      ldy  STACKVAR_0168                ; CPU stack
      beq  COMPAREONLYSTA_C19B          
      sta  (ZP2NDADDR_C3,x)             ; Transient tape load
COMPAREONLYSTA_C19B:
      cmp  (ZP2NDADDR_C3,x)             ; Transient tape load
      beq  DONERTS_C1AA                 
PRTOUTPTRTS_C19F:
      jsr  PRTADDRHEX_C82D              
      jsr  PRINTSPACE                   
      jsr  STOP                         ; Routine: Terminate the keyboard scan
      beq  RETURNTOPROMPT_C1AB          
DONERTS_C1AA:
      rts                               

RETURNTOPROMPT_C1AB:
      jmp  DOFULLPROMPT                 

CMDFILL:
      jsr  PARSECMDLINE_C815            
      jsr  GET2NDADDRCMD_C81F           
      jsr  CHRINPRINTNEWLINE            
      jsr  PARSEARGHEXBYTE              
      bcc  CMDFILLSNTXERR_C1D7          
      sta  STACKVAR_015E                ; CPU stack
LOOP_C1BF:
      ldx  VAR0167WRAPFLAG              ; CPU stack
      bne  RETURNTOPROMPT_C1DA          
      jsr  CALCRANGESIZE                
      bcc  RETURNTOPROMPT_C1DA          
      lda  STACKVAR_015E                ; CPU stack
      sta  (ZP1STADDR_C1,x)             ; I/O starting address
      cmp  (ZP1STADDR_C1,x)             ; I/O starting address
      bne  CMDFILLSNTXERR_C1D7          
      jsr  INCREMENTADDR_C93B           
      bne  LOOP_C1BF                    
CMDFILLSNTXERR_C1D7:
      jmp  SYNTAXERROR                  

RETURNTOPROMPT_C1DA:
      jmp  DOFULLPROMPT                 

CMDHUNT:
      jsr  PARSECMDLINE_C815            
      jsr  GET2NDADDRCMD_C81F           
      jsr  CHRINPRINTNEWLINE            
      ldx  #$00                         
      jsr  CHRINPRINTNEWLINE            
      cmp  #$27                         
      bne  HUNTHEXVALUES_C203           
      jsr  CHRINPRINTNEWLINE            
LOOPOVERSTRING_C1F2:
      sta  XTRARGSTABLE_0176,x          ; CPU stack
      inx                               
      jsr  INDIRECTCHRIN                
      cmp  #$0D                         
      beq  MAYBEDOHUNT_C21F             
      cpx  #$20                         
      bne  LOOPOVERSTRING_C1F2          
      beq  MAYBEDOHUNT_C21F             
HUNTHEXVALUES_C203:
      stx  STACKVAR_016A                ; CPU stack
      jsr  PARSEMOREARGS_C891           
      bcc  CMDFILLSNTXERR_C1D7          
LOOPVALUES_C20B:
      sta  XTRARGSTABLE_0176,x          ; CPU stack
      inx                               
      jsr  INDIRECTCHRIN                
      cmp  #$0D                         
      beq  MAYBEDOHUNT_C21F             
      jsr  PARSEARGHEXBYTE              
      bcc  CMDFILLSNTXERR_C1D7          
      cpx  #$20                         
      bne  LOOPVALUES_C20B              
MAYBEDOHUNT_C21F:
      stx  STACKVAR_015C                ; CPU stack
      jsr  PRINTNEWLINE                 
LOOP_C225:
      ldx  #$00                         
      ldy  #$00                         
LOOP_C229:
      lda  (ZP1STADDR_C1),y             ; I/O starting address
      cmp  XTRARGSTABLE_0176,x          ; CPU stack
      bne  MAYBEKEEPLOOK_C23A           
      iny                               
      inx                               
      cpx  STACKVAR_015C                ; CPU stack
      bne  LOOP_C229                    
      jsr  PRTOUTPTRTS_C19F             
MAYBEKEEPLOOK_C23A:
      jsr  INCREMENTADDR_C93B           
      ldy  VAR0167WRAPFLAG              ; CPU stack
      bne  FINISHPRTNL_C247             
      jsr  CALCRANGESIZE                
      bcs  LOOP_C225                    
FINISHPRTNL_C247:
      jmp  DOFULLPROMPT                 

CMDDISASSEMBLE:
      jsr  GET1STADDRCMDL_C42D          
LOOP_C24D:
      jsr  CALCRANGESIZE                
      bcc  EARLYEXIT_C25F               
      ldy  #$2C                         ; Load Y with ',' for printing.
      jsr  PRTSOMETHING_C0F8            
      jsr  MAYBADJBYINSTRSIZE           
      jsr  STOP                         ; Routine: Terminate the keyboard scan
      bne  LOOP_C24D                    
EARLYEXIT_C25F:
      jsr  PRINTCURSORUP                
      bne  FINISHPRTNL_C247             
PRTDISLINE_C264:
      jsr  PRTYNLPRMPT_C947             
DISPRTHEX_C267:
      jsr  PRTADDRHEX_C82D              
      jsr  PRINTSPACE                   
      jsr  MAYBPATCHDIS_CBEF            
      pha                               
      jsr  DISFUNCTNNOT_C320            
      pla                               
DISREADDATA_C275:
      jsr  DISREADDATA_C337             
      ldx  #$06                         
DISREAD3DIGIT_C27A:
      cpx  #$03                         
      bne  DISREADDATA_C292             
      ldy  STACKVAR_0160                ; CPU stack
      beq  DISREADDATA_C292             
LOOP_C283:
      lda  STACKVAR_0169                ; CPU stack
      cmp  #$E8                         
      lda  (ZP1STADDR_C1),y             ; I/O starting address
      bcs  DISMAYBPRT_C2A9              
      jsr  DISPRTHEXRTS_C2B6            
      dey                               
      bne  LOOP_C283                    
DISREADDATA_C292:
      asl  STACKVAR_0169                ; CPU stack
      bcc  DISDONEREADDTA_C2A5          
      lda  INSNMODEPUNCT1,x             
      jsr  DISPRTAMAYBE_C5A1            
      lda  INSNMODEPUNCT2,x             
      beq  DISDONEREADDTA_C2A5          
      jsr  DISPRTAMAYBE_C5A1            
DISDONEREADDTA_C2A5:
      dex                               
      bne  DISREAD3DIGIT_C27A           
      rts                               

DISMAYBPRT_C2A9:
      jsr  WC2CC                        
      tax                               
      inx                               
      bne  DISPRTYA_C2B1                
      iny                               
DISPRTYA_C2B1:
      tya                               
      jsr  DISPRTHEXRTS_C2B6            
      txa                               
DISPRTHEXRTS_C2B6:
      stx  STACKVAR_015C                ; CPU stack
      jsr  PRINTHEXBYTE                 
      ldx  STACKVAR_015C                ; CPU stack
      rts                               

MAYBADJBYINSTRSIZE:
      lda  STACKVAR_0160                ; CPU stack
MAYBEGETNEXTADDR:
      jsr  WC2CB                        
      sta  ZP1STADDR_C1                 ; I/O starting address
      sty  ZP1STADDR_C2                 ; I/O starting address
      rts                               

WC2CB:
      sec                               
WC2CC:
      ldy  ZP1STADDR_C2                 ; I/O starting address
      tax                               
      bpl  WC2D2                        
      dey                               
WC2D2:
      adc  ZP1STADDR_C1                 ; I/O starting address
      bcc  DONE_C2D7                    
      iny                               
DONE_C2D7:
      rts                               

WC2D8:
      tay                               
      lsr                               
      bcc  WC2E7                        
      lsr                               
      bcs  WC2F6                        
      cmp  #$22                         
      beq  WC2F6                        
      and  #$07                         
      ora  #$80                         
WC2E7:
      lsr                               
      tax                               
      lda  MODE,x                       
      bcs  WC2F2                        
      lsr                               
      lsr                               
      lsr                               
      lsr                               
WC2F2:
      and  #$0F                         
      bne  WC2FA                        
WC2F6:
      ldy  #$80                         
      lda  #$00                         
WC2FA:
      tax                               
      lda  MODE2,x                      
      sta  STACKVAR_0169                ; CPU stack
      and  #$03                         
      sta  STACKVAR_0160                ; CPU stack
      tya                               
      and  #$8F                         
      tax                               
      tya                               
      ldy  #$03                         
      cpx  #$8A                         
      beq  WC31C                        
WC311:
      lsr                               
      bcc  WC31C                        
      lsr                               
WC315:
      lsr                               
      ora  #$20                         
      dey                               
      bne  WC315                        
      iny                               
WC31C:
      dey                               
      bne  WC311                        
      rts                               

DISFUNCTNNOT_C320:
      lda  (ZP1STADDR_C1),y             ; I/O starting address
      jsr  DISPRTHEXRTS_C2B6            
      ldx  #$01                         
DISLOOP_C327:
      jsr  LOOP_C102                    
      cpy  STACKVAR_0160                ; CPU stack
      iny                               
      bcc  DISFUNCTNNOT_C320            
      ldx  #$03                         
      cpy  #$03                         
      bcc  DISLOOP_C327                 
      rts                               

DISREADDATA_C337:
      tay                               
      lda  MNEML,y                      
      sta  STACKVAR_0165                ; CPU stack
      lda  MNEMR,y                      
      sta  STACKVAR_0166                ; CPU stack
DISLOOP_C344:
      lda  #$00                         
      ldy  #$05                         
DISLOOP_C348:
      asl  STACKVAR_0166                ; CPU stack
      rol  STACKVAR_0165                ; CPU stack
      rol                               
      dey                               
      bne  DISLOOP_C348                 
      adc  #$3F                         
      jsr  INDIRECTCHROUT               
      dex                               
      bne  DISLOOP_C344                 
      jmp  PRINTSPACE                   

CMDCOMMA:
      jsr  PARSECMDLINE_C815            
      lda  #$03                         
      jsr  WC3AE                        
      ldy  #$2C                         
      jmp  WC544                        

BRKZEROEMPTY_C36A:
      brk                               
      brk                               
      brk                               
      brk                               
      brk                               
      brk                               
      brk                               
      brk                               
      brk                               
      brk                               
      brk                               
      brk                               
      brk                               
      brk                               
      brk                               
      brk                               
      brk                               
      brk                               
      brk                               
      brk                               
      brk                               
      brk                               
      brk                               
      brk                               
CALLIRQHANDLER:
      lda  ZPVAR_CC                     ; Flash state: 0=flashing
      bne  WC38F                        
      ldx  #$01                         
      lda  ZPVAR_CF                     ; Flag: Last cursore state (Flash/fixed)
      beq  WC38D                        
      inx                               
WC38D:
      stx  ZPVAR_CD                     ; Timer: countdown for cursor changing
WC38F:
      lda  $028C                        ; Repeat delay counter
      beq  WC397                        
      dec  $028C                        ; Repeat delay counter
WC397:
      dec  $028B                        ; Repeat velocity counter
      bne  WC39F                        
      inc  $028B                        ; Repeat velocity counter
WC39F:
      lda  IRQHND2ADDRVECT+1            
      pha                               
      lda  IRQHND2ADDRVECT              
      pha                               
      php                               
      pha                               
      pha                               
      pha                               
      jmp  (STACKVAR_0171)              ; CPU stack

WC3AE:
      sta  STACKVAR_015E                ; CPU stack
      pha                               
WC3B2:
      jsr  CHRINPRINTNEWLINE            
      jsr  WC919                        
      bne  WC3B2                        
      pla                               
WC3BB:
      eor  #$FF                         
      jmp  MAYBEGETNEXTADDR             

CMDMEMORY:
      jsr  GET1STADDRCMDL_C42D          
LOOP_C3C3:
      ldx  VAR0167WRAPFLAG              ; CPU stack
      bne  WC3D5                        
      jsr  CALCRANGESIZE                
      bcc  WC3D5                        
      jsr  NEWLINEMEMDUMP_C3D8          
      jsr  STOP                         ; Routine: Terminate the keyboard scan
      bne  LOOP_C3C3                    
WC3D5:
      jmp  EARLYEXIT_C25F               

NEWLINEMEMDUMP_C3D8:
      jsr  PRINTNEWLINE                 
DUMPMEMLINE_C3DB:
      ldx  #$2E                         ; Load X with '.' for prompt.
      lda  #$3A                         ; Load A with ':' for prompt.
      jsr  PRINTTWOCHARS                ; Print '.:' prompt.
      jsr  PRINTSPACE                   
      jsr  PRTADDRHEX_C82D              ; Print memory address in hex.
      lda  #$08                         ; We want 8 bytes.
      jsr  PRINTSPACEHEXBYTE            ; Print 8 bytes as hex digits.
      lda  #$08                         
      jsr  WC3BB                        
      lda  #$12                         
      jsr  INDIRECTCHROUT               
      ldy  #$08                         
      ldx  #$00                         
WC3FB:
      lda  (ZP1STADDR_C1,x)             ; I/O starting address
      and  #$7F                         
      cmp  #$20                         
      bcc  WC407                        
      cmp  #$22                         
      bne  WC409                        
WC407:
      lda  #$2E                         
WC409:
      jsr  INDIRECTCHROUT               
      jsr  INCREMENTADDR_C93B           
      dey                               
      bne  WC3FB                        
REVERSEOFF:
      lda  #$92                         
      jmp  INDIRECTCHROUT               

CMDCOLON:
      jsr  PARSECMDLINE_C815            
      lda  #$08                         
      jsr  WC3AE                        
      jsr  PRINTCURSORUP                
      jsr  NEWLINEMEMDUMP_C3D8          
      lda  #$3A                         ; Load A with ':'
ADDKEYBOARDBUFFER:
      sta  $0277                        ; Keyboard buffer queue (FIFO)
      jmp  PUTADDRKEYBOARDBUFF          

GET1STADDRCMDL_C42D:
      jsr  PARSECMDLINE_C815            
      sta  ZP2NDADDR_C3                 ; Transient tape load
      stx  ZP2NDADDR_C4                 ; Transient tape load
      jsr  INDIRECTCHRIN                
      cmp  #$0D                         
      beq  WC43E                        
      jsr  WC81A                        
WC43E:
      jmp  PRINTNEWLINE                 

CMDASSEMBLE:
      jsr  GETARGCMDLINE_C866           
      sta  ZP2NDADDR_C3                 ; Transient tape load
      stx  ZP2NDADDR_C4                 ; Transient tape load
LOOPSKIPSPACE_C448:
      ldx  #$00                         
      stx  STACKVAR_0177                ; CPU stack
LOOPNEXTCHAR_C44D:
      jsr  CHRINPRINTNEWLINE            
      cmp  #$20                         
      beq  LOOPSKIPSPACE_C448           
      sta  STACKVAR_0162,x              ; CPU stack
      inx                               
      cpx  #$03                         
      bne  LOOPNEXTCHAR_C44D            
WC45C:
      dex                               
      bmi  WC473                        
      lda  STACKVAR_0162,x              ; CPU stack
      sec                               
      sbc  #$3F                         
      ldy  #$05                         
WC467:
      lsr                               
      ror  STACKVAR_0177                ; CPU stack
      ror  XTRARGSTABLE_0176            ; CPU stack
      dey                               
      bne  WC467                        
      beq  WC45C                        
WC473:
      ldx  #$02                         
GETDIGITS_C475:
      jsr  INDIRECTCHRIN                
      cmp  #$0D                         
      beq  PROCESSLINE_C49E             
      cmp  #$3A                         
      beq  PROCESSLINE_C49E             
      cmp  #$20                         
      beq  GETDIGITS_C475               
      jsr  VALIDHEXDIGIT_C598           
      bcs  WC498                        
      jsr  CONVHEXDIGIT_C89E            
      ldy  ZP1STADDR_C1                 ; I/O starting address
      sty  ZP1STADDR_C2                 ; I/O starting address
      sta  ZP1STADDR_C1                 ; I/O starting address
      lda  #$30                         
      sta  XTRARGSTABLE_0176,x          ; CPU stack
      inx                               
WC498:
      sta  XTRARGSTABLE_0176,x          ; CPU stack
      inx                               
      bne  GETDIGITS_C475               
PROCESSLINE_C49E:
      stx  STACKVAR_0165                ; CPU stack
      ldx  #$00                         
      stx  VAR0167WRAPFLAG              ; CPU stack
LOOKUPOPCODE_C4A6:
      ldx  #$00                         
      stx  STACKVAR_015E                ; CPU stack
      lda  VAR0167WRAPFLAG              ; CPU stack
      jsr  WC2D8                        
      ldx  STACKVAR_0169                ; CPU stack
      stx  STACKVAR_0166                ; CPU stack
      tax                               
      lda  MNEMR,x                      
      jsr  MAYBPRSOPCODE_C578           
      lda  MNEML,x                      
      jsr  MAYBPRSOPCODE_C578           
      ldx  #$06                         
WC4C6:
      cpx  #$03                         
      bne  WC4DE                        
      ldy  STACKVAR_0160                ; CPU stack
      beq  WC4DE                        
WC4CF:
      lda  STACKVAR_0169                ; CPU stack
      cmp  #$E8                         
      lda  #$30                         
      bcs  WC4F6                        
      jsr  MAYBDBLPARSE_C575            
      dey                               
      bne  WC4CF                        
WC4DE:
      asl  STACKVAR_0169                ; CPU stack
      bcc  WC4F1                        
      lda  INSNMODEPUNCT1,x             
      jsr  MAYBPRSOPCODE_C578           
      lda  INSNMODEPUNCT2,x             
      beq  WC4F1                        
      jsr  MAYBPRSOPCODE_C578           
WC4F1:
      dex                               
      bne  WC4C6                        
      beq  WC4FC                        
WC4F6:
      jsr  MAYBDBLPARSE_C575            
      jsr  MAYBDBLPARSE_C575            
WC4FC:
      lda  STACKVAR_0165                ; CPU stack
      cmp  STACKVAR_015E                ; CPU stack
      beq  WC507                        
      jmp  WC585                        

WC507:
      jsr  MAYBESWPVARS_C856            
      ldy  STACKVAR_0160                ; CPU stack
      beq  WC53D                        
      lda  STACKVAR_0166                ; CPU stack
      cmp  #$9D                         
      bne  WC535                        
      jsr  CALCRANGESIZE                
      bcc  WC525                        
      tya                               
      bne  SYNTAXERROR_C58D             
      ldx  STACKVAR_0164                ; CPU stack
      bmi  SYNTAXERROR_C58D             
      bpl  WC52D                        
WC525:
      iny                               
      bne  SYNTAXERROR_C58D             
      ldx  STACKVAR_0164                ; CPU stack
      bpl  SYNTAXERROR_C58D             
WC52D:
      dex                               
      dex                               
      txa                               
      ldy  STACKVAR_0160                ; CPU stack
      bne  WC538                        
WC535:
      lda  ZP1STADDR_C2,y               ; I/O starting address
WC538:
      sta  (ZP1STADDR_C1),y             ; I/O starting address
      dey                               
      bne  WC535                        
WC53D:
      lda  VAR0167WRAPFLAG              ; CPU stack
      sta  (ZP1STADDR_C1),y             ; I/O starting address
      ldy  #$41                         
WC544:
      sty  $0277                        ; Keyboard buffer queue (FIFO)
      jsr  PRINTCURSORUP                
      jsr  PRTSOMETHING_C0F8            
      jsr  MAYBADJBYINSTRSIZE           
PUTADDRKEYBOARDBUFF:
      lda  #$20                         
      sta  $0278                        ; Keyboard buffer queue (FIFO)
      sta  $027D                        ; Keyboard buffer queue (FIFO)
      lda  ZP1STADDR_C2                 ; I/O starting address
      jsr  GENHEX_C5AC                  
      stx  $0279                        ; Keyboard buffer queue (FIFO)
      sta  $027A                        ; Keyboard buffer queue (FIFO)
      lda  ZP1STADDR_C1                 ; I/O starting address
      jsr  GENHEX_C5AC                  
      stx  $027B                        ; Keyboard buffer queue (FIFO)
      sta  $027C                        ; Keyboard buffer queue (FIFO)
      lda  #$07                         
      sta  LENKEYBUFF                   ; Number of char in keyboard buffer
      jmp  DOFULLPROMPT                 

MAYBDBLPARSE_C575:
      jsr  MAYBPRSOPCODE_C578           
MAYBPRSOPCODE_C578:
      stx  STACKVAR_015C                ; CPU stack
      ldx  STACKVAR_015E                ; CPU stack
      cmp  XTRARGSTABLE_0176,x          ; CPU stack
      beq  WC590                        
      pla                               
      pla                               
WC585:
      inc  VAR0167WRAPFLAG              ; CPU stack
      beq  SYNTAXERROR_C58D             
      jmp  LOOKUPOPCODE_C4A6            

SYNTAXERROR_C58D:
      jmp  SYNTAXERROR                  

WC590:
      inx                               
      stx  STACKVAR_015E                ; CPU stack
      ldx  STACKVAR_015C                ; CPU stack
      rts                               

VALIDHEXDIGIT_C598:
      cmp  #$30                         
      bcc  NOTVALIDHEX_C59F             
      cmp  #$47                         
      rts                               

NOTVALIDHEX_C59F:
      sec                               
      rts                               

DISPRTAMAYBE_C5A1:
      cmp  STACKVAR_0161                ; CPU stack
      bne  JMPINDIRECTCHROUT            
      rts                               

PRINTCURSORUP:
      lda  #$91                         
JMPINDIRECTCHROUT:
      jmp  INDIRECTCHROUT               

GENHEX_C5AC:
      pha                               
      lsr                               
      lsr                               
      lsr                               
      lsr                               
      jsr  GENHEXDIGIT_C84C             
      tax                               
      pla                               
      and  #$0F                         
WC5B8:
      jmp  GENHEXDIGIT_C84C             

FUNCTVECT:
      sta  STACKVAR_0151                ; CPU stack
      php                               
      pla                               
      and  #$EF                         
      sta  STACKVAR_0150                ; CPU stack
      stx  STACKVAR_0152                ; CPU stack
      sty  STACKVAR_0153                ; CPU stack
      pla                               
      clc                               
      adc  #$01                         
      sta  PCHIGHSTACKVAR_014F          ; CPU stack
      pla                               
      adc  #$00                         
      sta  PCLOWSTACKVAR_014E           ; CPU stack
      lda  #$80                         
      sta  STACKVAR_015A                ; CPU stack
      bne  IRQREADCIA_C612              
BRKHANDLER:
      lda  $DC0D                        ; Read CIA #1
      and  #$02                         ; Check if bit #1 is set. Timer B underflow.
      bne  SETUPVIC_C5F1                ; If bit #1 is set call setup vic.
      tsx                               
      lda  STACKVAR_0104,x              ; CPU stack/Tape error/Floating conversion area
      and  #$10                         
      bne  SETUPVIC_C5F1                
      jmp  BRKZEROEMPTY_C36A            ; Jump to a BRK instruction, triggering the BRK handler.

SETUPVIC_C5F1:
      lda  $D011                        ; Read the VIC control register
      ora  #$10                         ; Enable bit 4 (turn on screen?)
      sta  $D011                        ; Store back in the VIC control register.
      cld                               
      pla                               
      sta  STACKVAR_0153                ; CPU stack
      pla                               
      sta  STACKVAR_0152                ; CPU stack
      pla                               
      sta  STACKVAR_0151                ; CPU stack
      pla                               
      sta  STACKVAR_0150                ; CPU stack
      pla                               
      sta  PCHIGHSTACKVAR_014F          ; CPU stack
      pla                               
      sta  PCLOWSTACKVAR_014E           ; CPU stack
IRQREADCIA_C612:
      lda  HWINTVECT                    ; Vector: Hardware Interrupt (IRQ)
      sta  STACKVAR_0156                ; CPU stack
      lda  $0315                        ; Vector: Hardware Interrupt (IRQ)
      sta  STACKVAR_0155                ; CPU stack
      tsx                               
      stx  SAVESTATUS_0154              ; CPU stack
      jsr  WC8E4                        
      lda  $DC0D                        ; Read CIA #1 IRQ to clear FLAGs.
      cli                               
      lda  STACKVAR_0150                ; CPU stack
      and  #$10                         
      beq  WC633                        
WC630:
      jmp  UPDPCSTACKVAR                

WC633:
      bit  STACKVAR_015A                ; CPU stack
      bvc  WC657                        
      lda  PCLOWSTACKVAR_014E           ; CPU stack
      cmp  STACKVAR_016C                ; CPU stack
      bne  MAYBCHECKTIMERB              
      lda  PCHIGHSTACKVAR_014F          ; CPU stack
      cmp  STACKVAR_016B                ; CPU stack
      bne  MAYBCHECKTIMERB              
      lda  STACKVAR_016F                ; CPU stack
      bne  DECSTACKVAR016F              
      lda  STACKVAR_0170                ; CPU stack
      bne  DECSTACKVAR0170              
      lda  #$80                         
      sta  STACKVAR_015A                ; CPU stack
WC657:
      bmi  WC66D                        
      lsr  STACKVAR_015A                ; CPU stack
      bcc  WC630                        
      ldx  SAVESTATUS_0154              ; CPU stack
      txs                               
      lda  TEXTMONEXT-1                 
      pha                               
      lda  FUNCVECTADDR                 
      pha                               
      jmp  MAYBRESTRPCREGRTI            

WC66D:
      jsr  PRINTNEWLINE                 
      jsr  PUT0151INC1C2ZPVAR           
      sta  STACKVAR_015E                ; CPU stack
      ldy  #$00                         
      jsr  PRINTONEHEXBYTE              
      jsr  REGPRTFLAGS_C99C             
      lda  PCHIGHSTACKVAR_014F          ; CPU stack
      ldx  PCLOWSTACKVAR_014E           ; CPU stack
      sta  ZP1STADDR_C1                 ; I/O starting address
      stx  ZP1STADDR_C2                 ; I/O starting address
      jsr  PRINTSPACE                   
      jsr  PRTDISLINE_CCEF              
LOOPWAITGETIN:
      jsr  GETIN                        ; Routine: Take the char from keyboard buffer
      beq  LOOPWAITGETIN                
      cmp  #$03                         ; Compare to STOP char.
      bne  STEPCHECKFORJ                ; If not STOP keep checking.
      jmp  DOFULLPROMPT                 ; Jump back to normal mode.

STEPCHECKFORJ:
      cmp  #$4A                         ; Compare to 'J' key for JMP to tracepoint and continue.
      bne  MAYBENABLETIMERB             ; Any other key keep stepping.
      lda  #$01                         ; This should be saying "jump to PC and keep going"
      sta  STACKVAR_015A                ; CPU stack
      bne  MAYBENABLETIMERB             
DECSTACKVAR0170:
      dec  STACKVAR_0170                ; CPU stack
DECSTACKVAR016F:
      dec  STACKVAR_016F                ; CPU stack
MAYBCHECKTIMERB:
      lda  $DC01                        ; Data port B #1: keyboard, joystick, paddle
      and  #$80                         ; Check for bit 7 timer b toggle/impulse
      bne  MAYBENABLETIMERB             
      ldx  #$53                         ; Is this an 'S' here?
      jmp  PRINTBSTAR                   

CMDGO:
      lda  #$00                         
      beq  WC6CD                        
CMDQUICKTRACE:
      lda  STACKVAR_016D                ; CPU stack
      ldx  STACKVAR_016E                ; CPU stack
      sta  STACKVAR_016F                ; CPU stack
      stx  STACKVAR_0170                ; CPU stack
      lda  #$40                         
      bne  WC6CD                        
CMDWALK:
      lda  #$80                         
WC6CD:
      sta  STACKVAR_015A                ; Save A as requested op GO/QTRACE/WALK
      jsr  INDIRECTCHRIN                
      cmp  #$0D                         ; Check for newline / enter key?
      beq  WC6E8                        
      cmp  #$20                         ; Check for space.
      bne  SYNTAXERROR_C74D             
      jsr  PARSEMORECMDLN_C87A          
      jsr  SAVEAXREG_C8FC               
      jsr  INDIRECTCHRIN                
      cmp  #$0D                         
      bne  SYNTAXERROR_C74D             
WC6E8:
      jsr  PRTREGTXT                    
      lda  STACKVAR_015A                ; Load requested op.
      beq  MAYBRESTRIRQRTI              ; If 0 the op is GO.
MAYBENABLETIMERB:
      sei                               
      lda  $D011                        ; VIC control register
      and  #$EF                         ; Turn off bit 4. Disable screen?
      sta  $D011                        ; VIC control register
LOOPRASTERWAIT:
      lda  $D012                        ; Read current raster line.
      cmp  #$FF                         ; Look for raster line 255.
      bne  LOOPRASTERWAIT               ; Busy loop for raster line 255.
      lda  #$82                         ; Enables timer B underflow interrupt.  Bit 7 fill bit set to 1
      sta  $DC0D                        ; Interrupt control register CIA #1
      lda  $DC0D                        ; Interrupt control register CIA #1
      lda  BRKHNDRADD                   
      ldx  BRKHNDRADD+1                 
      sta  STACKVAR_0156                ; CPU stack
      stx  STACKVAR_0155                ; CPU stack
      lda  #$3D                         
      ldx  #$00                         
      sta  $DC06                        ; Timer B #1: Lo Byte
      stx  $DC07                        ; Timer B #1: Hi Byte
      lda  $DC0F                        ; Control register B of CIA #1
      ora  #$81                         ; Start timer bit 1 set, bit 7 alarm something?
      sta  $DC0F                        ; Control register B of CIA #1
MAYBRESTRIRQRTI:
      ldx  SAVESTATUS_0154              ; CPU stack
      txs                               
      sei                               
      lda  STACKVAR_0155                ; CPU stack
      sta  $0315                        ; Vector: Hardware Interrupt (IRQ)
      lda  STACKVAR_0156                ; CPU stack
      sta  HWINTVECT                    ; Vector: Hardware Interrupt (IRQ)
MAYBRESTRPCREGRTI:
      lda  PCLOWSTACKVAR_014E           ; CPU stack
      pha                               
      lda  PCHIGHSTACKVAR_014F          ; CPU stack
      pha                               
      lda  STACKVAR_0150                ; CPU stack
      pha                               
      lda  STACKVAR_0151                ; CPU stack
      ldx  STACKVAR_0152                ; CPU stack
      ldy  STACKVAR_0153                ; CPU stack
      rti                               

SYNTAXERROR_C74D:
      jmp  SYNTAXERROR                  

CMDBREAK:
      jsr  GETARGCMDLINE_C866           
      sta  STACKVAR_016B                ; CPU stack
      stx  STACKVAR_016C                ; CPU stack
      lda  #$00                         
      sta  STACKVAR_016D                ; CPU stack
      sta  STACKVAR_016E                ; CPU stack
      jsr  GETMORECMDLIN2_C877          
      sta  STACKVAR_016D                ; CPU stack
      stx  STACKVAR_016E                ; CPU stack
      jmp  DOFULLPROMPT                 

CMDNNOTSURE:
      jsr  PARSEMORESTUFF_C7FA          
      sta  STACKVAR_0173                ; CPU stack
      stx  STACKVAR_0174                ; CPU stack
      jsr  GETMORECMDLIN2_C877          
      sta  STACKVAR_0162                ; CPU stack
      stx  STACKVAR_0163                ; CPU stack
      jsr  GETMORECMDLIN2_C877          
      sta  ZPVAR_AE                     ; Addresses of Tape end/Program end
      stx  ZPVAR_AF                     ; Addresses of Tape end/Program end
      jsr  INDIRECTCHRIN                
      cmp  #$0D                         
      beq  MAYBEPRCSSLINE_C797          
      jsr  INDIRECTCHRIN                
      cmp  #$57                         
      bne  MAYBEPRCSSLINE_C797          
      inc  STACKVAR_0161                ; CPU stack
MAYBEPRCSSLINE_C797:
      jsr  MAYBESWPVARS_C856            
WC79A:
      ldx  VAR0167WRAPFLAG              ; CPU stack
      bne  WC7B7                        
      jsr  CALCRANGESIZE_C11B           
      bcc  WC7B7                        
      ldy  STACKVAR_0161                ; CPU stack
      bne  WC7C3                        
      lda  (ZP1STADDR_C1),y             ; I/O starting address
      jsr  WC2D8                        
      tax                               
      lda  MNEML,x                      
      bne  WC7BA                        
      jsr  PRTSOMETHING_C0F8            
WC7B7:
      jmp  DOFULLPROMPT                 

WC7BA:
      ldy  STACKVAR_0160                ; CPU stack
      cpy  #$02                         
      bne  LOOPC7F2                     
      beq  WC7C6                        
WC7C3:
      sty  STACKVAR_0160                ; CPU stack
WC7C6:
      dey                               
      sec                               
      lda  (ZP1STADDR_C1),y             ; I/O starting address
      tax                               
      sbc  STACKVAR_0162                ; CPU stack
      iny                               
      lda  (ZP1STADDR_C1),y             ; I/O starting address
      sbc  STACKVAR_0163                ; CPU stack
      bcc  LOOPC7F2                     
      dey                               
      lda  ZPVAR_AE                     ; Addresses of Tape end/Program end
      sbc  (ZP1STADDR_C1),y             ; I/O starting address
      iny                               
      lda  ZPVAR_AF                     ; Addresses of Tape end/Program end
      sbc  (ZP1STADDR_C1),y             ; I/O starting address
      bcc  LOOPC7F2                     
      dey                               
      clc                               
      txa                               
      adc  STACKVAR_0173                ; CPU stack
      sta  (ZP1STADDR_C1),y             ; I/O starting address
      iny                               
      lda  (ZP1STADDR_C1),y             ; I/O starting address
      adc  STACKVAR_0174                ; CPU stack
      sta  (ZP1STADDR_C1),y             ; I/O starting address
LOOPC7F2:
      jsr  INCREMENTADDR_C93B           
      dey                               
      bpl  LOOPC7F2                     
      bmi  WC79A                        
PARSEMORESTUFF_C7FA:
      jsr  GETARGCMDLINE_C866           
      sta  ZP2NDADDR_C3                 ; Transient tape load
      stx  ZP2NDADDR_C4                 ; Transient tape load
      jsr  GETMORECMDLIN2_C877          
      sta  STACKVAR_0165                ; CPU stack
      stx  STACKVAR_0166                ; CPU stack
      jsr  CHRINPRINTNEWLINE            
WC80D:
      jsr  PARSEMORECMDLN_C87A          
SAVEVARSDONE_C810:
      sta  ZP1STADDR_C1                 ; I/O starting address
      stx  ZP1STADDR_C2                 ; I/O starting address
      rts                               

PARSECMDLINE_C815:
      jsr  GETARGCMDLINE_C866           
      bcs  SAVEVARSDONE_C810            
WC81A:
      jsr  PARSEMORECMDLN_C87A          
      bcs  SAVE2NDADDRVAR_C822          
GET2NDADDRCMD_C81F:
      jsr  GETMORECMDLIN2_C877          
SAVE2NDADDRVAR_C822:
      sta  ZP2NDADDR_C3                 ; Transient tape load
      stx  ZP2NDADDR_C4                 ; Transient tape load
      rts                               

      jsr  SWPZPSTACKVARS_C109          
      jmp  GETMORECMDLIN2_C877          

PRTADDRHEX_C82D:
      lda  ZP1STADDR_C2                 ; I/O starting address
      jsr  PRINTHEXBYTE                 
      lda  ZP1STADDR_C1                 ; I/O starting address
PRINTHEXBYTE:
      pha                               
      lsr                               
      lsr                               
      lsr                               
      lsr                               
      jsr  GENHEXDIGIT_C84C             
      tax                               
      pla                               
      and  #$0F                         
      jsr  GENHEXDIGIT_C84C             
PRINTTWOCHARS:
      pha                               
      txa                               
      jsr  INDIRECTCHROUT               
      pla                               
      jmp  INDIRECTCHROUT               

GENHEXDIGIT_C84C:
      clc                               
      adc  #$F6                         
      bcc  NUMERICDIGIT_C853            
      adc  #$06                         
NUMERICDIGIT_C853:
      adc  #$3A                         
      rts                               

MAYBESWPVARS_C856:
      ldx  #$02                         
LOOP_C858:
      lda  ZPVAR_C0,x                   ; Stop motor of tape
      pha                               
      lda  ZP1STADDR_C2,x               ; I/O starting address
      sta  ZPVAR_C0,x                   ; Stop motor of tape
      pla                               
      sta  ZP1STADDR_C2,x               ; I/O starting address
      dex                               
      bne  LOOP_C858                    
      rts                               

GETARGCMDLINE_C866:
      lda  #$00                         
      sta  STACKVAR_016A                ; CPU stack
LOOPGETCHR_C86B:
      jsr  CHRINPRINTNEWLINE            
      cmp  #$20                         
      beq  LOOPGETCHR_C86B              
      jsr  CONVHEXDIGIT_C89E            
      bcs  WC87F                        
GETMORECMDLIN2_C877:
      jsr  CHRINPRINTNEWLINE            
PARSEMORECMDLN_C87A:
      jsr  PARSEARGHEXBYTE              
      bcc  SYNTAXERROR_C886             
WC87F:
      tax                               
      jsr  PARSEARGHEXBYTE              
      bcc  SYNTAXERROR_C886             
      rts                               

SYNTAXERROR_C886:
      jmp  SYNTAXERROR                  

PARSEARGHEXBYTE:
      lda  #$00                         
      sta  STACKVAR_016A                ; CPU stack
      jsr  CHRINPRINTNEWLINE            
PARSEMOREARGS_C891:
      cmp  #$20                         
      bne  CONVHEXDIGIT_C89E            
      jsr  CHRINPRINTNEWLINE            
      cmp  #$20                         
      bne  WC8AB                        
      clc                               
      rts                               

CONVHEXDIGIT_C89E:
      jsr  MAYBELOW4BITS_C8B3           
      asl                               
      asl                               
      asl                               
      asl                               
      sta  STACKVAR_016A                ; CPU stack
      jsr  CHRINPRINTNEWLINE            
WC8AB:
      jsr  MAYBELOW4BITS_C8B3           
      ora  STACKVAR_016A                ; CPU stack
      sec                               
      rts                               

MAYBELOW4BITS_C8B3:
      cmp  #$3A                         
      php                               
      and  #$0F                         
      plp                               
      bcc  DONE_C8BD                    
      adc  #$08                         
DONE_C8BD:
      rts                               

CHRINPRINTNEWLINE:
      jsr  INDIRECTCHRIN                
      cmp  #$0D                         
      bne  DONE_C8BD                    
      jmp  DOFULLPROMPT                 

WC8C8:
      jsr  WC8D3                        
      lda  $DC0D                        ; Interrupt control register CIA #1
      and  #$01                         
      beq  WC8C8                        
      rts                               

WC8D3:
      jsr  STOP                         ; Routine: Terminate the keyboard scan
      bne  WC8E3                        
      jsr  WC8E4                        
      lda  #$03                         
      sta  $9A                          ; Output device (CMD=3)
      lda  #$00                         
      sta  $99                          ; Input device (default=0)
WC8E3:
      rts                               

WC8E4:
      php                               
      sei                               
      lda  $DC0D                        ; Interrupt control register CIA #1
      and  #$81                         
      sta  $DC0D                        ; Interrupt control register CIA #1
      lda  IRQHNDRADD                   
      sta  HWINTVECT                    ; Vector: Hardware Interrupt (IRQ)
      lda  IRQHNDRADD+1                 
      sta  $0315                        ; Vector: Hardware Interrupt (IRQ)
      plp                               
      rts                               

SAVEAXREG_C8FC:
      sta  PCHIGHSTACKVAR_014F          ; CPU stack
      stx  PCLOWSTACKVAR_014E           ; CPU stack
      rts                               

PRINTSPACEHEXBYTE:
      sta  STACKVAR_015E                ; Save # of bytes requested to print.
      ldy  #$00                         ; Set Y to 0 index.
PRINTSPACENEXTBYTE:
      jsr  PRINTSPACE                   
PRINTONEHEXBYTE:
      lda  (ZP1STADDR_C1),y             ; I/O starting address
      jsr  PRINTHEXBYTE                 
      jsr  INCREMENTADDR_C93B           ; We increment address not Y index.
      dec  STACKVAR_015E                ; Decrement # of bytes requested.
      bne  PRINTSPACENEXTBYTE           
      rts                               

WC919:
      jsr  PARSEARGHEXBYTE              
      bcc  ARGHEXFOUNDSPACE             ; Carry clear if we found a space?
      ldx  #$00                         
      sta  (ZP1STADDR_C1,x)             ; I/O starting address
      cmp  (ZP1STADDR_C1,x)             ; I/O starting address
      beq  ARGHEXFOUNDSPACE             ; Isn't this always true?  We STA/CMP the same spot above?
      jmp  SYNTAXERROR                  ; Unreachable code? VICE monitor never hit?

ARGHEXFOUNDSPACE:
      jsr  INCREMENTADDR_C93B           
      dec  STACKVAR_015E                ; CPU stack
      rts                               

PUT0151INC1C2ZPVAR:
      lda  #$51                         
      sta  ZP1STADDR_C1                 ; I/O starting address
      lda  #$01                         
      sta  ZP1STADDR_C2                 ; I/O starting address
      lda  #$04                         
      rts                               

INCREMENTADDR_C93B:
      inc  ZP1STADDR_C1                 ; Increment low byte.
      bne  DONE_C946                    ; If it didn't wrap around to zero, we are done.
      inc  ZP1STADDR_C2                 ; Otherwise increment high byte.
      bne  DONE_C946                    ; If it didn't wrap to zero we are done.
      inc  VAR0167WRAPFLAG              ; Otherwise increment this byte???
DONE_C946:
      rts                               

PRTYNLPRMPT_C947:
      tya                               
      pha                               
      jsr  PRINTNEWLINE                 
      pla                               
WC94D:
      ldx  #$2E                         ; Load X with '.' for printing.
      jsr  PRINTTWOCHARS                
      jmp  PRINTSPACE                   

      jsr  PRINTSPACE                   ; Unused / unreachable code?
PRINTSPACE:
      lda  #$20                         
PRINTCHAR:                              ; BIT hack to skip C95B LDA #$0D
      .byte $2C
PRINTNEWLINE:
      lda  #$0D                         
      jmp  INDIRECTCHROUT               

CMDREGISTERS:
      ldx  #$00                         
PRTREGISTERS:
      lda  TEXTCMDREGISTERS,x           
      jsr  INDIRECTCHROUT               
      inx                               
      cpx  #$22                         
      bne  PRTREGISTERS                 
      ldy  #$3B                         
      jsr  PRTYNLPRMPT_C947             
      lda  PCLOWSTACKVAR_014E           ; CPU stack
      jsr  PRINTHEXBYTE                 
      lda  PCHIGHSTACKVAR_014F          ; CPU stack
      jsr  PRINTHEXBYTE                 
      jsr  PRINTSPACE                   
      lda  $0319                        ; Vector: Not maskerable Interrupt (NMI)
      jsr  PRINTHEXBYTE                 
      lda  $0318                        ; Vector: Not maskerable Interrupt (NMI)
      jsr  PRINTHEXBYTE                 
      jsr  PUT0151INC1C2ZPVAR           
      jsr  PRINTSPACEHEXBYTE            
      jsr  REGPRTFLAGS_C99C             
JMPPRINTNEWLINE:
      jmp  DOFULLPROMPT                 

      jmp  SYNTAXERROR                  

REGPRTFLAGS_C99C:
      jsr  PRINTSPACE                   
      lda  #$08                         
      sta  STACKVAR_015E                ; CPU stack
      lda  STACKVAR_0150                ; CPU stack
PRINTBITSDOTSTAR:
      rol                               
      pha                               
      lda  #$2A                         
      bcs  WC9AF                        
      lda  #$2E                         
WC9AF:
      jsr  INDIRECTCHROUT               
      pla                               
      dec  STACKVAR_015E                ; CPU stack
      bne  PRINTBITSDOTSTAR             
      rts                               

      nop                               
      nop                               
      nop                               
      nop                               
CMDSEMICOLON:
      jsr  GETARGCMDLINE_C866           
      jsr  SAVEAXREG_C8FC               
      jsr  GETMORECMDLIN2_C877          
      sta  STACKVAR_0156                ; CPU stack
      stx  STACKVAR_0155                ; CPU stack
      jsr  PUT0151INC1C2ZPVAR           
      sta  STACKVAR_015E                ; CPU stack
LOOP_C9D2:
      jsr  CHRINPRINTNEWLINE            
      jsr  WC919                        
      bne  LOOP_C9D2                    
      jsr  CHRINPRINTNEWLINE            
      lda  #$08                         ; We want to read 8 bytes for status register bits.
      sta  STACKVAR_015E                ; Save to our count variable.
READSTATUSDOTSTAR:
      pha                               
      jsr  CHRINPRINTNEWLINE            
      cmp  #$2A                         ; Compare to '*' for set bits.
      bne  STATUSBITNOTSET              ; Case of '.' or unset bit.
      sec                               ; Set carry for guaranteed branch.
      bcs  STATUSBITSET                 ; Branch based on carry we just set.
STATUSBITNOTSET:
      clc                               
STATUSBITSET:
      pla                               
      rol                               ; Rotate in carry bit from '.' and '*' comparisons.
      dec  STACKVAR_015E                ; Decrement for each bit we set.
      bne  READSTATUSDOTSTAR            ; Check for more bits to process.
      sta  STACKVAR_0150                ; Store our finished byte.
      jmp  JMPPRINTNEWLINE              

CMDEXIT:
      sei                               
      ldx  #$01                         
RESTOREVECTORS:
      lda  SAVEDVECTORTABLE,x           ; CPU stack
      sta  HWINTVECT,x                  ; Vector: Hardware Interrupt (IRQ)
      dex                               
      bpl  RESTOREVECTORS               
      cli                               
      ldx  SAVESTATUS_0154              ; CPU stack
      txs                               
      jmp  ($A002)                      ; Routine Vector: close canal, start up

WCA0F:
      jmp  SYNTAXERROR                  

CMDLOADSAVE:
      lda  #$01                         
      ldx  #$08                         
      ldy  #$FF                         
      jsr  SETLFS                       ; Routine: Set primary, secondary and logical addresses
      ldy  #$00                         
      sty  $B7                          ; Length of current file name
      sty  $90                          ; Statusbyte ST of I/O KERNAL
      lda  #$01                         
      sta  $BC                          ; Pointer: current file name
      lda  #$76                         
      sta  $BB                          ; Pointer: current file name
WCA29:
      jsr  INDIRECTCHRIN                
      cmp  #$20                         
      beq  WCA29                        
      cmp  #$0D                         
      beq  WCA4E                        
      cmp  #$22                         
WCA36:
      bne  WCA0F                        
WCA38:
      jsr  INDIRECTCHRIN                
      cmp  #$22                         
      beq  WCA66                        
      cmp  #$0D                         
      beq  WCA4E                        
      sta  ($BB),y                      ; Pointer: current file name
      inc  $B7                          ; Length of current file name
      iny                               
      cpy  #$10                         
WCA4A:
      beq  WCA0F                        
      bne  WCA38                        
WCA4E:
      lda  CMDREQUESTED                 ; CPU stack
      cmp  #$4C                         
WCA53:
      bne  WCA36                        
      lda  #$00                         
      jsr  LOAD                         ; Routine: Load the Ram from a device
      jsr  WC8C8                        
      lda  $90                          ; Statusbyte ST of I/O KERNAL
      and  #$10                         
WCA61:
      bne  WCA53                        
      jmp  DOFULLPROMPT                 

WCA66:
      jsr  INDIRECTCHRIN                
      cmp  #$0D                         
      beq  WCA4E                        
      cmp  #$2C                         
WCA6F:
      bne  WCA61                        
      jsr  PARSEARGHEXBYTE              
      and  #$0F                         
WCA76:
      beq  WCA4A                        
      cmp  #$03                         
      beq  WCA76                        
      sta  $BA                          ; Current device number
      jsr  INDIRECTCHRIN                
      cmp  #$0D                         
      beq  WCA4E                        
      cmp  #$2C                         
WCA87:
      bne  WCA6F                        
      jsr  WC80D                        
      jsr  INDIRECTCHRIN                
      cmp  #$2C                         
WCA91:
      bne  WCA87                        
      jsr  PARSEMORECMDLN_C87A          
      sta  ZPVAR_AE                     ; Addresses of Tape end/Program end
      stx  ZPVAR_AF                     ; Addresses of Tape end/Program end
WCA9A:
      jsr  INDIRECTCHRIN                
      cmp  #$20                         
      beq  WCA9A                        
      cmp  #$0D                         
WCAA3:
      bne  WCA91                        
      lda  CMDREQUESTED                 ; CPU stack
      cmp  #$53                         
      bne  WCAA3                        
      lda  #$C1                         
      ldx  ZPVAR_AE                     ; Addresses of Tape end/Program end
      ldy  ZPVAR_AF                     ; Addresses of Tape end/Program end
      jsr  SAVE                         ; Routine: Save the Ram to a device
      jmp  DOFULLPROMPT                 

IRQHANDLER:
      sei                               
      lda  STACKVAR_0175                ; CPU stack
      bne  RESETKEYBOARDBUFF            
      lda  LENKEYBUFF                   ; Number of char in keyboard buffer
      bne  KEYHANDLER                   
RESETKEYBOARDBUFF:
      lda  #$00                         
      sta  LENKEYBUFF                   ; Number of char in keyboard buffer
      nop                               
      nop                               
      nop                               
      nop                               
      nop                               
RESTOREREGISTERSRTI:
      pla                               
      tay                               
      pla                               
      tax                               
      pla                               
      rti                               

KEYHANDLER:
      lda  $0277                        ; Keyboard buffer queue (FIFO)
      cmp  #$11                         ; Check for cursor down.
      bne  WCB41                        
      lda  $D6                          ; Cursor line number
      cmp  #$18                         ; Check for screen line/row $18 (24, 25th row?)
      bne  RESTOREREGISTERSRTI          
      lda  $D1                          ; Pointer: current screen line address
      sta  ZP2NDADDR_C3                 ; Transient tape load
      lda  $D2                          ; Pointer: current screen line address
      sta  ZP2NDADDR_C4                 ; Transient tape load
      lda  #$19                         ; 25 (rows on screen?)
      sta  STACKVAR_016F                ; CPU stack
LOOPCAEB:
      ldy  #$01                         
      jsr  MYBCHECKMEMCMD_CD85          
      cmp  #$3A                         ; Compare with ':' colon.
      beq  MAYBHANDLEBOTH               
      cmp  #$2C                         ; Compare with ',' comma.
      beq  MAYBHANDLECOMMA              
      dec  STACKVAR_016F                ; CPU stack
      beq  RESTOREREGISTERSRTI          
      sec                               
      lda  ZP2NDADDR_C3                 ; Transient tape load
      sbc  #$28                         ; Subtract 40 for one row of screen?
      sta  ZP2NDADDR_C3                 ; Transient tape load
      bcs  LOOPCAEB                     
      dec  ZP2NDADDR_C4                 ; Transient tape load
      bne  LOOPCAEB                     
MAYBHANDLECOMMA:
      sta  CMDREQUESTED                 ; CPU stack
MAYBHANDLEBOTH:
      jsr  MAYBEFINDLEFTPAREN           
      bcs  RESTOREREGISTERSRTI          
      jsr  GETNEXTSPRITECHAR            
      cmp  #$3A                         ; Check for ':' colon.
      bne  DODISASSEMBLELINE            
      clc                               
      lda  ZP1STADDR_C1                 ; I/O starting address
      adc  #$08                         
      sta  ZP1STADDR_C1                 ; I/O starting address
      bcc  MEMDUMPRETURN                
      inc  ZP1STADDR_C2                 ; I/O starting address
MEMDUMPRETURN:
      jsr  NEWLINEMEMDUMP_C3D8          
      jmp  RESETKEYBUFFRETURN           

DODISASSEMBLELINE:
      jsr  MAYBPATCHDIS_CBEF            
      jsr  MAYBADJBYINSTRSIZE           
      lda  #$00                         
      sta  STACKVAR_0161                ; CPU stack
      ldy  #$2C                         ; Load Y with ',' for printing.
      jsr  PRTDISLINE_C264              
RESETKEYBUFFRETURN:
      lda  #$00                         
      sta  LENKEYBUFF                   ; Number of char in keyboard buffer
      jmp  EARLYEXIT_C25F               

WCB41:
      cmp  #$91                         ; Check for cursor up.
      bne  RESTOREREGISTERSRTI          ; If not cursor up, exit handler.
      lda  $D6                          ; Cursor line number
      bne  RESTOREREGISTERSRTI          ; If the cursor is not on line 0 we are done?
      lda  $D1                          ; Pointer: current screen line address
      sta  ZP2NDADDR_C3                 ; Transient tape load
      lda  $D2                          ; Pointer: current screen line address
      sta  ZP2NDADDR_C4                 ; Transient tape load
      lda  #$19                         
      sta  STACKVAR_016F                ; CPU stack
WCB56:
      ldy  #$01                         
      jsr  MYBCHECKMEMCMD_CD85          
      cmp  #$3A                         ; Compare to ':' memory line.
      beq  WCB78                        
      cmp  #$2C                         ; Compare to ',' (disassembly line)
      beq  WCB75                        
      dec  STACKVAR_016F                ; CPU stack
      beq  JMPTOEXITRTI                 
      clc                               
      lda  ZP2NDADDR_C3                 ; Transient tape load
      adc  #$28                         
      sta  ZP2NDADDR_C3                 ; Transient tape load
      bcc  WCB56                        
      inc  ZP2NDADDR_C4                 ; Transient tape load
      bne  WCB56                        
WCB75:
      sta  CMDREQUESTED                 ; CPU stack
WCB78:
      jsr  MAYBEFINDLEFTPAREN           ; Handle left '(' maybe?
      bcc  WCB80                        
JMPTOEXITRTI:
      jmp  RESTOREREGISTERSRTI          

WCB80:
      jsr  SCROLLGETNEXTSPRCHR          
      cmp  #$3A                         ; Compare to ':' colon memory op
      beq  WCB89                        
      bne  WCBA4                        
WCB89:
      jsr  MAYBESCROLLSCREEN            
      sec                               
      lda  ZP1STADDR_C1                 ; I/O starting address
      sbc  #$08                         
      sta  ZP1STADDR_C1                 ; I/O starting address
      bcs  WCB97                        
      dec  ZP1STADDR_C2                 ; I/O starting address
WCB97:
      jsr  DUMPMEMLINE_C3DB             
CLRKEYBHOMEPROMPT:
      lda  #$00                         ; Reset keyboard buffer
      sta  LENKEYBUFF                   ; Reset keyboard buffer
      jsr  PRINTHOME                    
      jmp  PRINTDOTPROMPT               

WCBA4:
      jsr  MAYBESCROLLSCREEN            
      lda  ZP1STADDR_C1                 ; I/O starting address
      ldx  ZP1STADDR_C2                 ; I/O starting address
      sta  ZP2NDADDR_C3                 ; Transient tape load
      stx  ZP2NDADDR_C4                 ; Transient tape load
      lda  #$10                         
      sta  STACKVAR_016F                ; CPU stack
WCBB4:
      sec                               
      lda  ZP2NDADDR_C3                 ; Transient tape load
      sbc  STACKVAR_016F                ; CPU stack
      sta  ZP1STADDR_C1                 ; I/O starting address
      lda  ZP2NDADDR_C4                 ; Transient tape load
      sbc  #$00                         
      sta  ZP1STADDR_C2                 ; I/O starting address
WCBC2:
      jsr  MAYBPATCHDIS_CBEF            
      jsr  MAYBADJBYINSTRSIZE           
      jsr  CALCRANGESIZE                
      beq  WCBD4                        
      bcs  WCBC2                        
      dec  STACKVAR_016F                ; CPU stack
      bne  WCBB4                        
WCBD4:
      inc  STACKVAR_0160                ; CPU stack
      lda  STACKVAR_0160                ; CPU stack
      jsr  WC3BB                        
      ldx  #$00                         
      lda  (ZP1STADDR_C1,x)             ; I/O starting address
      stx  STACKVAR_0161                ; CPU stack
      lda  #$2C                         
      jsr  WC94D                        
      jsr  DISPRTHEX_C267               
      jmp  CLRKEYBHOMEPROMPT            

MAYBPATCHDIS_CBEF:
      ldx  #$00                         
      lda  (ZP1STADDR_C1,x)             ; I/O starting address
      jmp  WC2D8                        

CMDDOLLAR:
      jsr  GETARGCMDLINE_C866           
      jsr  SAVEVARSDONE_C810            
      inc  $D3                          ; Column of cursor on the current line
      lda  #$3D                         
      jsr  INDIRECTCHROUT               
      jsr  HEXTODEC_CCCB                
MAYBEBLANKOUTPUT:
      jsr  PRINT8SPACES_C100            
      jmp  DOFULLPROMPT                 

CMDHASH:
      jsr  HASHDECTOHEX_CC85            
      lda  #$07                         ; Location of first output character.
      sta  $D3                          ; Move cursor to column 7?
      lda  #$3D                         ; Load A with '=' equals
      jsr  INDIRECTCHROUT               ; Print '=' first.
      jsr  PRTADDRHEX_C82D              ; Print hex value from conversion.
      jmp  MAYBEBLANKOUTPUT             

MAYBESCROLLSCREEN:
      lda  #$00                         
      sta  $02A5                        ; Transient for line index
      jsr  $E981                        
      lda  $0288                        ; Top of memory screen (page)
      ora  #$80                         
      sta  $D9                          ; Table of screen line/Transient editor
PRINTHOME:
      lda  #$13                         
      jmp  INDIRECTCHROUT               

MAYBEFINDLEFTPAREN:
      cpy  #$28                         ; Compare Y to '(' left parenthesis.
      bne  KEEPLOOK_CC38                
      sec                               
      rts                               

KEEPLOOK_CC38:
      jsr  MAYBESCREEN2PETSCII          
      cmp  #$20                         
      beq  MAYBEFINDLEFTPAREN           
      dey                               
      jsr  MAYBEGETHEXDGT_CC62          
      tax                               
      jsr  MAYBEGETHEXDGT_CC62          
      sta  ZP1STADDR_C1                 ; I/O starting address
      stx  ZP1STADDR_C2                 ; I/O starting address
      lda  #$FF                         
      sta  STACKVAR_0175                ; CPU stack
      sta  ZPVAR_CC                     ; Flash state: 0=flashing
      lda  ZPVAR_CF                     ; Flag: Last cursore state (Flash/fixed)
      beq  SKIPCURSOR_CC60              
      lda  ZPVAR_CE                     ; Char under the cursor
      ldy  $D3                          ; Column of cursor on the current line
      sta  ($D1),y                      ; Pointer: current screen line address
      lda  #$00                         
      sta  ZPVAR_CF                     ; Flag: Last cursore state (Flash/fixed)
SKIPCURSOR_CC60:
      clc                               
      rts                               

MAYBEGETHEXDGT_CC62:
      jsr  MAYBESCREEN2PETSCII          
      jsr  MAYBELOW4BITS_C8B3           
      asl                               
      asl                               
      asl                               
      asl                               
      sta  STACKVAR_016A                ; CPU stack
      jsr  MAYBESCREEN2PETSCII          
      jsr  MAYBELOW4BITS_C8B3           
      ora  STACKVAR_016A                ; CPU stack
      rts                               

MAYBESCREEN2PETSCII:
      lda  (ZP2NDADDR_C3),y             ; Transient tape load
      iny                               
      and  #$7F                         
      cmp  #$20                         
      bcs  DONERTS_CC84                 
      ora  #$40                         
DONERTS_CC84:
      rts                               

HASHDECTOHEX_CC85:
      ldx  #$00                         
      stx  ZP1STADDR_C1                 ; I/O starting address
      stx  ZP1STADDR_C2                 ; I/O starting address
HASHREADADIGIT:
      jsr  HASHVALIDATEDIGITS           
      bcs  HASHEXIT_CCCA                
      pha                               
      lda  ZP1STADDR_C2                 ; I/O starting address
      sta  ZP2NDADDR_C3                 ; Transient tape load
      lda  ZP1STADDR_C1                 ; I/O starting address
      asl                               
      rol  ZP2NDADDR_C3                 ; Transient tape load
      asl                               
      rol  ZP2NDADDR_C3                 ; Transient tape load
      adc  ZP1STADDR_C1                 ; I/O starting address
      sta  ZP1STADDR_C1                 ; I/O starting address
      lda  ZP2NDADDR_C3                 ; Transient tape load
      adc  ZP1STADDR_C2                 ; I/O starting address
      sta  ZP1STADDR_C2                 ; I/O starting address
      asl  ZP1STADDR_C1                 ; I/O starting address
      rol  ZP1STADDR_C2                 ; I/O starting address
      pla                               
      adc  ZP1STADDR_C1                 ; I/O starting address
      sta  ZP1STADDR_C1                 ; I/O starting address
      bcc  HASHREADADIGIT               
      inc  ZP1STADDR_C2                 ; I/O starting address
      bcs  HASHREADADIGIT               
HASHVALIDATEDIGITS:
      jsr  INDIRECTCHRIN                
      cmp  #$0D                         
      beq  HASHBITHACKCLCEXIT+1         
      cmp  #$30                         
      bcc  HASHBITHACKCLCEXIT+1         
      cmp  #$3A                         
      bcs  HASHEXIT_CCCA                
      and  #$0F                         
      clc                               
HASHBITHACKCLCEXIT:
      .byte $24
HASHBITHACKSECEXIT:
      sec                               
HASHEXIT_CCCA:
      rts                               

HEXTODEC_CCCB:
      ldx  #$08                         ; Will look at 5 sets of 2 bytes (10 total in table)
HEXTODECLOOP_CCCD:
      ldy  #$30                         ; Load Y with '0' (zero digit)
      sec                               
HEXTODECLOOP_CCD0:
      lda  ZP1STADDR_C1                 ; I/O starting address
      sbc  DATAREF001,x                 
      pha                               
      lda  ZP1STADDR_C2                 ; I/O starting address
      sbc  DATAREF001+1,x               
      bcc  PRINTDIGIT_CCE5              
      sta  ZP1STADDR_C2                 ; I/O starting address
      pla                               
      sta  ZP1STADDR_C1                 ; I/O starting address
      iny                               
      bne  HEXTODECLOOP_CCD0            
PRINTDIGIT_CCE5:
      pla                               
      tya                               
      jsr  INDIRECTCHROUT               
      dex                               
      dex                               
      bpl  HEXTODECLOOP_CCCD            
      rts                               

PRTDISLINE_CCEF:
      jsr  PRTADDRHEX_C82D              
      jsr  PRINTSPACE                   
      jsr  MAYBPATCHDIS_CBEF            
      ldx  #$03                         
      jmp  DISREADDATA_C275             

PRTREGTXT:
      jsr  MAYBESTEPPING                
      ldx  #$00                         
LOOPPRTREGTXT:
      lda  TEXTREGISTERS,x              ; Has the text for registers and flags.
      jsr  CHROUT                       ; Should this be INDIRECTCHROUT?
      inx                               
      cpx  #$14                         ; Total of 20 characters to print.
      bcc  LOOPPRTREGTXT                
      rts                               

SYNTAXERROR_CD0E:
      jmp  SYNTAXERROR                  

CMDEXAMINE:
      jsr  INDIRECTCHRIN                
      ldx  #$7F                         ; Used with N flag to indicate op requested.
      cmp  #$43                         ; Compare 'C' for examine/edit char.
      beq  EXAMINE_VALID                ; If 'C' skip over 'S' check.
      inx                               ; $80 will set N flag and indicate example sprite op.
      cmp  #$53                         ; Compare 'S' for examine sprite.
      bne  SYNTAXERROR_CD0E             ; No valid sub-command. Print syntax error.
EXAMINE_VALID:
      stx  NEGATIVEFLAGVAR              ; CPU stack
      jsr  GET1STADDRCMDL_C42D          
LOOP_CD25:
      ldx  VAR0167WRAPFLAG              ; CPU stack
      bne  DONE_CD37                    
      jsr  CALCRANGESIZE                
      bcc  DONE_CD37                    
      jsr  SHOWSPRITECHARMEM            
      jsr  STOP                         ; Routine: Terminate the keyboard scan
      bne  LOOP_CD25                    
DONE_CD37:
      jmp  EARLYEXIT_C25F               

SHOWSPRITECHARMEM:
      jsr  PRINTNEWLINE                 
CHECKCMDREQUESTED:
      ldx  #$2E                         ; Load X with a '.' for prompt.
      lda  #$5D                         ; Load A with a ']' for edit sprite.
      bit  NEGATIVEFLAGVAR              ; Check which operation we want via N flag.
      bmi  CONTSHOWSPRITECHAR           ; If N set we want ']' edit sprite.
      lda  #$5B                         ; Load A with '[' for edit char.
CONTSHOWSPRITECHAR:
      jsr  PRINTTWOCHARS                ; Print '.[' or '.]' depending on op.
      jsr  PRINTSPACE                   
      jsr  PRINTADDRESS_CD72            ; Print address I'm assuming.
      jsr  PRINTSPACE                   
      ldy  #$00                         ; Will be used for number of bytes loop for sprite.
      ldx  #$08                         ; We will want 8 bits.
PRINTSPRITECHAR:
      stx  STACKVAR_015E                ; Number of bits to print.
      lda  (ZP1STADDR_C1),y             ; I/O starting address
      jsr  PRINTBITSDOTSTAR             
      bit  NEGATIVEFLAGVAR              ; CPU stack
      bpl  PRINTDONEWITHBYTES           
      iny                               
      cpy  #$03                         
      bcc  PRINTSPRITECHAR              ; Still more bytes to print.
      dey                               ; Decrement Y to number of bytes printed.
PRINTDONEWITHBYTES:
      tya                               
      jsr  MAYBEGETNEXTADDR             ; Get or adjust next address?
      jmp  REVERSEOFF                   

PRINTADDRESS_CD72:
      bit  NEGATIVEFLAGVAR              ; CPU stack
      bpl  PRINTADDRESS_CD82            
      lda  ZP1STADDR_C1                 ; I/O starting address
      and  #$3F                         ; 63 or '?'
      cmp  #$3F                         ; 63 or '?'
      bne  PRINTADDRESS_CD82            
      jsr  INCREMENTADDR_C93B           
PRINTADDRESS_CD82:
      jmp  PRTADDRHEX_C82D              

MYBCHECKMEMCMD_CD85:
      jsr  MAYBESCREEN2PETSCII          
      cmp  #$3A                         ; Compare with ':' colon.
      beq  SAVECMDREQUEST_CD94          
      cmp  #$5B                         ; Compare with '[' left bracket.
      beq  SAVECMDREQUEST_CD94          
      cmp  #$5D                         ; Compare with ']' right bracket.
      bne  DONE_CD99                    
SAVECMDREQUEST_CD94:
      sta  CMDREQUESTED                 ; Save ':' or '[' but act like colon (next line)?
      lda  #$3A                         ; Load A with ':' colon.
DONE_CD99:
      rts                               

GETNEXTSPRITECHAR:
      lda  CMDREQUESTED                 ; CPU stack
      ldx  #$7F                         ; Will get loaded to N flag var if '[' edit char.
      cmp  #$5B                         ; Compare with '[' left bracket.
      beq  EDITCMDVALID                 
      inx                               ; Will use $80 for edit sprite N var flag.
      cmp  #$5D                         ; Compare with ']' right bracket.
      bne  DONE_CD99                    ; Not valid '[' or ']' command.  Return.
EDITCMDVALID:
      stx  NEGATIVEFLAGVAR              ; CPU stack
      clc                               
      lda  #$01                         ; One byte for edit char.
      bit  NEGATIVEFLAGVAR              ; Check if we want char or sprite.
      bpl  SKIPTOBYTESET_CDB5           ; For char jump ahead.
      lda  #$03                         ; Three bytes for edit sprite.
SKIPTOBYTESET_CDB5:
      adc  ZP1STADDR_C1                 ; I/O starting address
      sta  ZP1STADDR_C1                 ; I/O starting address
      bcc  SKIPINC_CDBD                 
      inc  ZP1STADDR_C2                 ; I/O starting address
SKIPINC_CDBD:
      jsr  SHOWSPRITECHARMEM            
      jmp  RESETKEYBUFFRETURN           

SCROLLGETNEXTSPRCHR:
      lda  CMDREQUESTED                 ; CPU stack
      ldx  #$7F                         ; Will be used for N flag checking.
      cmp  #$5B                         ; Compare with '[' left bracket
      beq  SCROLLEDITCMDVALID           
      inx                               ; $7F becomes $80 which set N flag for right bracket.
      cmp  #$5D                         ; Compare with ']' right bracket.
      bne  DONE_CD99                    ; No valid command, return.
SCROLLEDITCMDVALID:
      stx  NEGATIVEFLAGVAR              ; This variables tells us which op we want.  Char or Sprite.
      jsr  MAYBESCROLLSCREEN            
      sec                               
      lda  #$01                         ; Edit char is 1 byte.
      bit  NEGATIVEFLAGVAR              ; Check which operation we want.
      bpl  EDITSPRITCHAR_CDE1           ; Branch if '[' left bracket edit char.
      lda  #$03                         ; Edit sprite is 3 bytes.
EDITSPRITCHAR_CDE1:
      sta  CMDREQUESTED                 ; CPU stack
      lda  ZP1STADDR_C1                 ; I/O starting address
      sbc  CMDREQUESTED                 ; CPU stack
      sta  ZP1STADDR_C1                 ; I/O starting address
      bcs  SKIPDEC_CDEF                 
      dec  ZP1STADDR_C2                 ; I/O starting address
SKIPDEC_CDEF:
      bit  NEGATIVEFLAGVAR              ; CPU stack
      bpl  MAYBEFINISHUP_CDFE           
      lda  ZP1STADDR_C1                 ; I/O starting address
      and  #$3F                         
      cmp  #$3D                         
      bne  MAYBEFINISHUP_CDFE           
      dec  ZP1STADDR_C1                 ; I/O starting address
MAYBEFINISHUP_CDFE:
      jsr  CHECKCMDREQUESTED            
      jmp  CLRKEYBHOMEPROMPT            

CMDLEFTBRACKET:
      ldx  #$7F                         ; N flag will not be set. (7th bit 0)
      bne  BRACKETRESTOFLINE            
CMDRIGHTBRACKET:
      ldx  #$80                         ; N flag will be set (7th bit 1)
BRACKETRESTOFLINE:
      stx  NEGATIVEFLAGVAR              ; Store for testing N flag later.
      jsr  PARSECMDLINE_C815            
      jsr  CHRINPRINTNEWLINE            
      ldy  #$00                         
LOOP_CE15:
      jsr  GETSPRITECHARBITS            
      sta  (ZP1STADDR_C1),y             ; I/O starting address
      bit  NEGATIVEFLAGVAR              ; Check if we want edit char or edit sprite. (N flag)
      bpl  CONTINUE_CE24                ; If N is not set we want 1 byte for edit char.
      iny                               ; Edit sprite needs to read 2 more bytes.
      cpy  #$03                         ; Have we read 0/1/2 already?
      bcc  LOOP_CE15                    ; Read more bytes.
CONTINUE_CE24:
      jsr  PRINTCURSORUP                
      jsr  SHOWSPRITECHARMEM            
      lda  CMDREQUESTED                 ; CPU stack
      jmp  ADDKEYBOARDBUFFER            

GETSPRITECHARBITS:
      ldx  #$08                         ; We will read a full 8 characters / 8 bits worth.
LOOPSPRITECHARBITS:
      pha                               ; Save A / character line variable on stack.
      jsr  CHRINPRINTNEWLINE            
      cmp  #$2A                         ; Check for '*' to enable bits on this line of character.
      sec                               ; Set carry for bits we want enabled.
      beq  SETSPRITECHARBIT             
      clc                               ; Clear carry for 0 bits.
SETSPRITECHARBIT:
      pla                               ; Pull character variable off stack.
      rol                               ; Add carry bit to A / character.
      dex                               
      bne  LOOPSPRITECHARBITS           
BARERTS_CE41:
      rts                               

MAYBESTEPPING:
      jsr  PRINTNEWLINE                 
      lda  CMDREQUESTED                 ; CPU stack
      cmp  #$47                         ; Check for 'G' (GO) command?
      beq  DONE_CE50                    
      cmp  #$51                         ; Check for 'Q' Quick Trace command?
      bne  BARERTS_CE41                 
DONE_CE50:
      pla                               ; Pull caller address off stack (return one call up?)
      pla                               ; Pull caller address off stack (return one call up?)
      rts                               

EMPTYZERO1:
      .byte $00, $00, $00, $00, $00     
SETCOLORS:
      lda  #$00                         ; Load A for BLACK color.
      sta  $D020                        ; Set border.
      sta  $D021                        ; Set background.
      lda  #$05                         ; Load A for WHITE text.
      jsr  CHROUT                       ; Set WHITE text. Should we call INDIRECTCHROUT?
      rts                               

EMPTYZERO_CE66:
      .byte $00, $00, $00, $00, $00, $00, $00, $00 
      .byte $00, $00, $00, $00, $00, $00, $00, $00 
      .byte $00, $00, $00, $00, $00, $00, $00, $00 
      .byte $00, $00, $00, $00, $00, $00, $00, $00 
      .byte $00, $00, $00, $00, $00, $00, $00, $00 
      .byte $00, $00, $00, $00, $00, $00, $00, $00 
      .byte $00, $00, $00, $00          
DATAREF001:
      .byte $01, $00, $0A, $00, $64, $00, $E8, $03 
      .byte $10, $27                    
MODE:
      .byte $40, $02, $45, $03, $D0, $08, $40, $09 
      .byte $30, $22, $45, $33, $D0, $08, $40, $09 
      .byte $40, $02, $45, $33, $D0, $08, $40, $09 
      .byte $40, $02, $45, $B3, $D0, $08, $40, $09 
      .byte $00, $22, $44, $33, $D0, $8C, $44, $00 
      .byte $11, $22, $44, $33, $D0, $8C, $44, $9A 
      .byte $10, $22, $44, $33, $D0, $08, $40, $09 
      .byte $10, $22, $44, $33, $D0, $08, $40, $09 
      .byte $62, $13, $78, $A9          
MODE2:
      .byte $00, $21, $81, $82, $00, $00, $59, $4D 
      .byte $91, $92, $86, $4A, $85     
INSNMODEPUNCT1:
      .byte $9D
CHAR1:
      .byte $2C, $29, $2C, $23, $28     
INSNMODEPUNCT2:
      .byte $24
CHAR2:
      .byte $59, $00, $58, $24, $24, $00
MNEML:
      .byte $1C, $8A, $1C, $23, $5D, $8B, $1B, $A1 
      .byte $9D, $8A, $1D, $23, $9D, $8B, $1D, $A1 
      .byte $00, $29, $19, $AE, $69, $A8, $19, $23 
      .byte $24, $53, $1B, $23, $24, $53, $19, $A1 
      .byte $00, $1A, $5B, $5B, $A5, $69, $24, $24 
      .byte $AE, $AE, $A8, $AD, $29, $00, $7C, $00 
      .byte $15, $9C, $6D, $9C, $A5, $69, $29, $53 
      .byte $84, $13, $34, $11, $A5, $69, $23, $A0 
MNEMR:
      .byte $D8, $62, $5A, $48, $26, $62, $94, $88 
      .byte $54, $44, $C8, $54, $68, $44, $E8, $94 
      .byte $00, $B4, $08, $84, $74, $B4, $28, $6E 
      .byte $74, $F4, $CC, $4A, $72, $F2, $A4, $8A 
      .byte $00, $AA, $A2, $A2, $74, $74, $74, $72 
      .byte $44, $68, $B2, $32, $B2, $00, $22, $00 
      .byte $1A, $1A, $26, $26, $72, $72, $88, $C8 
      .byte $C4, $CA, $26, $48, $44, $44, $A2, $C8 
TEXTCMDREGISTERS:
      .byte $0D, $20, $20, $20, $20, $50, $43, $20 
      .byte $20, $4E, $4D, $49, $20, $20
TEXTREGISTERS:
      .byte $41, $43, $20, $58, $52, $20, $59, $52 
      .byte $20, $53, $50, $20, $4E, $56, $23, $42 
      .byte $44, $49, $5A, $43          
CMDTABLE:
      .byte $41, $42, $43, $44, $46, $47, $48, $4C 
      .byte $4D, $4E, $51, $52, $53, $54, $57, $58 
      .byte $2C, $3A, $3B, $23, $24, $45, $5B, $5D 
      .byte $00, $00                    
CMDVECTORTABLE:
      .byte <CMDASSEMBLE, >CMDASSEMBLE, <CMDBREAK, >CMDBREAK, <CMDCOMPARE, >CMDCOMPARE, <CMDDISASSEMBLE, >CMDDISASSEMBLE 
      .byte <CMDFILL, >CMDFILL, <CMDGO, >CMDGO, <CMDHUNT, >CMDHUNT, <CMDLOADSAVE, >CMDLOADSAVE 
      .byte <CMDMEMORY, >CMDMEMORY, <CMDNNOTSURE, >CMDNNOTSURE, <CMDQUICKTRACE, >CMDQUICKTRACE, <CMDREGISTERS, >CMDREGISTERS 
      .byte <CMDLOADSAVE, >CMDLOADSAVE, <CMDTRANSFER, >CMDTRANSFER, <CMDWALK, >CMDWALK, <CMDEXIT, >CMDEXIT 
      .byte <CMDCOMMA, >CMDCOMMA, <CMDCOLON, >CMDCOLON, <CMDSEMICOLON, >CMDSEMICOLON, <CMDHASH, >CMDHASH 
      .byte <CMDDOLLAR, >CMDDOLLAR, <CMDEXAMINE, >CMDEXAMINE, <CMDLEFTBRACKET, >CMDLEFTBRACKET, <CMDRIGHTBRACKET, >CMDRIGHTBRACKET 
      .byte $00, $00                    
LOADADD:
      .byte <ENTRY, >ENTRY
IRQHNDRADD:
      .byte <CALLIRQHANDLER, >CALLIRQHANDLER
BRKHNDRADD:
      .byte <BRKHANDLER, >BRKHANDLER
IRQHND2ADDRVECT:
      .byte <IRQHANDLER, >IRQHANDLER
FUNCVECTADDR:                           ; Should be <FUNCTVECT-1, >FUNCTVECT-1 instead.
      .word $C5BA
TEXTMONEXT:
      .byte $4D, $4F, $4E, $45, $58, $54; Can't be string as upper/lower PETSCII issue.
