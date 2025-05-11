;
; Client side linkage for a C64 OS relocatable library.
;
%option ignore_unused
libcalendar {
    ; library size in pages
    const ubyte size = 3
    ; library codes
    const ubyte libcode1 = 'C'
    const ubyte libcode2 = 'A'

    ; pointer to first page of library
    ubyte pgref = 0

    ; byte offset from library load address
    ; aka slot in jmp table
    const uword datetos_ = $03
    const uword firstdow_ = $06
    const uword dayofyr_ = $09
    const uword weeknum_ = $0c
    const uword daysinm_ = $0f
    const uword isleap_ = $12
    const uword mnthname_ = $15
    const uword dayname_ = $18

    ; C64 OS relocatable loading.
    ; This requires the os.appfileref page to be valid.
    sub load() -> bool {
        ; call C64 OS kernal loadlib()
        ;   - loadlib() loads in a library based on the first two letters of the name
        pgref = os.loadlib(size, libcode1, libcode2)

        ; fixup page of subs below
        @(&datetos+2) = pgref
        @(&firstdow+2) = pgref
        @(&dayofyr+2) = pgref
        @(&weeknum+2) = pgref
        @(&daysinm+2) = pgref
        @(&isleap+2) = pgref
        @(&mnthname+2) = pgref
        @(&dayname+2) = pgref
        return true
    }

    ; unload library
    ; should be called from appquit()
    sub unload() -> bool {
        os.unldlib(lser.slunload, libcode1, libcode2)
        return true
    }

    ; wrappers for library routines

    asmsub datetos(ubyte arg0 @A) -> ubyte @X, ubyte @Y {
        %asm {{
            jmp p8b_libcalendar.p8c_datetos_
        }}
    }

    asmsub firstdow(ubyte arg0 @A, ubyte arg1 @X, ubyte arg2 @Y) -> ubyte @A {
        %asm {{
            jmp p8b_libcalendar.p8c_firstdow_
        }}
    }

    asmsub dayofyr(ubyte arg0 @A, ubyte arg1 @X, ubyte arg2 @Y) {
        %asm {{
            jmp p8b_libcalendar.p8c_dayofyr_
        }}
    }

    asmsub weeknum(ubyte arg0 @A, ubyte arg1 @X, ubyte arg2 @Y) -> uword @XY {
        %asm {{
            jmp p8b_libcalendar.p8c_weeknum_
        }}
    }

    asmsub daysinm(ubyte arg0 @X, ubyte arg1 @Y) -> ubyte @A {
        %asm {{
            jmp p8b_libcalendar.p8c_daysinm_
        }}
    }

    asmsub isleap(ubyte arg0 @Y) -> bool @Pc {
        %asm {{
            jmp p8b_libcalendar.p8c_isleap_
        }}
    }

    asmsub mnthname(ubyte arg0 @X) -> ubyte @A, uword @XY {
        %asm {{
            jmp p8b_libcalendar.p8c_mnthname_
        }}
    }

    asmsub dayname(ubyte arg0 @X) -> ubyte @A, uword @XY {
        %asm {{
            jmp p8b_libcalendar.p8c_dayname_
        }}
    }
}