;****************************
;  Checksum from Master Code 'data' statements.
;  Ported to Commander X16 r43 ROM 
;  cl65 -o file.prg -t cx16 -C cx16-asm.cfg --start-addr 0x0400 checksum-x16.s
;****************************

linnum  := $D4      ; and $D5
lowtr   := $C1      ; and $C2
result  := $4B      ; checksum returned here.
argline := $4C      ; and $4d, argument passed in linnum (returns next line)
tmp4e   := $4E      ; used for basic end of program ('00 00' link address) check
fndlin  := $C8E1    ; Might need to be adjusted for each new ROM release

      .setcpu "6502x"


      .org $0400

      lda  argline
      ldx  argline+1
      sta  linnum        ; Copy passed argument to basic function arg zero page
      stx  linnum+1      ; Copy passed argument to basic function arg zero page
      jsr  fndlin        ; Call fndlin to get address of line or next after
      cld
      ldy  #$01
      lda  (lowtr),y     ; Check high byte of link address
      sta  tmp4e         ; Save high byte (page) for checking for end of program '00 00'
      beq  checksum      ; If high byte of link address is '00', no next line
      iny
      lda  (lowtr),y     ; get low byte of line number found
      sta  argline       ; overwrite passed in line number (low byte)
      iny
      lda  (lowtr),y     ; get high byte of line number found
      sta  argline+1     ; overwrite passed in line number (high byte) 
      iny
      lda  #$00
checksum:
      sta  result        ; Result of sum returned here
      lda  (lowtr),y     ; Read next byte on this line
      beq  done          ; If '00' then end of this line
      clc
      adc  result        ; Add byte to running sum
      iny
      bne  checksum 
done:
      rts

