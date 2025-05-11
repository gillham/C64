; Prog8 definitions for the Text I/O and Screen routines for the Commodore-64
; All routines work with Screencode character encoding, except `print`, `chrout` and `input_chars`,
; these work with PETSCII encoding instead.

%import syslib
%import conv2
;%import shared_cbm_textio_functions
%import shared_cbm_textio_functions2
%import os

;%option no_symbol_prefixing, ignore_unused
;%option no_symbol_prefixing
;%option ignore_unused

txt {
    %option no_symbol_prefixing, ignore_unused

const ubyte DEFAULT_WIDTH = 40
const ubyte DEFAULT_HEIGHT = 25

alias chrout = cbm.CHROUT

;extsub $FFD2 = chrout(ubyte character @ A)    ; for consistency. You can also use cbm.CHROUT directly ofcourse. Note: takes a PETSCII encoded character.

sub  clear_screen() {
    chrout(147)
}

sub  cls() {
    chrout(147)
}

sub home() {
    chrout(19)
}

sub nl() {
    chrout(10)
}

sub spc() {
    chrout(' ')
}

sub bell() {
    ; flash border
    os.alert()
}

asmsub column(ubyte col @A) clobbers(A, X, Y) {
    ; ---- set the cursor on the given column (starting with 0) on the current line
    %asm {{
        pha
        sec
        jsr  cbm.PLOT
        pla
        tay
        clc
        jmp  cbm.PLOT
    }}
}


asmsub get_column() -> ubyte @Y {
    %asm {{
        sec
        jmp cbm.PLOT
    }}
}

asmsub row(ubyte rownum @A) clobbers(A, X, Y) {
    ; ---- set the cursor on the given row (starting with 0) on the current line
    %asm {{
        pha
        sec
        jsr  cbm.PLOT
        pla
        tax
        clc
        jmp  cbm.PLOT
    }}
}

asmsub get_row() -> ubyte @X {
    %asm {{
        sec
        jmp cbm.PLOT
    }}
}

asmsub get_cursor() -> ubyte @X, ubyte @Y {
    %asm {{
        sec
        jsr  cbm.PLOT
        stx  P8ZP_SCRATCH_REG  ; swap X and Y
        tya
        tax
        ldy  P8ZP_SCRATCH_REG
        rts
    }}
}


asmsub  fill_screen (ubyte character @ A, ubyte color @ Y) clobbers(A)  {
	; ---- fill the character screen with the given fill character and character color.
	;      (assumes screen and color matrix are at their default addresses)

	%asm {{
		pha
		jsr  color
		pla
		jsr  p8b_os.p8s_ctxclear
		rts
        }}

}

asmsub  clear_screenchars (ubyte character @ A) clobbers(Y)  {
	; ---- clear the character screen with the given fill character (leaves colors)
	;      (assumes screen matrix is at the default address)

        ; C64 OS does NOT leave colors and clears the draw context which might
        ; need a ctx2scr to clear the "screen" per se.
        ; TODO: see about clearing the character but not the color with context buffer
        ; Can't assume address.
	%asm {{
		jmp  p8b_os.p8s_ctxclear
        }}
}

asmsub  clear_screencolors (ubyte color @ A) clobbers(Y)  {
	; ---- clear the character screen colors with the given color (leaves characters).
	;      (assumes color matrix is at the default address)
	%asm {{
		ldy  #250
-		sta  cbm.Colors+250*0-1,y
		sta  cbm.Colors+250*1-1,y
		sta  cbm.Colors+250*2-1,y
		sta  cbm.Colors+250*3-1,y
		dey
		bne  -
		rts
        }}
}

sub color (ubyte txtcol) {
    ; maybe should get current draw property flags
    ; and use those when changing color?
    ; so we don't accidentally change.
    ubyte props = @(hdr.d_ctx+hdr.d_pet2scr) | @(hdr.d_ctx+hdr.d_reverse) | @(hdr.d_ctx+hdr.d_crsrmov)
    os.setdprops(hdr.d_crsr_h, txtcol)
}
;asmsub color (ubyte txtcol @Y) {
;    %asm {{
;        lda p8b_hdr.p8c_d_ctx + p8b_hdr.p8c_d_pet2scr
;        ora p8b_hdr.p8c_d_ctx + p8b_hdr.p8c_d_reverse
;        ora p8b_hdr.p8c_d_ctx + p8b_hdr.p8c_d_crsrmov
;        tax
;        jmp p8b_os.p8s_setdprops
;    }}
;}

sub lowercase() {
    ; nop on C64 OS
}

sub uppercase() {
    ; nop on C64 OS
}

asmsub  scroll_left  (bool alsocolors @ Pc) clobbers(A, X, Y)  {
	; ---- scroll the whole screen 1 character to the left
	;      contents of the rightmost column are unchanged, you should clear/refill this yourself
	;      Carry flag determines if screen color data must be scrolled too

	%asm {{
		bcc _scroll_screen

+               ; scroll the screen and the color memory
		ldx  #0
		ldy  #38
-
        .for row=0, row<=24, row+=1
            lda  cbm.Screen + 40*row + 1,x
            sta  cbm.Screen + 40*row + 0,x
            lda  cbm.Colors + 40*row + 1,x
            sta  cbm.Colors + 40*row + 0,x
        .next
		inx
		dey
		bpl  -
		rts

_scroll_screen  ; scroll only the screen memory
		ldx  #0
		ldy  #38
-
        .for row=0, row<=24, row+=1
            lda  cbm.Screen + 40*row + 1,x
            sta  cbm.Screen + 40*row + 0,x
        .next
		inx
		dey
		bpl  -

		rts
	}}
}

asmsub  scroll_right  (bool alsocolors @ Pc) clobbers(A,X)  {
	; ---- scroll the whole screen 1 character to the right
	;      contents of the leftmost column are unchanged, you should clear/refill this yourself
	;      Carry flag determines if screen color data must be scrolled too
	%asm {{
		bcc  _scroll_screen

+               ; scroll the screen and the color memory
		ldx  #38
-
        .for row=0, row<=24, row+=1
            lda  cbm.Screen + 40*row + 0,x
            sta  cbm.Screen + 40*row + 1,x
            lda  cbm.Colors + 40*row + 0,x
            sta  cbm.Colors + 40*row + 1,x
        .next
		dex
		bpl  -
		rts

_scroll_screen  ; scroll only the screen memory
		ldx  #38
-
        .for row=0, row<=24, row+=1
            lda  cbm.Screen + 40*row + 0,x
            sta  cbm.Screen + 40*row + 1,x
        .next
		dex
		bpl  -

		rts
	}}
}

asmsub  scroll_up  (bool alsocolors @ Pc) clobbers(A,X)  {
	; ---- scroll the whole screen 1 character up
	;      contents of the bottom row are unchanged, you should refill/clear this yourself
	;      Carry flag determines if screen color data must be scrolled too
	%asm {{
		bcc  _scroll_screen

+               ; scroll the screen and the color memory
		ldx #39
-
        .for row=1, row<=24, row+=1
            lda  cbm.Screen + 40*row,x
            sta  cbm.Screen + 40*(row-1),x
            lda  cbm.Colors + 40*row,x
            sta  cbm.Colors + 40*(row-1),x
        .next
		dex
		bpl  -
		rts

_scroll_screen  ; scroll only the screen memory
		ldx #39
-
        .for row=1, row<=24, row+=1
            lda  cbm.Screen + 40*row,x
            sta  cbm.Screen + 40*(row-1),x
        .next
		dex
		bpl  -

		rts
	}}
}

asmsub  scroll_down  (bool alsocolors @ Pc) clobbers(A,X)  {
	; ---- scroll the whole screen 1 character down
	;      contents of the top row are unchanged, you should refill/clear this yourself
	;      Carry flag determines if screen color data must be scrolled too
	%asm {{
		bcc  _scroll_screen

+               ; scroll the screen and the color memory
		ldx #39
-
        .for row=23, row>=0, row-=1
            lda  cbm.Colors + 40*row,x
            sta  cbm.Colors + 40*(row+1),x
            lda  cbm.Screen + 40*row,x
            sta  cbm.Screen + 40*(row+1),x
        .next
		dex
		bpl  -
		rts

_scroll_screen  ; scroll only the screen memory
		ldx #39
-
        .for row=23, row>=0, row-=1
            lda  cbm.Screen + 40*row,x
            sta  cbm.Screen + 40*(row+1),x
        .next
		dex
		bpl  -

		rts
	}}
}

asmsub  setchr  (ubyte col @X, ubyte row @Y, ubyte character @A) clobbers(A, Y)  {
	; ---- sets the character in the screen matrix at the given position
	%asm {{
		pha
		tya
		asl  a
		tay
		lda  _screenrows+1,y
		sta  _mod+2
		txa
		clc
		adc  _screenrows,y
		sta  _mod+1
		bcc  +
		inc  _mod+2
+		pla
_mod		sta  $ffff		; modified
		rts

_screenrows	.word  cbm.Screen + range(0, 1000, 40)
        ; !notreached!
	}}
}

asmsub  getchr  (ubyte col @A, ubyte row @Y) clobbers(Y) -> ubyte @ A {
	; ---- get the character in the screen matrix at the given location
	%asm  {{
                pha
		tya
                ldx  p8b_hdr.p8c_d_ctx + p8b_hdr.p8c_d_origin
                ldy  p8b_hdr.p8c_d_ctx + p8b_hdr.p8c_d_origin + 1
                jsr  p8b_os.p8s_scrrow
                sty  _mod+2
                stx  _mod+1
                pla
                clc
                adc  _mod+1
                sta  _mod+1
                bcc  _mod
                inc  _mod+2
_mod		lda  $ffff		; modified
		rts
	}}
}

asmsub  setclr  (ubyte col @X, ubyte row @Y, ubyte color @A) clobbers(A, Y)  {
	; ---- set the color in A on the screen matrix at the given position
	%asm {{
		pha
		tya
		asl  a
		tay
		lda  _colorrows+1,y
		sta  _mod+2
		txa
		clc
		adc  _colorrows,y
		sta  _mod+1
		bcc  +
		inc  _mod+2
+		pla
_mod		sta  $ffff		; modified
		rts

_colorrows	.word  $d800 + range(0, 1000, 40)
        ; !notreached!
	}}
}

asmsub  getclr  (ubyte col @A, ubyte row @Y) clobbers(Y) -> ubyte @ A {
	; ---- get the color in the screen color matrix at the given location
	%asm  {{
                pha
       	        tya
                ldx  p8b_hdr.p8c_d_ctx + p8b_hdr.p8c_d_coloro
                ldy  p8b_hdr.p8c_d_ctx + p8b_hdr.p8c_d_coloro + 1
                jsr  p8b_os.p8s_scrrow
                sty  _mod+2
                stx  _mod+1
                pla
                clc
                adc  _mod+1
                sta  _mod+1
                bcc  _mod
                inc  _mod+2
_mod		lda  $ffff		; modified
		rts
	}}
}

sub  setcc  (ubyte col, ubyte row, ubyte character, ubyte charcolor)  {
	; ---- set char+color at the given position on the screen
	%asm {{
                ; character
		lda  row
                ldx p8b_hdr.p8c_d_ctx + p8b_hdr.p8c_d_origin
                ldy p8b_hdr.p8c_d_ctx + p8b_hdr.p8c_d_origin + 1
                jsr p8b_os.p8s_scrrow
                sty _charmod+2
                txa
                clc
                adc col
                sta _charmod+1
                bcc +
                inc _charmod+2
                ; color
+       	lda  row
                ldx p8b_hdr.p8c_d_ctx + p8b_hdr.p8c_d_coloro
                ldy p8b_hdr.p8c_d_ctx + p8b_hdr.p8c_d_coloro + 1
                jsr p8b_os.p8s_scrrow
                sty _colormod+2
                txa
                clc
                adc col
                sta _colormod+1
                bcc +
                inc _colormod+2
+		lda  character
_charmod	sta  $ffff		; modified
		lda  charcolor
_colormod	sta  $ffff		; modified
		rts
	}}
}

asmsub  plot  (ubyte col @ Y, ubyte row @ X) {
	%asm  {{
		clc
		jmp  cbm.PLOT
	}}
}

asmsub width() clobbers(X,Y) -> ubyte @A {
    ; -- returns the text screen width (number of columns)
    %asm {{
        lda #p8b_os.p8c_screen_cols
        rts
    }}
}

asmsub height() clobbers(X, Y) -> ubyte @A {
    ; -- returns the text screen height (number of rows)
    %asm {{
        lda #p8b_os.p8c_screen_rows
        rts
    }}
}

asmsub waitkey() -> ubyte @A {
    %asm {{
-       jsr cbm.GETIN
        beq -
        rts
    }}
}
}
