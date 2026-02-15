%import c64oscharset
%import textio

main {
    sub start() {
        ubyte i,j
        uword ptr = $c990   ; start on line 10
        ;str @shared message1 = c64os:"ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        str @shared message1 = c64os:"{|}^"
        str @shared message2 = iso:"{|}^"
        str @shared message3 = petscii:"abcdefghijklmnopqrstuvwxyz"
        str @shared message4 = petscii:"ABCDEFGHIJKLMNOPQRSTUVWXYZ"

        txt.lowercase()
        setup_screen()

        ;
        ; all setup so now use it.
        ;

        txt.cls()

        ; draw character set via screencodes
        repeat 255 {
            @(ptr+i) = i
            i++
        }

        txt.setchr(10,10, sc:'A')

        ;const ubyte backslash = iso:'\\'
        const ubyte backslash = $5c
        const ubyte circumflex = iso:'^'
        const ubyte underscore = iso:'_'
        const ubyte backtick = iso:'`'
        const ubyte left_curly = iso:'{'
        const ubyte pipe = iso:'|'
        const ubyte right_curly = iso:'}'
        const ubyte tilde = iso:'~'

        txt.nl()
        txt.print("main ")
        txt.chrout(left_curly)
        txt.nl()
        txt.print("    start() ")
        txt.chrout(left_curly)
        txt.nl()
        txt.print("        txt.print(\"hello, world!\")")
        txt.nl()
        txt.print("        txt.print(\"test: ")
        txt.print(iso:"\\^_`{|}~\")")
        txt.nl()
        txt.print(iso:"    }")
        txt.nl()
        txt.print(iso:"}")
        txt.nl()
        txt.plot(0,19)
        ;txt.print(iso:"abcdefghijklmnopqrstuvwxyz")
;        txt.print(iso:"abcd")
;        txt.print(c64os:"abcd")
        txt.nl()
        txt.print(message1)
        txt.nl()
        txt.print(message2)
        txt.nl()
        txt.print(message3)
        txt.nl()
        txt.print(message4)
        txt.nl()

        ; stall
        repeat {}

        ; finalize
        sys.wait(180)
        restore_screen()
        txt.cls()
        repeat {}
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
        ; reset to default
        c64.CIA2DDRA = c64.CIA2DDRA | %00000011
        c64.CIA2PRA = $97
        c64.VMCSB = $15

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
