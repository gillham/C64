os {
    ; function for registering callbacks
    ; fills jump vector slots at the start of app memory.
    sub register(ubyte slot, uword function) {
        hdr.appbase[slot] = lsb(function)
        hdr.appbase[slot+1] = msb(function)
        ; bind hdr function so it stays in code
        hdr.raw_rts_()
    }

inline asmsub alert() {
    %asm {{
        jsr p8b_os.p8l_l_alert
    }}
}
inline asmsub appendto(uword arg0 @XY) {
    %asm {{
        jsr p8b_os.p8l_l_appendto
    }}
}
inline asmsub asc2pet(ubyte arg0 @A) -> ubyte @A {
    %asm {{
        jsr p8b_os.p8l_l_asc2pet
    }}
}
inline asmsub bcd2int(ubyte arg0 @A) -> ubyte @A {
    %asm {{
        jsr p8b_os.p8l_l_bcd2int
    }}
}
inline asmsub bkalloc(ubyte arg0 @X) -> ubyte @Y, bool @Pc {
    %asm {{
        jsr p8b_os.p8l_l_bkalloc
    }}
}
inline asmsub bkfree(ubyte arg0 @X, ubyte arg1 @Y) -> bool @Pc {
    %asm {{
        jsr p8b_os.p8l_l_bkfree
    }}
}
inline asmsub boundschk() -> bool @Pc {
    %asm {{
        jsr p8b_os.p8l_l_boundschk
    }}
}
inline asmsub cclose(ubyte arg0 @X, ubyte arg1 @Y) {
    %asm {{
        jsr p8b_os.p8l_l_cclose
    }}
}
inline asmsub classlnk(uword arg0 @XY) {
    %asm {{
        jsr p8b_os.p8l_l_classlnk
    }}
}
inline asmsub classptr(ubyte arg0 @X) {
    %asm {{
        jsr p8b_os.p8l_l_classptr
    }}
}
inline asmsub clipin(ubyte arg0 @A, uword arg1 @XY) {
    %asm {{
        jsr p8b_os.p8l_l_clipin
    }}
}
inline asmsub clipout(ubyte arg0 @A, uword arg1 @XY) {
    %asm {{
        jsr p8b_os.p8l_l_clipout
    }}
}
inline asmsub confcmp() {
    %asm {{
        jsr p8b_os.p8l_l_confcmp
    }}
}
inline asmsub confcopy() -> ubyte @X, ubyte @Y {
    %asm {{
        jsr p8b_os.p8l_l_confcopy
    }}
}
inline asmsub confgfx(ubyte arg0 @A, ubyte arg1 @X, ubyte arg2 @Y) {
    %asm {{
        jsr p8b_os.p8l_l_confgfx
    }}
}
inline asmsub config() {
    %asm {{
        jsr p8b_os.p8l_l_config
    }}
}
inline asmsub confirq() {
    %asm {{
        jsr p8b_os.p8l_l_confirq
    }}
}
inline asmsub confsize() {
    %asm {{
        jsr p8b_os.p8l_l_confsize
    }}
}
inline asmsub copen(ubyte arg0 @A) {
    %asm {{
        jsr p8b_os.p8l_l_copen
    }}
}
inline asmsub copybufs() {
    %asm {{
        jsr p8b_os.p8l_l_copybufs
    }}
}
inline asmsub cread(ubyte arg0 @A, uword arg1 @XY) {
    %asm {{
        jsr p8b_os.p8l_l_cread
    }}
}
inline asmsub ctx2scr(ubyte arg0 @X, ubyte arg1 @Y) {
    %asm {{
        jsr p8b_os.p8l_l_ctx2scr
    }}
}
inline asmsub ctxclear(ubyte arg0 @A) {
    %asm {{
        jsr p8b_os.p8l_l_ctxclear
    }}
}
inline asmsub ctxdraw(ubyte arg0 @A) -> bool @Pc {
    %asm {{
        jsr p8b_os.p8l_l_ctxdraw
    }}
}
inline asmsub cwrite(ubyte arg0 @A, uword arg1 @XY) {
    %asm {{
        jsr p8b_os.p8l_l_cwrite
    }}
}
inline asmsub datetos(ubyte arg0 @A) -> ubyte @X, ubyte @Y {
    %asm {{
        jsr p8b_os.p8l_l_datetos
    }}
}
inline asmsub dayname(ubyte arg0 @X) -> ubyte @A {
    %asm {{
        jsr p8b_os.p8l_l_dayname
    }}
}
inline asmsub dayofyr(ubyte arg0 @A, ubyte arg1 @X, ubyte arg2 @Y) {
    %asm {{
        jsr p8b_os.p8l_l_dayofyr
    }}
}
inline asmsub daysinm(ubyte arg0 @X, ubyte arg1 @Y) -> ubyte @A {
    %asm {{
        jsr p8b_os.p8l_l_daysinm
    }}
}
inline asmsub deactiv() {
    %asm {{
        jsr p8b_os.p8l_l_deactiv
    }}
}
inline asmsub deqkcmd() {
    %asm {{
        jsr p8b_os.p8l_l_deqkcmd
    }}
}
inline asmsub deqkprnt() {
    %asm {{
        jsr p8b_os.p8l_l_deqkprnt
    }}
}
inline asmsub deqmouse(bool arg0 @Pc) {
    %asm {{
        jsr p8b_os.p8l_l_deqmouse
    }}
}
inline asmsub devroot(ubyte arg0 @A) {
    %asm {{
        jsr p8b_os.p8l_l_devroot
    }}
}
inline asmsub div16(bool arg0 @Pc) {
    %asm {{
        jsr p8b_os.p8l_l_div16
    }}
}
inline asmsub drawctx() {
    %asm {{
        jsr p8b_os.p8l_l_drawctx
    }}
}
inline asmsub evtloop() {
    %asm {{
        jsr p8b_os.p8l_l_evtloop
    }}
}
inline asmsub fclose(uword arg0 @XY) {
    %asm {{
        jsr p8b_os.p8l_l_fclose
    }}
}
inline asmsub ferror() -> ubyte @A {
    %asm {{
        jsr p8b_os.p8l_l_ferror
    }}
}
inline asmsub filecopy() {
    %asm {{
        jsr p8b_os.p8l_l_filecopy
    }}
}
inline asmsub finit(uword arg0 @XY) -> ubyte @A, ubyte @X, bool @Pc {
    %asm {{
        jsr p8b_os.p8l_l_finit
    }}
}
inline asmsub firstdow(ubyte arg0 @A, ubyte arg1 @X, ubyte arg2 @Y) -> ubyte @A {
    %asm {{
        jsr p8b_os.p8l_l_firstdow
    }}
}
inline asmsub fopen(ubyte arg0 @A, uword arg1 @XY) -> ubyte @A, bool @Pc {
    %asm {{
        jsr p8b_os.p8l_l_fopen
    }}
}
inline asmsub frclip(ubyte arg0 @A, bool arg1 @Pc) {
    %asm {{
        jsr p8b_os.p8l_l_frclip
    }}
}
inline asmsub fread(uword arg0 @XY) {
    %asm {{
        jsr p8b_os.p8l_l_fread
    }}
}
inline asmsub free(uword arg0 @XY) {
    %asm {{
        jsr p8b_os.p8l_l_free
    }}
}
inline asmsub freedir(ubyte arg0 @A) {
    %asm {{
        jsr p8b_os.p8l_l_freedir
    }}
}
inline asmsub frefcvt(uword arg0 @XY) {
    %asm {{
        jsr p8b_os.p8l_l_frefcvt
    }}
}
inline asmsub frisodt(uword arg0 @XY) -> ubyte @A, ubyte @X, ubyte @Y {
    %asm {{
        jsr p8b_os.p8l_l_frisodt
    }}
}
inline asmsub frisotm(uword arg0 @XY) -> ubyte @X, ubyte @Y {
    %asm {{
        jsr p8b_os.p8l_l_frisotm
    }}
}
inline asmsub fwrite(uword arg0 @XY) {
    %asm {{
        jsr p8b_os.p8l_l_fwrite
    }}
}
inline asmsub getargs(ubyte arg0 @A) {
    %asm {{
        jsr p8b_os.p8l_l_getargs
    }}
}
inline asmsub getcrc(ubyte arg0 @A, bool arg1 @Pc) -> bool @Pc {
    %asm {{
        jsr p8b_os.p8l_l_getcrc
    }}
}
inline asmsub getdirp() -> ubyte @A {
    %asm {{
        jsr p8b_os.p8l_l_getdirp
    }}
}
inline asmsub getmethod(ubyte arg0 @Y) {
    %asm {{
        jsr p8b_os.p8l_l_getmethod
    }}
}
inline asmsub getprop16(ubyte arg0 @Y) {
    %asm {{
        jsr p8b_os.p8l_l_getprop16
    }}
}
inline asmsub getsfref(ubyte arg0 @Y) -> ubyte @X, ubyte @Y {
    %asm {{
        jsr p8b_os.p8l_l_getsfref
    }}
}
inline asmsub gettime() -> ubyte @X, ubyte @Y {
    %asm {{
        jsr p8b_os.p8l_l_gettime
    }}
}
inline asmsub gopath(ubyte arg0 @A, ubyte arg1 @X) {
    %asm {{
        jsr p8b_os.p8l_l_gopath
    }}
}
inline asmsub height() {
    %asm {{
        jsr p8b_os.p8l_l_height
    }}
}
inline asmsub hidemouse() {
    %asm {{
        jsr p8b_os.p8l_l_hidemouse
    }}
}
inline asmsub initcrc(ubyte arg0 @A) -> bool @Pc {
    %asm {{
        jsr p8b_os.p8l_l_initcrc
    }}
}
inline asmsub initmouse(bool arg0 @Pc) {
    %asm {{
        jsr p8b_os.p8l_l_initmouse
    }}
}
inline asmsub instanceof(uword arg0 @XY) -> bool @Pc {
    %asm {{
        jsr p8b_os.p8l_l_instanceof
    }}
}
inline asmsub isdescof(uword arg0 @XY) -> ubyte @A, bool @Pz {
    %asm {{
        jsr p8b_os.p8l_l_isdescof
    }}
}
inline asmsub isdigit(ubyte arg0 @A) -> bool @Pc {
    %asm {{
        jsr p8b_os.p8l_l_isdigit
    }}
}
inline asmsub isleap(ubyte arg0 @Y) -> bool @Pc {
    %asm {{
        jsr p8b_os.p8l_l_isleap
    }}
}
inline asmsub killmouse() -> bool @Pc {
    %asm {{
        jsr p8b_os.p8l_l_killmouse
    }}
}
inline asmsub layerpop() -> bool @Pz {
    %asm {{
        jsr p8b_os.p8l_l_layerpop
    }}
}
inline asmsub layerpush(uword arg0 @XY) -> ubyte @X, bool @Pc {
    %asm {{
        jsr p8b_os.p8l_l_layerpush
    }}
}
inline asmsub loadapp(uword arg0 @XY) {
    %asm {{
        jsr p8b_os.p8l_l_loadapp
    }}
}
inline asmsub loadclr() {
    %asm {{
        jsr p8b_os.p8l_l_loadclr
    }}
}
inline asmsub loadicns(uword arg0 @XY) {
    %asm {{
        jsr p8b_os.p8l_l_loadicns
    }}
}
inline asmsub loadlib(ubyte arg0 @A, ubyte arg1 @X, ubyte arg2 @Y) -> ubyte @A {
    %asm {{
        jsr p8b_os.p8l_l_loadlib
    }}
}
inline asmsub loadreloc(uword arg0 @XY) -> ubyte @A {
    %asm {{
        jsr p8b_os.p8l_l_loadreloc
    }}
}
inline asmsub loadtune(uword arg0 @XY) -> ubyte @A, ubyte @X, bool @Pc {
    %asm {{
        jsr p8b_os.p8l_l_loadtune
    }}
}
inline asmsub loadutil(uword arg0 @XY) -> bool @Pc {
    %asm {{
        jsr p8b_os.p8l_l_loadutil
    }}
}
inline asmsub maketab(ubyte arg0 @A) -> bool @Pc {
    %asm {{
        jsr p8b_os.p8l_l_maketab
    }}
}
inline asmsub malloc(ubyte arg0 @A, uword arg1 @XY) -> bool @Pc {
    %asm {{
        jsr p8b_os.p8l_l_malloc
    }}
}
inline asmsub markredraw(ubyte arg0 @X) {
    %asm {{
        jsr p8b_os.p8l_l_markredraw
    }}
}
inline asmsub memcpy(ubyte arg0 @A, ubyte arg1 @Y) {
    %asm {{
        jsr p8b_os.p8l_l_memcpy
    }}
}
inline asmsub memfree() -> ubyte @X {
    %asm {{
        jsr p8b_os.p8l_l_memfree
    }}
}
inline asmsub memncpy(ubyte arg0 @A, ubyte arg1 @X, ubyte arg2 @Y) {
    %asm {{
        jsr p8b_os.p8l_l_memncpy
    }}
}
inline asmsub memset(ubyte arg0 @A, ubyte arg1 @Y) {
    %asm {{
        jsr p8b_os.p8l_l_memset
    }}
}
inline asmsub mnthname(ubyte arg0 @X) -> ubyte @A {
    %asm {{
        jsr p8b_os.p8l_l_mnthname
    }}
}
inline asmsub mnudraw() {
    %asm {{
        jsr p8b_os.p8l_l_mnudraw
    }}
}
inline asmsub mnukcmd() {
    %asm {{
        jsr p8b_os.p8l_l_mnukcmd
    }}
}
inline asmsub mnumouse() {
    %asm {{
        jsr p8b_os.p8l_l_mnumouse
    }}
}
inline asmsub mouserc(ubyte arg0 @A, ubyte arg1 @X, ubyte arg2 @Y) -> ubyte @A, ubyte @X, ubyte @Y {
    %asm {{
        jsr p8b_os.p8l_l_mouserc
    }}
}
inline asmsub msgapp(ubyte arg0 @A, ubyte arg1 @X, ubyte arg2 @Y, bool arg3 @Pc) {
    %asm {{
        jsr p8b_os.p8l_l_msgapp
    }}
}
inline asmsub msgutil(ubyte arg0 @A, ubyte arg1 @X, ubyte arg2 @Y, bool arg3 @Pc) {
    %asm {{
        jsr p8b_os.p8l_l_msgutil
    }}
}
inline asmsub mul16() {
    %asm {{
        jsr p8b_os.p8l_l_mul16
    }}
}
inline asmsub opaqancs() {
    %asm {{
        jsr p8b_os.p8l_l_opaqancs
    }}
}
inline asmsub partroot(ubyte arg0 @A) {
    %asm {{
        jsr p8b_os.p8l_l_partroot
    }}
}
inline asmsub pathadd(ubyte arg0 @A, uword arg1 @XY) {
    %asm {{
        jsr p8b_os.p8l_l_pathadd
    }}
}
inline asmsub pathup(ubyte arg0 @A) {
    %asm {{
        jsr p8b_os.p8l_l_pathup
    }}
}
inline asmsub pet2asc(ubyte arg0 @A) -> ubyte @A {
    %asm {{
        jsr p8b_os.p8l_l_pet2asc
    }}
}
inline asmsub pet2scr(ubyte arg0 @A) -> ubyte @A {
    %asm {{
        jsr p8b_os.p8l_l_pet2scr
    }}
}
inline asmsub pgalloc(ubyte arg0 @A, ubyte arg1 @X) -> ubyte @Y, bool @Pc {
    %asm {{
        jsr p8b_os.p8l_l_pgalloc
    }}
}
inline asmsub pgfetch(uword arg0 @XY) -> bool @Pc {
    %asm {{
        jsr p8b_os.p8l_l_pgfetch
    }}
}
inline asmsub pgfree(ubyte arg0 @X, ubyte arg1 @Y) -> bool @Pc {
    %asm {{
        jsr p8b_os.p8l_l_pgfree
    }}
}
inline asmsub pgmark(ubyte arg0 @X, ubyte arg1 @Y) {
    %asm {{
        jsr p8b_os.p8l_l_pgmark
    }}
}
inline asmsub pgstash(uword arg0 @XY) -> bool @Pc {
    %asm {{
        jsr p8b_os.p8l_l_pgstash
    }}
}
inline asmsub polldevices() {
    %asm {{
        jsr p8b_os.p8l_l_polldevices
    }}
}
inline asmsub prep_rw(ubyte arg0 @A, uword arg1 @XY) {
    %asm {{
        jsr p8b_os.p8l_l_prep_rw
    }}
}
inline asmsub presort() {
    %asm {{
        jsr p8b_os.p8l_l_presort
    }}
}
inline asmsub procgfx() {
    %asm {{
        jsr p8b_os.p8l_l_procgfx
    }}
}
inline asmsub ptrthis(uword arg0 @XY) {
    %asm {{
        jsr p8b_os.p8l_l_ptrthis
    }}
}
inline asmsub pullctx() {
    %asm {{
        jsr p8b_os.p8l_l_pullctx
    }}
}
inline asmsub pushctx() {
    %asm {{
        jsr p8b_os.p8l_l_pushctx
    }}
}
inline asmsub quitapp() {
    %asm {{
        jsr p8b_os.p8l_l_quitapp
    }}
}
inline asmsub readdir() -> ubyte @X, bool @Pc {
    %asm {{
        jsr p8b_os.p8l_l_readdir
    }}
}
inline asmsub readkcmd() -> ubyte @A, ubyte @Y, bool @Pc {
    %asm {{
        jsr p8b_os.p8l_l_readkcmd
    }}
}
inline asmsub readkprnt() -> ubyte @A, bool @Pc {
    %asm {{
        jsr p8b_os.p8l_l_readkprnt
    }}
}
inline asmsub readmouse() -> ubyte @A, ubyte @X, ubyte @Y, bool @Pc {
    %asm {{
        jsr p8b_os.p8l_l_readmouse
    }}
}
inline asmsub readreg(ubyte arg0 @A, ubyte arg1 @Y, bool arg2 @Pc) -> ubyte @A {
    %asm {{
        jsr p8b_os.p8l_l_readreg
    }}
}
inline asmsub realloc(ubyte arg0 @A, uword arg1 @XY) -> bool @Pc {
    %asm {{
        jsr p8b_os.p8l_l_realloc
    }}
}
inline asmsub recontext() {
    %asm {{
        jsr p8b_os.p8l_l_recontext
    }}
}
inline asmsub redraw() {
    %asm {{
        jsr p8b_os.p8l_l_redraw
    }}
}
inline asmsub redrwtod() {
    %asm {{
        jsr p8b_os.p8l_l_redrwtod
    }}
}
inline asmsub renamef() {
    %asm {{
        jsr p8b_os.p8l_l_renamef
    }}
}
inline asmsub reset() {
    %asm {{
        jsr p8b_os.p8l_l_reset
    }}
}
inline asmsub reuconf(ubyte arg0 @A, uword arg1 @XY) -> ubyte @A, bool @Pc {
    %asm {{
        jsr p8b_os.p8l_l_reuconf
    }}
}
inline asmsub scratchf() {
    %asm {{
        jsr p8b_os.p8l_l_scratchf
    }}
}
inline asmsub scrlayer() {
    %asm {{
        jsr p8b_os.p8l_l_scrlayer
    }}
}
inline asmsub scrrow(ubyte arg0 @A, uword arg1 @XY) {
    %asm {{
        jsr p8b_os.p8l_l_scrrow
    }}
}
inline asmsub seebas() {
    %asm {{
        jsr p8b_os.p8l_l_seebas
    }}
}
inline asmsub setclass() {
    %asm {{
        jsr p8b_os.p8l_l_setclass
    }}
}
inline asmsub setctx(uword arg0 @XY) {
    %asm {{
        jsr p8b_os.p8l_l_setctx
    }}
}
inline asmsub setdprops(ubyte arg0 @X, ubyte arg1 @Y) {
    %asm {{
        jsr p8b_os.p8l_l_setdprops
    }}
}
inline asmsub setflags(ubyte arg0 @A) {
    %asm {{
        jsr p8b_os.p8l_l_setflags
    }}
}
inline asmsub setgfx(uword arg0 @XY) {
    %asm {{
        jsr p8b_os.p8l_l_setgfx
    }}
}
inline asmsub setlrc(uword arg0 @XY, bool arg1 @Pc) {
    %asm {{
        jsr p8b_os.p8l_l_setlrc
    }}
}
inline asmsub setname(ubyte arg0 @A, uword arg1 @XY) {
    %asm {{
        jsr p8b_os.p8l_l_setname
    }}
}
inline asmsub setsuper() {
    %asm {{
        jsr p8b_os.p8l_l_setsuper
    }}
}
inline asmsub settime(uword arg0 @XY) {
    %asm {{
        jsr p8b_os.p8l_l_settime
    }}
}
inline asmsub settkenv(uword arg0 @XY) {
    %asm {{
        jsr p8b_os.p8l_l_settkenv
    }}
}
;inline asmsub sort() {
;    %asm {{
;        jsr p8b_os.p8l_l_sort
;    }}
;}
inline asmsub spotcopy() {
    %asm {{
        jsr p8b_os.p8l_l_spotcopy
    }}
}
inline asmsub stattune(ubyte arg0 @A) {
    %asm {{
        jsr p8b_os.p8l_l_stattune
    }}
}
inline asmsub strdel(ubyte arg0 @A, ubyte arg1 @Y) {
    %asm {{
        jsr p8b_os.p8l_l_strdel
    }}
}
inline asmsub strins(ubyte arg0 @A, ubyte arg1 @Y) {
    %asm {{
        jsr p8b_os.p8l_l_strins
    }}
}
inline asmsub strlen(uword arg0 @XY) {
    %asm {{
        jsr p8b_os.p8l_l_strlen
    }}
}
inline asmsub syskcmd(ubyte arg0 @A, ubyte arg1 @Y) {
    %asm {{
        jsr p8b_os.p8l_l_syskcmd
    }}
}
inline asmsub timedwn() {
    %asm {{
        jsr p8b_os.p8l_l_timedwn
    }}
}
inline asmsub timeevt() {
    %asm {{
        jsr p8b_os.p8l_l_timeevt
    }}
}
inline asmsub timeque(uword arg0 @XY) -> bool @Pc {
    %asm {{
        jsr p8b_os.p8l_l_timeque
    }}
}
inline asmsub tkenv() {
    %asm {{
        jsr p8b_os.p8l_l_tkenv
    }}
}
inline asmsub tkkcmd(uword arg0 @XY) -> bool @Pc {
    %asm {{
        jsr p8b_os.p8l_l_tkkcmd
    }}
}
inline asmsub tkkprnt(uword arg0 @XY) -> bool @Pc {
    %asm {{
        jsr p8b_os.p8l_l_tkkprnt
    }}
}
inline asmsub tkmouse(uword arg0 @XY) -> bool @Pc {
    %asm {{
        jsr p8b_os.p8l_l_tkmouse
    }}
}
inline asmsub tknew(uword arg0 @XY) {
    %asm {{
        jsr p8b_os.p8l_l_tknew
    }}
}
inline asmsub tkupdate(uword arg0 @XY) {
    %asm {{
        jsr p8b_os.p8l_l_tkupdate
    }}
}
inline asmsub toglock(uword arg0 @XY) {
    %asm {{
        jsr p8b_os.p8l_l_toglock
    }}
}
inline asmsub tohex(ubyte arg0 @A) -> ubyte @X, ubyte @Y {
    %asm {{
        jsr p8b_os.p8l_l_tohex
    }}
}
inline asmsub toint(ubyte arg0 @A, uword arg1 @XY) {
    %asm {{
        jsr p8b_os.p8l_l_toint
    }}
}
inline asmsub toisodt(ubyte arg0 @A, ubyte arg1 @X, ubyte arg2 @Y) {
    %asm {{
        jsr p8b_os.p8l_l_toisodt
    }}
}
inline asmsub toisotm(ubyte arg0 @X, ubyte arg1 @Y) {
    %asm {{
        jsr p8b_os.p8l_l_toisotm
    }}
}
inline asmsub tolower(ubyte arg0 @A) -> ubyte @A {
    %asm {{
        jsr p8b_os.p8l_l_tolower
    }}
}
inline asmsub tostr() {
    %asm {{
        jsr p8b_os.p8l_l_tostr
    }}
}
inline asmsub toupper(ubyte arg0 @A) -> ubyte @A {
    %asm {{
        jsr p8b_os.p8l_l_toupper
    }}
}
inline asmsub try() {
    %asm {{
        jsr p8b_os.p8l_l_try
    }}
}
inline asmsub tuneinfo(ubyte arg0 @X) {
    %asm {{
        jsr p8b_os.p8l_l_tuneinfo
    }}
}
inline asmsub unldlib(ubyte arg0 @A, ubyte arg1 @X, ubyte arg2 @Y) {
    %asm {{
        jsr p8b_os.p8l_l_unldlib
    }}
}
inline asmsub updc16(ubyte arg0 @A) {
    %asm {{
        jsr p8b_os.p8l_l_updc16
    }}
}
inline asmsub updc32(ubyte arg0 @A) {
    %asm {{
        jsr p8b_os.p8l_l_updc32
    }}
}
inline asmsub updc8(ubyte arg0 @A) {
    %asm {{
        jsr p8b_os.p8l_l_updc8
    }}
}
inline asmsub updstat() {
    %asm {{
        jsr p8b_os.p8l_l_updstat
    }}
}
inline asmsub viewwtag(ubyte arg0 @A) {
    %asm {{
        jsr p8b_os.p8l_l_viewwtag
    }}
}
inline asmsub walk(ubyte arg0 @A) -> bool @Pc {
    %asm {{
        jsr p8b_os.p8l_l_walk
    }}
}
inline asmsub weeknum(ubyte arg0 @A, ubyte arg1 @X, ubyte arg2 @Y) {
    %asm {{
        jsr p8b_os.p8l_l_weeknum
    }}
}
inline asmsub width() {
    %asm {{
        jsr p8b_os.p8l_l_width
    }}
}
inline asmsub writreg(ubyte arg0 @A, ubyte arg1 @Y) -> ubyte @A {
    %asm {{
        jsr p8b_os.p8l_l_writreg
    }}
}
inline asmsub initextern() clobbers(A,X,Y) {
    %asm {{
        ldx #<p8b_os.p8l_l_externs
        ldy #>p8b_os.p8l_l_externs
        jsr $02fc
    }}
}
l_externs:
l_alert:
    %asm {{
        .byte p8b_hdr.p8c_lser
        .word p8b_hdr.p8c_alert_
    }}
l_appendto:
    %asm {{
        .byte p8b_hdr.p8c_ltkt
        .word p8b_hdr.p8c_appendto_
    }}
l_asc2pet:
    %asm {{
        .byte p8b_hdr.p8c_lstr
        .word p8b_hdr.p8c_asc2pet_
    }}
l_bkalloc:
    %asm {{
        .byte p8b_hdr.p8c_lmem
        .word p8b_hdr.p8c_bkalloc_
    }}
l_bkfree:
    %asm {{
        .byte p8b_hdr.p8c_lmem
        .word p8b_hdr.p8c_bkfree_
    }}
l_boundschk:
    %asm {{
        .byte p8b_hdr.p8c_ltkt
        .word p8b_hdr.p8c_boundschk_
    }}
l_cclose:
    %asm {{
        .byte p8b_hdr.p8c_lfil
        .word p8b_hdr.p8c_cclose_
    }}
l_classlnk:
    %asm {{
        .byte p8b_hdr.p8c_ltkt
        .word p8b_hdr.p8c_classlnk_
    }}
l_classptr:
    %asm {{
        .byte p8b_hdr.p8c_ltkt
        .word p8b_hdr.p8c_classptr_
    }}
l_clipin:
    %asm {{
        .byte p8b_hdr.p8c_lfil
        .word p8b_hdr.p8c_clipin_
    }}
l_clipout:
    %asm {{
        .byte p8b_hdr.p8c_lfil
        .word p8b_hdr.p8c_clipout_
    }}
l_confirq:
    %asm {{
        .byte p8b_hdr.p8c_lser
        .word p8b_hdr.p8c_confirq_
    }}
l_copen:
    %asm {{
        .byte p8b_hdr.p8c_lfil
        .word p8b_hdr.p8c_copen_
    }}
l_copybufs:
    %asm {{
        .byte p8b_hdr.p8c_lscr
        .word p8b_hdr.p8c_copybufs_
    }}
l_cread:
    %asm {{
        .byte p8b_hdr.p8c_lfil
        .word p8b_hdr.p8c_cread_
    }}
l_ctx2scr:
    %asm {{
        .byte p8b_hdr.p8c_lscr
        .word p8b_hdr.p8c_ctx2scr_
    }}
l_ctxclear:
    %asm {{
        .byte p8b_hdr.p8c_lscr
        .word p8b_hdr.p8c_ctxclear_
    }}
l_ctxdraw:
    %asm {{
        .byte p8b_hdr.p8c_lscr
        .word p8b_hdr.p8c_ctxdraw_
    }}
l_cwrite:
    %asm {{
        .byte p8b_hdr.p8c_lfil
        .word p8b_hdr.p8c_cwrite_
    }}
l_deactiv:
    %asm {{
        .byte p8b_hdr.p8c_lmnu
        .word p8b_hdr.p8c_deactiv_
    }}
l_deqkcmd:
    %asm {{
        .byte p8b_hdr.p8c_linp
        .word p8b_hdr.p8c_deqkcmd_
    }}
l_deqkprnt:
    %asm {{
        .byte p8b_hdr.p8c_linp
        .word p8b_hdr.p8c_deqkprnt_
    }}
l_deqmouse:
    %asm {{
        .byte p8b_hdr.p8c_linp
        .word p8b_hdr.p8c_deqmouse_
    }}
l_div16:
    %asm {{
        .byte p8b_hdr.p8c_lmat
        .word p8b_hdr.p8c_div16_
    }}
l_evtloop:
    %asm {{
        .byte p8b_hdr.p8c_lscr
        .word p8b_hdr.p8c_evtloop_
    }}
l_fclose:
    %asm {{
        .byte p8b_hdr.p8c_lfil
        .word p8b_hdr.p8c_fclose_
    }}
l_ferror:
    %asm {{
        .byte p8b_hdr.p8c_lfil
        .word p8b_hdr.p8c_ferror_
    }}
l_finit:
    %asm {{
        .byte p8b_hdr.p8c_lfil
        .word p8b_hdr.p8c_finit_
    }}
l_fopen:
    %asm {{
        .byte p8b_hdr.p8c_lfil
        .word p8b_hdr.p8c_fopen_
    }}
l_fread:
    %asm {{
        .byte p8b_hdr.p8c_lfil
        .word p8b_hdr.p8c_fread_
    }}
l_free:
    %asm {{
        .byte p8b_hdr.p8c_lmem
        .word p8b_hdr.p8c_free_
    }}
l_frefcvt:
    %asm {{
        .byte p8b_hdr.p8c_lfil
        .word p8b_hdr.p8c_frefcvt_
    }}
l_fwrite:
    %asm {{
        .byte p8b_hdr.p8c_lfil
        .word p8b_hdr.p8c_fwrite_
    }}
l_getargs:
    %asm {{
        .byte p8b_hdr.p8c_lser
        .word p8b_hdr.p8c_getargs_
    }}
l_getmethod:
    %asm {{
        .byte p8b_hdr.p8c_ltkt
        .word p8b_hdr.p8c_getmethod_
    }}
l_getprop16:
    %asm {{
        .byte p8b_hdr.p8c_ltkt
        .word p8b_hdr.p8c_getprop16_
    }}
l_getsfref:
    %asm {{
        .byte p8b_hdr.p8c_lser
        .word p8b_hdr.p8c_getsfref_
    }}
l_hidemouse:
    %asm {{
        .byte p8b_hdr.p8c_linp
        .word p8b_hdr.p8c_hidemouse_
    }}
l_initmouse:
    %asm {{
        .byte p8b_hdr.p8c_linp
        .word p8b_hdr.p8c_initmouse_
    }}
l_instanceof:
    %asm {{
        .byte p8b_hdr.p8c_ltkt
        .word p8b_hdr.p8c_instanceof_
    }}
l_isdescof:
    %asm {{
        .byte p8b_hdr.p8c_ltkt
        .word p8b_hdr.p8c_isdescof_
    }}
l_isdigit:
    %asm {{
        .byte p8b_hdr.p8c_lstr
        .word p8b_hdr.p8c_isdigit_
    }}
l_killmouse:
    %asm {{
        .byte p8b_hdr.p8c_linp
        .word p8b_hdr.p8c_killmouse_
    }}
l_layerpop:
    %asm {{
        .byte p8b_hdr.p8c_lscr
        .word p8b_hdr.p8c_layerpop_
    }}
l_layerpush:
    %asm {{
        .byte p8b_hdr.p8c_lscr
        .word p8b_hdr.p8c_layerpush_
    }}
l_loadapp:
    %asm {{
        .byte p8b_hdr.p8c_lser
        .word p8b_hdr.p8c_loadapp_
    }}
l_loadclr:
    %asm {{
        .byte p8b_hdr.p8c_lscr
        .word p8b_hdr.p8c_loadclr_
    }}
l_loadicns:
    %asm {{
        .byte p8b_hdr.p8c_lscr
        .word p8b_hdr.p8c_loadicns_
    }}
l_loadlib:
    %asm {{
        .byte p8b_hdr.p8c_lser
        .word p8b_hdr.p8c_loadlib_
    }}
l_loadreloc:
    %asm {{
        .byte p8b_hdr.p8c_lser
        .word p8b_hdr.p8c_loadreloc_
    }}
l_loadutil:
    %asm {{
        .byte p8b_hdr.p8c_lser
        .word p8b_hdr.p8c_loadutil_
    }}
l_malloc:
    %asm {{
        .byte p8b_hdr.p8c_lmem
        .word p8b_hdr.p8c_malloc_
    }}
l_markredraw:
    %asm {{
        .byte p8b_hdr.p8c_lscr
        .word p8b_hdr.p8c_markredraw_
    }}
l_memcpy:
    %asm {{
        .byte p8b_hdr.p8c_lmem
        .word p8b_hdr.p8c_memcpy_
    }}
l_memfree:
    %asm {{
        .byte p8b_hdr.p8c_lmem
        .word p8b_hdr.p8c_memfree_
    }}
l_memncpy:
    %asm {{
        .byte p8b_hdr.p8c_lstr
        .word p8b_hdr.p8c_memncpy_
    }}
l_memset:
    %asm {{
        .byte p8b_hdr.p8c_lmem
        .word p8b_hdr.p8c_memset_
    }}
l_mnudraw:
    %asm {{
        .byte p8b_hdr.p8c_lmnu
        .word p8b_hdr.p8c_mnudraw_
    }}
l_mnukcmd:
    %asm {{
        .byte p8b_hdr.p8c_lmnu
        .word p8b_hdr.p8c_mnukcmd_
    }}
l_mnumouse:
    %asm {{
        .byte p8b_hdr.p8c_lmnu
        .word p8b_hdr.p8c_mnumouse_
    }}
l_mouserc:
    %asm {{
        .byte p8b_hdr.p8c_linp
        .word p8b_hdr.p8c_mouserc_
    }}
l_msgapp:
    %asm {{
        .byte p8b_hdr.p8c_ltim
        .word p8b_hdr.p8c_msgapp_
    }}
l_msgutil:
    %asm {{
        .byte p8b_hdr.p8c_ltim
        .word p8b_hdr.p8c_msgutil_
    }}
l_mul16:
    %asm {{
        .byte p8b_hdr.p8c_lmat
        .word p8b_hdr.p8c_mul16_
    }}
l_opaqancs:
    %asm {{
        .byte p8b_hdr.p8c_ltkt
        .word p8b_hdr.p8c_opaqancs_
    }}
l_pet2asc:
    %asm {{
        .byte p8b_hdr.p8c_lstr
        .word p8b_hdr.p8c_pet2asc_
    }}
l_pet2scr:
    %asm {{
        .byte p8b_hdr.p8c_lstr
        .word p8b_hdr.p8c_pet2scr_
    }}
l_pgalloc:
    %asm {{
        .byte p8b_hdr.p8c_lmem
        .word p8b_hdr.p8c_pgalloc_
    }}
l_pgfetch:
    %asm {{
        .byte p8b_hdr.p8c_lmem
        .word p8b_hdr.p8c_pgfetch_
    }}
l_pgfree:
    %asm {{
        .byte p8b_hdr.p8c_lmem
        .word p8b_hdr.p8c_pgfree_
    }}
l_pgmark:
    %asm {{
        .byte p8b_hdr.p8c_lmem
        .word p8b_hdr.p8c_pgmark_
    }}
l_pgstash:
    %asm {{
        .byte p8b_hdr.p8c_lmem
        .word p8b_hdr.p8c_pgstash_
    }}
l_polldevices:
    %asm {{
        .byte p8b_hdr.p8c_linp
        .word p8b_hdr.p8c_polldevices_
    }}
l_ptrthis:
    %asm {{
        .byte p8b_hdr.p8c_ltkt
        .word p8b_hdr.p8c_ptrthis_
    }}
l_pullctx:
    %asm {{
        .byte p8b_hdr.p8c_ltkt
        .word p8b_hdr.p8c_pullctx_
    }}
l_pushctx:
    %asm {{
        .byte p8b_hdr.p8c_ltkt
        .word p8b_hdr.p8c_pushctx_
    }}
l_quitapp:
    %asm {{
        .byte p8b_hdr.p8c_lser
        .word p8b_hdr.p8c_quitapp_
    }}
l_readkcmd:
    %asm {{
        .byte p8b_hdr.p8c_linp
        .word p8b_hdr.p8c_readkcmd_
    }}
l_readkprnt:
    %asm {{
        .byte p8b_hdr.p8c_linp
        .word p8b_hdr.p8c_readkprnt_
    }}
l_readmouse:
    %asm {{
        .byte p8b_hdr.p8c_linp
        .word p8b_hdr.p8c_readmouse_
    }}
l_realloc:
    %asm {{
        .byte p8b_hdr.p8c_lmem
        .word p8b_hdr.p8c_realloc_
    }}
l_recontext:
    %asm {{
        .byte p8b_hdr.p8c_ltkt
        .word p8b_hdr.p8c_recontext_
    }}
l_redraw:
    %asm {{
        .byte p8b_hdr.p8c_lscr
        .word p8b_hdr.p8c_redraw_
    }}
l_redrwtod:
    %asm {{
        .byte p8b_hdr.p8c_lser
        .word p8b_hdr.p8c_redrwtod_
    }}
l_reuconf:
    %asm {{
        .byte p8b_hdr.p8c_lmem
        .word p8b_hdr.p8c_reuconf_
    }}
l_scrrow:
    %asm {{
        .byte p8b_hdr.p8c_lscr
        .word p8b_hdr.p8c_scrrow_
    }}
l_seebas:
    %asm {{
        .byte p8b_hdr.p8c_lmat
        .word p8b_hdr.p8c_seebas_
    }}
l_setclass:
    %asm {{
        .byte p8b_hdr.p8c_ltkt
        .word p8b_hdr.p8c_setclass_
    }}
l_setctx:
    %asm {{
        .byte p8b_hdr.p8c_ltkt
        .word p8b_hdr.p8c_setctx_
    }}
l_setdprops:
    %asm {{
        .byte p8b_hdr.p8c_lscr
        .word p8b_hdr.p8c_setdprops_
    }}
l_setflags:
    %asm {{
        .byte p8b_hdr.p8c_lser
        .word p8b_hdr.p8c_setflags_
    }}
l_setgfx:
    %asm {{
        .byte p8b_hdr.p8c_lser
        .word p8b_hdr.p8c_setgfx_
    }}
l_setlrc:
    %asm {{
        .byte p8b_hdr.p8c_lscr
        .word p8b_hdr.p8c_setlrc_
    }}
l_setsuper:
    %asm {{
        .byte p8b_hdr.p8c_ltkt
        .word p8b_hdr.p8c_setsuper_
    }}
l_settkenv:
    %asm {{
        .byte p8b_hdr.p8c_ltkt
        .word p8b_hdr.p8c_settkenv_
    }}
l_strdel:
    %asm {{
        .byte p8b_hdr.p8c_lstr
        .word p8b_hdr.p8c_strdel_
    }}
l_strins:
    %asm {{
        .byte p8b_hdr.p8c_lstr
        .word p8b_hdr.p8c_strins_
    }}
l_strlen:
    %asm {{
        .byte p8b_hdr.p8c_lstr
        .word p8b_hdr.p8c_strlen_
    }}
l_syskcmd:
    %asm {{
        .byte p8b_hdr.p8c_lser
        .word p8b_hdr.p8c_syskcmd_
    }}
l_timedwn:
    %asm {{
        .byte p8b_hdr.p8c_ltim
        .word p8b_hdr.p8c_timedwn_
    }}
l_timeevt:
    %asm {{
        .byte p8b_hdr.p8c_ltim
        .word p8b_hdr.p8c_timeevt_
    }}
l_timeque:
    %asm {{
        .byte p8b_hdr.p8c_ltim
        .word p8b_hdr.p8c_timeque_
    }}
l_tkkcmd:
    %asm {{
        .byte p8b_hdr.p8c_ltkt
        .word p8b_hdr.p8c_tkkcmd_
    }}
l_tkkprnt:
    %asm {{
        .byte p8b_hdr.p8c_ltkt
        .word p8b_hdr.p8c_tkkprnt_
    }}
l_tkmouse:
    %asm {{
        .byte p8b_hdr.p8c_ltkt
        .word p8b_hdr.p8c_tkmouse_
    }}
l_tknew:
    %asm {{
        .byte p8b_hdr.p8c_ltkt
        .word p8b_hdr.p8c_tknew_
    }}
l_tkupdate:
    %asm {{
        .byte p8b_hdr.p8c_ltkt
        .word p8b_hdr.p8c_tkupdate_
    }}
l_tohex:
    %asm {{
        .byte p8b_hdr.p8c_lmat
        .word p8b_hdr.p8c_tohex_
    }}
l_toint:
    %asm {{
        .byte p8b_hdr.p8c_lmat
        .word p8b_hdr.p8c_toint_
    }}
l_tolower:
    %asm {{
        .byte p8b_hdr.p8c_lstr
        .word p8b_hdr.p8c_tolower_
    }}
l_tostr:
    %asm {{
        .byte p8b_hdr.p8c_lmat
        .word p8b_hdr.p8c_tostr_
    }}
l_toupper:
    %asm {{
        .byte p8b_hdr.p8c_lstr
        .word p8b_hdr.p8c_toupper_
    }}
l_unldlib:
    %asm {{
        .byte p8b_hdr.p8c_lser
        .word p8b_hdr.p8c_unldlib_
    }}
l_updstat:
    %asm {{
        .byte p8b_hdr.p8c_lser
        .word p8b_hdr.p8c_updstat_
    }}
l_viewwtag:
    %asm {{
        .byte p8b_hdr.p8c_ltkt
        .word p8b_hdr.p8c_viewwtag_
    }}
l_walk:
    %asm {{
        .byte p8b_hdr.p8c_ltkt
        .word p8b_hdr.p8c_walk_
    }}
l_terminator:
    %asm {{
        .byte $FF
    }}
}
