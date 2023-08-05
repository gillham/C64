

;mastercode-x16.prg ==0801==
10000 rem******************************
10020 rem general initialisation
10030 rem******************************
10031 base = 16
10032 if len(ptr$)+len(e$)<>255 then clr : gosub 19000
10035 dev = 1
10040 deffn hex(x) = (x and 15)+48-((x and 15)>9)*7
10050 deffn dec(x) = x-48+(x>57)*7
10060 false = 0 : true = -1
10070 poke 53281,1 : poke 53280,15
10100 rem******************************
10101 rem control routine for monitor
10102 rem******************************
10110 data exit to basic,memory modify,memory dump,machine code excute
10111 data load machine code file,save machine code file
10120 data disassembler
10130 data file editor
10140 data assembler
10190 data end
10200 restore
10220 x = 0
10230 print "{lblu}{clr}--------- machine code monitor ---------{lgrn}{down}"
10250 read t$
10260 if t$<>"end" then print tab(5) x ")" t$ : x= x+1 : goto 10250
10265 if x<15 then for y = x to 15 : print : next
10270 print "command ( 0 -" x-1 " ) : ";: input t
10300 if t<0 or t>x then 10100
10305 if t=0 then print "{clr}{down}{down}{down}{down}                  {rvon}bye{rvof}{down}{down}{down}{down}" : close 1: end
10310 on t gosub 13100,13300,13500,14300,14100,15800,24800,20000
10320 goto 10100
11000 rem******************************
11001 rem convert decimal to hex
11002 rem******************************
11010 t = h : h$ = ""
11020 h$ = chr$(fnhex(t-int(t/16)*16))+h$ : t = int(t/16) : if t>0 then 11020
11050 return
11100 rem******************************
11101 rem byte into hex
11102 rem******************************
11110 h = peek(ad) : ad = ad+1
11120 gosub 11000
11130 if len(h$)<2 then h$ = "0"+h$
11140 o2$ = o2$+h$
11150 return
11200 rem******************************
11201 rem input finish address
11202 rem******************************
11205 h$ = ""
11210 input "finish address ( in hex) : "; h$ : gosub 11950
11230 if err or h<0 or h>65535 then 11200
11240 ea = h : return
11250 rem******************************
11251 rem input file name
11252 gosub 25500 : if dev=4 then 11290
11255 in$ = ""
11260 input " file name : "; in$ : t = len(in$)
11280 if t>16 or t<0 then print "{down}file name invalid" : goto 11260
11290 return
11850 rem******************************
11851 rem ask continue ?
11852 rem******************************
11858 t$ = ""
11860 input "continue ( y/n ) : "; t$
11870 if t$="y" then co = true : goto 11895
11880 if t$<>"n" then print "{up}"; : goto 11850
11890 co = false
11895 return
11950 rem******************************
11951 rem convert hex in h$ to dec in h
11952 rem******************************
11975 err = false : h = 0 : if len(h$)=0 then 12030
11980 for x = 1 to len(h$)
11990 t = fndec(asc(mid$(h$,x,1))): h = h*base+t
12010 if t>base-1 or t<0 then err = true
12020 next x
12030 return
12050 rem******************************
12051 rem input start address
12052 rem******************************
12057 h$ = ""
12060 input "start address ( in hex ) : "; h$ : gosub11950
12080 if err or h<0 or h>65535 then 12060
12090 ad = h : return
12200 rem******************************
12201 rem hex loader
12202 rem******************************
12210 t1$ = ""
12220 for x1 = 1 to len(t$) step 2
12230 t1$ = t1$+chr$(fndec(asc(mid$(t$,x1,1)))*16+fndec(asc(mid$(t$,x1+1,1))))
12260 next x1
12270 return
13000 rem******************************
13001 rem get 1 byte
13002 rem******************************
13007 h$ = ""
13010 input "byte ( in hex ) : "; h$
13030 gosub 11950
13040 if err or h<0 or h>255 then print "{up}" : goto 13000
13050 return
13100 rem******************************
13101 rem memory modify
13102 rem******************************
13110 gosub 12050
13120 h = ad : gosub 11000 : print h$ tab(6) "/" ; : o2$ = ""
13140 gosub 11100 : ad = ad-1 : print h$ spc(6) ;
13150 t$ = ""
13160 input " +,-,i,e : "; t$
13170 if t$="+" and ad<65535 then ad = ad+1 : goto 13120
13180 if t$="-" and ad>0 then ad = ad-1 : goto 13120
13190 if t$="e" then return
13200 if t$<>"i" then print"{up}{up}" : goto 13120
13210 gosub 13000 : poke ad,h : goto 13120
13300 rem******************************
13301 rem dump memory to screen
13302 rem******************************
13310 gosub 12050
13320 print "{clr}" : for x1 = 1 to 18 : h = ad : gosub 11000
13340 o2$ = "" : o1$ = h$ : o3$ = ""
13350 for x2 = 0 to 7
13360 gosub 11100 : o2$ = o2$+" "
13375 if h>31 and h<95 then o3$ = o3$+chr$(h) : goto 13380
13377 o3$ = o3$+"."
13380 next x2
13390 print o1$ tab(5) o2$ tab(31) o3$
13400 next x1
13410 print : gosub 11850 : if co then 13320
13440 return
13500 rem******************************
13501 rem machine code execute
13502 rem******************************
13510 gosub 12050 : sys ad : return
14100 rem******************************
14101 rem machine code save
14102 rem******************************
14110 gosub 11250 : gosub 12050 : gosub 11200
14115 t$ = "n" : if dev=8 then input "overwrite existing file ( y/n ) : "; t$
14116 if t$="y" then in$ = "@0:"+in$
14120 if dev=8 then in$ = in$+",s,w"
14125 if sa>ea then 14190
14130 open 2,dev,2,in$ : print# 2,ad : print# 2,ea
14150 for x = ad to ea : print# 2,peek(x) : next : print# 2 : close 2
14190 return
14300 rem******************************
14301 rem machine code load
14302 rem******************************
14310 gosub 11250 : if dev=8 then in$ = in$+",s,r"
14320 open 2,dev,0,in$ : input# 2,sa,ea : if st then close 2 : return
14350 for x = sa to ea : input# 2,t : poke x,t : next : close 2 : return
15300 rem******************************
15301 rem add operand in op to o1$
15302 rem******************************
15310 on op+1 goto 15450,15500,15550,15600
15330 if op>6 and op<10 then o1$ = o1$+"("
15340 gosub 11100
15350 o1$ = o1$+"$" : t$ = h$
15360 if op<9 then 15390
15370 gosub 11100
15380 o1$ = o1$+h$
15390 o1$ = o1$+t$
15400 if op=9 or op=8 then o1$ = o1$+")"
15410 if op-int(op/3)*3=1 then o1$ = o1$+",x"
15420 if op-int(op/3)*3=2 then o1$ = o1$+",y"
15430 if op=7 then o1$ = o1$+")"
15440 return
15450 rem******************************
15451 rem accumulat0r (op=0)
15452 rem******************************
15460 o1$ = o1$+"a"
15500 rem implied (op=1)
15510 return
15550 rem******************************
15551 rem immediate (op=2)
15552 rem******************************
15560 gosub 11100
15570 o1$ = o1$+"#$"+h$
15580 return
15600 rem******************************
15601 rem relative (op=3)
15602 rem******************************
15610 gosub 11100
15620 if h>127 then h = h-256
15630 h = h+ad
15640 gosub 11000
15650 o1$ = o1$+"$"+h$
15660 return
15700 rem******************************
15701 rem disassemble instruction
15702 rem******************************
15710 o2$ = ""
15715 gosub 11100 : h = h+1
15720 if h>255 then h = 3
15730 t = asc(mid$(ta$(0),h,1))
15750 o1$ = mid$(ta$(2),t*3+1,3)+" "
15760 op = asc(mid$(ta$(1),int((h+1)/2),1))
15770 if (h and 1) =1 then op = op/16
15780 op = op and 15
15790 return
15800 rem******************************
15801 rem disassemble memory area
15802 rem******************************
15810 gosub 12050
15820 print "{clr}" : for i = 1 to 20
15825 h = ad : gosub 11000 : print h$ tab(6) ;
15830 gosub 15700 : gosub 15300
15850 print o2$ tab(14) o1$
15860 next i
15865 print
15870 gosub 11850
15880 if co then 15820
15890 return
19000 rem******************************
19001 rem initalise decoder tables
19002 rem******************************
19005 base = 16
19007 deffn dec(x) = x-48+(x>57)*7
19010 dim ta$(4)
19011 t$ =    "0a223838382202382422023838220238"
19012 t$ = t$+"09223838382202380d22383838220238"
19013 t$ = t$+"1c013838060127382601273806012738"
19014 t$ = t$+"07013838380127382c01383838012738"
19015 t$ = t$+"2917383838172038231720381b172038"
19016 t$ = t$+"0b173838381720380f17383838172038"
19017 t$ = t$+"2a00383838002838250028381b002838"
19018 gosub 12200 : ta$(0) = t1$
19019 t$ =    "0c003838380028382e00383838002838"
19020 t$ = t$+"382f3838312f303816383538312f3038"
19021 t$ = t$+"032f3838312f3038372f3638382f3838"
19022 t$ = t$+"1f1d1e381f1d1e38331d32381f1d1e38"
19023 t$ = t$+"041d38381f1d1e38101d34381f1d1e38"
19024 t$ = t$+"13113838131114381a11153813111438"
19025 t$ = t$+"08113838381114380e11383838111438"
19026 gosub 12200 : ta$(0) = ta$(0)+t1$
19027 t$ =    "122b3838122b1838192b2138122b1838"
19028 t$ = t$+"052b3838382b18382d2b3838382b18"
19029 gosub 12200 : ta$(0) = ta$(0)+t1$
19030 t$ =    "1711166112011cc1381114411b111aa1"
19031 t$ = t$+"c71166611201ccc1381114411b111aa1"
19032 t$ = t$+"171116611201ccc1381114411b111aa1"
19033 t$ = t$+"1711166112019cc1381114411b111aa1"
19034 t$ = t$+"171166611111ccc1381144511b111a11"
19035 t$ = t$+"272166611211ccc1381144511b11aab1"
19036 t$ = t$+"271166611211ccc1381114411b111aa1"
19037 t$ = t$+"271166611211ccc1381114411b111a"
19038 gosub 12200 : ta$(1) = t1$+chr$(160)
19040 ta$(2) =        "adcandaslbccbcsbeqbitbmibnebplbrkbvcbvs"
19041 ta$(2) = ta$(2)+"clccldcliclvcmpcpxcpydecdexdeyeorincinx"
19042 ta$(2) = ta$(2)+"inyjmpjsrldaldxldylsrnoporaphaphpplaplp"
19043 ta$(2) = ta$(2)+"rolrorrtirtssbcsecsedseistastxstytaxtay"
19044 ta$(2) = ta$(2)+"tsxtxatxstya???"
19046 ta$(2) = ta$(2)+"bytwrddbyendorgprtsym"
19047 t$ =    "61210690b0f02430d01000507018d858"
19048 t$ = t$+"b8cdecccceca884deee8c84c20adaeac"
19049 t$ = t$+"4aea0d480868282a6a4060ed38f8788d"
19050 t$ = t$+"8e8caaa8ba8a9a98"
19051 gosub 12200 : ta$(3) = t1$
19052 t$ =    "ff11ffffff090affff1d0effff051eff"
19053 t$ = t$+"ff15ffffffffffffff01ffffff1916ff"
19054 t$ = t$+"ff2dffff2c293effff3d2effff2526ff"
19055 t$ = t$+"ff35ffffffffffffff31ffffff3936ff"
19056 t$ = t$+"ff51ffffff495effff5d4eff6c4546ff"
19057 t$ = t$+"ff55ffffffffffffff41ffffff5956ff"
19058 t$ = t$+"ff6dffffff697effff7d6effff6566ff"
19059 gosub 12200 : ta$(4) = t1$
19060 t$ =    "ff75ffffffffffffff71ffffff7976ff"
19061 t$ = t$+"ff91ffff949d96ffffffffff848586ff"
19062 t$ = t$+"ff95ffffffffffffff81ffffff99ffff"
19063 t$ = t$+"bcb1beffa0a9a2ffffbdffafa4a5a6ff"
19064 t$ = t$+"ffb5ffffffffffffffa1ffffb4b9b6ff"
19065 t$ = t$+"ffd1ffffc0c9deffffddffffc4c5c6ff"
19066 t$ = t$+"ffd5ffffffffffffffc1ffffffd9d6ff"
19067 gosub 12200 : ta$(4) = ta$(4)+t1$
19068 t$ =    "fff1ffffe0e9fefffffdffffe4e5e6ff"
19069 t$ = t$+"fff5ffffffffffffffe1fffffff9f6"
19070 gosub 12200 : ta$(4) = ta$(4)+t1$
19080 sm = 50 : se = 0 : dim stable$(sm)
19101 dim err$(18)
19103 err$(1) = "single byte out of range"
19104 err$(2) = "double byte out of range"
19105 err$(3) = "invalid oprand or opcode"
19106 err$(4) = "invalid operator"
19107 err$(5) = "index is not x or y"
19108 err$(6) = "label not alpha-numeric"
19109 err$(7) = "incorrect number base"
19110 err$(8) = "label defined twice"
19112 err$(10) = "branch out of range"
19113 err$(11) = "undefined label"
19114 err$(12) = "only single chr. expected"
19116 err$(14) = "out of symbol space"
19117 err$(15) = "division by zero"
19120 err$(18) = "addressing mode not availble with this opcode"
19980 dim fi$(254) : gosub 24300
19990 return
20000 rem******************************
20001 rem generate assembly listing
20002 rem******************************
20005 se = 0 : fmax = len(ptr$) : sy = false
20010 input " error only listing ( y/n ) :"; t$
20020 eo = left$(t$,1)="y"
20025 input " assemble to memory ( y/n ) :"; t$
20029 am = left$(t$,1)="y"
20030 ad = 0 : rem set start address
20040 for q = 1 to fmax
20050 in$ = file$(asc(mid$(ptr$,q,1))) : o$ = ""
20060 gosub 26400
20070 if exit then q=fmax+1
20080 next q
20085 t = fre(x)
20090 ad = 0 : ec = 0 : print "add.  data     source code"
20100 for q = 1 to fmax
20110 in$ = file$(asc(mid$(ptr$,q,1))) : o$ = ""
20120 q1 = ad
20130 gosub 27600
20140 if err then 20250
20145 if eo then 20222
20150 h = q1 : gosub 11000
20160 q$ = h$
20180 q2 = 3 : if len(o$)<q2 then q2 = len(o$)
20185 q1$ ="" : if o$="" then 20221
20190 for q3 = 1 to q2
20200 h = asc(mid$(o$,q3,1)) : gosub 11000
20210 if len(h$)=1 then h$ = "0"+h$
20220 q1$ = q1$+h$ : next q3
20221 print q$ spc(6-len(q$)) q1$ spc(8-len(q1$)) ; : gosub 28100
20222 if not am or o$="" then 20250
20225 for x = 1 to len(o$) : poke q1+x-1,asc(mid$(o$,x,1)) : next
20250 if exit then q = fmax+1 : rem leave loop
20260 next q
20270 print : print " total errors in file ---" ec : print
20280 if sy then gosub 26900
20290 if peek(152) <> 0 then print#2 : close2 : goto 20300
20295 get t$ : if t$="" then 20295
20300 return
23000 rem******************************
23001 rem file editor
23002 rem******************************
23010 rem file editor
23020 rem find line number in 'ln' in file
23030 t = len(ptr$)+1 : t2 = -1
23040 t = t-1 : if t<=0 then goto 23080
23050 t1 = asc(mid$(ptr$,t,1))
23060 t2 = asc(mid$(fi$(t1),1,1))+256*asc(mid$(fi$(t1),2,1))
23070 if t2>ln then 23040
23080 err = not(t2=ln) : if err then t = t+1
23090 return
23100 rem******************************
23101 rem add line to file
23102 rem******************************
23105 if ln<0 or ln>65535 then 23215
23110 gosub 23020
23120 if not err then t1 = asc(mid$(ptr$,t,1)) : goto 23150
23130 if e$="" then err = true : goto 23220
23140 t1 = asc(e$)  : e$ = mid$(e$,2)
23150 t2 = int(ln/256)
23160 fi$(t1) = chr$(ln-t2*256)+chr$(t2)+in$
23170 if not err then 23220
23180 t$ = "" : t1$ = ""
23190 if t>1 then t$ = left$(ptr$,t-1)
23200 if t<=len(ptr$) then t1$ = mid$(ptr$,t)
23210 ptr$ = t$+chr$(t1)+t1$
23215 err = false
23220 return
23300 rem******************************
23301 rem delete line pointed at by t
23302 rem******************************
23310 t$ = "" : t1$ = ""
23320 if t>1 then t$ = left$(ptr$,t-1)
23330 if t<len(ptr$) then t1$ = mid$(ptr$,t+1)
23340 e$ = e$+mid$(ptr$,t,1)
23350 ptr$ = t$+t1$
23360 return
23400 rem******************************
23401 rem list lines pointed at by t
23402 rem******************************
23410 print asc(mid$(fi$(t),1,1))+256*asc(mid$(fi$(t),2,1)) tab(6) ;
23420 print mid$(fi$(t),3)
23430 return
23500 rem******************************
23501 rem start and finish pointers
23502 rem******************************
23510 ln = sl : gosub 23020
23520 sp = t
23530 ln = fl : gosub 23020
23540 fp = t
23545 if err then fp = fp-1
23550 if fp>len(ptr$) then fp = len(ptr$)
23560 return
23600 rem******************************
23601 rem load file from device
23602 rem******************************
23610 gosub 11250
23615 if dev=8 then in$ = in$+",s,r"
23630 open2,dev,0,in$
23635 input#2 , in$ : if st then goto 23650
23640 if in$<>"end" then gosub 24000 : gosub 23900 : gosub 23100 : goto 23635
23650 close 2
23660 return
23700 rem******************************
23701 rem save file to device
23702 rem******************************
23705 gosub 11250
23710 if dev=8 then in$ = in$+",s,w"
23715 t$ = "n" : if dev=8 then input "overwrite existing file ( y/n ) : "; t$
23716 if t$="y" then in$ = "@0:"+in$
23720 open2,dev,2,in$ : cmd 2
23730 sl = 0 : fl = 65536
23750 gosub 24420 : print#2 , "end"
23760 print#2 : close 2
23780 return
23900 rem******************************
23901 rem remove leading spaces
23902 rem******************************
23910 for t = 1 to len(in$)
23920 if mid$(in$,t,1)=" " then next t
23950 in$ = mid$(in$,t) : return
24000 rem******************************
24001 rem get line number
24002 rem******************************
24010 ln = -65536
24020 if len(in$)=0 or in$<"0" or left$(in$,1)>"9" then 24090
24030 for t = 1 to len(in$)
24040 if mid$(in$,t,1)<="9" and mid$(in$,t,1)>="0" then next t
24080 ln = val(left$(in$,t-1)) : in$ = mid$(in$,t)
24090 return
24200 rem******************************
24201 rem  first and last lines
24202 rem******************************
24205 in$ = "" : input "first - last lines : "; in$
24210 sl = 0 : fl = 65535 : t3 = 0 : err = false
24220 if len(in$)=0 then 24295
24230 gosub 24000
24240 if ln>=0 then sl = ln : goto 24260
24250 if ln>-65536 then fl = -ln : goto 24295
24260 gosub 23900 : if len(in$)=0 then fl = sl : goto 24295
24270 in$ = mid$(in$,2) : gosub 23900
24290 if len(in$)>0 then gosub 24000 : fl = ln
24295 err = sl<0 or sl>65535 or fl<0 or fl>65535 or err : return
24300 rem******************************
24301 rem initalise file
24302 rem******************************
24310 ptr$ = "" : e$ = "" : for x = 0 to 254 : e$ = e$+chr$(x) : next : return
24400 rem******************************
24401 rem list lines
24402 rem******************************
24410 gosub 24200 : if err then 24460
24420 print "{clr}" : gosub 23500 : if fp<spor fp=0 then 24460
24430 for t1 = sp to fp : t = asc(mid$(ptr$,t1,1)) : gosub 23400 : next : print
24455 if peek(650)=0 then get t$ : if t$="" then 24455
24460 return
24500 rem******************************
24501 rem delete line(s)
24502 rem******************************
24510 gosub 24200 : if err then 24460
24520 gosub 23500 : if fp<sp then 24560
24530 t = sp : for t1 = sp to fp : gosub 23300 : next
24560 return
24600 rem******************************
24601 rem input line(s)
24602 rem******************************
24610 print "{clr}"
24620 in$ = "" : input in$ : gosub 24000 : if ln=-65536 then 24665
24650 gosub 23900 : if len(in$)=0 then 24680
24660 gosub 23100 : if not err then 24620
24665 return
24680 gosub 23020 : if not err then gosub 23300
24690 goto 24620
24700 rem******************************
24701 rem renumber file in steps of 10
24702 rem******************************
24710 ln = 10 : err = false
24720 if len(ptr$)<1 then 24780
24730 for t = 1 to len(ptr$)
24735 t1 = asc(mid$(ptr$,t,1))
24740 fi$(t1) = chr$(ln-int(ln/256)*256)+chr$(ln/256)+mid$(fi$(t1),3)
24750 ln = ln+10 : next
24780 return
24800 rem******************************
24801 rem file editor menu
24802 rem******************************
24820 print "{clr}{pur} ------------ file editor ------------{wht}{down}"
24835 print "      0) exit from file editor"
24840 print "      1) input line(s)"
24850 print "      2) list line(s)"
24860 print "      3) delete line(s)"
24870 print "      4) renumber file"
24880 print "      5) initialise file"
24890 print "      6) load file"
24900 print "      7) save file"
24910 print "      8) add machine code to file"
24915 print "      9) change device number{down}{down}{down}{down}{down}"
24920 input " command ( 0-9 ) : "; co
24940 if co=0 then return
24950 if co>0 then on co gosub 24600,24400,24500,24700,24300,23600,23700,25000
24960 if co>8 then on co-8 gosub 25500
24970 goto 24800
25000 rem******************************
25001 rem add to file from memory
25002 rem******************************
25010 gosub 12050 : gosub 11200 : gosub 24200
25050 for xy = ad to ea step 15
25060 in$ = " byt " : ln = sl : sl = sl+5
25070 for xz = 0 to 14 : o2$ = ""
25080 gosub 11100 : in$ = in$+"$"+h$
25100 if xz<14 and ad<=ea then in$ = in$+"." : next xz
25110 gosub 23100 : next xy : return
25500 rem******************************
25501 rem change device number
25502 rem******************************
25510 print spc(19) dev
25520 input "{up}new device number:";dev
25530 return
26000 rem******************************
26001 rem symbol up to colon etc.
26002 rem******************************
26010 h$ = "" : t1 = len(in$)
26020 ptr = ptr+1
26030 if t1<ptr then 26060
26040 t = asc(mid$(in$,ptr,1))
26045 if t=32 then 26020
26050 if t<>58 and t<>59 then h$ = h$+chr$(t) : goto 26020
26060 return
26100 rem******************************
26101 rem operand type to be used
26102 rem******************************
26110 t6 = ptr : gosub 26000
26120 err = false
26130 if len(h$)=0 then op = 1 : return
26140 if h$="a" then op = 0 : return
26145 if asc(h$)=35 then op = 2 : return
26170 op = 12
26180 if left$(h$,1)="(" then op = op-3
26190 t = 1 : t1 = len(h$)
26200 t2 = asc(mid$(h$,t,1))
26210 if t2<>46 and t<t1 then t = t+1 : goto 26200
26220 if t2<>46 then 26275
26230 t = t+1 : if t>t1 then 26270
26240 t2 = asc(mid$(h$,t,1))
26250 if t2=89 then op = op-1 : goto 26275
26260 if t2=88 then op = op-2 : goto 26275
26270 rem not a valid index
26272 en = 5 : goto 28000
26275 if(op=12)and((po>2andpo<6)or(po>6andpo<10)orpo=12orpo=11)then op = 3
26281 rem zero page oprands
26282 if op<10 then return
26284 t7 = ptr : ptr = t6
26286 gosub 28600
26288 if err or result>255 then 26292
26290 op = op-6
26292 ptr = t7
26294 return
26300 rem******************************
26301 rem evaluate opcode
26302 rem******************************
26310 t1 = 3 : t = po
26320 t = asc(mid$(ta$(t1),t+1,1))
26330 if t=255 then err = true : return
26340 t1 = 4 : t2 = asc(mid$(ta$(1),int(t/2+1),1))
26350 if (1 and t)=0 then t2 = int(t2/16)
26355 t2 = t2 and 15
26360 if t2<>op then 26320
26370 o$ = o$+chr$(t)
26380 err = false
26390 return
26400 rem******************************
26401 rem do pass 1 assembly on in$
26402 rem******************************
26405 print "{home}{down}{down}{down}{down}{down}{down}{down}{down}{down}{down}{down}{down}{down}{down}{down}{down}{down}{down}{down}{down}{down}{down}                                        " ;
26406 print "                                       " ;
26407 print "{home}{down}{down}{down}{down}{down}{down}{down}{down}{down}{down}{down}{down}{down}{down}{down}{down}{down}{down}{down}{down}{down}{down}" ;: gosub 28100
26410 pass = 1 : exit = false : ptr = 2
26420 gosub 28850
26430 if not err then 26540
26440 if t=58 and len(h$)=0 then 26420
26450 if t=59 or t=-1 then return
26460 gosub 28700
26480 gosub 28850
26490 if not err then 26540
26500 if t=58 and len(h$)=0 then 26420
26520 return
26540 if po>55 then gosub 26600 : goto 26556
26550 gosub 26100
26552 gosub 26300 : if err and op>3 and op<7 then op = op+6 : goto 26552
26555 gosub 26560
26556 if len(in$)>ptr and not exit then 26420
26557 return
26560 rem******************************
26561 rem byte length
26562 rem******************************
26565 ad = ad+1
26570 if op>1 then ad = ad+1
26580 if op>8 then ad = ad+1
26590 return
26600 rem******************************
26601 rem calculate directive length
26602 rem******************************
26610 t1 = len(in$)
26620 if po=56 then 26720 : rem byt directive
26625 if po=60 then gosub 28600 : ad = result : rem deal with org directive
26627 if po=59 then exit = true
26630 if po>58 then return : rem end & org directives
26640 rem find len. of wrd & dby
26650 ad = ad+2
26660 ptr = ptr+1
26670 if ptr>t1 then return
26680 t = asc(mid$(in$,ptr,1))
26690 if t=58 or t=59 then return
26700 if t<>46 then 26660
26710 goto 26650
26720 rem length for byt.
26730 ad = ad+1
26740 ptr = ptr+1
26750 if ptr>t1 then return
26760 t = asc(mid$(in$,ptr,1))
26770 if t=58 or t=59 then return
26780 if t<>46 then 26740
26790 goto 26730
26900 rem******************************
26901 rem dump symbol table to screen
26902 rem******************************
26910 if se<1 then 26975
26915 print
26920 for x = 0 to se-1
26930 print left$(st$(x),6) tab(10) ;
26940 h = asc(mid$(st$(x),8))*256+asc(mid$(st$(x),7))
26950 gosub 11000
26960 print h$
26970 next x
26975 print "{down} total number of symbols ---" se
26980 return
27000 rem******************************
27001 rem evaluate operand
27002 rem******************************
27010 err = false
27020 if op<2 then return
27030 if op=3 then 27500
27040 if op=2 then 27400
27050 gosub 28600
27060 if err or len(o$)=0 then return
27070 if (result<0 or result>255) and op<9 then en = 1 : goto 28000
27080 if result<0 or result>65535 then en= 2 : goto 28000
27090 if op<9 then 27140
27100 t = int(result/256)
27110 result = result-t*256
27120 gosub 27140
27130 result = t
27140 o$ = o$+chr$(result)
27150 return
27200 rem******************************
27201 rem directive operand evaluator
27202 rem******************************
27205 err = false
27210 if po=60 then gosub 28600 : ad =result
27214 if po=62 then sy = true
27215 if po=61 then open 2,4 : cmd 2 : print "{down}add.  data     source code{down}"
27220 if po=59 then exit = true
27230 if po>58 then return
27240 if po=56 then 27330
27250 rem dby & wrd directives
27260 gosub 28600
27270 if result<0 or result>65535 then en = 2 : goto 28000
27280 if po=58 then result = int(result/256)+256*(result-int(result/256)*256)
27281 rem 27280 reverses hi. & lo. bytes if directive is dby
27290 t1 =t : gosub 27100 : ad = ad+2
27300 if t1=32 then gosub 28150
27310 if t1=46 then 27260
27320 return
27330 rem byt directive
27340 gosub 28600
27350 if result<0 or result>255 then en = 1 : goto 28000
27360 gosub 27140 : ad = ad+1
27370 if t=32 then gosub 28150
27380 if t=46 then 27340
27390 return
27400 rem******************************
27401 rem evaluate immediate expression
27402 rem******************************
27410 t5 = ptr : gosub 26000
27420 if asc(h$)<>35 then 27480
27430 if mid$(h$,2,1)="'" then 27450
27440 ptr = t5
27442 if ptr>len(in$) then 27446
27444 if asc(mid$(in$,ptr,1))<>35 then ptr = ptr+1 : goto 27442
27446 op = 8 : gosub 27050 : op = 2
27448 return
27450 rem single chr. expected
27460 if len(h$)<>3 then 27480
27470 o$ = o$+mid$(h$,3,1) : return
27480 en = 12
27490 goto 28000
27500 rem******************************
27501 rem evaluate relative expression
27502 rem******************************
27510 gosub 28600
27520 if len(o$)=0 or err then return
27530 result = result-ad
27540 if result<0 then result = result+256
27560 if result<256 and result>=0 then 27140
27570 en = 10
27580 goto 28000
27600 rem******************************
27601 rem do pass 2 assembly
27602 rem******************************
27605 pass = 2
27610 o$ = ""
27620 exit = false : err = false
27625 ptr = 2
27630 gosub 28850
27640 if not err then 27720
27650 if t=58 and len(h$)=0 then 27630
27660 if t=59 or t=-1 then err = false : return
27665 gosub 28700
27670 gosub 28850
27680 if not err then 27720
27690 if t=58 and len(h$)=0 then 27630
27695 if t=59 or t=-1 then err = false : return
27700 en = 3 : goto 28000
27720 if po>55 then gosub 27200 : goto 27745
27723 t5 = ptr : gosub 26100 : t8 = ptr  : ptr = t5
27725 gosub 26300 : if not err then 27730
27727 if op<7 and op>3 then op = op+6 : ptr = t5 : goto 27725
27728 en = 18 : goto 28000
27729 rem this bit attemps to match absloute add mode to opcode if zp has failed
27730 gosub 26560
27740 if not err and len(o$)>0 then gosub 27000 : ptr = t8
27745 if len(in$)>ptr and not exit then 27630
27750 return
28000 rem******************************
28001 rem assembler error routine
28002 rem******************************
28005 if ptr>=300 or pass<>2 then 28050 : rem supress secondary errors in line
28010 print spc(14) ; : gosub 28100
28015 ec = ec+1
28020 for x = -13 to ptr : print "=" ;: next x : print "{up}"
28030 print "   " err$(en) " error"
28040 ptr = 300 : err = true
28050 return
28100 rem******************************
28101 rem print in$ to the screen
28102 rem******************************
28120 print 256*asc(mid$(in$,2,1))+asc(mid$(in$,1,1)) mid$(in$,3)
28140 return
28150 rem******************************
28151 rem symbol to non-letter/digit
28152 rem******************************
28160 h$ = "" : t = -1
28165 ptr = ptr+1
28170 if ptr>len(in$) then 28210
28180 t = asc(mid$(in$,ptr,1))
28185 if t=32 and len(h$)=0 then 28160
28190 if t<48 or t>90 or ( t>57 and t<65 ) then 28210
28200 h$ = h$+chr$(t) : goto 28165
28210 return
28250 rem******************************
28251 rem find label in st$
28252 rem******************************
28260 err = false : h = 0 : t1 = 0
28270 if len(h$)<6 then h$ = h$+" " : goto 28270
28280 if t1=se then err = true : return
28290 if mid$(st$(t1),1,6)<>h$ then t1 = t1+1 : goto 28280
28295 h = asc(mid$(st$(t1),8,1))*256+asc(mid$(st$(t1),7,1)) : return
28300 rem******************************
28301 rem evaluate label or number
28302 rem******************************
28320 gosub 28150
28325 if t=40 and len(h$)=0 then gosub 28150
28330 t1 = len(h$)
28335 if (t=-1 or t=32 or t=58 or t=59 or t=41 or t=46) and t1 = 0 then return
28340 if t1=0 then 28390
28350 if asc(h$)<=57 then h = val(h$) : goto 28492
28360 gosub 28250 : rem find label in symbol table
28370 if err then en = 11 : h = 0 : goto 28000
28380 goto 28492
28390 rem hex,octal or binary numbers evaluate
28400 t2 = t : gosub 28150
28410 if len(h$)=0 then 28450
28420 if t2=36 then 28470
28430 if t2=37 then base = 2 : goto 28470
28440 if t2=38 then base = 8 : goto 28470
28450 rem invalid label
28460 h = 0 : en = 6 : goto 28000
28470 rem test if valid number
28475 gosub 11950
28480 base = 16 : rem default base
28490 if err then h = 0 : en = 7 : goto 28000
28492 ptr = ptr-1 : gosub 28150 : rem get next operator
28495 return
28500 rem******************************
28501 rem evaluate term with * or /
28502 rem******************************
28510 gosub 28300 : term = h
28520 if ptr>len(in$) then return
28530 if t=42 then gosub 28300 : term = int(term*h) : goto 28520
28550 if t<>47 then return
28560 gosub 28300
28570 if h=0 then term = 0 : en = 15 : goto 28000
28580 term = int(term/h)
28590 goto 28520
28600 rem******************************
28601 rem evaluate expression
28602 rem******************************
28605 err = false
28610 gosub 28500 : result = term
28620 ift=-1or t=32 or t=58 or t=59 or t=41 or t=46 or ptr>len(in$) then return
28630 if t=43 then gosub 28500 : result = int(result+term) : goto 28620
28640 if t=45 then gosub 28500 : result = int(result-term) : goto 28620
28650 result = 0 : en = 4 : goto 28000
28700 rem******************************
28701 rem add symbol to symbol table
28702 rem******************************
28710 if se>=sm then exit = true : pass = 2 : en = 14 : goto 28000
28720 gosub 28250 : if not err then 28830
28740 t$ = left$(h$+"       ",6)
28745 tb = ptr
28750 gosub 28150 : rem does = follow
28760 if t<>61 then ptr = tb : re = ad : goto 28780
28770 t0 = t : gosub 28600
28780 en = 0
28790 if re<0 or re>65535 then st$(se)=t$+chr$(0)+chr$(0)+chr$(2) : goto 28810
28800 st$(se) = t$+chr$(re-int(re/256)*256)+chr$(int(re/256))
28810 se = se+1
28820 return
28830 if pass=1 and len(st$(t1))<9 then st$(t1) = st$(t1)+chr$(8)
28835 if pass<>2 then 28840
28836 ta = ptr : gosub 28150 : if t<>61 then ptr = ta : goto 28840
28837 gosub 26000 : rem scan past = sign (if present) on pass 2
28840 if pass<>2 or len(st$(t1))<9 then return
28845 en = asc(mid$(st$(t1),9,1)) : goto 28000
28850 rem******************************
28851 rem test for opcode/directive
28852 rem******************************
28860 gosub 28150
28870 err = false
28890 ptr = ptr-1
28895 if len(h$)<>3 then 28940
28900 po = -2
28910 po = po+3
28920 if h$=mid$(ta$(2),po,3) then 28950
28930 if (po+3)<=len(ta$(2)) then 28910
28940 err = true
28950 po = (po-1)/3
28960 err = (po=56) or err
28970 if po>56 then po = po-1
28980 return
63800 rem checksum program
63801 gosub 63810
63802 gosub 63840
63803 if fl>=0 then 63802
63804 end
63810 deffn deek(x) = peek(x)+256*peek(x+1)
63820 rem data for machine code
63821 data ***
63822 data 165,076,166,077,133,212,134,213,032,225
63823 data 200,216,160,001,177,193,133,078,240,013
63824 data 200,177,193,133,076,200,177,193,133,077
63825 data 200,169,000,133,075,177,193,240,006,024
63826 data 101,075,200,208,244,096
63827 data -1
63830 rem put data into memory
63831 ad = 1024
63832 restore
63833 read t$: if t$<>"***" then 63833
63834 read t : if t>=0 then poke ad,t : ad = ad+1 : goto 63834
63835 dev = 3 : in$ = "" : input "output device number "; dev
63836 if dev=1 or dev>4 then input "file name ";in$
63837 r$ = chr$(13) : s$ = "***************************************"+r$
63838 return
63840 rem do initalisation
63841 fl = 0 : input "first line "; fl : if fl<0 then return
63842 ll = 65536 : input "last line "; ll
63843 input "module name ";m$
63844 open 1,dev,2,in$
63845 print#1,s$ r$spc((40-len(m$))/2)m$r$ r$"line numbers"fl"to"ll;r$s$r$
63850 rem actual program
63851 ln = fl : c = 0 : c1 = 0
63852 poke 76,ln-int(ln/256)*256 : poke 77,ln/256
63853 sys 1024 : cs = peek(75) : ln = fndeek(76)+1
63860 rem format output into 3 columns
63861 t$ = left$(str$(ln-1)+"      ",6)+left$(str$(cs)+"       ",7)
63862 print#1,t$;
63864 c = c+1 : if c>=3 then print#1 : c = 0 : c1 = c1 + 1
63865 if c1>=20 and dev=3 then c1 = 0 : gosub 63898
63866 if ln<=ll and peek(78) then 63852
63867 close 1 : return
63898 get t$ : if t$="" then 63898
63899 return

