%import c64oscharset
%import textio
%option no_sysinit
%zeropage dontuse

main {
    sub start() {

        setup_screen()

        ;send cursor up/down so kernal routines
        ;are all set for output to new location
        txt.chrout($91)
        txt.chrout($11)
        txt.print("character set installed.")
        txt.nl()
    }

    ; Sets up custom character set and moves
    ; screen.  Also copies old screen data.
    sub setup_screen() {
        ; copy custom character set to final location
        sys.memcopy(&chars.CUSTOM, $c000, $0800)

        ; copy old screen ram to new screen
        sys.memcopy($0400, $c800, $0400)

        ; set VIC-II bank 3
        c64.CIA2DDRA = c64.CIA2DDRA | %00000011
        c64.CIA2PRA = $94

        ; needs VIC-II memory bank set ($dd00) above
        c64.VMCSB = (16*2) + (0<<1)

        ; tell the kernal where screen memory is. (high byte)
        @($0288) = $c8
    }
}
