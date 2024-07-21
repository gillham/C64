
; comments
; $E0 - $F8
; 183 bytes in color strings (256 byte limit?)
mtext {
    const ubyte LINK_CODE = $F3
    const ubyte LINK_PATH = $02
    const ubyte LINK_STOP = $03
    str LINK_FILE = " fn:"
    str[] codemin = [
        "<c:bla",
        "<c:w",
        "<c:r",
        "<c:c",
        "<c:p",
        "<c:g",
        "<c:blu",
        "<c:y",
        "<c:o",
        "<c:br",
        "<c:lr",
        "<c:light r",
        "<c:d",
        "<c:m",
        "<c:lgree",
        "<c:light gree",
        "<c:lb",
        "<c:light b",
        "<c:lgra",
        "<c:light gra",
        "<c:lgrey",
        "<c:light grey",
        "<t:n",
        "<t:s",
        "<t:e",
        "<l:",
        "<j:l",
        "<j:r",
        "<j:c",
        "<j:f",
        "<h:"
    ]

    ubyte[] codebyte = [
        ; c:black
        $E0,
        ; c:white
        $E1,
        ; c:red
        $E2,
        ; c:cyan
        $E3,
        ; c:purple
        $E4,
        ; c:green
        $E5,
        ; c:blue
        $E6,
        ; c:yellow
        $E7,
        ; c:orange
        $E8,
        ; c:brown
        $E9,
        ; c:lred
        $EA,
        ; c:light red
        $EA,
        ; c:dark gray
        $EB,
        ; c:medium gray
        $EC,
        ; c:lgreen
        $ED,
        ; c:light green
        $ED,
        ; c:lblue
        $EE,
        ; c:light blue
        $EE,
        ; c:lgray
        $EF,
        ; c:light gray
        $EF,
        ; c:lgrey
        $EF,
        ; c:light grey
        $EF,
        ; t:normal
        $F0,
        ; t:strong
        $F1,
        ; t:empahtic
        $F2,
        ; l: (handled special)
        $F3,
        ; j:left
        $F4,
        ; j:right
        $F5,
        ; j:center
        $F6,
        ; j:full
        $F7,
        ; h:
        $F8
    ]
}

