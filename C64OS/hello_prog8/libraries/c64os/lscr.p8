;
; Based on C64 OS os/s/screen.t
;
lscr {
    %option merge

    const ubyte lscr_module = $0100-(2*5)
    const uword evtloop_ = $00
    const uword markredraw_ = $03
    const uword layerpush_ = $06
    const uword layerpop_ = $09
    const uword setlrc_ = $0c
    const uword setdprops_ = $0f
    const uword ctxclear_ = $12
    const uword ctxdraw_ = $15
    const uword ctx2scr_ = $18
    const uword redraw_ = $1b
    const uword scrrow_ = $1e
    const uword loadclr_ = $21
    const uword loadicns_ = $24
    const uword copybufs_ = $27
    const uword palflag = $02a6
    const ubyte screen_cols = 40
    const ubyte screen_rows = 25
    const ubyte split = $3f
    const ubyte lastsplt = $40
    const uword colhbuf = $0300
    const uword colmbuf = $0302
    const ubyte rvs_mask = %10000000
    const ubyte sldraw = 0
    const ubyte slmous = 2
    const ubyte slkcmd = 4
    const ubyte slkprt = 6
    const ubyte slindx = 8
    const ubyte slsize = 9
    const uword current = $0381
    const ubyte layeridx = $96
    const ubyte laydirtx = $9f

    ; aliases to functions in the os block below
    alias evtloop = os.evtloop
    alias markredraw = os.markredraw
    alias layerpush = os.layerpush
    alias layerpop = os.layerpop
    alias setlrc = os.setlrc
    alias setdprops = os.setdprops
    alias ctxclear = os.ctxclear
    alias ctxdraw = os.ctxdraw
    alias ctx2scr = os.ctx2scr
    alias redraw = os.redraw
    alias scrrow = os.scrrow
    alias loadclr = os.loadclr
    alias loadicns = os.loadicns
    alias copybufs = os.copybufs
}

;
; These merge into the main kernal jump table in os.p8
;
os {
    %option merge

    asmsub evtloop() {
        %asm {{
            .byte p8b_lscr.p8c_lscr_module
            .word p8b_lscr.p8c_evtloop_
            ; rts
            ; !notreached!
        }}
    }
    asmsub markredraw(ubyte arg0 @X) {
        %asm {{
            .byte p8b_lscr.p8c_lscr_module
            .word p8b_lscr.p8c_markredraw_
            ; rts
            ; !notreached!
        }}
    }
    asmsub layerpush(uword arg0 @XY) -> bool @Pc {
        %asm {{
            .byte p8b_lscr.p8c_lscr_module
            .word p8b_lscr.p8c_layerpush_
            ; rts
            ; !notreached!
        }}
    }
    asmsub layerpop() -> bool @Pz {
        %asm {{
            .byte p8b_lscr.p8c_lscr_module
            .word p8b_lscr.p8c_layerpop_
            ; rts
            ; !notreached!
        }}
    }
    asmsub setlrc(uword arg0 @XY, bool arg1 @Pc) {
        %asm {{
            .byte p8b_lscr.p8c_lscr_module
            .word p8b_lscr.p8c_setlrc_
            ; rts
            ; !notreached!
        }}
    }
    asmsub setdprops(ubyte arg0 @X, ubyte arg1 @Y) {
        %asm {{
            .byte p8b_lscr.p8c_lscr_module
            .word p8b_lscr.p8c_setdprops_
            ; rts
            ; !notreached!
        }}
    }
    asmsub ctxclear(ubyte arg0 @A) {
        %asm {{
            .byte p8b_lscr.p8c_lscr_module
            .word p8b_lscr.p8c_ctxclear_
            ; rts
            ; !notreached!
        }}
    }
    asmsub ctxdraw(ubyte arg0 @A) -> bool @Pc {
        %asm {{
            .byte p8b_lscr.p8c_lscr_module
            .word p8b_lscr.p8c_ctxdraw_
            ; rts
            ; !notreached!
        }}
    }
    asmsub ctx2scr(ubyte arg0 @X, ubyte arg1 @Y) {
        %asm {{
            .byte p8b_lscr.p8c_lscr_module
            .word p8b_lscr.p8c_ctx2scr_
            ; rts
            ; !notreached!
        }}
    }
    asmsub redraw() {
        %asm {{
            .byte p8b_lscr.p8c_lscr_module
            .word p8b_lscr.p8c_redraw_
            ; rts
            ; !notreached!
        }}
    }
    asmsub scrrow(ubyte arg0 @A, uword arg1 @XY) -> uword @XY {
        %asm {{
            .byte p8b_lscr.p8c_lscr_module
            .word p8b_lscr.p8c_scrrow_
            ; rts
            ; !notreached!
        }}
    }
    asmsub loadclr() {
        %asm {{
            .byte p8b_lscr.p8c_lscr_module
            .word p8b_lscr.p8c_loadclr_
            ; rts
            ; !notreached!
        }}
    }
    asmsub loadicns(uword arg0 @XY) {
        %asm {{
            .byte p8b_lscr.p8c_lscr_module
            .word p8b_lscr.p8c_loadicns_
            ; rts
            ; !notreached!
        }}
    }
    asmsub copybufs() {
        %asm {{
            .byte p8b_lscr.p8c_lscr_module
            .word p8b_lscr.p8c_copybufs_
            ; rts
            ; !notreached!
        }}
    }
}