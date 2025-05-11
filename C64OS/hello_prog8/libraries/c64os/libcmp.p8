;
; Client side linkage for a C64 OS relocatable library.
;
%option ignore_unused
libcmp {
    ; library size in pages
    const ubyte size = 2
    ; library codes
    const ubyte libcode1 = 'C'
    const ubyte libcode2 = 'M'

    ; pointer to first page of library
    ubyte pgref = 0

    ; byte offset from library load address
    ; aka slot in jmp table
    const uword confcmp_ = $00

    ; C64 OS relocatable loading.
    ; This requires the os.appfileref page to be valid.
    sub load() -> bool {
        ; call C64 OS kernal loadlib()
        ;   - loadlib() loads in a library based on the first two letters of the name
        pgref = os.loadlib(size, libcode1, libcode2)

        ; fixup page of subs below
        @(&confcmp+2) = pgref
        return true
    }

    ; unload library
    ; should be called from appquit()
    sub unload() -> bool {
        os.unldlib(lser.slunload, libcode1, libcode2)
        return true
    }

    ; wrappers for library routines

    asmsub confcmp() {
        %asm {{
            jmp p8b_libcmp.p8c_confcmp_
        }}
    }
}