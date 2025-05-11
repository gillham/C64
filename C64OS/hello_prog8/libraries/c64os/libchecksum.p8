;
; Client side linkage for a C64 OS relocatable library.
;
%option ignore_unused
libchecksum {
    ; library size in pages
    const ubyte size = 3
    ; library codes
    const ubyte libcode1 = 'C'
    const ubyte libcode2 = 'H'

    ; pointer to first page of library
    ubyte pgref = 0

    ; byte offset from library load address
    ; aka slot in jmp table
    const uword maketab_ = $06
    const uword initcrc_ = $09
    const uword updc8_ = $0c
    const uword updc16_ = $0f
    const uword updc32_ = $12
    const uword getcrc_ = $15

    ; C64 OS relocatable loading.
    ; This requires the os.appfileref page to be valid.
    sub load() -> bool {
        ; call C64 OS kernal loadlib()
        ;   - loadlib() loads in a library based on the first two letters of the name
        pgref = os.loadlib(size, libcode1, libcode2)

        ; fixup page of subs below
        @(&maketab+2) = pgref
        @(&initcrc+2) = pgref
        @(&updc8+2) = pgref
        @(&updc16+2) = pgref
        @(&updc32+2) = pgref
        @(&getcrc+2) = pgref
        return true
    }

    ; unload library
    ; should be called from appquit()
    sub unload() -> bool {
        os.unldlib(lser.slunload, libcode1, libcode2)
        return true
    }

    ; wrappers for library routines

    asmsub maketab(ubyte arg0 @A) -> bool @Pc {
        %asm {{
            jmp p8b_libchecksum.p8c_maketab_
        }}
    }

    asmsub initcrc(ubyte arg0 @A) -> bool @Pc {
        %asm {{
            jmp p8b_libchecksum.p8c_initcrc_
        }}
    }

    asmsub updc8(ubyte arg0 @A) {
        %asm {{
            jmp p8b_libchecksum.p8c_updc8_
        }}
    }

    asmsub updc16(ubyte arg0 @A) {
        %asm {{
            jmp p8b_libchecksum.p8c_updc16_
        }}
    }

    asmsub updc32(ubyte arg0 @A) {
        %asm {{
            jmp p8b_libchecksum.p8c_updc32_
        }}
    }

    asmsub getcrc(ubyte arg0 @A, bool arg1 @Pc) -> uword @XY, bool @Pc {
        %asm {{
            jmp p8b_libchecksum.p8c_getcrc_
        }}
    }
}