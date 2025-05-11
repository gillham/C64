%option ignore_unused
;
; Each importable modules block needs to be here.
; Otherwise it won't make it to the assembly output.
; Each separate module file does a '%options merge' to these.
;
lmem {}
linp {}
lstr {}
lmat {}
lscr {}
lmnu {}
lser {}
lfil {}
ltkt {}
ltim {}

; fundamental application defines
; os/s/app.s
app {
    ; base address of all C64 OS apps
    const uword appbase         = $0900
    const uword utilbase        = $e000
    const uword initextern      = $02fc

    ; Application jump table
    const ubyte appinit         = $0000
    const ubyte appmcmd         = $0002
    const ubyte appquit         = $0004
    const ubyte appfrze         = $0006
    const ubyte appthaw         = $0008

    ; Utility jump table
    const ubyte utilinit        = $0000
    const ubyte utilmcmd        = $0002
    const ubyte utilquit        = $0004
    const ubyte utilfrze        = $0006
    const ubyte utilthaw        = $0008
    const ubyte utilidnt        = $000a

    ; Message commands
    const ubyte mc_mnu          = $0000
    const ubyte mc_menq         = $0001
    const ubyte mc_col          = $0002
    const ubyte mc_fopn         = $0003
    const ubyte mc_fsav         = $0004
    const ubyte mc_stptr        = $0005
    const ubyte mc_mous         = $0006
    const ubyte mc_kcmd         = $0007
    const ubyte mc_kprt         = $0008
    const ubyte mc_mptr         = $0009
    const ubyte mc_rflg         = $000a
    const ubyte mc_hmem         = $000b
    const ubyte mc_theme        = $000c
    const ubyte mc_chrs         = $000d
    const ubyte mc_devs         = $000e
    const ubyte mc_memw         = $000f
    const ubyte mc_jobc         = $0010
    const ubyte mc_dmod         = $0011
    const ubyte mc_cpbd         = $0012
    const ubyte mc_date         = $0013
    const ubyte mc_fsel         = $0014
    const ubyte mc_splt         = $0015
    const ubyte mc_reua         = $0016
    const ubyte mc_media        = $0017
    const ubyte mc_ntwrk        = $0018
    const ubyte mc_null         = $00ff

    ; Menu status inquiry flags
    const ubyte mnu_dis         = $0001 ; entry disabled
    const ubyte mnu_sel         = $0002 ; entry selected
}

os {
    ; dispatch vector table offsets
    ; used with register()
    const ubyte APP_INIT = 0
    const ubyte APP_MSG = 2
    const ubyte APP_QUIT = 4
    const ubyte APP_FREEZE = 6
    const ubyte APP_THAW = 8

    ; function for registering callbacks
    ; fills jump vector slots at the start of app memory
    sub register(ubyte slot, uword function) {
        app.appbase[slot] = lsb(function)
        app.appbase[slot+1] = msb(function)
    }

    inline asmsub initextern() clobbers(A,X,Y) {
        %asm {{
            ldx #<p8b_os.p8l_l_externs
            ldy #>p8b_os.p8l_l_externs
            jsr $02fc
        }}
    }
l_externs:
    ; special case as it is used by the syslib init_system code.
    l_pgmark:
        %asm {{
            .byte p8b_lmem.p8c_lmem_module
            .word p8b_lmem.p8c_pgmark_
        }}
}

; kernal jump table termination byte
kjmp_terminator {
    %option force_output
    ;l_terminator:
    %asm {{
        .byte $FF
    }}
}
