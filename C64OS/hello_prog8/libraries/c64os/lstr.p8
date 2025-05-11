;
; Based on C64 OS os/s/string.s
;
lstr {
    %option merge

    const ubyte lstr_module = $0100-(2*3)
    const uword strlen_ = $00
    const uword memncpy_ = $03
    const uword asc2pet_ = $06
    const uword pet2asc_ = $09
    const uword pet2scr_ = $0c
    const uword tolower_ = $0f
    const uword toupper_ = $12
    const uword isdigit_ = $15
    const uword strdel_ = $18
    const uword strins_ = $1b
    const ubyte strptr = $61
    const ubyte stralt = $63
    const uword printstr = $ab1e

    ; aliases to functions in the os block below
    alias strlen = os.strlen
    alias memncpy = os.memncpy
    alias asc2pet = os.asc2pet
    alias pet2asc = os.pet2asc
    alias pet2scr = os.pet2scr
    alias tolower = os.tolower
    alias toupper = os.toupper
    alias isdigit = os.isdigit
    alias strdel = os.strdel
    alias strins = os.strins
}

;
; These merge into the main kernal jump table in os.p8
;
os {
    %option merge

    asmsub strlen(uword arg0 @XY) -> uword @XY {
        %asm {{
            .byte p8b_lstr.p8c_lstr_module
            .word p8b_lstr.p8c_strlen_
            ; rts
            ; !notreached!
        }}
    }
    asmsub memncpy(ubyte arg0 @A, ubyte arg1 @X, ubyte arg2 @Y) {
        %asm {{
            .byte p8b_lstr.p8c_lstr_module
            .word p8b_lstr.p8c_memncpy_
            ; rts
            ; !notreached!
        }}
    }
    asmsub asc2pet(ubyte arg0 @A) -> ubyte @A {
        %asm {{
            .byte p8b_lstr.p8c_lstr_module
            .word p8b_lstr.p8c_asc2pet_
            ; rts
            ; !notreached!
        }}
    }
    asmsub pet2asc(ubyte arg0 @A) -> ubyte @A {
        %asm {{
            .byte p8b_lstr.p8c_lstr_module
            .word p8b_lstr.p8c_pet2asc_
            ; rts
            ; !notreached!
        }}
    }
    asmsub pet2scr(ubyte arg0 @A) -> ubyte @A {
        %asm {{
            .byte p8b_lstr.p8c_lstr_module
            .word p8b_lstr.p8c_pet2scr_
            ; rts
            ; !notreached!
        }}
    }
    asmsub tolower(ubyte arg0 @A) -> ubyte @A {
        %asm {{
            .byte p8b_lstr.p8c_lstr_module
            .word p8b_lstr.p8c_tolower_
            ; rts
            ; !notreached!
        }}
    }
    asmsub toupper(ubyte arg0 @A) -> ubyte @A {
        %asm {{
            .byte p8b_lstr.p8c_lstr_module
            .word p8b_lstr.p8c_toupper_
            ; rts
            ; !notreached!
        }}
    }
    asmsub isdigit(ubyte arg0 @A) -> bool @Pc {
        %asm {{
            .byte p8b_lstr.p8c_lstr_module
            .word p8b_lstr.p8c_isdigit_
            ; rts
            ; !notreached!
        }}
    }
    asmsub strdel(ubyte arg0 @A, ubyte arg1 @Y) {
        %asm {{
            .byte p8b_lstr.p8c_lstr_module
            .word p8b_lstr.p8c_strdel_
            ; rts
            ; !notreached!
        }}
    }
    asmsub strins(ubyte arg0 @A, ubyte arg1 @Y) {
        %asm {{
            .byte p8b_lstr.p8c_lstr_module
            .word p8b_lstr.p8c_strins_
            ; rts
            ; !notreached!
        }}
    }
}