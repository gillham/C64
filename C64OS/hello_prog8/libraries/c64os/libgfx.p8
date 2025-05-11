;
; Client side linkage for a C64 OS relocatable library.
;
%option ignore_unused
libgfx {
    ; library size in pages
    const ubyte size = 4
    ; library codes
    const ubyte libcode1 = 'G'
    const ubyte libcode2 = 'F'

    ; pointer to first page of library
    ubyte pgref = 0

    ; byte offset from library load address
    ; aka slot in jmp table
    const uword gfxlibpg = $08ca
    const uword procgfx_ = $06
    const uword confgfx_ = $09

    ; C64 OS relocatable loading.
    ; This requires the os.appfileref page to be valid.
    sub load() -> bool {
        ; call C64 OS kernal loadlib()
        ;   - loadlib() loads in a library based on the first two letters of the name
        pgref = os.loadlib(size, libcode1, libcode2)

        ; fixup page of subs below
        @(&procgfx+2) = pgref
        @(&confgfx+2) = pgref
        return true
    }

    ; unload library
    ; should be called from appquit()
    sub unload() -> bool {
        os.unldlib(lser.slunload, libcode1, libcode2)
        return true
    }

    ; wrappers for library routines

    asmsub procgfx() {
        %asm {{
            jmp p8b_libgfx.p8c_procgfx_
        }}
    }

    asmsub confgfx(ubyte arg0 @A, ubyte arg1 @X, ubyte arg2 @Y) {
        %asm {{
            jmp p8b_libgfx.p8c_confgfx_
        }}
    }
}