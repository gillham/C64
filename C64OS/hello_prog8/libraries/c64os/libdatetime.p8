;
; Client side linkage for a C64 OS relocatable library.
;
%option ignore_unused
libdatetime {
    ; library size in pages
    const ubyte size = 2
    ; library codes
    const ubyte libcode1 = 'D'
    const ubyte libcode2 = 'A'

    ; pointer to first page of library
    ubyte pgref = 0

    ; byte offset from library load address
    ; aka slot in jmp table
    const uword toisodt_ = $03
    const uword frisodt_ = $06
    const uword toisotm_ = $09
    const uword frisotm_ = $0c
    const uword gettime_ = $0f
    const uword bcd2int_ = $12

    ; C64 OS relocatable loading.
    ; This requires the os.appfileref page to be valid.
    sub load() -> bool {
        ; call C64 OS kernal loadlib()
        ;   - loadlib() loads in a library based on the first two letters of the name
        pgref = os.loadlib(size, libcode1, libcode2)

        ; fixup page of subs below
        @(&toisodt+2) = pgref
        @(&frisodt+2) = pgref
        @(&toisotm+2) = pgref
        @(&frisotm+2) = pgref
        @(&gettime+2) = pgref
        @(&bcd2int+2) = pgref
        return true
    }

    ; unload library
    ; should be called from appquit()
    sub unload() -> bool {
        os.unldlib(lser.slunload, libcode1, libcode2)
        return true
    }

    ; wrappers for library routines

    asmsub toisodt(ubyte arg0 @A, ubyte arg1 @X, ubyte arg2 @Y) -> uword @XY {
        %asm {{
            jmp p8b_libdatetime.p8c_toisodt_
        }}
    }

    asmsub frisodt(uword arg0 @XY) -> ubyte @A, ubyte @X, ubyte @Y {
        %asm {{
            jmp p8b_libdatetime.p8c_frisodt_
        }}
    }

    asmsub toisotm(ubyte arg0 @X, ubyte arg1 @Y) -> uword @XY {
        %asm {{
            jmp p8b_libdatetime.p8c_toisotm_
        }}
    }

    asmsub frisotm(uword arg0 @XY) -> ubyte @X, ubyte @Y {
        %asm {{
            jmp p8b_libdatetime.p8c_frisotm_
        }}
    }

    asmsub gettime() -> ubyte @X, ubyte @Y {
        %asm {{
            jmp p8b_libdatetime.p8c_gettime_
        }}
    }

    asmsub bcd2int(ubyte arg0 @A) -> ubyte @A {
        %asm {{
            jmp p8b_libdatetime.p8c_bcd2int_
        }}
    }
}