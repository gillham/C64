;
; Based on C64 OS os/s/service.t
;
lser {
    %option merge

    const ubyte lser_module = $0100-(2*7)
    const uword alert_ = $00
    const uword confirq_ = $03
    const uword getargs_ = $06
    const uword updstat_ = $09
    const uword setflags_ = $0c
    const uword redrwtod_ = $0f
    const uword setgfx_ = $12
    const uword getsfref_ = $15
    const uword syskcmd_ = $18
    const uword initextern_ = $1b
    const uword loadutil_ = $1e
    const uword quitapp_ = $21
    const uword loadapp_ = $24
    const uword loadreloc_ = $27
    const uword loadlib_ = $2a
    const uword unldlib_ = $2d
    const ubyte jiffylo = $a2
    const ubyte jiffymi = $a1
    const ubyte jiffyhi = $a0
    const ubyte jcount = $cd
    const ubyte jc_min = $eb
    const ubyte sysjmp = $54
    const ubyte jmpvec = $55
    const uword raw_rts = $02b2
    const uword sec_rts = $02b3
    const uword clc_rts = $02b5
    const uword emptystr = $02b7
    const uword sysfref = $02c0
    const uword homebase = $02e9
    const uword evttime = $02ff
    const uword cpuusage = $0217
    const ubyte busychar = $e6
    const uword loopbrkvec = $0336
    const uword appfileref = $0338
    const uword opnfileref = $033a
    const uword berrcode = $03b9
    const uword basicerr = $08f0
    const uword redirect = $08f4
    const uword redirectvec = $08f9
    const uword opnutilmcmd = $03fa
    const uword opnutilmdlo = $03fb
    const uword opnutilmdhi = $03fc
    const uword opnappmcmd = $03fa
    const uword opnappmdlo = $03fb
    const uword opnappmdhi = $03fc
    const uword syskvals = $02b8
    const uword syskmods = $02bc
    const uword himemuse = $03fe
    const ubyte hmemfree = %00000000
    const ubyte hmemutil = %00000001
    const ubyte hmembuff = %00000010
    const ubyte hmembitm = %01000000
    const ubyte hmemmult = %10000000
    const uword redrawflgs = $03ff
    const ubyte rnewgfx = %00000001
    const ubyte renagfx = %00000010
    const ubyte rgraphix = %00000100
    const ubyte rmodal = %00001000
    const ubyte rstatbar = %00010000
    const ubyte rcpubusy = %00100000
    const ubyte rclock = %01000000
    const ubyte rmenubar = %10000000
    const uword libchrlo = $08a2
    const uword libchrhi = $08ac
    const uword libinfo = $08b6
    const uword liblocs = $08c0
    const ubyte slnoinit = %10000000
    const ubyte slunload = %10000000

    ; aliases to functions in the os block below
    alias alert = os.alert
    alias confirq = os.confirq
    alias getargs = os.getargs
    alias updstat = os.updstat
    alias setflags = os.setflags
    alias redrwtod = os.redrwtod
    alias setgfx = os.setgfx
    alias getsfref = os.getsfref
    alias syskcmd = os.syskcmd
    alias initextern = os.initextern
    alias loadutil = os.loadutil
    alias quitapp = os.quitapp
    alias loadapp = os.loadapp
    alias loadreloc = os.loadreloc
    alias loadlib = os.loadlib
    alias unldlib = os.unldlib
}

;
; These merge into the main kernal jump table in os.p8
;
os {
    %option merge

    asmsub alert() {
        %asm {{
            .byte p8b_lser.p8c_lser_module
            .word p8b_lser.p8c_alert_
            ; rts
            ; !notreached!
        }}
    }
    asmsub confirq() {
        %asm {{
            .byte p8b_lser.p8c_lser_module
            .word p8b_lser.p8c_confirq_
            ; rts
            ; !notreached!
        }}
    }
    asmsub getargs(ubyte arg0 @A) {
        %asm {{
            .byte p8b_lser.p8c_lser_module
            .word p8b_lser.p8c_getargs_
            ; rts
            ; !notreached!
        }}
    }
    asmsub updstat() {
        %asm {{
            .byte p8b_lser.p8c_lser_module
            .word p8b_lser.p8c_updstat_
            ; rts
            ; !notreached!
        }}
    }
    asmsub setflags(ubyte arg0 @A) {
        %asm {{
            .byte p8b_lser.p8c_lser_module
            .word p8b_lser.p8c_setflags_
            ; rts
            ; !notreached!
        }}
    }
    asmsub redrwtod() {
        %asm {{
            .byte p8b_lser.p8c_lser_module
            .word p8b_lser.p8c_redrwtod_
            ; rts
            ; !notreached!
        }}
    }
    asmsub setgfx(uword arg0 @XY) {
        %asm {{
            .byte p8b_lser.p8c_lser_module
            .word p8b_lser.p8c_setgfx_
            ; rts
            ; !notreached!
        }}
    }
    asmsub getsfref(ubyte arg0 @Y) -> ubyte @X, ubyte @Y {
        %asm {{
            .byte p8b_lser.p8c_lser_module
            .word p8b_lser.p8c_getsfref_
            ; rts
            ; !notreached!
        }}
    }
    asmsub syskcmd(ubyte arg0 @A, ubyte arg1 @Y) {
        %asm {{
            .byte p8b_lser.p8c_lser_module
            .word p8b_lser.p8c_syskcmd_
            ; rts
            ; !notreached!
        }}
    }
    asmsub loadutil(uword arg0 @XY) -> bool @Pc {
        %asm {{
            .byte p8b_lser.p8c_lser_module
            .word p8b_lser.p8c_loadutil_
            ; rts
            ; !notreached!
        }}
    }
    asmsub quitapp() -> uword @XY {
        %asm {{
            .byte p8b_lser.p8c_lser_module
            .word p8b_lser.p8c_quitapp_
            ; rts
            ; !notreached!
        }}
    }
    asmsub loadapp(uword arg0 @XY) {
        %asm {{
            .byte p8b_lser.p8c_lser_module
            .word p8b_lser.p8c_loadapp_
            ; rts
            ; !notreached!
        }}
    }
    asmsub loadreloc(uword arg0 @XY) -> ubyte @A, bool @Pc {
        %asm {{
            .byte p8b_lser.p8c_lser_module
            .word p8b_lser.p8c_loadreloc_
            ; rts
            ; !notreached!
        }}
    }
    asmsub loadlib(ubyte arg0 @A, ubyte arg1 @X, ubyte arg2 @Y) -> ubyte @A {
        %asm {{
            .byte p8b_lser.p8c_lser_module
            .word p8b_lser.p8c_loadlib_
            ; rts
            ; !notreached!
        }}
    }
    asmsub unldlib(ubyte arg0 @A, ubyte arg1 @X, ubyte arg2 @Y) {
        %asm {{
            .byte p8b_lser.p8c_lser_module
            .word p8b_lser.p8c_unldlib_
            ; rts
            ; !notreached!
        }}
    }
}