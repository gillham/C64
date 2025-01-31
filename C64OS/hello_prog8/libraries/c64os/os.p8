%option ignore_unused

hdr {
const ubyte APP_INIT = 0
const ubyte APP_MSG = 2
const ubyte APP_QUIT = 4
const ubyte APP_FREEZE = 6
const ubyte APP_THAW = 8
const uword acptr = $ffa5
const ubyte actcode = 2
const ubyte actionsize = 4
const uword addfav = 18
const uword addrcnt = 21
const uword alert_ = 0
const uword appbase = $0900
const uword appendto_ = 69
const uword appfileref = $0338
const ubyte appfrze = 6
const ubyte appinit = 0
const ubyte appmcmd = 2
const ubyte appquit = 4
const uword appreubk = $0282
const ubyte appthaw = 8
const ubyte arg = $69
const uword argfac = $bbfc
const ubyte argptr = $45
const uword asc2pet_ = 6
const ubyte at_gnrl = 0
const ubyte at_instl = 2
const ubyte at_rstr = 1
const ubyte awidth = 0
const uword backregs = $03bc
const uword bankmap = $1b00
const uword bankordr = $1ae0
const uword basicerr = $08f0
const uword bcd2int_ = $0012
const uword berrcode = $03b9
const uword bindnhd_ = 6
const uword bkalloc_ = 9
const uword bkfree_ = 6
const uword bmapmem = $e000
const ubyte bnk_empt = $fd
const ubyte bnk_free = $fe
const ubyte bnk_full = $fc
const ubyte bnk_nota = $ff
const uword boundschk_ = 12
const ubyte brc_115 = $0009
const ubyte brc_12 = $0001
const ubyte brc_144 = $0005
const ubyte brc_192 = $0006
const ubyte brc_230 = $000a
const ubyte brc_24 = $0002
const ubyte brc_3 = $0000
const ubyte brc_384 = $0007
const ubyte brc_48 = $0003
const ubyte brc_576 = $0008
const ubyte brc_96 = $0004
const ubyte busychar = $00e6
const ubyte c_bckgnd = $0001
const ubyte c_border = $0000
const ubyte c_button = $000a
const ubyte c_colblr = $0014
const ubyte c_colfoc = $0013
const ubyte c_defbut = $000b
const ubyte c_disabl = $000e
const uword c_dsize = $0248
const ubyte c_dsptxt = $0006
const uword c_dstype = $0247
const uword c_dtype = $0246
const ubyte c_emftxt = $0008
const ubyte c_fpanel = $0002
const ubyte c_ftitle = $0003
const ubyte c_mnubar = $0004
const ubyte c_mnusel = $0005
const ubyte c_scrlbg = $000d
const ubyte c_scrlfg = $000c
const ubyte c_seltxt = $0009
const ubyte c_stgtxt = $0007
const ubyte c_tabblr = $0012
const ubyte c_tabfoc = $0011
const ubyte c_txffoc = $0010
const ubyte c_txtfld = $000f
const ubyte car_comp = 21
const ubyte car_date = 12
const ubyte car_lock = 1
const ubyte car_magic = 1
const ubyte car_name = 5
const ubyte car_note = 17
const ubyte car_size = 2
const ubyte car_type = 0
const ubyte car_ver = 11
const ubyte cbgmask = $f0
const ubyte cblack = $00
const ubyte cblue = $06
const ubyte cbmkey = %00000010
const ubyte cbrown = $09
const uword cclose_ = 36
const ubyte ccyan = $03
const ubyte cdgrey = $0b
const ubyte cfgmask = $0f
const ubyte cgf_frcnt = $0004
const ubyte cgf_frdel = $0005
const ubyte cgf_fscls = $0009
const ubyte cgf_fsrws = $0008
const ubyte cgf_lpcnt = $0006
const ubyte cgf_mdctl = $0007
const ubyte cgf_mxcls = $0001
const ubyte cgf_mxrws = $0000
const ubyte cgf_mxsci = $0003
const ubyte cgf_mxsri = $0002
const ubyte cgf_vdatr = $000b
const ubyte cgf_vdmod = $000a
const ubyte cgm_artist = $0000
const ubyte cgm_releas = $0040
const ubyte cgm_source = $0020
const ubyte cgm_title = $0060
const ubyte cgreen = $05
const uword charset = $d000
const ubyte chblack = $00
const ubyte chblue = $60
const ubyte chbrown = $90
const ubyte chcyan = $30
const ubyte chdgrey = $b0
const ubyte chgreen = $50
const ubyte childptr = 2
const uword chkin = $ffc6
const uword chkout = $ffc9
const ubyte chlblue = $e0
const ubyte chlgreen = $d0
const ubyte chlgrey = $f0
const ubyte chlred = $a0
const ubyte chmgrey = $c0
const ubyte chorange = $80
const ubyte chpurple = $40
const ubyte chred = $20
const ubyte chrget = $73
const ubyte chrgot = $79
const uword chrin = $ffcf
const uword chrout = $ffd2
const ubyte chwhite = $10
const ubyte chyellow = $70
const uword cia1 = $dc00
const uword cia2 = $dd00
const uword cia_icr = $dd0d
const uword cia_rxcr = $dd0f
const uword cia_txcr = $dd0e
const uword cint = $ff81
const uword ciout = $ffa8
const uword clall = $ffe7
const ubyte class = $2d
const uword classlnk_ = 30
const uword classptr_ = 33
const ubyte clblue = $0e
const uword clc_rts = $02b5
const ubyte clgreen = $0d
const ubyte clgrey = $0f
const uword clipin_ = 21
const uword clipout_ = 24
const uword closcnps_ = 18
const uword close = $ffc3
const uword clrchn = $ffcc
const ubyte clred = $0a
const ubyte cmdchan = $0f
const ubyte cmdload = $00
const ubyte cmdsave = $01
const ubyte cmgrey = $0c
const ubyte cmp_16 = 1
const ubyte cmp_8 = 2
const ubyte cmp_date = 3
const ubyte cmp_nstr = 0
const ubyte cnp_pass = 2
const ubyte cnp_user = 0
const uword cnpctrl_ = $0018
const ubyte cnphost = 6
const uword cnplibpg = $0244
const ubyte cnppass = 9
const ubyte cnpport = 7
const uword cnpsack_ = 36
const uword cnpsclr_ = 27
const uword cnpsget_ = 33
const uword cnpsin_ = 30
const uword cnpsout_ = 21
const uword cnpsput_ = 24
const uword cnpsrvr_ = $0015
const ubyte cnpuser = 8
const ubyte codeptr = 6
const uword colbuf = $d800
const uword colhbuf = $0300
const uword colmbuf = $0302
const uword colmem = $d800
const uword confbaud_ = $000f
const uword confcmp_ = 0
const uword confcopy_ = $0006
const uword confgfx_ = 9
const uword config_ = $e012
const uword confirq_ = 3
const uword confsize_ = $e014
const uword copen_ = 27
const uword copybufs_ = 39
const ubyte corange = $08
const ubyte cp_csum = 3
const ubyte cp_data = 4
const ubyte cp_dsiz = 2
const ubyte cp_port = 1
const ubyte cp_type = 0
const ubyte cptr = $26
const ubyte cpurple = $04
const uword cpuusage = $0217
const ubyte crc = $22
const uword cread_ = 30
const ubyte cred = $02
const ubyte csc_clos = 2
const ubyte csc_data = 4
const ubyte csc_fail = 1
const ubyte csc_open = 0
const ubyte csc_tclr = 5
const ubyte csc_time = 3
const ubyte csf_clng = %00000010
const ubyte csf_open = %10000000
const ubyte csf_opng = %00000001
const ubyte csf_txng = %00000100
const ubyte csk_flgs = 4
const ubyte csk_name = 0
const ubyte csk_rbuf = 10
const ubyte csk_rsiz = 8
const ubyte csk_rsum = 9
const ubyte csk_size = 11
const ubyte csk_stat = 2
const ubyte csk_tbuf = 7
const ubyte csk_tsiz = 5
const ubyte csk_tsum = 6
const ubyte ct_3icon = 7
const ubyte ct_4bit = 6
const ubyte ct_aiff = 1
const ubyte ct_appl = 1
const ubyte ct_arts = 3
const ubyte ct_asctxt = 1
const ubyte ct_audio = 2
const ubyte ct_base64 = 2
const ubyte ct_cal = 11
const ubyte ct_date = 5
const ubyte ct_dattim = 6
const ubyte ct_email = 3
const ubyte ct_float = 1
const ubyte ct_fref = 7
const ubyte ct_gif = 5
const ubyte ct_gzip = 3
const ubyte ct_hdx = 0
const ubyte ct_hexdec = 8
const ubyte ct_hires = 1
const ubyte ct_html = 12
const ubyte ct_image = 3
const ubyte ct_jpeg = 4
const ubyte ct_koala = 2
const ubyte ct_midi = 6
const ubyte ct_mod = 4
const ubyte ct_mp3 = 5
const ubyte ct_mtext = 2
const ubyte ct_multc = 0
const ubyte ct_number = 9
const ubyte ct_pettxt = 0
const ubyte ct_raw = 0
const ubyte ct_sid = 3
const ubyte ct_snd = 7
const ubyte ct_tel = 10
const ubyte ct_text = 0
const ubyte ct_uuenc = 4
const ubyte ct_video = 4
const ubyte ct_wave = 2
const ubyte ct_weburl = 4
const ubyte ct_xml = 13
const ubyte ct_zip = 0
const ubyte ctrlkey = %00000100
const uword ctx2scr_ = 24
const uword ctxclear_ = 18
const uword ctxdraw_ = 21
const uword current = $0381
const ubyte currentdv = $ba
const ubyte currentlf = $b8
const ubyte currentsa = $b9
const ubyte cwhite = $01
const uword cwrite_ = 33
const ubyte cyellow = $07
const ubyte d_bwidth = $0004
const ubyte d_ccrsr = $003b
const ubyte d_color = $0011
const ubyte d_coloro = $0002
const ubyte d_crsr_h = $0001
const ubyte d_crsrmov = $0014
const uword d_ctx = $039c
const uword d_day = $03b5
const ubyte d_dcrsr = $0039
const uword d_dow = $03b2
const ubyte d_height = $0006
const ubyte d_ibh = $000f
const ubyte d_ibv = $0010
const ubyte d_lcol = $000d
const ubyte d_lrow = $000b
const uword d_month = $03b4
const ubyte d_oleft = $0009
const ubyte d_origin = $0000
const ubyte d_otop = $0007
const ubyte d_outbnd = $003d
const ubyte d_pet2scr = $0012
const ubyte d_petscr = $0040
const ubyte d_redraw = $0015
const ubyte d_revers = $0080
const ubyte d_reverse = $0013
const ubyte d_size = $000b
const ubyte d_width = $0005
const uword d_year = $03b3
const uword datadir = $dd03
const uword dataget_ = 12
const uword dataput_ = 15
const uword datareg = $dd01
const uword datetos_ = 3
const uword dayname_ = 24
const uword dayofyr_ = 9
const uword daysinm_ = 15
const uword dblclktm = $0288
const uword deactiv_ = 9
const uword defpg = $0383
const uword defpgcnt = $0384
const ubyte deptr = $0022
const uword deqkcmd_ = 21
const uword deqkprnt_ = 27
const uword deqmouse_ = 15
const uword detectiec = $3a00
const uword detectrec = $6400
const ubyte dev1541 = 41
const ubyte dev1571 = 71
const uword dev1581 = 81
const ubyte devcmdfd = $80+2
const ubyte devcmdhd = $80+3
const ubyte devcmdrd = $80+5
const ubyte devcmdrl = $80+4
const ubyte devfor = 1
const ubyte devide64 = $80+7
const ubyte devnot = 0
const ubyte devp1541 = $c0+11
const uword devroot_ = 15
const ubyte devsdiec = $80+6
const ubyte devultim = $c0+10
const ubyte devvice = 10
const ubyte df_afkey = %00001000
const ubyte df_afmus = %00010000
const ubyte df_dirty = %00000001
const ubyte df_first = %00100000
const ubyte df_ibnds = %01000000
const ubyte df_opaqu = %00000100
const ubyte df_sized = %00000010
const ubyte df_visib = %10000000
const uword div16_ = 3
const uword div3216_ = 18
const ubyte divcarry = $68
const uword divi = $bb12
const uword divi10 = $bafe
const ubyte dividnd = $63
const ubyte divisor = $61
const ubyte divrond = $67
const ubyte divrslt = $63
const ubyte divtemp = $67
const ubyte dosave = 24
const uword drawctx_ = $e00e
const uword drivemap = $0334
const ubyte dti_auth = $0004
const ubyte dti_date = $0006
const ubyte dti_fcnt = $000a
const ubyte dti_fdel = $000b
const ubyte dti_frmt = $0000
const ubyte dti_frsz = $000e
const ubyte dti_imsz = $0003
const ubyte dti_lcnt = $000c
const ubyte dti_mctl = $000d
const ubyte dti_mode = $0001
const ubyte dti_mxst = $0009
const ubyte dti_mxsz = $0008
const ubyte dti_pxsz = $0002
const ubyte dti_sorc = $0005
const ubyte dti_titl = $0007
const ubyte dti_vida = $0010
const ubyte dti_vidm = $000f
const uword emptystr = $02b7
const ubyte entrysize = 8
const ubyte err_scllo = 3
const ubyte err_sdalo = 2
const uword evtloop_ = 0
const uword evttime = $02ff
const ubyte excaddr = $0e
const uword exception = $03df
const ubyte excindex = $c7
const uword f_name = $0203
const uword f_prefix = $0200
const ubyte fac = $61
const uword facarg = $bc0c
const uword facint32 = $bc9b
const uword facmem = $bbd4
const uword facstr = $bddd
const ubyte fas_name = $00
const ubyte fas_stat = $11
const uword fasslots = $1c00
const uword fclose_ = 15
const ubyte fdbsiz = $0001
const ubyte fddate = $0018
const ubyte fdhour = $0019
const ubyte fdmin = $001a
const ubyte fdmnth = $0017
const ubyte fdname = $0003
const ubyte fdpetsz = $001b
const ubyte fds_boot = $0008
const ubyte fds_hide = $0002
const ubyte fds_lock = $0001
const ubyte fds_open = $0004
const ubyte fds_slct = $0080
const ubyte fdstatus = $0015
const ubyte fdtype = $0014
const ubyte fdyear = $0016
const uword ferror_ = 3
const ubyte ff_a = %00001000
const ubyte ff_o = %00010000
const ubyte ff_p = %01000000
const ubyte ff_q = %10000000
const ubyte ff_r = %00000001
const ubyte ff_s = %00000010
const ubyte ff_w = %00000100
const uword filecopy_ = $0009
const ubyte filesopen = $98
const ubyte fillchar = 4
const ubyte fillcolr = 5
const uword finit_ = 0
const uword firstdow_ = 6
const ubyte fj_dfref = $0006
const ubyte fj_sdir = $0005
const ubyte fj_sfref = $0004
const ubyte fj_type = $0000
const ubyte fj_vcb = $0007
const ubyte fnamelen = $b7
const ubyte fnameptr = $bb
const ubyte fo_dfref = $0006
const ubyte fo_id = $0000
const ubyte fo_rdir = $0005
const ubyte fo_sfref = $0004
const ubyte fo_valid = $0007
const uword fopen_ = 6
const uword fp_abs = $bc58
const uword fp_and = $afe9
const uword fp_atn = $e30e
const uword fp_chgsgn = $bfb4
const uword fp_cmp = $bc5b
const uword fp_cos = $e264
const uword fp_exp = $bfed
const uword fp_int = $bccc
const uword fp_log = $b9ea
const uword fp_not = $aed4
const uword fp_or = $afe6
const uword fp_rnd = $e097
const uword fp_round = $bc1b
const uword fp_sgn = $bc39
const uword fp_sin = $e26b
const uword fp_sqr = $bf71
const uword fp_tan = $e2b4
const uword frclip_ = 21
const uword fread_ = 9
const uword free_ = 9
const uword freedir_ = 3
const ubyte frefblks = 3
const uword frefcvt_ = 18
const ubyte frefdev = 0
const ubyte freflfn = 2
const ubyte frefname = 5
const ubyte frefpart = 1
const ubyte frefpath = 22
const ubyte frefptr = $00d1
const uword frefsize = 256
const uword frisodt_ = $0006
const uword frisotm_ = $000c
const ubyte fss_safe = $00
const uword fss_stat = $03b8
const ubyte fss_usaf = $01
const ubyte ft_del = $0005
const ubyte ft_dir = $0000
const ubyte ft_prg = $0001
const ubyte ft_rel = $0002
const ubyte ft_seq = $0003
const ubyte ft_usr = $0004
const uword fwrite_ = 12
const ubyte gbgcol = 5
const ubyte gbmapptr = 6
const ubyte gbmbufsz = 10
const ubyte gchbufsz = 8
const ubyte gcmbufsz = 9
const ubyte gcolhptr = 1
const ubyte gcolmptr = 3
const uword getargs_ = 6
const uword getcrc_ = 21
const uword getdirp_ = 0
const uword getext = 3
const uword getin = $ffe4
const uword getmethod_ = 51
const uword getprop16_ = 39
const uword getsfref_ = 21
const uword gettime_ = $000f
const uword gfxlibpg = $08ca
const uword gopath_ = 18
const ubyte gvidmode = 0
const ubyte headersize = 2
const uword height_ = $5b
const uword hidemouse_ = 6
const uword hight = yb
const uword himemuse = $03fe
const ubyte hmembitm = $0040
const ubyte hmembuff = $0002
const ubyte hmemfree = $0000
const ubyte hmemmult = $0080
const ubyte hmemutil = $0001
const uword homebase = $02e9
const ubyte hopen = 1
const ubyte hwidth = 0
const ubyte icn_3disk = $16
const ubyte icn_5disk = $15
const ubyte icn_ball = $2c
const ubyte icn_chat = $31
const ubyte icn_check = $0c
const ubyte icn_chk0 = $06
const ubyte icn_chk1 = $07
const ubyte icn_clock = $37
const ubyte icn_clogo = $00
const ubyte icn_close = $13
const ubyte icn_cloud = $39
const ubyte icn_crght = $01
const ubyte icn_cycle = $0d
const ubyte icn_dhash = $0a
const ubyte icn_dir = $25
const ubyte icn_dnarr = $03
const ubyte icn_ehart = $3f
const ubyte icn_eject = $29
const ubyte icn_elips = $0b
const ubyte icn_eth = $22
const ubyte icn_face = $32
const ubyte icn_ffwd = $43
const ubyte icn_flag = $2b
const ubyte icn_gear = $3b
const ubyte icn_hdisk = $17
const ubyte icn_heart = $35
const ubyte icn_hgrip = $11
const ubyte icn_home = $2a
const ubyte icn_joy = $1c
const ubyte icn_kbd = $1a
const ubyte icn_key = $2e
const ubyte icn_lfarr = $04
const ubyte icn_list = $3d
const ubyte icn_lock0 = $26
const ubyte icn_lock1 = $27
const ubyte icn_man = $30
const ubyte icn_mem = $20
const ubyte icn_mic = $2f
const ubyte icn_mus = $1b
const ubyte icn_music = $38
const ubyte icn_pad = $1d
const ubyte icn_pause = $41
const ubyte icn_pen = $1e
const ubyte icn_pin = $2d
const ubyte icn_play = $40
const ubyte icn_prg = $23
const ubyte icn_qmark = $34
const ubyte icn_rad0 = $08
const ubyte icn_rad1 = $09
const ubyte icn_rcket = $3a
const ubyte icn_rtarr = $05
const ubyte icn_rwnd = $44
const ubyte icn_sdcrd = $18
const ubyte icn_seq = $24
const ubyte icn_slide = $0f
const ubyte icn_stop = $42
const ubyte icn_tab = $33
const ubyte icn_table = $3c
const ubyte icn_tabsp = $10
const ubyte icn_tape = $19
const ubyte icn_text = $3e
const ubyte icn_title = $14
const ubyte icn_today = $36
const ubyte icn_track = $0e
const ubyte icn_trash = $28
const ubyte icn_uparr = $02
const ubyte icn_usb = $21
const ubyte icn_vgrip = $12
const ubyte icn_wifi = $1f
const uword idrvpg = $0801
const uword imgconf = $0006
const uword imginfo = $0003
const uword imgload = $0009
const ubyte inibaud = 1
const uword initcrc_ = 9
const uword r_initextern = $02fc
const uword initextern_ = 27
const uword initmouse_ = 0
const uword instanceof_ = 54
const uword int16fac = $b395
const uword int16min = $b1a6
const uword int8fac = $bc3c
const uword iobase = $fff3
const uword isdescof_ = 60
const uword isdigit_ = 21
const uword isleap_ = 18
const ubyte jbut_dn = %00000010
const ubyte jbut_f1 = %00010000
const ubyte jbut_f2 = %00100000
const ubyte jbut_lt = %00000100
const ubyte jbut_rt = %00001000
const ubyte jbut_se = %01000000
const ubyte jbut_st = %10000000
const ubyte jbut_up = %00000001
const ubyte jc_min = $00eb
const ubyte jcount = $00cd
const uword jdrvpg = $0802
const ubyte jiffyhi = $00a0
const ubyte jiffylo = $00a2
const ubyte jiffymi = $00a1
const ubyte jmpvec = $0055
const uword joinwifi_ = $0012
const uword jport1 = $0304
const uword jport2 = $0305
const uword jport3 = $0306
const uword jport4 = $0307
const uword kbuffer = $0277
const ubyte kbufptr = $c6
const uword kcbufidx = $0311
const uword kcbufkmd = $07fd
const uword kcbufpet = $07fa
const uword kdrvpg = $0805
const uword keymods = $028d
const uword killmouse_ = 3
const uword l_code = $0354
const uword l_dev = $0355
const uword l_msg = $0359
const uword l_sec = $037e
const uword l_stat = $0356
const uword l_trk = $037b
const ubyte lastsplt = $40
const ubyte laydirtx = $9f
const ubyte layeridx = $96
const uword layerpop_ = 9
const uword layerpush_ = 6
const ubyte lbutmask = %00010000
const ubyte lclick = 4
const ubyte ldclik = 5
const uword ldfavs = 6
const ubyte ldown = 1
const uword ldrcnts = 9
const ubyte lfil = $0100-(2*8)
const uword lfntab = $0259
const uword libchrhi = $08ac
const uword libchrlo = $08a2
const uword libinfo = $08b6
const uword liblocs = $08c0
const ubyte linp = $0100-(2*2)
const uword listen = $ffb1
const ubyte lmat = $0100-(2*4)
const ubyte lmem = $0100-(2*1)
const ubyte lmnu = $0100-(2*6)
const uword load = $ffd5
const uword loadapp_ = 36
const uword loadclr_ = 33
const ubyte loaddef = $01
const uword loadicns_ = 36
const uword loadlib_ = 42
const uword loadnhd_ = $000c
const ubyte loadop = $00
const ubyte loadrel = $00
const uword loadreloc_ = 39
const uword loadset_ = $0006
const uword loadtune_ = $0006
const uword loadutil_ = 30
const uword loopbrkvec = $0336
const ubyte lptr = $52
const ubyte lscr = $0100-(2*5)
const ubyte lser = $0100-(2*7)
const ubyte lshftkey = %00000001
const ubyte lstr = $0100-(2*3)
const ubyte ltim = $00ec
const ubyte ltkt = $0100-(2*9)
const ubyte ltrack = 2
const ubyte lup = 3
const ubyte magicadr = $00
const uword maketab_ = 6
const uword malloc_ = 12
const ubyte mapapp = $ff
const ubyte mapfree = $00
const uword mappgfst = $08a1
const ubyte mappglst = $09
const ubyte mapsys = $01
const ubyte maputil = $02
const uword markredraw_ = 3
const ubyte maxbaud = 2
const uword mbufidx = $0310
const ubyte mbutmask = %00000010
const ubyte mc_chrs = 13
const ubyte mc_col = 2
const ubyte mc_cpbd = 18
const ubyte mc_date = 19
const ubyte mc_devs = 14
const ubyte mc_dmod = 17
const ubyte mc_fopn = 3
const ubyte mc_fsav = 4
const ubyte mc_fsel = 20
const ubyte mc_hmem = 11
const ubyte mc_jobc = 16
const ubyte mc_kcmd = 7
const ubyte mc_kprt = 8
const ubyte mc_media = 23
const ubyte mc_memw = 15
const ubyte mc_menq = 1
const ubyte mc_mnu = 0
const ubyte mc_mous = 6
const ubyte mc_mptr = 9
const ubyte mc_ntwrk = 24
const ubyte mc_null = $ff
const ubyte mc_reua = 22
const ubyte mc_rflg = 10
const ubyte mc_splt = 21
const ubyte mc_stptr = 5
const ubyte mc_theme = 12
const ubyte mcl_bnce = $0002
const ubyte mcl_hwrp = $0003
const ubyte mcl_loop = $0001
const ubyte mcl_mtrx = $0005
const ubyte mcl_stat = $0000
const ubyte mcl_vwrp = $0004
const ubyte mclick = 12
const ubyte mcr_dact = $0080
const ubyte mcr_dbio = $0001
const ubyte mcr_dxrm = $0020
const ubyte mcr_fast = $0004
const ubyte mcr_flmd = $0010
const ubyte mcr_ncrd = $0002
const ubyte mcr_rtc = $0013
const ubyte mcr_trgr = $0040
const ubyte mdown = 10
const ubyte mdptr = $0024
const uword memarg = $ba8c
const uword membot = $ff9c
const uword memcpy_ = 0
const uword memdisp = $08cc
const uword memdivi = $bb0f
const uword memfac = $bba2
const uword memfree_ = 6
const uword memmap = $0800
const uword memminus = $b850
const uword memmult = $ba28
const uword memncpy_ = 3
const uword memplus = $b867
const uword mempool = $0380
const uword mempow = $bf78
const uword memset_ = 3
const ubyte memsize = $61
const uword memtop = $ff99
const uword memutil = $08de
const uword metapage = $ff3f
const ubyte mf_bdchk = %01000000
const ubyte mf_resiz = %00000010
const ubyte mhfree = 0
const ubyte mhlen = 1
const ubyte mhsize = 3
const uword minus = $b853
const ubyte mm_load = $0002
const ubyte mm_start = $0001
const ubyte mm_stop = $0000
const uword mmc_ctl = $df11
const uword mmc_idy = $df13
const uword mmc_spi = $df10
const uword mmc_sta = $df12
const ubyte mmi_card = $0064
const ubyte mmi_ena1 = $000a
const ubyte mmi_ena2 = $001c
const ubyte mmi_reva = $0001
const ubyte mmi_revb = $0002
const ubyte mmi_unl1 = $0055
const ubyte mmi_unl2 = $00aa
const uword mnthname_ = 21
const ubyte mnu_dis = %00000001
const ubyte mnu_sel = %00000010
const uword mnudraw_ = 0
const ubyte mnuicon = $f2
const uword mnukcmd_ = 6
const ubyte mnulayer = 3
const uword mnumouse_ = 3
const ubyte modkeys = 3
const uword mouseacc = $0290
const ubyte mousehid = %00010000
const ubyte mouselft = %10000000
const ubyte mousemvd = %00000100
const ubyte mousenat = %01000000
const ubyte mouseon = %00000001
const ubyte mousepre = %00100000
const uword mouseptr = $028f
const uword mouserc_ = 9
const uword mousesiz = $08cb
const ubyte mousetrk = %00000010
const uword mouskeys_ = 0
const ubyte move = 0
const uword msgapp_ = $0009
const uword msgutil_ = $000c
const ubyte msr_busy = $0001
const ubyte msr_ncrd = $0008
const ubyte msr_wrtp = $0010
const uword mul16_ = 0
const uword mult = $ba2b
const uword mult10 = $bae2
const ubyte multcnd = $63
const ubyte multplr = $61
const ubyte mup = 11
const uword mus0col = $02fa
const uword mus1col = $02fb
const ubyte mus_cbm = %00100000
const ubyte mus_ctrl = %01000000
const ubyte mus_shft = %00010000
const ubyte musbtns = $f2
const uword musbuff = $07f4
const uword musbufx = $07e8
const uword musbufy = $07ee
const uword musflgs = $03fd
const ubyte musxpos = $41
const ubyte musypos = $43
const uword ndrvpg = $0804
const uword neg1_2 = $b9e0
const uword netstat = $0245
const ubyte nettimer = $02
const ubyte nextptr = 0
const ubyte nhddrvr = 3
const uword nhdpause_ = 27
const ubyte nhdpgsz = 0
const uword nhdresum_ = 30
const uword nmictrl = $02a1
const ubyte ns_cpcf = %00010000
const ubyte ns_cpup = %00100000
const ubyte ns_nhcf = %00000001
const ubyte ns_nhsp = %00000010
const ubyte ns_onlin = %00111111
const ubyte ns_trcf = %00000100
const ubyte ns_trup = %00001000
const ubyte oj_type = 0
const ubyte oj_vcb = 4
const uword opaqancs_ = 63
const uword open = $ffc0
const uword opencnps_ = 15
const uword opensock_ = 24
const uword opnappmcmd = $03fa
const uword opnappmdhi = $03fc
const uword opnappmdlo = $03fb
const uword opnfileref = $033a
const uword opnfrefreu = $2000
const uword opnutilmcmd = $03fa
const uword opnutilmdhi = $03fc
const uword opnutilmdlo = $03fb
const uword palflag = $02a6
const uword partroot_ = 12
const uword pathadd_ = 6
const uword pathup_ = 9
const uword pet2asc_ = 9
const uword pet2scr_ = 12
const ubyte petvalue = 1
const ubyte pfc_ct1 = $0000
const ubyte pfc_ct2 = $0001
const ubyte pfc_date = $0005
const ubyte pfc_dow = $0006
const ubyte pfc_hour = $0004
const ubyte pfc_mins = $0003
const ubyte pfc_mnth = $0007
const ubyte pfc_read = $0080
const ubyte pfc_secs = $0002
const ubyte pfc_suba = $0010
const ubyte pfc_year = $0008
const uword pgalloc_ = 21
const uword pgfetch_ = 27
const uword pgfree_ = 15
const uword pgmark_ = 18
const uword pgstash_ = 30
const uword pi = $aea8
const uword pi1_2 = $e2e0
const uword pi2_1 = $e2e5
const ubyte pi_auth = 21
const uword pi_bakcol = 2056
const uword pi_brdcol = 2055
const uword pi_chrset = 2057
const uword pi_colmem = 1055
const ubyte pi_copyr = 38
const ubyte pi_magic = 0
const ubyte pi_scrmem = 55
const ubyte pi_title = 4
const ubyte pi_ver = 3
const uword plot = $fff0
const uword plus = $b86a
const ubyte pnode = $2f
const uword polldevices_ = 30
const uword pollget_ = 9
const uword pos1 = $b9bc
const uword pos10 = $baf9
const uword pos1_4 = $e2ea
const uword pos1_log2 = $bfbf
const uword pos1_sqr2 = $b9d6
const uword poslog2 = $b9e5
const uword possqr2 = $b9db
const uword power = $bf7b
const uword prep_rw_ = $0006
const ubyte prepload = $000e
const uword presort_ = $0000
const uword printstr = $ab1e
const uword procgfx_ = 6
const ubyte product = $65
const ubyte pt_41 = $0007
const ubyte pt_71 = $0008
const ubyte pt_81 = $0009
const ubyte pt_ack = 'a'
const ubyte pt_alive = '-'
const ubyte pt_cfs = $000b
const ubyte pt_close = 'c'
const ubyte pt_cpm = $000a
const ubyte pt_data = 'd'
const ubyte pt_nak = 'n'
const ubyte pt_nat = $0006
const ubyte pt_open = 'o'
const ubyte pt_serv = 's'
const ubyte pt_sys = $000c
const ubyte pt_time = 't'
const uword ptrthis_ = 42
const uword pullctx_ = 3
const ubyte purebyte = $ff
const uword pushctx_ = 0
const uword quitapp_ = 33
const uword ramtas = $ff87
const uword raw_rts = $02b2
const ubyte rbuf_cnt = $b4
const ubyte rbutmask = %00000001
const ubyte rc_ctr = %10010000
const ubyte rc_rtc = %10010001
const ubyte rc_swap = %10010010
const ubyte rc_tctr = %10000000
const ubyte rc_trtc = %10000001
const ubyte rc_tswap = %10000010
const ubyte rclick = 9
const ubyte rclock = $0040
const ubyte rcpubusy = $0020
const uword rdfav = 12
const ubyte rdown = 6
const uword rdrcnt = 15
const uword rdtim = $ffde
const ubyte readbit = 1
const uword readdir_ = 6
const uword readkcmd_ = 18
const uword readkprnt_ = 24
const uword readmouse_ = 12
const uword readreg_ = $0009
const uword readregs = $03c3
const uword readset_ = $0009
const uword readst = $ffb7
const uword readutils = $2100
const uword realloc_ = 3
const uword rec = $df00
const ubyte rec_ac = $0a
const ubyte rec_chi = $03
const ubyte rec_clo = $02
const ubyte rec_cmd = $01
const ubyte rec_imsk = $09
const ubyte rec_lhi = $08
const ubyte rec_llo = $07
const ubyte rec_rhi = $06
const ubyte rec_rlo = $04
const ubyte rec_rmi = $05
const ubyte rec_stat = $00
const uword recontext_ = 9
const uword recshunt = $022a
const uword redirect = $08f4
const uword redirectvec = $08f9
const uword redraw_ = 27
const uword redrawflgs = $03ff
const uword redrwtod_ = 15
const ubyte regstore = $c8
const ubyte reindex = 3
const ubyte remandr = $65
const ubyte renagfx = $0002
const uword renamef_ = $000f
const uword reset_ = $0003
const uword restor = $ff8a
const ubyte ret_nok = 1
const ubyte ret_ok = 0
const ubyte reu_inc = $01
const uword reubank = $0284
const uword reubanks = $0281
const uword reuconf_ = 24
const uword reufrzbk = $0286
const uword reupage = $0283
const ubyte rgraphix = $0004
const ubyte ribuf = $f7
const uword ridbe = $029b
const uword ridbs = $029c
const ubyte rm_ankb = %00000010
const ubyte rm_ankl = %00000100
const ubyte rm_ankr = %00001000
const ubyte rm_ankt = %00000001
const ubyte rm_rschd = %10000000
const ubyte rmenubar = $0080
const ubyte rmodal = $0008
const ubyte rnewgfx = $0001
const ubyte robuf = $f9
const uword rodbe = $029d
const uword rodbs = $029e
const uword rootpg = $0382
const uword rootview = $03ba
const ubyte rs232cts = $40
const ubyte rs232dcd = $10
const ubyte rs232dsr = $80
const uword rs232in = $dd01
const uword rs232out = $dd00
const ubyte rs232ri = $08
const ubyte rs232rtr = $02
const ubyte rs232rx = $01
const uword rs232sig = $dd01
const ubyte rs232tx = $04
const ubyte rsbyte = $9e
const ubyte rsh_bank = $05
const ubyte rsh_cadr = $01
const ubyte rsh_cmd = $00
const ubyte rsh_radr = $03
const ubyte rsh_size = $06
const ubyte rshftkey = %00001000
const ubyte rstatbar = $0010
const uword rtcdrvrreu = $2100
const ubyte rtrack = 7
const ubyte rup = 8
const ubyte rvs_mask = %10000000
const ubyte rxbitcnt = $bd
const ubyte rxbyte = $ab
const uword rxtmrhi = $dd07
const uword rxtmrlo = $dd06
const uword save = $ffd8
const uword scanmovs_ = $0000
const uword scnjbtns_ = $0003
const uword scnkbtns_ = 3
const uword scnkey = $ff9f
const uword scnpbtns_ = $0003
const uword scratchf_ = $0012
const uword scrbuf = $0400
const uword screen = $ffed
const ubyte screen_cols = 40
const ubyte screen_rows = 25
const uword scrlayer_ = $e00c
const uword scrlwhls = $0287
const uword scrmem = $dc00
const uword scrrow_ = 30
const uword sec_rts = $02b3
const uword second = $ff93
const uword seebas_ = 15
const uword seeioker = $02ac
const uword seeram = $02a7
const uword sessbgn_ = 9
const uword sessend_ = 12
const uword setclass_ = 45
const uword setctx_ = 6
const uword setdprops_ = 15
const uword setflags_ = 12
const uword setgfx_ = 18
const uword sethand_ = 6
const uword setlfs = $ffba
const uword setlrc_ = 12
const uword setmsg = $ff90
const uword setnam = $ffbd
const uword setname_ = 3
const uword setrate_ = 18
const uword setsuper_ = 48
const uword settim = $ffdb
const uword settime_ = 6
const uword settkenv_ = 15
const uword settmo = $ffa2
const uword sfil = sstr-$0546
const uword sid = $d400
const ubyte sinitreu = $000a
const uword sinp = sser-$0350
const ubyte sj_nlen = 7
const ubyte sj_ovr = 6
const ubyte sj_type = 0
const ubyte sj_vcb = 4
const ubyte sldraw = 0
const ubyte slindx = 8
const ubyte slkcmd = 4
const ubyte slkprt = 6
const ubyte slmous = 2
const ubyte slnoinit = $0080
const ubyte slsize = 9
const uword sltb = $d000-(2*10)
const ubyte slunload = $0080
const ubyte slvwait = 50
const uword smat = sinp-$0175
const uword smem = stim-$028a
const uword smnu = sscr-$08aa
const uword sort_ = $0003
const ubyte spi_auth = $01
const ubyte spi_copy = $02
const ubyte spi_name = $00
const uword spirqvec = $0334
const ubyte split = $3f
const uword spotcopy_ = $000c
const ubyte sps_halt = $fe
const ubyte sps_hold = $ff
const ubyte sps_play = $fd
const ubyte srestore = $000c
const uword sscr = sfil-$06ae
const uword sser = sltb-$0716
const uword ssidstat_ = 21
const uword sstr = smem-$014d
const uword stack = $0100
const ubyte stat_app = 1
const ubyte stat_drv = 0
const ubyte stat_fil = 2
const uword statmode = $08ef
const uword stattune_ = $0009
const ubyte status = $90
const uword stim = smat-$021b
const uword stkt = smnu-$0557
const uword stop = $ffe1
const ubyte stralt = $63
const uword strdel_ = 24
const uword strfac = $bcf3
const uword strins_ = 27
const uword strlen_ = 0
const ubyte strptr = $61
const uword sw = $de00
const uword sw_cmd = sw+$02
const uword sw_ctrl = sw+$03
const uword sw_data = sw+$00
const uword sw_stat = sw+$01
const ubyte swb14400 = $0d
const ubyte swb19200 = $0e
const ubyte swb38400 = $0f
const ubyte swb_100 = $01
const ubyte swb_1200 = $07
const ubyte swb_150 = $02
const ubyte swb_220 = $03
const ubyte swb_2400 = $08
const ubyte swb_270 = $04
const ubyte swb_300 = $05
const ubyte swb_3600 = $09
const ubyte swb_4800 = $0a
const ubyte swb_600 = $06
const ubyte swb_7200 = $0b
const ubyte swb_9600 = $0c
const ubyte swc_dtr = %00000001
const ubyte swc_ech = %00010000
const ubyte swc_irq = %00000010
const ubyte swc_par = %00100000
const ubyte swc_tc0 = %00000100
const ubyte swc_tc1 = %00001000
const ubyte swibuf = $f7
const uword swidbe = $029b
const uword swidbs = $029c
const ubyte swn_rx = $bd
const ubyte swn_rxtx = $b6
const ubyte swobuf = $f9
const uword swodbe = $029d
const uword swodbs = $029e
const ubyte swp_evn = %01000000
const ubyte swp_mrk = %10000000
const ubyte swp_odd = %00000000
const ubyte swp_spc = %11000000
const ubyte sws_dcd = %00100000
const ubyte sws_dsr = %01000000
const ubyte sws_fer = %00000010
const ubyte sws_irq = %10000000
const ubyte sws_oer = %00000100
const ubyte sws_per = %00000001
const ubyte sws_rrd = %00001000
const ubyte sws_trd = %00010000
const ubyte swt_tbrk = %00001100
const ubyte swt_tmrh = %00000000
const ubyte swt_tmrl = %00001000
const ubyte swt_torl = %00000100
const ubyte swx_brc = %00010000
const ubyte swx_stp = %10000000
const ubyte swx_w5b = %01100000
const ubyte swx_w6b = %01000000
const ubyte swx_w7b = %00100000
const ubyte swx_w8b = %00000000
const uword sysfref = $02c0
const ubyte sysjmp = $0054
const uword syskcmd_ = 24
const uword syskmods = $02bc
const uword syskvals = $02b8
const uword t_blinks = $03b7
const uword t_hour = $dc0b
const uword t_mins = $dc0a
const uword t_secs = $dc09
const uword t_twelve = $03b6
const uword talk = $ffb4
const ubyte tbuf_cnt = $ab
const ubyte tcancel = $0020
const uword tcc_btn = $d0fb
const uword tcc_crt = $d0f0
const uword tcc_dis = $d0fd
const uword tcc_dsk = $d0f7
const uword tcc_dwr = $d0f6
const uword tcc_ena = $d0fe
const uword tcc_fd0 = $d0f8
const uword tcc_fd1 = $d0f9
const uword tcc_gio = $d0fc
const uword tcc_reg = $d0fa
const uword tcc_reu = $d0f5
const uword tcc_sid = $d0f4
const uword tcc_spi = $d0f1
const uword tcc_tur = $d0f3
const uword tcc_vic = $d0f2
const ubyte tcp_host = $0000
const ubyte tcp_port = $0002
const ubyte td_did = $0011
const ubyte td_fc = $0021
const ubyte td_filt = $003e
const ubyte td_flags = $003d
const ubyte td_free = $0013
const ubyte td_head = $0000
const ubyte td_part = $001b
const ubyte td_patt = $0028
const ubyte td_pfc = $0023
const ubyte td_pfree = $0015
const ubyte td_ppart = $001d
const ubyte td_sel = $003c
const ubyte td_sortf = $003a
const ubyte td_sorto = $003b
const ubyte td_type = $0039
const ubyte te_cmusv = 11
const ubyte te_dctx = 0
const ubyte te_fkeyv = 7
const ubyte te_flags = 3
const ubyte te_fmusv = 9
const ubyte te_layer = 4
const ubyte te_mpool = 2
const ubyte te_posx = 13
const ubyte te_posy = 14
const ubyte te_rview = 5
const ubyte templfn = $7f
const ubyte tena_cnf = $002a
const ubyte tena_dis = $00ff
const ubyte tena_mnu = $0020
const ubyte tena_rst = $00a5
const ubyte texprd = $0008
const ubyte tf_blur = %10000000
const ubyte tf_dirty = %00000001
const ubyte tf_keyh = %01000000
const ubyte this = $2b
const uword timedwn_ = $0003
const uword timeevt_ = $0006
const uword timeque_ = $0000
const ubyte timeridx = $0009
const ubyte timerprs = $10
const uword timutil = $08cd
const ubyte tintrvl = $0040
const ubyte titleptr = 4
const uword tkcolors = $0387
const uword tkenv_ = $e010
const ubyte tkenvptr = $ef
const uword tkkcmd_ = 24
const uword tkkprnt_ = 27
const uword tkmouse_ = 21
const uword tknew_ = 36
const uword tksa = $ff96
const uword tkupdate_ = 18
const uword toglock_ = $0003
const uword tohex_ = 12
const uword toint_ = 9
const uword toisodt_ = $0003
const uword toisotm_ = $0009
const uword tolower_ = 15
const uword tostr_ = 6
const uword toupper_ = 18
const ubyte tpause = $0080
const ubyte tprecis = $0004
const ubyte tptr = $50
const ubyte trealtm = $0002
const ubyte treset = $0010
const ubyte treu_g128 = $0048
const ubyte treu_g1m = $0060
const ubyte treu_g256 = $0050
const ubyte treu_g2m = $0068
const ubyte treu_g4m = $0070
const ubyte treu_g512 = $0058
const ubyte treu_g64 = $0040
const ubyte treu_r128 = $0080
const ubyte treu_r16 = $0087
const ubyte treu_r1m = $0083
const ubyte treu_r256 = $0081
const ubyte treu_r2m = $0084
const ubyte treu_r4m = $0085
const ubyte treu_r512 = $0082
const ubyte treu_r8m = $0086
const uword try_ = $03ca
const ubyte ts_a2p = $0040
const ubyte ts_apps = $0001
const ubyte ts_case = $0080
const ubyte ts_date = $0004
const ubyte ts_des = $0001
const ubyte ts_dirs = $0004
const ubyte ts_disk = $0000
const ubyte ts_filt = $0020
const ubyte ts_name = $0001
const ubyte ts_pdir = $0008
const ubyte ts_size = $0002
const ubyte ts_time = $0010
const ubyte ts_type = $0003
const ubyte ts_utils = $0002
const ubyte tspi_cde = $0010
const ubyte tspi_cdf = $0020
const ubyte tspi_mce = $0001
const ubyte tspi_mcr = $0003
const ubyte tspi_mda = $0004
const ubyte tspi_nmi = $0040
const ubyte tspi_rom = $0008
const ubyte tstat = $0003
const ubyte ttime = $0000
const ubyte ttrig = $0004
const uword tuneinfo_ = $000c
const ubyte tvalu = $0006
const ubyte txbitcnt = $b4
const ubyte txbyte = $b6
const ubyte txnxtbit = $b5
const uword txtmrhi = $dd05
const uword txtmrlo = $dd04
const ubyte txtptr = $7a
const uword ua_ch1 = $df20
const uword ua_ch2 = $df40
const uword ua_ch3 = $df60
const uword ua_ch4 = $df80
const uword ua_ch5 = $dfa0
const uword ua_ch6 = $dfc0
const uword ua_ch7 = $dfe0
const ubyte ua_ctrl = $00
const ubyte ua_iclr = $1f
const ubyte ua_lhi = $08
const ubyte ua_llo = $0a
const ubyte ua_lmi = $09
const ubyte ua_pan = $02
const ubyte ua_rahi = $11
const ubyte ua_ralo = $13
const ubyte ua_rami = $12
const ubyte ua_rbhi = $15
const ubyte ua_rblo = $17
const ubyte ua_rbmi = $16
const ubyte ua_rhi = $0e
const ubyte ua_rlo = $0f
const ubyte ua_shi = $04
const ubyte ua_slo = $07
const ubyte ua_smh = $05
const ubyte ua_sml = $06
const ubyte ua_vol = $01
const uword uci = $df00
const ubyte uci_abrt = %00000100
const ubyte uci_busy = %00010000
const ubyte uci_cbsy = %00000001
const ubyte uci_cerr = %00001000
const ubyte uci_cmd = $1d
const ubyte uci_ctrl = $1c
const ubyte uci_dacc = %00000010
const ubyte uci_dlst = %00100000
const ubyte uci_dmor = %00110000
const ubyte uci_dtav = %10000000
const ubyte uci_eror = %00001000
const ubyte uci_id = $1d
const ubyte uci_idle = %00000000
const ubyte uci_pcmd = %00000001
const ubyte uci_resp = $1e
const ubyte uci_sdat = $1f
const ubyte uci_smsk = %00110000
const ubyte uci_stat = $1c
const ubyte uci_stav = %01000000
const uword udtim = $ffea
const uword uf_chkb = $ff30
const ubyte uf_clrbuf = %00000010
const ubyte uf_cnfglb = %00000100
const uword uf_draw = $ff2a
const uword uf_init = $ff21
const uword uf_kcmd = $ff36
const uword uf_kill = $ff1b
const uword uf_kprt = $ff39
const uword uf_link = $ff3c
const uword uf_load = $ff1e
const uword uf_mapc = $ff27
const uword uf_msrc = $ff2d
const uword uf_pmus = $ff33
const uword uf_quit = $ff24
const ubyte uf_settit = %00000001
const ubyte uf_swpicn = %00001000
const ubyte uf_umodal = %10000000
const uword uint8fac = $b3a2
const uword umdefpg = $0385
const uword umdefpgc = $0386
const uword unldlib_ = 45
const uword unlsn = $ffae
const uword untlk = $ffab
const uword updc16_ = 15
const uword updc32_ = 18
const uword updc8_ = 12
const uword updstat_ = 9
const uword utilbase = $e000
const ubyte utilfrze = 6
const ubyte utilidnt = 10
const ubyte utilinit = 0
const ubyte utilmcmd = 2
const ubyte utilquit = 4
const ubyte utilthaw = 8
const uword utiltimr = $0221
const ubyte vat_bgnd = $0010
const ubyte vat_fli4 = $0002
const ubyte vat_fli8 = $0001
const ubyte vat_lace = $0004
const ubyte vat_xshf = $0008
const ubyte vdm_ebchr = $0002
const ubyte vdm_hrbmp = $0003
const ubyte vdm_mcbmp = $0004
const ubyte vdm_mcchr = $0001
const ubyte vdm_stchr = $0000
const uword vector = $ff8d
const ubyte verifyop = $01
const uword vic = $d000
const uword viewwtag_ = 66
const uword walk_ = 57
const ubyte wdnmask = %00001000
const ubyte wdown = 13
const uword weeknum_ = 12
const uword width = xb
const uword width_ = $59
const ubyte wifi_pass = $0002
const ubyte wifi_ssid = $0000
const ubyte wifinam = 4
const ubyte wifipas = 5
const ubyte workbank = $00
const ubyte writebit = 0
const uword writreg_ = $000c
const ubyte wup = 14
const ubyte wupmask = %00000100
const ubyte xa = 0
const ubyte xb = 2
const ubyte ya = 1
const ubyte yb = 3
const ubyte ystash = $97
const uword zero = $ecb9
}
os {
; function for registering callbacks
; fills jump vector slots at the start of app memory
sub register(ubyte slot, uword function) {
    hdr.appbase[slot] = lsb(function)
    hdr.appbase[slot+1] = msb(function)
}
inline asmsub initextern() clobbers(A,X,Y) {
    %asm {{
        ldx #<p8b_os.p8l_l_externs
        ldy #>p8b_os.p8l_l_externs
        jsr $02fc
    }}
}
l_externs:
; special case as it is used by the syslib init_system code.
l_pgmark:
    %asm {{
        .byte p8b_hdr.p8c_lmem
        .word p8b_hdr.p8c_pgmark_
    }}
asmsub alert() {
    %asm {{
        .byte p8b_hdr.p8c_lser
        .word p8b_hdr.p8c_alert_
        ; rts
        ; !notreached!
    }}
}
asmsub appendto(uword arg0 @XY) {
    %asm {{
        .byte p8b_hdr.p8c_ltkt
        .word p8b_hdr.p8c_appendto_
        ; rts
        ; !notreached!
    }}
}
asmsub asc2pet(ubyte arg0 @A) -> ubyte @A {
    %asm {{
        .byte p8b_hdr.p8c_lstr
        .word p8b_hdr.p8c_asc2pet_
        ; rts
        ; !notreached!
    }}
}
asmsub bkalloc(ubyte arg0 @X) -> ubyte @Y, bool @Pc {
    %asm {{
        .byte p8b_hdr.p8c_lmem
        .word p8b_hdr.p8c_bkalloc_
        ; rts
        ; !notreached!
    }}
}
asmsub bkfree(ubyte arg0 @X, ubyte arg1 @Y) -> bool @Pc {
    %asm {{
        .byte p8b_hdr.p8c_lmem
        .word p8b_hdr.p8c_bkfree_
        ; rts
        ; !notreached!
    }}
}
asmsub boundschk() -> bool @Pc {
    %asm {{
        .byte p8b_hdr.p8c_ltkt
        .word p8b_hdr.p8c_boundschk_
        ; rts
        ; !notreached!
    }}
}
asmsub cclose(ubyte arg0 @X, ubyte arg1 @Y) {
    %asm {{
        .byte p8b_hdr.p8c_lfil
        .word p8b_hdr.p8c_cclose_
        ; rts
        ; !notreached!
    }}
}
asmsub classlnk(uword arg0 @XY) {
    %asm {{
        .byte p8b_hdr.p8c_ltkt
        .word p8b_hdr.p8c_classlnk_
        ; rts
        ; !notreached!
    }}
}
asmsub classptr(ubyte arg0 @X) -> uword @XY {
    %asm {{
        .byte p8b_hdr.p8c_ltkt
        .word p8b_hdr.p8c_classptr_
        ; rts
        ; !notreached!
    }}
}
asmsub clipin(ubyte arg0 @A, uword arg1 @XY) {
    %asm {{
        .byte p8b_hdr.p8c_lfil
        .word p8b_hdr.p8c_clipin_
        ; rts
        ; !notreached!
    }}
}
asmsub clipout(ubyte arg0 @A, uword arg1 @XY) {
    %asm {{
        .byte p8b_hdr.p8c_lfil
        .word p8b_hdr.p8c_clipout_
        ; rts
        ; !notreached!
    }}
}
asmsub confirq() {
    %asm {{
        .byte p8b_hdr.p8c_lser
        .word p8b_hdr.p8c_confirq_
        ; rts
        ; !notreached!
    }}
}
asmsub copen(ubyte arg0 @A) -> uword @XY {
    %asm {{
        .byte p8b_hdr.p8c_lfil
        .word p8b_hdr.p8c_copen_
        ; rts
        ; !notreached!
    }}
}
asmsub copybufs() {
    %asm {{
        .byte p8b_hdr.p8c_lscr
        .word p8b_hdr.p8c_copybufs_
        ; rts
        ; !notreached!
    }}
}
asmsub cread(ubyte arg0 @A, uword arg1 @XY) {
    %asm {{
        .byte p8b_hdr.p8c_lfil
        .word p8b_hdr.p8c_cread_
        ; rts
        ; !notreached!
    }}
}
asmsub ctx2scr(ubyte arg0 @X, ubyte arg1 @Y) {
    %asm {{
        .byte p8b_hdr.p8c_lscr
        .word p8b_hdr.p8c_ctx2scr_
        ; rts
        ; !notreached!
    }}
}
asmsub ctxclear(ubyte arg0 @A) {
    %asm {{
        .byte p8b_hdr.p8c_lscr
        .word p8b_hdr.p8c_ctxclear_
        ; rts
        ; !notreached!
    }}
}
asmsub ctxdraw(ubyte arg0 @A) -> bool @Pc {
    %asm {{
        .byte p8b_hdr.p8c_lscr
        .word p8b_hdr.p8c_ctxdraw_
        ; rts
        ; !notreached!
    }}
}
asmsub cwrite(ubyte arg0 @A, uword arg1 @XY) {
    %asm {{
        .byte p8b_hdr.p8c_lfil
        .word p8b_hdr.p8c_cwrite_
        ; rts
        ; !notreached!
    }}
}
asmsub deactiv() {
    %asm {{
        .byte p8b_hdr.p8c_lmnu
        .word p8b_hdr.p8c_deactiv_
        ; rts
        ; !notreached!
    }}
}
asmsub deqkcmd() {
    %asm {{
        .byte p8b_hdr.p8c_linp
        .word p8b_hdr.p8c_deqkcmd_
        ; rts
        ; !notreached!
    }}
}
asmsub deqkprnt() {
    %asm {{
        .byte p8b_hdr.p8c_linp
        .word p8b_hdr.p8c_deqkprnt_
        ; rts
        ; !notreached!
    }}
}
asmsub deqmouse(bool arg0 @Pc) {
    %asm {{
        .byte p8b_hdr.p8c_linp
        .word p8b_hdr.p8c_deqmouse_
        ; rts
        ; !notreached!
    }}
}
asmsub div16(bool arg0 @Pc) {
    %asm {{
        .byte p8b_hdr.p8c_lmat
        .word p8b_hdr.p8c_div16_
        ; rts
        ; !notreached!
    }}
}
asmsub div3216() {
    %asm {{
        .byte p8b_hdr.p8c_lmat
        .word p8b_hdr.p8c_div3216_
        ; rts
        ; !notreached!
    }}
}
asmsub evtloop() {
    %asm {{
        .byte p8b_hdr.p8c_lscr
        .word p8b_hdr.p8c_evtloop_
        ; rts
        ; !notreached!
    }}
}
asmsub fclose(uword arg0 @XY) {
    %asm {{
        .byte p8b_hdr.p8c_lfil
        .word p8b_hdr.p8c_fclose_
        ; rts
        ; !notreached!
    }}
}
asmsub ferror() -> ubyte @A {
    %asm {{
        .byte p8b_hdr.p8c_lfil
        .word p8b_hdr.p8c_ferror_
        ; rts
        ; !notreached!
    }}
}
asmsub finit(uword arg0 @XY) -> ubyte @A, ubyte @X, bool @Pc {
    %asm {{
        .byte p8b_hdr.p8c_lfil
        .word p8b_hdr.p8c_finit_
        ; rts
        ; !notreached!
    }}
}
asmsub fopen(ubyte arg0 @A, uword arg1 @XY) -> ubyte @A, uword @XY, bool @Pc {
    %asm {{
        .byte p8b_hdr.p8c_lfil
        .word p8b_hdr.p8c_fopen_
        ; rts
        ; !notreached!
    }}
}
asmsub fread(uword arg0 @XY) -> uword @XY {
    %asm {{
        .byte p8b_hdr.p8c_lfil
        .word p8b_hdr.p8c_fread_
        ; rts
        ; !notreached!
    }}
}
asmsub free(uword arg0 @XY) {
    %asm {{
        .byte p8b_hdr.p8c_lmem
        .word p8b_hdr.p8c_free_
        ; rts
        ; !notreached!
    }}
}
asmsub frefcvt(uword arg0 @XY) -> uword @XY {
    %asm {{
        .byte p8b_hdr.p8c_lfil
        .word p8b_hdr.p8c_frefcvt_
        ; rts
        ; !notreached!
    }}
}
asmsub fwrite(uword arg0 @XY) -> uword @XY {
    %asm {{
        .byte p8b_hdr.p8c_lfil
        .word p8b_hdr.p8c_fwrite_
        ; rts
        ; !notreached!
    }}
}
asmsub getargs(ubyte arg0 @A) {
    %asm {{
        .byte p8b_hdr.p8c_lser
        .word p8b_hdr.p8c_getargs_
        ; rts
        ; !notreached!
    }}
}
asmsub getmethod(ubyte arg0 @Y) -> uword @XY {
    %asm {{
        .byte p8b_hdr.p8c_ltkt
        .word p8b_hdr.p8c_getmethod_
        ; rts
        ; !notreached!
    }}
}
asmsub getprop16(ubyte arg0 @Y) -> uword @XY {
    %asm {{
        .byte p8b_hdr.p8c_ltkt
        .word p8b_hdr.p8c_getprop16_
        ; rts
        ; !notreached!
    }}
}
asmsub getsfref(ubyte arg0 @Y) -> ubyte @X, ubyte @Y {
    %asm {{
        .byte p8b_hdr.p8c_lser
        .word p8b_hdr.p8c_getsfref_
        ; rts
        ; !notreached!
    }}
}
asmsub hidemouse() {
    %asm {{
        .byte p8b_hdr.p8c_linp
        .word p8b_hdr.p8c_hidemouse_
        ; rts
        ; !notreached!
    }}
}
asmsub initmouse(bool arg0 @Pc) {
    %asm {{
        .byte p8b_hdr.p8c_linp
        .word p8b_hdr.p8c_initmouse_
        ; rts
        ; !notreached!
    }}
}
asmsub instanceof(uword arg0 @XY) -> bool @Pc {
    %asm {{
        .byte p8b_hdr.p8c_ltkt
        .word p8b_hdr.p8c_instanceof_
        ; rts
        ; !notreached!
    }}
}
asmsub isdescof(uword arg0 @XY) -> ubyte @A, bool @Pz {
    %asm {{
        .byte p8b_hdr.p8c_ltkt
        .word p8b_hdr.p8c_isdescof_
        ; rts
        ; !notreached!
    }}
}
asmsub isdigit(ubyte arg0 @A) -> bool @Pc {
    %asm {{
        .byte p8b_hdr.p8c_lstr
        .word p8b_hdr.p8c_isdigit_
        ; rts
        ; !notreached!
    }}
}
asmsub killmouse() -> bool @Pc {
    %asm {{
        .byte p8b_hdr.p8c_linp
        .word p8b_hdr.p8c_killmouse_
        ; rts
        ; !notreached!
    }}
}
asmsub layerpop() -> bool @Pz {
    %asm {{
        .byte p8b_hdr.p8c_lscr
        .word p8b_hdr.p8c_layerpop_
        ; rts
        ; !notreached!
    }}
}
asmsub layerpush(uword arg0 @XY) -> ubyte @X, bool @Pc {
    %asm {{
        .byte p8b_hdr.p8c_lscr
        .word p8b_hdr.p8c_layerpush_
        ; rts
        ; !notreached!
    }}
}
asmsub loadapp(uword arg0 @XY) {
    %asm {{
        .byte p8b_hdr.p8c_lser
        .word p8b_hdr.p8c_loadapp_
        ; rts
        ; !notreached!
    }}
}
asmsub loadclr() {
    %asm {{
        .byte p8b_hdr.p8c_lscr
        .word p8b_hdr.p8c_loadclr_
        ; rts
        ; !notreached!
    }}
}
asmsub loadicns(uword arg0 @XY) {
    %asm {{
        .byte p8b_hdr.p8c_lscr
        .word p8b_hdr.p8c_loadicns_
        ; rts
        ; !notreached!
    }}
}
asmsub loadlib(ubyte arg0 @A, ubyte arg1 @X, ubyte arg2 @Y) -> ubyte @A {
    %asm {{
        .byte p8b_hdr.p8c_lser
        .word p8b_hdr.p8c_loadlib_
        ; rts
        ; !notreached!
    }}
}
asmsub loadreloc(uword arg0 @XY) -> ubyte @A, bool @Pc {
    %asm {{
        .byte p8b_hdr.p8c_lser
        .word p8b_hdr.p8c_loadreloc_
        ; rts
        ; !notreached!
    }}
}
asmsub loadutil(uword arg0 @XY) -> bool @Pc {
    %asm {{
        .byte p8b_hdr.p8c_lser
        .word p8b_hdr.p8c_loadutil_
        ; rts
        ; !notreached!
    }}
}
asmsub malloc(ubyte arg0 @A, uword arg1 @XY) -> uword @XY, bool @Pc {
    %asm {{
        .byte p8b_hdr.p8c_lmem
        .word p8b_hdr.p8c_malloc_
        ; rts
        ; !notreached!
    }}
}
asmsub markredraw(ubyte arg0 @X) {
    %asm {{
        .byte p8b_hdr.p8c_lscr
        .word p8b_hdr.p8c_markredraw_
        ; rts
        ; !notreached!
    }}
}
asmsub memcpy(ubyte arg0 @A, ubyte arg1 @Y) {
    %asm {{
        .byte p8b_hdr.p8c_lmem
        .word p8b_hdr.p8c_memcpy_
        ; rts
        ; !notreached!
    }}
}
asmsub memfree() -> ubyte @X {
    %asm {{
        .byte p8b_hdr.p8c_lmem
        .word p8b_hdr.p8c_memfree_
        ; rts
        ; !notreached!
    }}
}
asmsub memncpy(ubyte arg0 @A, ubyte arg1 @X, ubyte arg2 @Y) {
    %asm {{
        .byte p8b_hdr.p8c_lstr
        .word p8b_hdr.p8c_memncpy_
        ; rts
        ; !notreached!
    }}
}
asmsub memset(ubyte arg0 @A, ubyte arg1 @Y) {
    %asm {{
        .byte p8b_hdr.p8c_lmem
        .word p8b_hdr.p8c_memset_
        ; rts
        ; !notreached!
    }}
}
asmsub mnudraw() {
    %asm {{
        .byte p8b_hdr.p8c_lmnu
        .word p8b_hdr.p8c_mnudraw_
        ; rts
        ; !notreached!
    }}
}
asmsub mnukcmd() {
    %asm {{
        .byte p8b_hdr.p8c_lmnu
        .word p8b_hdr.p8c_mnukcmd_
        ; rts
        ; !notreached!
    }}
}
asmsub mnumouse() {
    %asm {{
        .byte p8b_hdr.p8c_lmnu
        .word p8b_hdr.p8c_mnumouse_
        ; rts
        ; !notreached!
    }}
}
asmsub mouserc(ubyte arg0 @A, ubyte arg1 @X, ubyte arg2 @Y) -> ubyte @A, ubyte @X, ubyte @Y {
    %asm {{
        .byte p8b_hdr.p8c_linp
        .word p8b_hdr.p8c_mouserc_
        ; rts
        ; !notreached!
    }}
}
asmsub msgapp(ubyte arg0 @A, ubyte arg1 @X, ubyte arg2 @Y, bool arg3 @Pc) {
    %asm {{
        .byte p8b_hdr.p8c_ltim
        .word p8b_hdr.p8c_msgapp_
        ; rts
        ; !notreached!
    }}
}
asmsub msgutil(ubyte arg0 @A, ubyte arg1 @X, ubyte arg2 @Y, bool arg3 @Pc) {
    %asm {{
        .byte p8b_hdr.p8c_ltim
        .word p8b_hdr.p8c_msgutil_
        ; rts
        ; !notreached!
    }}
}
asmsub mul16() {
    %asm {{
        .byte p8b_hdr.p8c_lmat
        .word p8b_hdr.p8c_mul16_
        ; rts
        ; !notreached!
    }}
}
asmsub opaqancs() -> uword @XY {
    %asm {{
        .byte p8b_hdr.p8c_ltkt
        .word p8b_hdr.p8c_opaqancs_
        ; rts
        ; !notreached!
    }}
}
asmsub pet2asc(ubyte arg0 @A) -> ubyte @A {
    %asm {{
        .byte p8b_hdr.p8c_lstr
        .word p8b_hdr.p8c_pet2asc_
        ; rts
        ; !notreached!
    }}
}
asmsub pet2scr(ubyte arg0 @A) -> ubyte @A {
    %asm {{
        .byte p8b_hdr.p8c_lstr
        .word p8b_hdr.p8c_pet2scr_
        ; rts
        ; !notreached!
    }}
}
asmsub pgalloc(ubyte arg0 @A, ubyte arg1 @X) -> ubyte @Y, bool @Pc {
    %asm {{
        .byte p8b_hdr.p8c_lmem
        .word p8b_hdr.p8c_pgalloc_
        ; rts
        ; !notreached!
    }}
}
asmsub pgfetch(uword arg0 @XY) -> bool @Pc {
    %asm {{
        .byte p8b_hdr.p8c_lmem
        .word p8b_hdr.p8c_pgfetch_
        ; rts
        ; !notreached!
    }}
}
asmsub pgfree(ubyte arg0 @X, ubyte arg1 @Y) -> bool @Pc {
    %asm {{
        .byte p8b_hdr.p8c_lmem
        .word p8b_hdr.p8c_pgfree_
        ; rts
        ; !notreached!
    }}
}
asmsub pgmark(ubyte arg0 @X, ubyte arg1 @Y) {
    %asm {{
        .byte p8b_hdr.p8c_lmem
        .word p8b_hdr.p8c_pgmark_
        ; rts
        ; !notreached!
    }}
}
asmsub pgstash(uword arg0 @XY) -> bool @Pc {
    %asm {{
        .byte p8b_hdr.p8c_lmem
        .word p8b_hdr.p8c_pgstash_
        ; rts
        ; !notreached!
    }}
}
asmsub polldevices() {
    %asm {{
        .byte p8b_hdr.p8c_linp
        .word p8b_hdr.p8c_polldevices_
        ; rts
        ; !notreached!
    }}
}
asmsub ptrthis(uword arg0 @XY) {
    %asm {{
        .byte p8b_hdr.p8c_ltkt
        .word p8b_hdr.p8c_ptrthis_
        ; rts
        ; !notreached!
    }}
}
asmsub pullctx() {
    %asm {{
        .byte p8b_hdr.p8c_ltkt
        .word p8b_hdr.p8c_pullctx_
        ; rts
        ; !notreached!
    }}
}
asmsub pushctx() {
    %asm {{
        .byte p8b_hdr.p8c_ltkt
        .word p8b_hdr.p8c_pushctx_
        ; rts
        ; !notreached!
    }}
}
asmsub quitapp() -> uword @XY {
    %asm {{
        .byte p8b_hdr.p8c_lser
        .word p8b_hdr.p8c_quitapp_
        ; rts
        ; !notreached!
    }}
}
asmsub readkcmd() -> ubyte @A, ubyte @Y, bool @Pc {
    %asm {{
        .byte p8b_hdr.p8c_linp
        .word p8b_hdr.p8c_readkcmd_
        ; rts
        ; !notreached!
    }}
}
asmsub readkprnt() -> ubyte @A, bool @Pc {
    %asm {{
        .byte p8b_hdr.p8c_linp
        .word p8b_hdr.p8c_readkprnt_
        ; rts
        ; !notreached!
    }}
}
asmsub readmouse() -> ubyte @A, ubyte @X, ubyte @Y, bool @Pc {
    %asm {{
        .byte p8b_hdr.p8c_linp
        .word p8b_hdr.p8c_readmouse_
        ; rts
        ; !notreached!
    }}
}
asmsub realloc(ubyte arg0 @A, uword arg1 @XY) -> uword @XY, bool @Pc {
    %asm {{
        .byte p8b_hdr.p8c_lmem
        .word p8b_hdr.p8c_realloc_
        ; rts
        ; !notreached!
    }}
}
asmsub recontext() {
    %asm {{
        .byte p8b_hdr.p8c_ltkt
        .word p8b_hdr.p8c_recontext_
        ; rts
        ; !notreached!
    }}
}
asmsub redraw() {
    %asm {{
        .byte p8b_hdr.p8c_lscr
        .word p8b_hdr.p8c_redraw_
        ; rts
        ; !notreached!
    }}
}
asmsub redrwtod() {
    %asm {{
        .byte p8b_hdr.p8c_lser
        .word p8b_hdr.p8c_redrwtod_
        ; rts
        ; !notreached!
    }}
}
asmsub reuconf(ubyte arg0 @A, uword arg1 @XY) -> ubyte @A, bool @Pc {
    %asm {{
        .byte p8b_hdr.p8c_lmem
        .word p8b_hdr.p8c_reuconf_
        ; rts
        ; !notreached!
    }}
}
asmsub scrrow(ubyte arg0 @A, uword arg1 @XY) -> uword @XY {
    %asm {{
        .byte p8b_hdr.p8c_lscr
        .word p8b_hdr.p8c_scrrow_
        ; rts
        ; !notreached!
    }}
}
asmsub seebas() {
    %asm {{
        .byte p8b_hdr.p8c_lmat
        .word p8b_hdr.p8c_seebas_
        ; rts
        ; !notreached!
    }}
}
asmsub setclass() {
    %asm {{
        .byte p8b_hdr.p8c_ltkt
        .word p8b_hdr.p8c_setclass_
        ; rts
        ; !notreached!
    }}
}
asmsub setctx(uword arg0 @XY) {
    %asm {{
        .byte p8b_hdr.p8c_ltkt
        .word p8b_hdr.p8c_setctx_
        ; rts
        ; !notreached!
    }}
}
asmsub setdprops(ubyte arg0 @X, ubyte arg1 @Y) {
    %asm {{
        .byte p8b_hdr.p8c_lscr
        .word p8b_hdr.p8c_setdprops_
        ; rts
        ; !notreached!
    }}
}
asmsub setflags(ubyte arg0 @A) {
    %asm {{
        .byte p8b_hdr.p8c_lser
        .word p8b_hdr.p8c_setflags_
        ; rts
        ; !notreached!
    }}
}
asmsub setgfx(uword arg0 @XY) {
    %asm {{
        .byte p8b_hdr.p8c_lser
        .word p8b_hdr.p8c_setgfx_
        ; rts
        ; !notreached!
    }}
}
asmsub setlrc(uword arg0 @XY, bool arg1 @Pc) {
    %asm {{
        .byte p8b_hdr.p8c_lscr
        .word p8b_hdr.p8c_setlrc_
        ; rts
        ; !notreached!
    }}
}
asmsub setsuper() {
    %asm {{
        .byte p8b_hdr.p8c_ltkt
        .word p8b_hdr.p8c_setsuper_
        ; rts
        ; !notreached!
    }}
}
asmsub settkenv(uword arg0 @XY) {
    %asm {{
        .byte p8b_hdr.p8c_ltkt
        .word p8b_hdr.p8c_settkenv_
        ; rts
        ; !notreached!
    }}
}
asmsub strdel(ubyte arg0 @A, ubyte arg1 @Y) {
    %asm {{
        .byte p8b_hdr.p8c_lstr
        .word p8b_hdr.p8c_strdel_
        ; rts
        ; !notreached!
    }}
}
asmsub strins(ubyte arg0 @A, ubyte arg1 @Y) {
    %asm {{
        .byte p8b_hdr.p8c_lstr
        .word p8b_hdr.p8c_strins_
        ; rts
        ; !notreached!
    }}
}
asmsub strlen(uword arg0 @XY) -> uword @XY {
    %asm {{
        .byte p8b_hdr.p8c_lstr
        .word p8b_hdr.p8c_strlen_
        ; rts
        ; !notreached!
    }}
}
asmsub syskcmd(ubyte arg0 @A, ubyte arg1 @Y) {
    %asm {{
        .byte p8b_hdr.p8c_lser
        .word p8b_hdr.p8c_syskcmd_
        ; rts
        ; !notreached!
    }}
}
asmsub timedwn() {
    %asm {{
        .byte p8b_hdr.p8c_ltim
        .word p8b_hdr.p8c_timedwn_
        ; rts
        ; !notreached!
    }}
}
asmsub timeevt() {
    %asm {{
        .byte p8b_hdr.p8c_ltim
        .word p8b_hdr.p8c_timeevt_
        ; rts
        ; !notreached!
    }}
}
asmsub timeque(uword arg0 @XY) -> bool @Pc {
    %asm {{
        .byte p8b_hdr.p8c_ltim
        .word p8b_hdr.p8c_timeque_
        ; rts
        ; !notreached!
    }}
}
asmsub tkkcmd(uword arg0 @XY) -> bool @Pc {
    %asm {{
        .byte p8b_hdr.p8c_ltkt
        .word p8b_hdr.p8c_tkkcmd_
        ; rts
        ; !notreached!
    }}
}
asmsub tkkprnt(uword arg0 @XY) -> bool @Pc {
    %asm {{
        .byte p8b_hdr.p8c_ltkt
        .word p8b_hdr.p8c_tkkprnt_
        ; rts
        ; !notreached!
    }}
}
asmsub tkmouse(uword arg0 @XY) -> bool @Pc {
    %asm {{
        .byte p8b_hdr.p8c_ltkt
        .word p8b_hdr.p8c_tkmouse_
        ; rts
        ; !notreached!
    }}
}
asmsub tknew(uword arg0 @XY) -> uword @XY {
    %asm {{
        .byte p8b_hdr.p8c_ltkt
        .word p8b_hdr.p8c_tknew_
        ; rts
        ; !notreached!
    }}
}
asmsub tkupdate(uword arg0 @XY) {
    %asm {{
        .byte p8b_hdr.p8c_ltkt
        .word p8b_hdr.p8c_tkupdate_
        ; rts
        ; !notreached!
    }}
}
asmsub tohex(ubyte arg0 @A) -> ubyte @X, ubyte @Y {
    %asm {{
        .byte p8b_hdr.p8c_lmat
        .word p8b_hdr.p8c_tohex_
        ; rts
        ; !notreached!
    }}
}
asmsub toint(ubyte arg0 @A, uword arg1 @XY) {
    %asm {{
        .byte p8b_hdr.p8c_lmat
        .word p8b_hdr.p8c_toint_
        ; rts
        ; !notreached!
    }}
}
asmsub tolower(ubyte arg0 @A) -> ubyte @A {
    %asm {{
        .byte p8b_hdr.p8c_lstr
        .word p8b_hdr.p8c_tolower_
        ; rts
        ; !notreached!
    }}
}
asmsub tostr() -> uword @XY {
    %asm {{
        .byte p8b_hdr.p8c_lmat
        .word p8b_hdr.p8c_tostr_
        ; rts
        ; !notreached!
    }}
}
asmsub toupper(ubyte arg0 @A) -> ubyte @A {
    %asm {{
        .byte p8b_hdr.p8c_lstr
        .word p8b_hdr.p8c_toupper_
        ; rts
        ; !notreached!
    }}
}
asmsub unldlib(ubyte arg0 @A, ubyte arg1 @X, ubyte arg2 @Y) {
    %asm {{
        .byte p8b_hdr.p8c_lser
        .word p8b_hdr.p8c_unldlib_
        ; rts
        ; !notreached!
    }}
}
asmsub updstat() {
    %asm {{
        .byte p8b_hdr.p8c_lser
        .word p8b_hdr.p8c_updstat_
        ; rts
        ; !notreached!
    }}
}
asmsub viewwtag(ubyte arg0 @A) {
    %asm {{
        .byte p8b_hdr.p8c_ltkt
        .word p8b_hdr.p8c_viewwtag_
        ; rts
        ; !notreached!
    }}
}
asmsub walk(ubyte arg0 @A) -> bool @Pc {
    %asm {{
        .byte p8b_hdr.p8c_ltkt
        .word p8b_hdr.p8c_walk_
        ; rts
        ; !notreached!
    }}
}
l_terminator:
    %asm {{
        .byte $FF
    }}
}
