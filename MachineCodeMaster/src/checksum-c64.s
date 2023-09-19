;****************************
;  Checksum from Master Code 'data' statements.
;
;  cl65 -o checksum-c64.prg -t c64 -C c64-asm.cfg --start-addr 0xcf00 checksum-c64.s
;****************************

linnum  := $14      ; and $16
lowtr   := $5F      ; and $60
result  := $FB      ; checksum returned here.
argline := $FC      ; and $FD, argument passed in linnum (returns next line)
tmp4e   := $FE      ; used for basic end of program ('00 00' link address) check
fndlin  := $A613    ; Might need to be adjusted for each new ROM release

      .setcpu "6502x"


      .org $CF00

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

