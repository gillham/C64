;
; Based on C64 OS os/s/memory.s
;
lmem {
    %option merge

    const ubyte lmem_module = $0100-(2*1)
    const uword memcpy_ = $00
    const uword memset_ = $03
    const uword memfree_ = $06
    const uword free_ = $09
    const uword malloc_ = $0c
    const uword pgfree_ = $0f
    const uword pgmark_ = $12
    const uword pgalloc_ = $15
    const uword reuconf_ = $18
    const uword pgfetch_ = $1b
    const uword pgstash_ = $1e
    const uword realloc_ = $03
    const uword bkfree_ = $06
    const uword bkalloc_ = $09
    const uword seeram = $02a7
    const uword seeioker = $02ac
    const uword memmap = $0800
    const ubyte mapfree = $00
    const ubyte mapsys = $01
    const ubyte maputil = $02
    const ubyte mapapp = $ff
    const uword mempool = $0380
    const uword mappgfst = $08a1
    const ubyte mappglst = $09
    const uword memdisp = $08cc
    const ubyte mhfree = 0
    const ubyte mhlen = 1
    const ubyte mhsize = 3
    const ubyte memsize = $61

    ; aliases to functions in the os block below
    alias memcpy = os.memcpy
    alias memset = os.memset
    alias memfree = os.memfree
    alias free = os.free
    alias malloc = os.malloc
    alias pgfree = os.pgfree
    alias pgmark = os.pgmark
    alias pgalloc = os.pgalloc
    alias reuconf = os.reuconf
    alias pgfetch = os.pgfetch
    alias pgstash = os.pgstash
    alias realloc = os.realloc
    alias bkfree = os.bkfree
    alias bkalloc = os.bkalloc
}

;
; These merge into the main kernal jump table in os.p8
;
os {
    %option merge

    asmsub memcpy(ubyte arg0 @A, ubyte arg1 @Y) {
        %asm {{
            .byte p8b_lmem.p8c_lmem_module
            .word p8b_lmem.p8c_memcpy_
            ; rts
            ; !notreached!
        }}
    }
    asmsub memset(ubyte arg0 @A, ubyte arg1 @Y) {
        %asm {{
            .byte p8b_lmem.p8c_lmem_module
            .word p8b_lmem.p8c_memset_
            ; rts
            ; !notreached!
        }}
    }
    asmsub memfree() -> ubyte @X {
        %asm {{
            .byte p8b_lmem.p8c_lmem_module
            .word p8b_lmem.p8c_memfree_
            ; rts
            ; !notreached!
        }}
    }
    asmsub free(uword arg0 @XY) {
        %asm {{
            .byte p8b_lmem.p8c_lmem_module
            .word p8b_lmem.p8c_free_
            ; rts
            ; !notreached!
        }}
    }
    asmsub malloc(ubyte arg0 @A, uword arg1 @XY) -> uword @XY, bool @Pc {
        %asm {{
            .byte p8b_lmem.p8c_lmem_module
            .word p8b_lmem.p8c_malloc_
            ; rts
            ; !notreached!
        }}
    }
    asmsub pgfree(ubyte arg0 @X, ubyte arg1 @Y) -> bool @Pc {
        %asm {{
            .byte p8b_lmem.p8c_lmem_module
            .word p8b_lmem.p8c_pgfree_
            ; rts
            ; !notreached!
        }}
    }
    asmsub pgmark(ubyte arg0 @X, ubyte arg1 @Y) {
        %asm {{
            .byte p8b_lmem.p8c_lmem_module
            .word p8b_lmem.p8c_pgmark_
            ; rts
            ; !notreached!
        }}
    }
    asmsub pgalloc(ubyte arg0 @A, ubyte arg1 @X) -> ubyte @Y, bool @Pc {
        %asm {{
            .byte p8b_lmem.p8c_lmem_module
            .word p8b_lmem.p8c_pgalloc_
            ; rts
            ; !notreached!
        }}
    }
    asmsub reuconf(ubyte arg0 @A, uword arg1 @XY) -> ubyte @A, bool @Pc {
        %asm {{
            .byte p8b_lmem.p8c_lmem_module
            .word p8b_lmem.p8c_reuconf_
            ; rts
            ; !notreached!
        }}
    }
    asmsub pgfetch(uword arg0 @XY) -> bool @Pc {
        %asm {{
            .byte p8b_lmem.p8c_lmem_module
            .word p8b_lmem.p8c_pgfetch_
            ; rts
            ; !notreached!
        }}
    }
    asmsub pgstash(uword arg0 @XY) -> bool @Pc {
        %asm {{
            .byte p8b_lmem.p8c_lmem_module
            .word p8b_lmem.p8c_pgstash_
            ; rts
            ; !notreached!
        }}
    }
    asmsub realloc(ubyte arg0 @A, uword arg1 @XY) -> uword @XY, bool @Pc {
        %asm {{
            .byte p8b_lmem.p8c_lmem_module
            .word p8b_lmem.p8c_realloc_
            ; rts
            ; !notreached!
        }}
    }
    asmsub bkfree(ubyte arg0 @X, ubyte arg1 @Y) -> bool @Pc {
        %asm {{
            .byte p8b_lmem.p8c_lmem_module
            .word p8b_lmem.p8c_bkfree_
            ; rts
            ; !notreached!
        }}
    }
    asmsub bkalloc(ubyte arg0 @X) -> ubyte @Y, bool @Pc {
        %asm {{
            .byte p8b_lmem.p8c_lmem_module
            .word p8b_lmem.p8c_bkalloc_
            ; rts
            ; !notreached!
        }}
    }
}