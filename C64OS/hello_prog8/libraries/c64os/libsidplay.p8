;
; Client side linkage for a C64 OS relocatable library.
;
%option ignore_unused
libsidplay {
    ; library size in pages
    const ubyte size = 3
    ; library codes
    const ubyte libcode1 = 'S'
    const ubyte libcode2 = 'I'

    ; pointer to first page of library
    ubyte pgref = 0

    ; byte offset from library load address
    ; aka slot in jmp table
    const uword loadtune_ = $06
    const uword stattune_ = $09
    const uword tuneinfo_ = $0c

    ; C64 OS relocatable loading.
    ; This requires the os.appfileref page to be valid.
    sub load() -> bool {
        ; call C64 OS kernal loadlib()
        ;   - loadlib() loads in a library based on the first two letters of the name
        pgref = os.loadlib(size, libcode1, libcode2)

        ; fixup page of subs below
        @(&loadtune+2) = pgref
        @(&stattune+2) = pgref
        @(&tuneinfo+2) = pgref
        return true
    }

    ; unload library
    ; should be called from appquit()
    sub unload() -> bool {
        os.unldlib(lser.slunload, libcode1, libcode2)
        return true
    }

    ; wrappers for library routines

    asmsub loadtune(uword arg0 @XY) -> ubyte @A, ubyte @X, bool @Pc {
        %asm {{
            jmp p8b_libsidplay.p8c_loadtune_
        }}
    }

    asmsub stattune(ubyte arg0 @A) {
        %asm {{
            jmp p8b_libsidplay.p8c_stattune_
        }}
    }

    asmsub tuneinfo(ubyte arg0 @X) -> uword @XY {
        %asm {{
            jmp p8b_libsidplay.p8c_tuneinfo_
        }}
    }
}