;
; Client side linkage for a C64 OS relocatable library.
;
%option ignore_unused
libdir {
    ; library size in pages
    const ubyte size = 5
    ; library codes
    const ubyte libcode1 = 'D'
    const ubyte libcode2 = 'I'

    ; pointer to first page of library
    ubyte pgref = 0

    ; byte offset from library load address
    ; aka slot in jmp table
    const uword getdirp_ = $00
    const uword freedir_ = $03
    const uword readdir_ = $06

    ; C64 OS relocatable loading.
    ; This requires the os.appfileref page to be valid.
    sub load() -> bool {
        ; call C64 OS kernal loadlib()
        ;   - loadlib() loads in a library based on the first two letters of the name
        pgref = os.loadlib(size, libcode1, libcode2)

        ; fixup page of subs below
        @(&getdirp+2) = pgref
        @(&freedir+2) = pgref
        @(&readdir+2) = pgref
        return true
    }

    ; unload library
    ; should be called from appquit()
    sub unload() -> bool {
        os.unldlib(lser.slunload, libcode1, libcode2)
        return true
    }

    ; wrappers for library routines

    asmsub getdirp() -> ubyte @A {
        %asm {{
            jmp p8b_libdir.p8c_getdirp_
        }}
    }

    asmsub freedir(ubyte arg0 @A) {
        %asm {{
            jmp p8b_libdir.p8c_freedir_
        }}
    }

    asmsub readdir() -> ubyte @X, bool @Pc {
        %asm {{
            jmp p8b_libdir.p8c_readdir_
        }}
    }
}