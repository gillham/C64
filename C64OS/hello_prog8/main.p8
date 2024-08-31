;
; Minimal example application.
;

; *required* Prog8 options
%output prg
%launcher none
%zeropage dontuse
%address $0900
%option no_sysinit

; C64 OS imports
%import hdr
%import os

;
; C64 OS Hello World Application written in Prog8.
;

main {
    str hello = "Welcome to C64 OS!"
    str prog8 = "(via Prog8!)"
    ubyte msg_act = 0
    ubyte msg_cmd = 0
    bool msg_ok = false
    ubyte msg_ret = 0

    ; C64 OS App entry point.
     sub start() {
        ; *must* register callbacks.
        os.register(hdr.APP_MSG, appmcmd)
        os.register(hdr.APP_QUIT, appquit)
        os.register(hdr.APP_FREEZE, appfrze)
        os.register(hdr.APP_THAW, appthaw)

        ; call screen.layerpush
        void os.layerpush(main.data.layer)
        ;Load Shared Libraries
        ;Load Custom TK Classes
        ;Load Custom Icons
        ;Initialize UI
        return
    }

    sub appmcmd() {
        ; immediately stash A & X
        ; is this good enough?
        %asm {{
        sta p8b_main.p8v_msg_cmd
        stx p8b_main.p8v_msg_act
        }}

        ;"Menu Enquiry" and "Menu Cmd"
        ;message types must be handled
        ;to support menu actions.
        if msg_cmd == hdr.mc_menq {
            msg_ret = mnuenq()
            sys.clear_carry()
            return
        }
        if msg_cmd == hdr.mc_mnu {
            msg_ok = mnucmd()
            if msg_ok {
                sys.clear_carry()
                return
            }
            sys.set_carry()
            return
        }

        ; We didn't handle this msg_cmd
        sys.set_carry()
        return
    }

    ; Mandatory quit callback
    sub appquit() {
        ;Deallocate resources here.
        ;Unload Shared Libraries
        ;Unload Custom Icons
        return
    }

    ; Mandatory REU freeze callback
    sub appfrze() {
        sys.set_carry()
        return
    }

    ; Mandatory REU thaw callback
    sub appthaw() {
        sys.set_carry()
        return
    }

    ; data structures like layers & draw context
    sub data() {
        layer:
        %asm {{
            .word p8b_main.p8s_drawmain
            .word p8b_main.p8s_handlerm;MouseEvt Handler
            .word p8b_main.p8s_handlerc;Kcmd Evt Handler
            .word p8b_main.p8s_handlerk;KprntEvt handler
            .byte 0       ;Layer Index
        }}
        drawctx:
        %asm {{
            .word p8b_hdr.p8c_scrbuf      ;Char Origin
            .word p8b_hdr.p8c_colbuf      ;Colr Origin
            .byte p8b_hdr.p8c_screen_cols ;Buff Width
            .byte p8b_hdr.p8c_screen_cols ;Draw Width
            .byte p8b_hdr.p8c_screen_rows ;Draw Height
            .word 0           ;Offset Top
            .word 0           ;Offset Left
        }}
    }

    ; main drawing function
    ; referenced in data.layer above
    sub drawmain() {

        ; Configure the Draw Context
        os.setctx(main.data.drawctx)

        ; Set Draw Properties and Color
        os.setdprops(hdr.d_crsr_h|hdr.d_petscr, hdr.clblue)

        ; Clear the Draw Context
        os.ctxclear($20)

        ; Configure draw position
        os.setlrc(5, false)
        os.setlrc(11, true)

        ; Print message
        print(hello)

        ; Print another message
        os.setdprops(hdr.d_crsr_h|hdr.d_petscr, hdr.cblue)
        os.setlrc(6, false)
        os.setlrc(14, true)
        print(prog8)

        return
    }

    ; simplistic routine
    sub print(str msg) {
        ubyte i = 0
        while msg[i] != $00 {
           void os.ctxdraw(msg[i])
           i++
        }
    }

    ; handle control keys
    sub handlerc() {
        ;sys.set_carry()
        sys.clear_carry()
        return
    }

    ; handle normal printable keys
    sub handlerk() {
        ;sys.set_carry()
        sys.clear_carry()
        return
    }

    ; handle mouse events
    sub handlerm() {
        ; need to set carry to say we handled it.
        ;sys.set_carry()
        sys.clear_carry()
        return
    }

    ; handle menu inquiries
    sub mnuenq() -> ubyte {
        ; all items enabled and not selected?
        return 0
    }

    ; handle quit from menu
    sub mnucmd() -> bool {
        if msg_act == '!' {
            os.quitapp()
        }

        ; quitapp exits so if we get here we didn't handle msg
        ; true == we handled message
        ; false == we didn't
        return false
    }
}

