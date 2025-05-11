;
; Based on C64 OS os/s/math.s
;
lmat {
    %option merge

    const ubyte lmat_module = $0100-(2*4)
    const uword mul16_ = $00
    const uword div16_ = $03
    const uword tostr_ = $06
    const uword toint_ = $09
    const uword tohex_ = $0c
    const uword seebas_ = $0f
    const uword div3216_ = $12
    const ubyte divisor = $61
    const ubyte dividnd = $63
    const ubyte divrslt = $63
    const ubyte remandr = $65
    const ubyte divrond = $67
    const ubyte divtemp = $67
    const ubyte divcarry = $68
    const ubyte multplr = $61
    const ubyte multcnd = $63
    const ubyte product = $65

    ; aliases to functions in the os block below
    alias mul16 = os.mul16
    alias div16 = os.div16
    alias tostr = os.tostr
    alias toint = os.toint
    alias tohex = os.tohex
    alias seebas = os.seebas
    alias div3216 = os.div3216
}

;
; These merge into the main kernal jump table in os.p8
;
os {
    %option merge

    asmsub mul16() {
        %asm {{
            .byte p8b_lmat.p8c_lmat_module
            .word p8b_lmat.p8c_mul16_
            ; rts
            ; !notreached!
        }}
    }
    asmsub div16(bool arg0 @Pc) {
        %asm {{
            .byte p8b_lmat.p8c_lmat_module
            .word p8b_lmat.p8c_div16_
            ; rts
            ; !notreached!
        }}
    }
    asmsub tostr() -> uword @XY {
        %asm {{
            .byte p8b_lmat.p8c_lmat_module
            .word p8b_lmat.p8c_tostr_
            ; rts
            ; !notreached!
        }}
    }
    asmsub toint(ubyte arg0 @A, uword arg1 @XY) {
        %asm {{
            .byte p8b_lmat.p8c_lmat_module
            .word p8b_lmat.p8c_toint_
            ; rts
            ; !notreached!
        }}
    }
    asmsub tohex(ubyte arg0 @A) -> ubyte @X, ubyte @Y {
        %asm {{
            .byte p8b_lmat.p8c_lmat_module
            .word p8b_lmat.p8c_tohex_
            ; rts
            ; !notreached!
        }}
    }
    asmsub seebas() {
        %asm {{
            .byte p8b_lmat.p8c_lmat_module
            .word p8b_lmat.p8c_seebas_
            ; rts
            ; !notreached!
        }}
    }
    asmsub div3216() {
        %asm {{
            .byte p8b_lmat.p8c_lmat_module
            .word p8b_lmat.p8c_div3216_
            ; rts
            ; !notreached!
        }}
    }
}