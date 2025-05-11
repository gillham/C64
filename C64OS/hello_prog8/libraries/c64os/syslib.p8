; Prog8 definitions for the Commodore 64 running C64 OS.
; Initially minimal sys.* and cx16.* definitions/routines.

;%option no_symbol_prefixing, ignore_unused
%option no_symbol_prefixing
%option ignore_unused
%import os

cbm {
    ; holds latest keypress
    ubyte keyb = $00

    ; Commodore (CBM) common variables, vectors and kernal routines

    &ubyte  TIME_HI         = $a0       ; software jiffy clock, hi byte
    &ubyte  TIME_MID        = $a1       ;  .. mid byte
    &ubyte  TIME_LO         = $a2       ;    .. lo byte. Updated by IRQ every 1/60 sec

    ; txt.input_chars() calls this to read a string.
    ; There is no simple translation from a busy loop
    ; looking for keyboard input to a full OS with event
    ; driven model.  We could try to build a keyboard buffer
    ; in the keyboard event callback so a call to CHRIN() would
    ; would get whatever was in the buffer, but we don't want
    ; CHRIN() to block as we are not a multitasking OS.  We could
    ; try to yield() somehow using the Prog8 coroutines thing but
    ; I think input_chars/CHRIN just can't work right now.
    ; For now we lie and say the user hit return
    ; which causes txt.input_chars to end so it doesn't hang.
    ;
    asmsub CHRIN() -> ubyte @A {
        %asm {{
            lda #$0d    ; say return (ascii 13) was pressed.
            rts
        }}
    }

    ;
    ; This should use my own draw into a virtual line buffer (from 10 Print Prog8)
    ; then ctx2scr instead of ctxdraw but it is close to CHROUT
    ; now except it doesn't wrap to the next line, scroll the screen
    ; or handle special characters (color change or clear screen etc)
    ;
    asmsub CHROUT(ubyte arg0 @A) {
        %asm {{
            jmp p8b_os.p8s_ctxdraw
        }}
    }

    ; this looks for the next character in the keyboard buffer
    ; it doesn't block, just returns zero if none
    ; we should be able to hook this up to the event driven keyboard
    ; handler to at least get the most recently pressed character?
    asmsub GETIN() -> bool @Pc, ubyte @A {
        %asm {{
            ldx keyb
            ;lda #$00    ; Return 0 to say no key available in buffer
            lda #$00
            sta keyb
            txa
            rts
        }}
    }

    asmsub PLOT(ubyte col @Y, ubyte row @X, bool dir @Pc) clobbers(A) -> ubyte @Y, ubyte @X {
        %asm {{
            ; for PLOT:
            ;   if carry is clear we are setting the col / row cursor position
            ;   if carry is set we are getting the col / row cursor position
            ; for setlrc:
            ;   if carry is clear we are setting row
            ;   if carry is set we are setting col
            ; row must be set first with setlrc

            ; just return current col/row if carry is set
            bcs +
            ; save col (Y) for second call to setlrc
            tya
            pha
            ; clear high-byte of RegWrd in Y
            lda #$0
            tay
            ; set row as carry is clear.
            jsr p8b_os.p8s_setlrc
            ; pull col (Y) from stack
            pla
            tax
            ; clear high-byte of RegWrd in Y
            lda #$0
            tay
            ; set carry to set column
            sec
            jsr p8b_os.p8s_setlrc
            clc

            ; return current value of col & row in X & Y
        +   ldx p8b_hdr.p8c_d_ctx + p8b_hdr.p8c_d_lrow
            ldy p8b_hdr.p8c_d_ctx + p8b_hdr.p8c_d_lcol
            ; should we clear carry before rts?
            rts

        }}

;        if dir {
;            os.setlrc(row, false)
;            os.setlrc(col, true)
;            return col, row
;        }
;        ; return current col / row from draw context
;        return @(hdr.d_ctx + hdr.d_lcol), @(hdr.d_ctx + hdr.d_lrow)
    }
}

c64 {
        ; C64 I/O registers (VIC, SID, CIA)

        ; the default locations of the 8 sprite pointers (store address of sprite / 64)
        ; (depending on the VIC bank and screen ram address selection these can be shifted around though,
        ; see the two routines after this for a dynamic way of determining the correct memory location)
        &ubyte  SPRPTR0         = 2040
        &ubyte  SPRPTR1         = 2041
        &ubyte  SPRPTR2         = 2042
        &ubyte  SPRPTR3         = 2043
        &ubyte  SPRPTR4         = 2044
        &ubyte  SPRPTR5         = 2045
        &ubyte  SPRPTR6         = 2046
        &ubyte  SPRPTR7         = 2047
        &ubyte[8]  SPRPTR       = 2040      ; the 8 sprite pointers as an array.


; ---- VIC-II 6567/6569/856x registers ----

        &ubyte  SP0X            = $d000
        &ubyte  SP0Y            = $d001
        &ubyte  SP1X            = $d002
        &ubyte  SP1Y            = $d003
        &ubyte  SP2X            = $d004
        &ubyte  SP2Y            = $d005
        &ubyte  SP3X            = $d006
        &ubyte  SP3Y            = $d007
        &ubyte  SP4X            = $d008
        &ubyte  SP4Y            = $d009
        &ubyte  SP5X            = $d00a
        &ubyte  SP5Y            = $d00b
        &ubyte  SP6X            = $d00c
        &ubyte  SP6Y            = $d00d
        &ubyte  SP7X            = $d00e
        &ubyte  SP7Y            = $d00f
        &ubyte[16]  SPXY        = $d000        ; the 8 sprite X and Y registers as an array.
        &uword[8] @nosplit SPXYW  = $d000        ; the 8 sprite X and Y registers as a combined xy word array.

        &ubyte  MSIGX           = $d010
        &ubyte  SCROLY          = $d011
        &ubyte  RASTER          = $d012
        &ubyte  LPENX           = $d013
        &ubyte  LPENY           = $d014
        &ubyte  SPENA           = $d015
        &ubyte  SCROLX          = $d016
        &ubyte  YXPAND          = $d017
        &ubyte  VMCSB           = $d018
        &ubyte  VICIRQ          = $d019
        &ubyte  IREQMASK        = $d01a
        &ubyte  SPBGPR          = $d01b
        &ubyte  SPMC            = $d01c
        &ubyte  XXPAND          = $d01d
        &ubyte  SPSPCL          = $d01e
        &ubyte  SPBGCL          = $d01f

        &ubyte  EXTCOL          = $d020        ; border color
        &ubyte  BGCOL0          = $d021        ; screen color
        &ubyte  BGCOL1          = $d022
        &ubyte  BGCOL2          = $d023
        &ubyte  BGCOL4          = $d024
        &ubyte  SPMC0           = $d025
        &ubyte  SPMC1           = $d026
        &ubyte  SP0COL          = $d027
        &ubyte  SP1COL          = $d028
        &ubyte  SP2COL          = $d029
        &ubyte  SP3COL          = $d02a
        &ubyte  SP4COL          = $d02b
        &ubyte  SP5COL          = $d02c
        &ubyte  SP6COL          = $d02d
        &ubyte  SP7COL          = $d02e
        &ubyte[8]  SPCOL        = $d027


; ---- end of VIC-II registers ----

; ---- CIA 6526 1 & 2 registers ----

        &ubyte  CIA1PRA         = $DC00        ; CIA 1 DRA, keyboard column drive (and joystick control port #2)
        &ubyte  CIA1PRB         = $DC01        ; CIA 1 DRB, keyboard row port (and joystick control port #1)
        &ubyte  CIA1DDRA        = $DC02        ; CIA 1 DDRA, keyboard column
        &ubyte  CIA1DDRB        = $DC03        ; CIA 1 DDRB, keyboard row
        &ubyte  CIA1TAL         = $DC04        ; CIA 1 timer A low byte
        &ubyte  CIA1TAH         = $DC05        ; CIA 1 timer A high byte
        &ubyte  CIA1TBL         = $DC06        ; CIA 1 timer B low byte
        &ubyte  CIA1TBH         = $DC07        ; CIA 1 timer B high byte
        &ubyte  CIA1TOD10       = $DC08        ; time of day, 1/10 sec.
        &ubyte  CIA1TODSEC      = $DC09        ; time of day, seconds
        &ubyte  CIA1TODMMIN     = $DC0A        ; time of day, minutes
        &ubyte  CIA1TODHR       = $DC0B        ; time of day, hours
        &ubyte  CIA1SDR         = $DC0C        ; Serial Data Register
        &ubyte  CIA1ICR         = $DC0D
        &ubyte  CIA1CRA         = $DC0E
        &ubyte  CIA1CRB         = $DC0F

        &ubyte  CIA2PRA         = $DD00        ; CIA 2 DRA, serial port and video address
        &ubyte  CIA2PRB         = $DD01        ; CIA 2 DRB, RS232 port / USERPORT
        &ubyte  CIA2DDRA        = $DD02        ; CIA 2 DDRA, serial port and video address
        &ubyte  CIA2DDRB        = $DD03        ; CIA 2 DDRB, RS232 port / USERPORT
        &ubyte  CIA2TAL         = $DD04        ; CIA 2 timer A low byte
        &ubyte  CIA2TAH         = $DD05        ; CIA 2 timer A high byte
        &ubyte  CIA2TBL         = $DD06        ; CIA 2 timer B low byte
        &ubyte  CIA2TBH         = $DD07        ; CIA 2 timer B high byte
        &ubyte  CIA2TOD10       = $DD08        ; time of day, 1/10 sec.
        &ubyte  CIA2TODSEC      = $DD09        ; time of day, seconds
        &ubyte  CIA2TODMIN      = $DD0A        ; time of day, minutes
        &ubyte  CIA2TODHR       = $DD0B        ; time of day, hours
        &ubyte  CIA2SDR         = $DD0C        ; Serial Data Register
        &ubyte  CIA2ICR         = $DD0D
        &ubyte  CIA2CRA         = $DD0E
        &ubyte  CIA2CRB         = $DD0F

; ---- end of CIA registers ----

; ---- SID 6581/8580 registers ----

        &ubyte  FREQLO1         = $D400        ; channel 1 freq lo
        &ubyte  FREQHI1         = $D401        ; channel 1 freq hi
        &uword  FREQ1           = $D400        ; channel 1 freq (word)
        &ubyte  PWLO1           = $D402        ; channel 1 pulse width lo (7-0)
        &ubyte  PWHI1           = $D403        ; channel 1 pulse width hi (11-8)
        &uword  PW1             = $D402        ; channel 1 pulse width (word)
        &ubyte  CR1             = $D404        ; channel 1 voice control register
        &ubyte  AD1             = $D405        ; channel 1 attack & decay
        &ubyte  SR1             = $D406        ; channel 1 sustain & release
        &ubyte  FREQLO2         = $D407        ; channel 2 freq lo
        &ubyte  FREQHI2         = $D408        ; channel 2 freq hi
        &uword  FREQ2           = $D407        ; channel 2 freq (word)
        &ubyte  PWLO2           = $D409        ; channel 2 pulse width lo (7-0)
        &ubyte  PWHI2           = $D40A        ; channel 2 pulse width hi (11-8)
        &uword  PW2             = $D409        ; channel 2 pulse width (word)
        &ubyte  CR2             = $D40B        ; channel 2 voice control register
        &ubyte  AD2             = $D40C        ; channel 2 attack & decay
        &ubyte  SR2             = $D40D        ; channel 2 sustain & release
        &ubyte  FREQLO3         = $D40E        ; channel 3 freq lo
        &ubyte  FREQHI3         = $D40F        ; channel 3 freq hi
        &uword  FREQ3           = $D40E        ; channel 3 freq (word)
        &ubyte  PWLO3           = $D410        ; channel 3 pulse width lo (7-0)
        &ubyte  PWHI3           = $D411        ; channel 3 pulse width hi (11-8)
        &uword  PW3             = $D410        ; channel 3 pulse width (word)
        &ubyte  CR3             = $D412        ; channel 3 voice control register
        &ubyte  AD3             = $D413        ; channel 3 attack & decay
        &ubyte  SR3             = $D414        ; channel 3 sustain & release
        &ubyte  FCLO            = $D415        ; filter cutoff lo (2-0)
        &ubyte  FCHI            = $D416        ; filter cutoff hi (10-3)
        &uword  FC              = $D415        ; filter cutoff (word)
        &ubyte  RESFILT         = $D417        ; filter resonance and routing
        &ubyte  MVOL            = $D418        ; filter mode and main volume control
        &ubyte  POTX            = $D419        ; potentiometer X
        &ubyte  POTY            = $D41A        ; potentiometer Y
        &ubyte  OSC3            = $D41B        ; channel 3 oscillator value read
        &ubyte  ENV3            = $D41C        ; channel 3 envelope value read

; ---- end of SID registers ----
}

sys {
    ; ------- lowlevel system routines --------

    const ubyte target = 64         ;  compilation target specifier.  64 = C64, 128 = C128, 16 = CommanderX16.

    const ubyte sizeof_bool = 1
    const ubyte sizeof_byte = 1
    const ubyte sizeof_ubyte = 1
    const ubyte sizeof_word = 2
    const ubyte sizeof_uword = 2
    const ubyte sizeof_float = 5

    asmsub internal_stringcopy(uword source @R0, uword target @AY) clobbers (A,Y) {
        ; Called when the compiler wants to assign a string value to another string.
        %asm {{
		sta  P8ZP_SCRATCH_W1
		sty  P8ZP_SCRATCH_W1+1
		lda  cx16.r0
		ldy  cx16.r0+1
		jmp  prog8_lib.strcpy
        }}
    }

    asmsub memcopy(uword source @R0, uword target @R1, uword count @AY) clobbers(A,X,Y) {
        ; note: only works for NON-OVERLAPPING memory regions!
        ; note: can't be inlined because is called from asm as well
        %asm {{
            ldx  cx16.r0
            stx  P8ZP_SCRATCH_W1        ; source in ZP
            ldx  cx16.r0+1
            stx  P8ZP_SCRATCH_W1+1
            ldx  cx16.r1
            stx  P8ZP_SCRATCH_W2        ; target in ZP
            ldx  cx16.r1+1
            stx  P8ZP_SCRATCH_W2+1
            cpy  #0
            bne  _longcopy

            ; copy <= 255 bytes
            tay
            bne  _copyshort
            rts     ; nothing to copy

_copyshort
            dey
            beq  +
-           lda  (P8ZP_SCRATCH_W1),y
            sta  (P8ZP_SCRATCH_W2),y
            dey
            bne  -
+           lda  (P8ZP_SCRATCH_W1),y
            sta  (P8ZP_SCRATCH_W2),y
            rts

_longcopy
            sta  P8ZP_SCRATCH_B1        ; lsb(count) = remainder in last page
            tya
            tax                         ; x = num pages (1+)
            ldy  #0
-           lda  (P8ZP_SCRATCH_W1),y
            sta  (P8ZP_SCRATCH_W2),y
            iny
            bne  -
            inc  P8ZP_SCRATCH_W1+1
            inc  P8ZP_SCRATCH_W2+1
            dex
            bne  -
            ldy  P8ZP_SCRATCH_B1
            bne  _copyshort
            rts
        }}
    }

    asmsub memset(uword mem @R0, uword numbytes @R1, ubyte value @A) clobbers(A,X,Y) {
        %asm {{
            ldy  cx16.r0
            sty  P8ZP_SCRATCH_W1
            ldy  cx16.r0+1
            sty  P8ZP_SCRATCH_W1+1
            ldx  cx16.r1
            ldy  cx16.r1+1
            jmp  prog8_lib.memset
        }}
    }

    asmsub memsetw(uword mem @R0, uword numwords @R1, uword value @AY) clobbers(A,X,Y) {
        %asm {{
            ldx  cx16.r0
            stx  P8ZP_SCRATCH_W1
            ldx  cx16.r0+1
            stx  P8ZP_SCRATCH_W1+1
            ldx  cx16.r1
            stx  P8ZP_SCRATCH_W2
            ldx  cx16.r1+1
            stx  P8ZP_SCRATCH_W2+1
            jmp  prog8_lib.memsetw
        }}
    }

    inline asmsub read_flags() -> ubyte @A {
        %asm {{
        php
        pla
        }}
    }

    inline asmsub clear_carry() {
        %asm {{
        clc
        }}
    }

    inline asmsub set_carry() {
        %asm {{
        sec
        }}
    }

    inline asmsub progend() -> uword @AY {
        %asm {{
            lda  #<prog8_program_end
            ldy  #>prog8_program_end
        }}
    }

    inline asmsub progstart() -> uword @AY {
        %asm {{
            lda  #<prog8_program_start
            ldy  #>prog8_program_start
        }}
    }

    inline asmsub push(ubyte value @A) {
        %asm {{
            pha
        }}
    }

    inline asmsub pushw(uword value @AY) {
        %asm {{
            pha
            tya
            pha
        }}
    }

    inline asmsub pop() -> ubyte @A {
        %asm {{
            pla
        }}
    }

    inline asmsub popw() -> uword @AY {
        %asm {{
            pla
            tay
            pla
        }}
    }

    ; this should really not be used with C64 OS, but...
    asmsub wait(uword jiffies @AY) {
        ; --- wait approximately the given number of jiffies (1/60th seconds) (N or N+1)
        ;     note: the system irq handler has to be active for this to work as it depends on the system jiffy clock
        %asm {{
            stx  P8ZP_SCRATCH_B1
            sta  P8ZP_SCRATCH_W1
            sty  P8ZP_SCRATCH_W1+1

_loop       lda  P8ZP_SCRATCH_W1
            ora  P8ZP_SCRATCH_W1+1
            bne  +
            ldx  P8ZP_SCRATCH_B1
            rts

+           lda  cbm.TIME_LO
            sta  P8ZP_SCRATCH_B1
-           lda  cbm.TIME_LO
            cmp  P8ZP_SCRATCH_B1
            beq  -

            lda  P8ZP_SCRATCH_W1
            bne  +
            dec  P8ZP_SCRATCH_W1+1
+           dec  P8ZP_SCRATCH_W1
            jmp  _loop
        }}
    }
}

cx16 {
    ; the sixteen virtual 16-bit registers that the CX16 has defined in the zeropage
    ; they are simulated on the C64 as well but their location in memory is different
    ; (because there's no room for them in the zeropage in the default configuration)
    ; Note that when using ZP options that free up more of the zeropage (such as %zeropage kernalsafe)
    ; there might be enough space to put them there after all, and the compiler will change these addresses!
    ; For C64 OS these are put immediately after the dispatch vector table at the start
    ; of the application.  This is the only fixed memory location we know will be available.
    &uword r0  = $090a
    &uword r1  = $090c
    &uword r2  = $090e
    &uword r3  = $0910
    &uword r4  = $0912
    &uword r5  = $0914
    &uword r6  = $0916
    &uword r7  = $0918
    &uword r8  = $091a
    &uword r9  = $091c
    &uword r10 = $091e
    &uword r11 = $0920
    &uword r12 = $0922
    &uword r13 = $0924
    &uword r14 = $0926
    &uword r15 = $0928

    &word r0s  = $090a
    &word r1s  = $090c
    &word r2s  = $090e
    &word r3s  = $0910
    &word r4s  = $0912
    &word r5s  = $0914
    &word r6s  = $0916
    &word r7s  = $0918
    &word r8s  = $091a
    &word r9s  = $091c
    &word r10s = $091e
    &word r11s = $0920
    &word r12s = $0922
    &word r13s = $0924
    &word r14s = $0926
    &word r15s = $0928

    &ubyte r0L  = $090a
    &ubyte r1L  = $090c
    &ubyte r2L  = $090e
    &ubyte r3L  = $0910
    &ubyte r4L  = $0912
    &ubyte r5L  = $0914
    &ubyte r6L  = $0916
    &ubyte r7L  = $0918
    &ubyte r8L  = $091a
    &ubyte r9L  = $091c
    &ubyte r10L = $091e
    &ubyte r11L = $0920
    &ubyte r12L = $0922
    &ubyte r13L = $0924
    &ubyte r14L = $0926
    &ubyte r15L = $0928

    &ubyte r0H  = $090b
    &ubyte r1H  = $090d
    &ubyte r2H  = $090f
    &ubyte r3H  = $0911
    &ubyte r4H  = $0913
    &ubyte r5H  = $0915
    &ubyte r6H  = $0917
    &ubyte r7H  = $0919
    &ubyte r8H  = $091b
    &ubyte r9H  = $091d
    &ubyte r10H = $091f
    &ubyte r11H = $0921
    &ubyte r12H = $0923
    &ubyte r13H = $0925
    &ubyte r14H = $0927
    &ubyte r15H = $0929

    &byte r0sL  = $090a
    &byte r1sL  = $090c
    &byte r2sL  = $090e
    &byte r3sL  = $0910
    &byte r4sL  = $0912
    &byte r5sL  = $0914
    &byte r6sL  = $0916
    &byte r7sL  = $0918
    &byte r8sL  = $091a
    &byte r9sL  = $091c
    &byte r10sL = $091e
    &byte r11sL = $0920
    &byte r12sL = $0922
    &byte r13sL = $0924
    &byte r14sL = $0926
    &byte r15sL = $0928

    &byte r0sH  = $090b
    &byte r1sH  = $090d
    &byte r2sH  = $090f
    &byte r3sH  = $0911
    &byte r4sH  = $0913
    &byte r5sH  = $0915
    &byte r6sH  = $0917
    &byte r7sH  = $0919
    &byte r8sH  = $091b
    &byte r9sH  = $091d
    &byte r10sH = $091f
    &byte r11sH = $0921
    &byte r12sH = $0923
    &byte r13sH = $0925
    &byte r14sH = $0927
    &byte r15sH = $0929

    asmsub save_virtual_registers() clobbers(A,Y) {
        %asm {{
            ldy  #31
    -       lda  cx16.r0,y
            sta  _cx16_vreg_storage,y
            dey
            bpl  -
            rts

    _cx16_vreg_storage
            .word 0,0,0,0,0,0,0,0
            .word 0,0,0,0,0,0,0,0
            ; !notreached!
        }}
    }

    asmsub restore_virtual_registers() clobbers(A,Y) {
        %asm {{
            ldy  #31
    -       lda  save_virtual_registers._cx16_vreg_storage,y
            sta  cx16.r0,y
            dey
            bpl  -
            rts
        }}
    }

    sub cpu_is_65816() -> bool {
        ; Returns true when you have a 65816 cpu, false when it's a 6502.
        return false
    }

}

p8_sys_startup {
    const uword appbase = $0900

    asmsub  init_system()  {
        ; Called by C64 OS via the 'appinit' slot in the
        ; dispatch vector table at the start of the program.
        %asm {{
            ; do kernal table linking via initextern fixed address
            ldx #<p8b_os.p8l_l_externs
            ldy #>p8b_os.p8l_l_externs
            jsr $02fc

            ; only call pgmark for programs loading at appbase
            lda  #>prog8_program_start
            cmp  #>p8_sys_startup.appbase
            bne  +

            ; mark all app pages as used
            ldx  #>p8_sys_startup.appbase
            ldy  #>prog8_program_end
            jsr p8b_os.p8l_l_pgmark

            ; call normal start routine
          + jmp p8b_main.p8s_start
        }}
    }

    asmsub  init_system_phase2()  {
        %asm {{
            rts     ; no phase 2 steps on C64 OS
        }}
    }

    asmsub  cleanup_at_exit()  {
        %asm {{
            rts     ; no cleanup steps on C64 OS
        }}
    }

}
