%import textio

args {
    const uword argptr  = $0200
    const ubyte REM     = $8f
    const ubyte SPC     = $20

    const ubyte MAXARGS = $08

    uword[] @nosplit argv = [$0000] * MAXARGS
    ubyte argc = 0

    ; parse screen line looking for
    ; args starting after a ':'
    sub parse() -> bool {
        ubyte i

        ; find first ':' if we have it
        while argptr[i] != $00 {
            if argptr[i] == ':' break
            i++
        }

        ; no args
        if argptr[i] == $00 {
            return false
        }

        ; skip over ':'
        i++

        ; skip any REM or space.
        ; mark start of first argument.
        while argptr[i] != $00 {
            if argptr[i] != REM and argptr[i] != SPC {
                argv[0] = argptr + i as uword
                argc++
                break
            }
            i++
        }

        ; Find any ':' and additional args.
        while argptr[i] != $00 {
            if argptr[i] == ':' {
                ; terminate arg, increment argc
                ; start looking for any more args
                argptr[i] = $00
                ; skip over null
                i++
                ; save pointer to arg
                argv[argc] = argptr + i as uword
                ; increment argc
                argc++
                ; stop processing if too many args
                if argc >= MAXARGS break
            }
            i++
        }

        return argc > 0
    }

}
