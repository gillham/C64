%import args
%import c64oscharset
%import diskio
%import textio
%option no_sysinit
%zeropage dontuse
%zpreserved $9b,$9b
%zpreserved $b0,$b1

main {
    sub start() {

        if args.parse() {
            setup_screen()
            ;txt.cls()
            txt.chrout($91)
            ;txt.chrout($11)
            if args.argc > 0 {
                viewfile(args.argv[0])
            }
            txt.plot(7,24)
            txt.print("-= press key to exit =-")
            void txt.waitkey()
            restore_screen()
            txt.chrout($91)
            txt.chrout($11)
        } else {
            txt.print(" use: /tview\n")
            txt.print("  or: load\"tview\",8\n")
            txt.print("then: run:rem filename\n")
        }
        ; JiffyDOS F key hack.
        @($9b) = $00
    }

    ; temp buffer hack
    uword buffer = memory("buffer", 8192, 256)

    sub viewfile(str filename) {
        uword index
        uword count
        ubyte temp
        ubyte key
        diskio.drivenumber = @($BA)
        if diskio.f_open(filename) {
            txt.cls()
            do {
                count = diskio.f_read(buffer, 8192)
                if count > 0 {
                    for index in 0 to count-1 {
                        temp = buffer[index]
                        when temp {
                            $0a -> continue
                            $0d -> {
                                if txt.get_row() >= 23 {
                                    txt.plot(7,24)
                                    txt.print("-= press key to page =-")
                                    key = txt.waitkey()
                                    ;txt.spc()
                                    ;txt.print_uwhex(key, true)
                                    ;sys.wait(180)
                                    ;txt.spc()
                                    if key == $5f or key == $03  or key == 'q' {
                                        diskio.f_close()
                                        void diskio.status()
                                        return
                                    }
                                    txt.cls()
                                } else {
                                    txt.nl()
                                }
                            }
                            else -> txt.chrout(temp)
                        }
                    }
                }
            } until count == 0
        } else {
            txt.print("\nERROR: failed to open: ")
            txt.print(filename)
            txt.nl()
        }
        diskio.f_close()
        void diskio.status()
    }

    sub fixlut() {
        ubyte i
        uword ptr
        %asm {{
            pha
            lda #<txt.setchr._screenrows
            sta p8b_main.p8s_fixlut.p8v_ptr
            lda #>txt.setchr._screenrows
            sta p8b_main.p8s_fixlut.p8v_ptr+1
            pla
        }}
        for i in 1 to 49 step 2 {
            @(ptr + i) += $c4
        }
    }

    sub restore_screen() {

        ; copy temp screen ram to original screen location
        sys.memcopy($c800, $0400, $0400)

        ; reset to default
        c64.CIA2DDRA = c64.CIA2DDRA | %00000011
        c64.CIA2PRA = $97
        ;c64.VMCSB = $15
        c64.VMCSB = $14

        ; tell the kernal where screen memory is. (high byte)
        @($0288) = $04
    }


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

        ; fixup textio cbm.Screen lookup table
        fixlut()
    }
}
