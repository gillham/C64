;
; Client side linkage for a C64 OS relocatable library.
;
%option ignore_unused
libfcopy {
    ; library size in pages
    const ubyte size = 3
    ; library codes
    const ubyte libcode1 = 'F'
    const ubyte libcode2 = 'C'

    ; pointer to first page of library
    ubyte pgref = 0

    ; byte offset from library load address
    ; aka slot in jmp table
    const uword confcopy_ = $06
    const uword filecopy_ = $09
    const uword spotcopy_ = $0c
    const uword renamef_ = $0f
    const uword scratchf_ = $12

    ; C64 OS relocatable loading.
    ; This requires the os.appfileref page to be valid.
    sub load() -> bool {
        ; call C64 OS kernal loadlib()
        ;   - loadlib() loads in a library based on the first two letters of the name
        pgref = os.loadlib(size, libcode1, libcode2)

        ; fixup page of subs below
        @(&confcopy+2) = pgref
        @(&filecopy+2) = pgref
        @(&spotcopy+2) = pgref
        @(&renamef+2) = pgref
        @(&scratchf+2) = pgref
        return true
    }

    ; unload library
    ; should be called from appquit()
    sub unload() -> bool {
        os.unldlib(lser.slunload, libcode1, libcode2)
        return true
    }

    ; wrappers for library routines

    asmsub confcopy() -> ubyte @X, ubyte @Y {
        %asm {{
            jmp p8b_libfcopy.p8c_confcopy_
        }}
    }

    asmsub filecopy() {
        %asm {{
            jmp p8b_libfcopy.p8c_filecopy_
        }}
    }

    asmsub spotcopy() {
        %asm {{
            jmp p8b_libfcopy.p8c_spotcopy_
        }}
    }

    asmsub renamef() {
        %asm {{
            jmp p8b_libfcopy.p8c_renamef_
        }}
    }

    asmsub scratchf() {
        %asm {{
            jmp p8b_libfcopy.p8c_scratchf_
        }}
    }
}