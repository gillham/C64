%import c64oscharset
%import textio
%option no_sysinit
%zeropage dontuse

main {
    sub start() {
        ; copy custom character set to final location
        sys.memcopy(&chars.CUSTOM, $3800, $0800)

        ; move character rom to top of VIC-II memory bank
        c64.VMCSB |= %00001110       

        ; adjust memtop up
        void cbm.MEMTOP($3800, false)

        ; set lower / upper end of string area?
        @(52) = $38
        @(56) = $38

        txt.print("character set installed.")
        txt.nl()
    }
}
