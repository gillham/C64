;
; Client side linkage for a C64 OS relocatable library.
;
%option ignore_unused
libcnp {
    ; library size in pages
    const ubyte size = 6
    ; library codes
    const ubyte libcode1 = 'C'
    const ubyte libcode2 = 'N'

    ; pointer to first page of library
    ubyte pgref = 0

    ; byte offset from library load address
    ; aka slot in jmp table
    const uword bindnhd_ = $06
    const uword sessbgn_ = $09
    const uword sessend_ = $0c
    const uword opencnps_ = $0f
    const uword closcnps_ = $12
    const uword cnpsout_ = $15
    const uword cnpsput_ = $18
    const uword cnpsclr_ = $1b
    const uword cnpsin_ = $1e
    const uword cnpsget_ = $21
    const uword cnpsack_ = $24

    ; C64 OS relocatable loading.
    ; This requires the os.appfileref page to be valid.
    sub load() -> bool {
        ; call C64 OS kernal loadlib()
        ;   - loadlib() loads in a library based on the first two letters of the name
        pgref = os.loadlib(size, libcode1, libcode2)

        ; fixup page of subs below
        @(&bindnhd+2) = pgref
        @(&sessbgn+2) = pgref
        @(&sessend+2) = pgref
        @(&opencnps+2) = pgref
        @(&closcnps+2) = pgref
        @(&cnpsout+2) = pgref
        @(&cnpsput+2) = pgref
        @(&cnpsclr+2) = pgref
        @(&cnpsin+2) = pgref
        @(&cnpsget+2) = pgref
        @(&cnpsack+2) = pgref
        return true
    }

    ; unload library
    ; should be called from appquit()
    sub unload() -> bool {
        os.unldlib(lser.slunload, libcode1, libcode2)
        return true
    }

    ; wrappers for library routines

    asmsub bindnhd() {
        %asm {{
            jmp p8b_libcnp.p8c_bindnhd_
        }}
    }

    asmsub sessbgn(uword arg0 @XY) {
        %asm {{
            jmp p8b_libcnp.p8c_sessbgn_
        }}
    }

    asmsub sessend(bool arg0 @Pc) {
        %asm {{
            jmp p8b_libcnp.p8c_sessend_
        }}
    }

    asmsub opencnps(uword arg0 @XY) {
        %asm {{
            jmp p8b_libcnp.p8c_opencnps_
        }}
    }

    asmsub closcnps(uword arg0 @XY) {
        %asm {{
            jmp p8b_libcnp.p8c_closcnps_
        }}
    }

    asmsub cnpsout(uword arg0 @XY) {
        %asm {{
            jmp p8b_libcnp.p8c_cnpsout_
        }}
    }

    asmsub cnpsput(ubyte arg0 @A) -> bool @Pc {
        %asm {{
            jmp p8b_libcnp.p8c_cnpsput_
        }}
    }

    asmsub cnpsclr() {
        %asm {{
            jmp p8b_libcnp.p8c_cnpsclr_
        }}
    }

    asmsub cnpsin(uword arg0 @XY) {
        %asm {{
            jmp p8b_libcnp.p8c_cnpsin_
        }}
    }

    asmsub cnpsget() -> ubyte @A, bool @Pc {
        %asm {{
            jmp p8b_libcnp.p8c_cnpsget_
        }}
    }

    asmsub cnpsack() {
        %asm {{
            jmp p8b_libcnp.p8c_cnpsack_
        }}
    }
}