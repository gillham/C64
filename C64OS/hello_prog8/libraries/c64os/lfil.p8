;
; Based on C64 OS os/s/file.t
;
lfil {
    %option merge

    const ubyte lfil_module = $0100-(2*8)
    const uword finit_ = $00
    const uword ferror_ = $03
    const uword fopen_ = $06
    const uword fread_ = $09
    const uword fwrite_ = $0c
    const uword fclose_ = $0f
    const uword frefcvt_ = $12
    const uword clipin_ = $15
    const uword clipout_ = $18
    const uword copen_ = $1b
    const uword cread_ = $1e
    const uword cwrite_ = $21
    const uword cclose_ = $24
    const ubyte frefdev = 0
    const ubyte frefpart = 1
    const ubyte freflfn = 2
    const ubyte frefblks = 3
    const ubyte frefname = 5
    const ubyte frefpath = 22
    const uword frefsize = 256
    const ubyte ff_r = %00000001
    const ubyte ff_s = %00000010
    const ubyte ff_w = %00000100
    const ubyte ff_a = %00001000
    const ubyte ff_o = %00010000
    const ubyte ff_p = %01000000
    const ubyte ff_q = %10000000
    const ubyte status = $90
    const ubyte filesopen = $98
    const ubyte fnamelen = $b7
    const ubyte currentlf = $b8
    const ubyte currentsa = $b9
    const ubyte currentdv = $ba
    const ubyte fnameptr = $bb
    const uword f_prefix = $0200
    const uword f_name = $0203
    const uword lfntab = $0259
    const ubyte templfn = $7f
    const uword c_dtype = $0246
    const uword c_dstype = $0247
    const uword c_dsize = $0248
    const uword l_code = $0354
    const uword l_dev = $0355
    const uword l_stat = $0356
    const uword l_msg = $0359
    const uword l_trk = $037b
    const uword l_sec = $037e

    ; aliases to functions in the os block below
    alias finit = os.finit
    alias ferror = os.ferror
    alias fopen = os.fopen
    alias fread = os.fread
    alias fwrite = os.fwrite
    alias fclose = os.fclose
    alias frefcvt = os.frefcvt
    alias clipin = os.clipin
    alias clipout = os.clipout
    alias copen = os.copen
    alias cread = os.cread
    alias cwrite = os.cwrite
    alias cclose = os.cclose
}

;
; These merge into the main kernal jump table in os.p8
;
os {
    %option merge

    asmsub finit(uword arg0 @XY) -> ubyte @A, ubyte @X, bool @Pc {
        %asm {{
            .byte p8b_lfil.p8c_lfil_module
            .word p8b_lfil.p8c_finit_
            ; rts
            ; !notreached!
        }}
    }
    asmsub ferror() -> ubyte @A {
        %asm {{
            .byte p8b_lfil.p8c_lfil_module
            .word p8b_lfil.p8c_ferror_
            ; rts
            ; !notreached!
        }}
    }
    asmsub fopen(ubyte arg0 @A, uword arg1 @XY) -> ubyte @A, uword @XY, bool @Pc {
        %asm {{
            .byte p8b_lfil.p8c_lfil_module
            .word p8b_lfil.p8c_fopen_
            ; rts
            ; !notreached!
        }}
    }
    asmsub fread(uword arg0 @XY) -> uword @XY {
        %asm {{
            .byte p8b_lfil.p8c_lfil_module
            .word p8b_lfil.p8c_fread_
            ; rts
            ; !notreached!
        }}
    }
    asmsub fwrite(uword arg0 @XY) -> uword @XY {
        %asm {{
            .byte p8b_lfil.p8c_lfil_module
            .word p8b_lfil.p8c_fwrite_
            ; rts
            ; !notreached!
        }}
    }
    asmsub fclose(uword arg0 @XY) {
        %asm {{
            .byte p8b_lfil.p8c_lfil_module
            .word p8b_lfil.p8c_fclose_
            ; rts
            ; !notreached!
        }}
    }
    asmsub frefcvt(uword arg0 @XY) -> uword @XY {
        %asm {{
            .byte p8b_lfil.p8c_lfil_module
            .word p8b_lfil.p8c_frefcvt_
            ; rts
            ; !notreached!
        }}
    }
    asmsub clipin(ubyte arg0 @A, uword arg1 @XY) {
        %asm {{
            .byte p8b_lfil.p8c_lfil_module
            .word p8b_lfil.p8c_clipin_
            ; rts
            ; !notreached!
        }}
    }
    asmsub clipout(ubyte arg0 @A, uword arg1 @XY) {
        %asm {{
            .byte p8b_lfil.p8c_lfil_module
            .word p8b_lfil.p8c_clipout_
            ; rts
            ; !notreached!
        }}
    }
    asmsub copen(ubyte arg0 @A) -> uword @XY {
        %asm {{
            .byte p8b_lfil.p8c_lfil_module
            .word p8b_lfil.p8c_copen_
            ; rts
            ; !notreached!
        }}
    }
    asmsub cread(ubyte arg0 @A, uword arg1 @XY) {
        %asm {{
            .byte p8b_lfil.p8c_lfil_module
            .word p8b_lfil.p8c_cread_
            ; rts
            ; !notreached!
        }}
    }
    asmsub cwrite(ubyte arg0 @A, uword arg1 @XY) {
        %asm {{
            .byte p8b_lfil.p8c_lfil_module
            .word p8b_lfil.p8c_cwrite_
            ; rts
            ; !notreached!
        }}
    }
    asmsub cclose(ubyte arg0 @X, ubyte arg1 @Y) {
        %asm {{
            .byte p8b_lfil.p8c_lfil_module
            .word p8b_lfil.p8c_cclose_
            ; rts
            ; !notreached!
        }}
    }
}