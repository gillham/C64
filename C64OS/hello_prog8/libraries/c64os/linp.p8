;
; Based on C64 OS os/s/input.t
;
linp {
    %option merge

    const ubyte linp_module = $0100-(2*2)
    const uword initmouse_ = $00
    const uword killmouse_ = $03
    const uword hidemouse_ = $06
    const uword mouserc_ = $09
    const uword readmouse_ = $0c
    const uword deqmouse_ = $0f
    const uword readkcmd_ = $12
    const uword deqkcmd_ = $15
    const uword readkprnt_ = $18
    const uword deqkprnt_ = $1b
    const uword polldevices_ = $1e
    const uword scrlwhls = $0287
    const uword dblclktm = $0288
    const uword mouseptr = $028f
    const uword mouseacc = $0290
    const ubyte musxpos = $41
    const ubyte musypos = $43
    const uword mus0col = $02fa
    const uword mus1col = $02fb
    const uword mousesiz = $08cb
    const uword mbufidx = $0310
    const uword musbufx = $07e8
    const uword musbufy = $07ee
    const uword musbuff = $07f4
    const uword kcbufidx = $0311
    const uword kcbufpet = $07fa
    const uword kcbufkmd = $07fd
    const ubyte kbufptr = $c6
    const uword kbuffer = $0277
    const uword musflgs = $03fd
    const ubyte mouseon = %00000001
    const ubyte mousetrk = %00000010
    const ubyte mousemvd = %00000100
    const ubyte mousehid = %00010000
    const ubyte mousepre = %00100000
    const ubyte mousenat = %01000000
    const ubyte mouselft = %10000000
    const uword keymods = $028d
    const ubyte musbtns = $f2
    const ubyte lshftkey = %00000001
    const ubyte cbmkey = %00000010
    const ubyte ctrlkey = %00000100
    const ubyte rshftkey = %00001000
    const ubyte mus_shft = %00010000
    const ubyte mus_cbm = %00100000
    const ubyte mus_ctrl = %01000000
    const ubyte lbutmask = %00010000
    const ubyte wdnmask = %00001000
    const ubyte wupmask = %00000100
    const ubyte mbutmask = %00000010
    const ubyte rbutmask = %00000001
    const ubyte move = 0
    const ubyte ldown = 1
    const ubyte ltrack = 2
    const ubyte lup = 3
    const ubyte lclick = 4
    const ubyte ldclik = 5
    const ubyte rdown = 6
    const ubyte rtrack = 7
    const ubyte rup = 8
    const ubyte rclick = 9
    const ubyte mdown = 10
    const ubyte mup = 11
    const ubyte mclick = 12
    const ubyte wdown = 13
    const ubyte wup = 14

    ; aliases to functions in the os block below
    alias initmouse = os.initmouse
    alias killmouse = os.killmouse
    alias hidemouse = os.hidemouse
    alias mouserc = os.mouserc
    alias readmouse = os.readmouse
    alias deqmouse = os.deqmouse
    alias readkcmd = os.readkcmd
    alias deqkcmd = os.deqkcmd
    alias readkprnt = os.readkprnt
    alias deqkprnt = os.deqkprnt
    alias polldevices = os.polldevices
}

;
; These merge into the main kernal jump table in os.p8
;
os {
    %option merge

    asmsub initmouse(bool arg0 @Pc) {
        %asm {{
            .byte p8b_linp.p8c_linp_module
            .word p8b_linp.p8c_initmouse_
            ; rts
            ; !notreached!
        }}
    }
    asmsub killmouse() -> bool @Pc {
        %asm {{
            .byte p8b_linp.p8c_linp_module
            .word p8b_linp.p8c_killmouse_
            ; rts
            ; !notreached!
        }}
    }
    asmsub hidemouse() {
        %asm {{
            .byte p8b_linp.p8c_linp_module
            .word p8b_linp.p8c_hidemouse_
            ; rts
            ; !notreached!
        }}
    }
    asmsub mouserc(ubyte arg0 @A, ubyte arg1 @X, ubyte arg2 @Y) -> ubyte @A, ubyte @X, ubyte @Y {
        %asm {{
            .byte p8b_linp.p8c_linp_module
            .word p8b_linp.p8c_mouserc_
            ; rts
            ; !notreached!
        }}
    }
    asmsub readmouse() -> ubyte @A, ubyte @X, ubyte @Y, bool @Pc {
        %asm {{
            .byte p8b_linp.p8c_linp_module
            .word p8b_linp.p8c_readmouse_
            ; rts
            ; !notreached!
        }}
    }
    asmsub deqmouse(bool arg0 @Pc) {
        %asm {{
            .byte p8b_linp.p8c_linp_module
            .word p8b_linp.p8c_deqmouse_
            ; rts
            ; !notreached!
        }}
    }
    asmsub readkcmd() -> ubyte @A, ubyte @Y, bool @Pc {
        %asm {{
            .byte p8b_linp.p8c_linp_module
            .word p8b_linp.p8c_readkcmd_
            ; rts
            ; !notreached!
        }}
    }
    asmsub deqkcmd() {
        %asm {{
            .byte p8b_linp.p8c_linp_module
            .word p8b_linp.p8c_deqkcmd_
            ; rts
            ; !notreached!
        }}
    }
    asmsub readkprnt() -> ubyte @A, bool @Pc {
        %asm {{
            .byte p8b_linp.p8c_linp_module
            .word p8b_linp.p8c_readkprnt_
            ; rts
            ; !notreached!
        }}
    }
    asmsub deqkprnt() {
        %asm {{
            .byte p8b_linp.p8c_linp_module
            .word p8b_linp.p8c_deqkprnt_
            ; rts
            ; !notreached!
        }}
    }
    asmsub polldevices() {
        %asm {{
            .byte p8b_linp.p8c_linp_module
            .word p8b_linp.p8c_polldevices_
            ; rts
            ; !notreached!
        }}
    }
}