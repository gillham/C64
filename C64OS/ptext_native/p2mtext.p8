%import diskio
%import strings
%import textio
%zeropage basicsafe

; import the various MText code definitions.
%import mtext

;
; Converts PText to MText for use with C64 OS.
;
main {
    uword ptextbuf = memory("ptextbuf", 10000, 256)
    uword mtextbuf = memory("mtextbuf", 10000, 256)
    sub start() {
        ; XXX: should be use a const from mtext.p8?
        str input = "."*30
        str output = "."*30
        ubyte codelen = 0
        ubyte code = 0
        uword count = 0
        uword i = 0
        uword mtextptr = 0

        ubyte drive = @($BA)
        diskio.drivenumber = drive

        ; Default C64 colors
        c64.EXTCOL = 14
        c64.BGCOL0 = 6
        ;cbm.COLOR = 14
        txt.color(14)

        txt.clear_screen()
        txt.lowercase()

        txt.print("    Using drive: ")
        txt.print_ub(drive)
        txt.nl()
        ; Ask user for filenames.
        ; Eventually allow on 'RUN:' ? RUN:FILEIN:FILEOUT
        txt.print(" Input filename? ")
        void txt.input_chars(input)
        txt.nl()
        txt.print("Output filename? ")
        void txt.input_chars(output)
        txt.nl()

        if not strings.endswith(output, ",s") {
            ; append ,s to make it a SEQ...
            void strings.append(output, ",s")
        }
        txt.nl()
        txt.print("Will save to:")
        txt.print(output)
        txt.nl()

        ; needs better error checking
        count = read_file()

        ; if we read anything, loop through it
        if count > 0 {
            for i in 0 to count {
                if ptextbuf[i] == '<' {
                    codelen = find_code(i)
                    ; shortest possible code is: '<h:>' (4 bytes)
                    if codelen > 3 {
                        code = scan_code(i, codelen)
                        if code > 0 {
                            ; copy code byte to mtextbuf
                            mtextbuf[mtextptr] = code
                            mtextptr++

                            ; links need special handling.
                            if code == mtext.LINK_CODE {
                                ; Handle link code
                                link_parse(i, codelen)
                            }
                            ; valid code written above
                            ; link_parse added link bits to output buffer
                            ; we skip over remainder of code text.
                            ; add (code length -1) to i.  it will point to
                            ; character after end of code marker '>' on the
                            ; next iteration of the loop when i increments.
                            i += codelen - 1
                            
                        } else {
                            ; code was invalid for some reason.
                            ; (invalid code or parameter, not in array)
                            ; copy byte to mtextbuf
                            ; (whole code will get copied eventually)
                            mtextbuf[mtextptr] = ptextbuf[i]
                            mtextptr++
                        }
                    } else {
                        ; This '<' is not part of a code, copy to mtextbuf
                        mtextbuf[mtextptr] = ptextbuf[i]
                        mtextptr++
                    }
                } else {
                    ; copy to mtextbuf
                    mtextbuf[mtextptr] = ptextbuf[i]
                    mtextptr++
                }
            }

        ; Needs better error checking.
        void file_write()
        }
    }

    ; Returns size of code in bytes
    ; Shortest code is 2 bytes. <h:> (Horizontal Rule)
    ; Shortest size then is 4 bytes. (all of '<h:>')
    ; Zero is no code. One/two/three are not valid codes.
    sub find_code(uword index) -> ubyte {
        ubyte i = 0
        ; what is maximum length of codes? (Link is longest)
        const ubyte maxlen = 64

        ; valid codes have '<', a letter, and then ':' so check
        ; for ':' first. We already know we found '<' to get here.
        if ptextbuf[index + 2] != ':' {
            return 0
        }

        ; validate first character of code is a letter. (ignoring case)
        ; scan_code() will check if it is actually a valid code.
        if not strings.isletter(ptextbuf[index+1]) {
            return 0
        }

        ; Look through the next maxlen characters for an
        ; end of code marker.
        for i in 0 to maxlen {
            if main.ptextbuf[index + i] == '>' {
                ; found end of code
                ; return i+1 as size.
                return i+1
            }

        }
        ; did not find a code (no '>' found in maxlen bytes)
        return 0
    }

    ; Parses various formats of link codes eventually.
    ; Just file references 'fn:' now.
    ; Possibly we should just look for ' xy:' since we don't
    ; care if it is a filename or not.  We are just using
    ; ' fn:' to find the break.
    ; Link format:
    ; <l:Click Text fn:Filename>
    sub link_parse(uword index, ubyte length) {
        ; the caller has already emitted the LINK_CODE byte
        ; we are pointing at the whole code "<l:...>"
        ; what is max link code size?  64?
        ; 64 for the moment.
        str temp = "."*64
        uword code_ptr = main.ptextbuf + index
        ubyte i = 0

        ; make a copy of our full link code
        strings.left(code_ptr, length, temp)

        ; make our copy all lowercase (only used for parsing)
        void strings.lower(temp)

        ; start after '<l:' and end before '>'
        for i in 3 to length-2 {
            ; Currently using '<space>fn:' to eat whitespace in mtext
            if strings.startswith(&temp+i, mtext.LINK_FILE) {
                ; copy LINK_PATH byte to output buffer
                main.mtextbuf[main.start.mtextptr] = mtext.LINK_PATH
                main.start.mtextptr++
                ; i currently points at the ' ' but next time will be the 'f'
                ; so we do not need to adjust it to copy from 'f' onwards.
            } else {
                ; we are still in the link text part or after link type ':'.
                ; copy text char to mtextbuf
                ; not from temp as that is lowercase
                main.mtextbuf[main.start.mtextptr] = main.ptextbuf[index+i]
                main.start.mtextptr++
            }
        }
        ; copy LINK_STOP byte to output buffer
        main.mtextbuf[main.start.mtextptr] = mtext.LINK_STOP
        main.start.mtextptr++
    }

    ; reads user provided file into ptextbuf
    ; returns the number of bytes read.
    ; returns zero if f_open or f_read_all fails.
    sub read_file() -> uword {
        uword count = 0
        txt.nl()
        txt.print("Reading: ")
        txt.print(main.start.input)
        if diskio.f_open(main.start.input) {
            ; need to add error checking here
            count = diskio.f_read_all(main.ptextbuf)
            txt.print(" (")
            txt.print_uw(count)
            txt.print(" bytes)")
            txt.nl()
        } else {
            txt.print("\nERROR: failed to open file.\n")
        }
        diskio.f_close()
        return count
    }

    ; looks up the code in the array(s)
    ; returns code byte or $00
    ; We will check for $00 in the caller, not write it to the buffer
    ; (otherwise could cause a zero terminated string issue)
    sub scan_code(uword index, ubyte length) -> ubyte {
        ; scratch spot for (non link) code from ptextbuf
        ; longest code: <c:light green> (or <c:medium gray>)
        ; link codes don't get copied to this buffer.
        str temp = "."*20
        uword code_ptr = main.ptextbuf + index
        ubyte i = 0

        ; find_code has already validated we have:
        ; <x:zzzz> where x is a letter.
        ; So we know we somewhat match the format.
        ; Now we want to see if it is a known code.

        ; for links we just return the link code and it
        ; gets special handling due to variable length
        ; and multiple codes separating fields.
        if strings.lowerchar(main.ptextbuf[index+1]) == 'l' {
            return mtext.LINK_CODE
        }

        ; for bytes (<b:xx>) we return the two or three characters after the ':'
        ; converted to a ubyte. (<b:a2> or <b:$a2> should work)
        if strings.lowerchar(main.ptextbuf[index+1]) == 'b' {
            return conv.hex2uword(main.ptextbuf + index + 3) as ubyte
        }

        ; everything else is a direct lookup.
        ; copy the code out to a temp string so it is easy
        ; to make lowercase and compare string to strings.
        strings.left(code_ptr, length, temp)

        ; make sure all of the code is lowercase
        void strings.lower(temp)

        for i in 0 to len(mtext.codemin)-1 {
            if strings.startswith(temp, mtext.codemin[i]) {
                ; return byte from mtext.codebyte that is
                ; in the same index position as the text 
                ; code match from mtext.codemin.
                ; codemin[0] = '<c:bla' & codebyte[0] = $E0
                return mtext.codebyte[i]
            } 
        }

        ; no matching code found
        ; XXX: caller might have a bug for unknown
        ;      codes in the valid code format (test)
        return 0
    }

    ; write mtextbuf to the output file.
    ; the output filename string already has
    ; a ',s' appended to mark this as a SEQ file
    ; XXX: needs better handling of errors.
    sub file_write() -> uword {
        ;uword count = 0
        txt.nl()
        txt.print("Writing: ")
        txt.print(main.start.output)
        txt.nl()
        txt.print("Expecting ")
        txt.print_uw(main.start.mtextptr-1)
        txt.print(" bytes")
        txt.nl()
        if diskio.f_open_w(main.start.output) {
            ; check status() here first...
            if diskio.f_write(main.mtextbuf, main.start.mtextptr-1) {
                diskio.f_close_w()
                txt.print("Done (")
                txt.print_uw(main.start.mtextptr-1)
                txt.print(" bytes)")
                txt.nl()
            } else {
                ; should check status() here also.
                txt.print("\nwrite error\n")
            }
        } else {
            txt.print("\nERROR: failed to open file.\n")
        }
        ; file is left in an inconsistent state and 
        ; zero length if we don't close it properly
        diskio.f_close_w()
        return 0
    }

}
