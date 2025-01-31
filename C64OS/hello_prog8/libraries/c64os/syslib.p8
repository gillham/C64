; Prog8 definitions for the Commodore 64 running C64 OS.
; Initially minimal sys.* and cx16.* definitions/routines.

%option no_symbol_prefixing, ignore_unused

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
