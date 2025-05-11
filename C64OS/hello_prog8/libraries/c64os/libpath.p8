;
; Client side linkage for a C64 OS relocatable library.
;
%option ignore_unused
libpath {
    ; library size in pages
    const ubyte size = 3
    ; library codes
    const ubyte libcode1 = 'P'
    const ubyte libcode2 = 'A'

    ; pointer to first page of library
    ubyte pgref = 0

    ; byte offset from library load address
    ; aka slot in jmp table
    const uword setname_ = $03
    const uword pathadd_ = $06
    const uword pathup_ = $09
    const uword partroot_ = $0c
    const uword devroot_ = $0f
    const uword gopath_ = $12
    const uword frclip_ = $15

    ; C64 OS relocatable loading.
    ; This requires the os.appfileref page to be valid.
    sub load() -> bool {
        ; call C64 OS kernal loadlib()
        ;   - loadlib() loads in a library based on the first two letters of the name
        pgref = os.loadlib(size, libcode1, libcode2)

        ; fixup page of subs below
        @(&setname+2) = pgref
        @(&pathadd+2) = pgref
        @(&pathup+2) = pgref
        @(&partroot+2) = pgref
        @(&devroot+2) = pgref
        @(&gopath+2) = pgref
        @(&frclip+2) = pgref
        return true
    }

    ; unload library
    ; should be called from appquit()
    sub unload() -> bool {
        os.unldlib(lser.slunload, libcode1, libcode2)
        return true
    }

    ; wrappers for library routines

    asmsub setname(ubyte arg0 @A, uword arg1 @XY) {
        %asm {{
            jmp p8b_libpath.p8c_setname_
        }}
    }

    asmsub pathadd(ubyte arg0 @A, uword arg1 @XY) {
        %asm {{
            jmp p8b_libpath.p8c_pathadd_
        }}
    }

    asmsub pathup(ubyte arg0 @A) {
        %asm {{
            jmp p8b_libpath.p8c_pathup_
        }}
    }

    asmsub partroot(ubyte arg0 @A) {
        %asm {{
            jmp p8b_libpath.p8c_partroot_
        }}
    }

    asmsub devroot(ubyte arg0 @A) {
        %asm {{
            jmp p8b_libpath.p8c_devroot_
        }}
    }

    asmsub gopath(ubyte arg0 @A, ubyte arg1 @X) {
        %asm {{
            jmp p8b_libpath.p8c_gopath_
        }}
    }

    asmsub frclip(ubyte arg0 @A, bool arg1 @Pc) {
        %asm {{
            jmp p8b_libpath.p8c_frclip_
        }}
    }
}