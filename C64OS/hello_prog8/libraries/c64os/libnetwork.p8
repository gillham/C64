;
; Client side linkage for a C64 OS relocatable library.
;
%option ignore_unused
libnetwork {
    ; library size in pages
    const ubyte size = 6
    ; library codes
    const ubyte libcode1 = 'N'
    const ubyte libcode2 = 'E'

    ; pointer to first page of library
    ubyte pgref = 0

    ; byte offset from library load address
    ; aka slot in jmp table
    const uword loadset_ = $06
    const uword readset_ = $09
    const uword loadnhd_ = $0c
    const uword confbaud_ = $0f
    const uword joinwifi_ = $12
    const uword cnpsrvr_ = $15
    const uword cnpctrl_ = $18

    ; C64 OS relocatable loading.
    ; This requires the os.appfileref page to be valid.
    sub load() -> bool {
        ; call C64 OS kernal loadlib()
        ;   - loadlib() loads in a library based on the first two letters of the name
        pgref = os.loadlib(size, libcode1, libcode2)

        ; fixup page of subs below
        @(&loadset+2) = pgref
        @(&readset+2) = pgref
        @(&loadnhd+2) = pgref
        @(&confbaud+2) = pgref
        @(&joinwifi+2) = pgref
        @(&cnpsrvr+2) = pgref
        @(&cnpctrl+2) = pgref
        return true
    }

    ; unload library
    ; should be called from appquit()
    sub unload() -> bool {
        os.unldlib(lser.slunload, libcode1, libcode2)
        return true
    }

    ; wrappers for library routines

    asmsub loadset() -> bool @Pc {
        %asm {{
            jmp p8b_libnetwork.p8c_loadset_
        }}
    }

    asmsub readset(ubyte arg0 @X) -> uword @XY {
        %asm {{
            jmp p8b_libnetwork.p8c_readset_
        }}
    }

    asmsub loadnhd() -> bool @Pc {
        %asm {{
            jmp p8b_libnetwork.p8c_loadnhd_
        }}
    }

    asmsub confbaud() -> ubyte @A, bool @Pc {
        %asm {{
            jmp p8b_libnetwork.p8c_confbaud_
        }}
    }

    asmsub joinwifi(uword arg0 @XY, bool arg1 @Pc) -> ubyte @A, uword @XY, bool @Pc {
        %asm {{
            jmp p8b_libnetwork.p8c_joinwifi_
        }}
    }

    asmsub cnpsrvr(uword arg0 @XY, bool arg1 @Pc) -> ubyte @A, bool @Pc {
        %asm {{
            jmp p8b_libnetwork.p8c_cnpsrvr_
        }}
    }

    asmsub cnpctrl(uword arg0 @XY, bool arg1 @Pc) {
        %asm {{
            jmp p8b_libnetwork.p8c_cnpctrl_
        }}
    }
}