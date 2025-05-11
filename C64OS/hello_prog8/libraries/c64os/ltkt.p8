;
; Based on C64 OS os/s/toolkit.t
;
ltkt {
    %option merge

    const ubyte ltkt_module = $0100-(2*9)
    const uword pushctx_ = $00
    const uword pullctx_ = $03
    const uword setctx_ = $06
    const uword recontext_ = $09
    const uword boundschk_ = $0c
    const uword settkenv_ = $0f
    const uword tkupdate_ = $12
    const uword tkmouse_ = $15
    const uword tkkcmd_ = $18
    const uword tkkprnt_ = $1b
    const uword classlnk_ = $1e
    const uword classptr_ = $21
    const uword tknew_ = $24
    const uword getprop16_ = $27
    const uword ptrthis_ = $2a
    const uword setclass_ = $2d
    const uword setsuper_ = $30
    const uword getmethod_ = $33
    const uword instanceof_ = $36
    const uword walk_ = $39
    const uword isdescof_ = $3c
    const uword opaqancs_ = $3f
    const uword viewwtag_ = $42
    const uword appendto_ = $45
    const ubyte this = $2b
    const ubyte class = $2d
    const ubyte pnode = $2f
    const uword rootview = $03ba
    const ubyte rm_ankt = %00000001
    const ubyte rm_ankb = %00000010
    const ubyte rm_ankl = %00000100
    const ubyte rm_ankr = %00001000
    const ubyte rm_rschd = %10000000
    const ubyte df_dirty = %00000001
    const ubyte df_sized = %00000010
    const ubyte df_opaqu = %00000100
    const ubyte df_afkey = %00001000
    const ubyte df_afmus = %00010000
    const ubyte df_first = %00100000
    const ubyte df_ibnds = %01000000
    const ubyte df_visib = %10000000
    const ubyte mf_resiz = %00000010
    const ubyte mf_bdchk = %01000000
    const ubyte tkenvptr = $ef
    const ubyte te_dctx = 0
    const ubyte te_mpool = 2
    const ubyte te_flags = 3
    const ubyte te_layer = 4
    const ubyte te_rview = 5
    const ubyte te_fkeyv = 7
    const ubyte te_fmusv = 9
    const ubyte te_cmusv = 11
    const ubyte te_posx = 13
    const ubyte te_posy = 14
    const ubyte tf_dirty = %00000001
    const ubyte tf_keyh = %01000000
    const ubyte tf_blur = %10000000

    ; aliases to functions in the os block below
    alias pushctx = os.pushctx
    alias pullctx = os.pullctx
    alias setctx = os.setctx
    alias recontext = os.recontext
    alias boundschk = os.boundschk
    alias settkenv = os.settkenv
    alias tkupdate = os.tkupdate
    alias tkmouse = os.tkmouse
    alias tkkcmd = os.tkkcmd
    alias tkkprnt = os.tkkprnt
    alias classlnk = os.classlnk
    alias classptr = os.classptr
    alias tknew = os.tknew
    alias getprop16 = os.getprop16
    alias ptrthis = os.ptrthis
    alias setclass = os.setclass
    alias setsuper = os.setsuper
    alias getmethod = os.getmethod
    alias instanceof = os.instanceof
    alias walk = os.walk
    alias isdescof = os.isdescof
    alias opaqancs = os.opaqancs
    alias viewwtag = os.viewwtag
    alias appendto = os.appendto
}

;
; These merge into the main kernal jump table in os.p8
;
os {
    %option merge

    asmsub pushctx() {
        %asm {{
            .byte p8b_ltkt.p8c_ltkt_module
            .word p8b_ltkt.p8c_pushctx_
            ; rts
            ; !notreached!
        }}
    }
    asmsub pullctx() {
        %asm {{
            .byte p8b_ltkt.p8c_ltkt_module
            .word p8b_ltkt.p8c_pullctx_
            ; rts
            ; !notreached!
        }}
    }
    asmsub setctx(uword arg0 @XY) {
        %asm {{
            .byte p8b_ltkt.p8c_ltkt_module
            .word p8b_ltkt.p8c_setctx_
            ; rts
            ; !notreached!
        }}
    }
    asmsub recontext() {
        %asm {{
            .byte p8b_ltkt.p8c_ltkt_module
            .word p8b_ltkt.p8c_recontext_
            ; rts
            ; !notreached!
        }}
    }
    asmsub boundschk() -> bool @Pc {
        %asm {{
            .byte p8b_ltkt.p8c_ltkt_module
            .word p8b_ltkt.p8c_boundschk_
            ; rts
            ; !notreached!
        }}
    }
    asmsub settkenv(uword arg0 @XY) {
        %asm {{
            .byte p8b_ltkt.p8c_ltkt_module
            .word p8b_ltkt.p8c_settkenv_
            ; rts
            ; !notreached!
        }}
    }
    asmsub tkupdate(uword arg0 @XY) {
        %asm {{
            .byte p8b_ltkt.p8c_ltkt_module
            .word p8b_ltkt.p8c_tkupdate_
            ; rts
            ; !notreached!
        }}
    }
    asmsub tkmouse(uword arg0 @XY) -> bool @Pc {
        %asm {{
            .byte p8b_ltkt.p8c_ltkt_module
            .word p8b_ltkt.p8c_tkmouse_
            ; rts
            ; !notreached!
        }}
    }
    asmsub tkkcmd(uword arg0 @XY) -> bool @Pc {
        %asm {{
            .byte p8b_ltkt.p8c_ltkt_module
            .word p8b_ltkt.p8c_tkkcmd_
            ; rts
            ; !notreached!
        }}
    }
    asmsub tkkprnt(uword arg0 @XY) -> bool @Pc {
        %asm {{
            .byte p8b_ltkt.p8c_ltkt_module
            .word p8b_ltkt.p8c_tkkprnt_
            ; rts
            ; !notreached!
        }}
    }
    asmsub classlnk(uword arg0 @XY) {
        %asm {{
            .byte p8b_ltkt.p8c_ltkt_module
            .word p8b_ltkt.p8c_classlnk_
            ; rts
            ; !notreached!
        }}
    }
    asmsub classptr(ubyte arg0 @X) -> uword @XY {
        %asm {{
            .byte p8b_ltkt.p8c_ltkt_module
            .word p8b_ltkt.p8c_classptr_
            ; rts
            ; !notreached!
        }}
    }
    asmsub tknew(uword arg0 @XY) -> uword @XY {
        %asm {{
            .byte p8b_ltkt.p8c_ltkt_module
            .word p8b_ltkt.p8c_tknew_
            ; rts
            ; !notreached!
        }}
    }
    asmsub getprop16(ubyte arg0 @Y) -> uword @XY {
        %asm {{
            .byte p8b_ltkt.p8c_ltkt_module
            .word p8b_ltkt.p8c_getprop16_
            ; rts
            ; !notreached!
        }}
    }
    asmsub ptrthis(uword arg0 @XY) {
        %asm {{
            .byte p8b_ltkt.p8c_ltkt_module
            .word p8b_ltkt.p8c_ptrthis_
            ; rts
            ; !notreached!
        }}
    }
    asmsub setclass() {
        %asm {{
            .byte p8b_ltkt.p8c_ltkt_module
            .word p8b_ltkt.p8c_setclass_
            ; rts
            ; !notreached!
        }}
    }
    asmsub setsuper() {
        %asm {{
            .byte p8b_ltkt.p8c_ltkt_module
            .word p8b_ltkt.p8c_setsuper_
            ; rts
            ; !notreached!
        }}
    }
    asmsub getmethod(ubyte arg0 @Y) -> uword @XY {
        %asm {{
            .byte p8b_ltkt.p8c_ltkt_module
            .word p8b_ltkt.p8c_getmethod_
            ; rts
            ; !notreached!
        }}
    }
    asmsub instanceof(uword arg0 @XY) -> bool @Pc {
        %asm {{
            .byte p8b_ltkt.p8c_ltkt_module
            .word p8b_ltkt.p8c_instanceof_
            ; rts
            ; !notreached!
        }}
    }
    asmsub walk(ubyte arg0 @A) -> bool @Pc {
        %asm {{
            .byte p8b_ltkt.p8c_ltkt_module
            .word p8b_ltkt.p8c_walk_
            ; rts
            ; !notreached!
        }}
    }
    asmsub isdescof(uword arg0 @XY) -> ubyte @A, bool @Pz {
        %asm {{
            .byte p8b_ltkt.p8c_ltkt_module
            .word p8b_ltkt.p8c_isdescof_
            ; rts
            ; !notreached!
        }}
    }
    asmsub opaqancs() -> uword @XY {
        %asm {{
            .byte p8b_ltkt.p8c_ltkt_module
            .word p8b_ltkt.p8c_opaqancs_
            ; rts
            ; !notreached!
        }}
    }
    asmsub viewwtag(ubyte arg0 @A) {
        %asm {{
            .byte p8b_ltkt.p8c_ltkt_module
            .word p8b_ltkt.p8c_viewwtag_
            ; rts
            ; !notreached!
        }}
    }
    asmsub appendto(uword arg0 @XY) {
        %asm {{
            .byte p8b_ltkt.p8c_ltkt_module
            .word p8b_ltkt.p8c_appendto_
            ; rts
            ; !notreached!
        }}
    }
}