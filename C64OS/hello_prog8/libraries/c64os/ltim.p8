;
; Based on C64 OS os/s/timers.t
;
ltim {
    %option merge

    const ubyte ltim_module = $0100-(2*10)
    const uword timeque_ = $00
    const uword timedwn_ = $03
    const uword timeevt_ = $06
    const uword msgapp_ = $09
    const uword msgutil_ = $0c
    const uword utiltimr = $0221
    const ubyte timeridx = $09
    const ubyte timerprs = $10
    const ubyte ttime = 0
    const ubyte tstat = 3
    const ubyte ttrig = 4
    const ubyte tvalu = 6
    const ubyte tpause = %10000000
    const ubyte tintrvl = %01000000
    const ubyte tcancel = %00100000
    const ubyte treset = %00010000
    const ubyte texprd = %00001000
    const ubyte tprecis = %00000100
    const ubyte trealtm = %00000010

    ; aliases to functions in the os block below
    alias timeque = os.timeque
    alias timedwn = os.timedwn
    alias timeevt = os.timeevt
    alias msgapp = os.msgapp
    alias msgutil = os.msgutil
}

;
; These merge into the main kernal jump table in os.p8
;
os {
    %option merge

    asmsub timeque(uword arg0 @XY) -> bool @Pc {
        %asm {{
            .byte p8b_ltim.p8c_ltim_module
            .word p8b_ltim.p8c_timeque_
            ; rts
            ; !notreached!
        }}
    }
    asmsub timedwn() {
        %asm {{
            .byte p8b_ltim.p8c_ltim_module
            .word p8b_ltim.p8c_timedwn_
            ; rts
            ; !notreached!
        }}
    }
    asmsub timeevt() {
        %asm {{
            .byte p8b_ltim.p8c_ltim_module
            .word p8b_ltim.p8c_timeevt_
            ; rts
            ; !notreached!
        }}
    }
    asmsub msgapp(ubyte arg0 @A, ubyte arg1 @X, ubyte arg2 @Y, bool arg3 @Pc) {
        %asm {{
            .byte p8b_ltim.p8c_ltim_module
            .word p8b_ltim.p8c_msgapp_
            ; rts
            ; !notreached!
        }}
    }
    asmsub msgutil(ubyte arg0 @A, ubyte arg1 @X, ubyte arg2 @Y, bool arg3 @Pc) {
        %asm {{
            .byte p8b_ltim.p8c_ltim_module
            .word p8b_ltim.p8c_msgutil_
            ; rts
            ; !notreached!
        }}
    }
}