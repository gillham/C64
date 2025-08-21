;
; Based on C64 OS os/s/menu.s
;
lmnu {
    %option merge

    const ubyte lmnu_module = $0100-(2*6)
    const uword mnudraw_ = $00
    const uword mnumouse_ = $03
    const uword mnukcmd_ = $06
    const uword deactiv_ = $09
    const ubyte mnuicon = $f2
    const ubyte mnulayer = 3
    const ubyte tptr = $50
    const ubyte lptr_module = $52
    const ubyte cptr = $26
    const uword rootpg = $0382
    const uword defpg = $0383
    const uword defpgcnt = $0384
    const uword umdefpg = $0385
    const uword umdefpgc = $0386
    const uword timutil = $08cd
    const uword memutil = $08de
    const uword statmode = $08ef
    const ubyte stat_drv = 0
    const ubyte stat_app = 1
    const ubyte stat_fil = 2
    const ubyte nextptr = 0
    const ubyte childptr = 2
    const ubyte titleptr = 4
    const ubyte codeptr = 6
    const ubyte entrysize = 8
    const ubyte awidth = 0
    const ubyte petvalue = 1
    const ubyte actcode = 2
    const ubyte modkeys = 3
    const ubyte actionsize = 4
    const ubyte hwidth = 0
    const ubyte hopen = 1
    const ubyte headersize = 2

    ; aliases to functions in the os block below
    alias mnudraw = os.mnudraw
    alias mnumouse = os.mnumouse
    alias mnukcmd = os.mnukcmd
    alias deactiv = os.deactiv
}

;
; These merge into the main kernal jump table in os.p8
;
os {
    %option merge

    asmsub mnudraw() {
        %asm {{
            .byte p8b_lmnu.p8c_lmnu_module
            .word p8b_lmnu.p8c_mnudraw_
            ; rts
            ; !notreached!
        }}
    }
    asmsub mnumouse() {
        %asm {{
            .byte p8b_lmnu.p8c_lmnu_module
            .word p8b_lmnu.p8c_mnumouse_
            ; rts
            ; !notreached!
        }}
    }
    asmsub mnukcmd() {
        %asm {{
            .byte p8b_lmnu.p8c_lmnu_module
            .word p8b_lmnu.p8c_mnukcmd_
            ; rts
            ; !notreached!
        }}
    }
    asmsub deactiv() {
        %asm {{
            .byte p8b_lmnu.p8c_lmnu_module
            .word p8b_lmnu.p8c_deactiv_
            ; rts
            ; !notreached!
        }}
    }
}
