

;alpax16.prg ==0801==
  100 rem ************ alpa ***********
  110 rem *   p. rosham, 12/4/1984    *
  111 rem *       e danny davis       *
  112 rem *                           *
  115 rem *     assembly language     *
  116 rem *      programming aid      *
  118 rem *                           *
  120 rem *****************************
  150 goto9000
 1000 rem
 1010 rem process line
 1020 rem
 1030 f=0:fm=0:er=0
 1040 for j=p1 to p2
 1050 if c$(j,1)="  " then 1110
 1053 co$=c$(j,1):ifc$(j,2)<>"  "then co$=co$+c$(j,2)
 1054 ifc$(j,3)<>"  "then co$=co$+c$(j,3)
 1055 gosub30000
 1056 if er>0 then 1110
 1061 if j<100 thenprint" ";
 1062 if j<10 thenprint" ";
 1069 printj;": ";
 1070 if left$(c$(j,2),1)="l"then1075
 1071 goto1080
 1075 printc$(j,1)+" "+c$(j,2)+c$(j,3);" ";:goto1090
 1080 printc$(j,1);" ";c$(j,2);" ";c$(j,3);
 1090 f=f+1
 1095 printspc(8);di$
 1100 if f=22 thengoto1120
 1110 nextj
 1120 return
 2000 rem
 2010 rem routine principale
 2020 a$="":input"command or line(###) : ";a$
 2040 if left$(a$,1)>"9"goto3000
 2042 print"{up}";:for i=1 to36:print" ";:nexti:printchr$(13);"{up}";
 2045 if left$(a$,1)<"0"goto2020
 2050 k$="":fork=1to4
 2060 ifmid$(a$,k,1)=" "goto2090
 2065 if mid$(a$,k,1)="" then a$="         ":j=val(k$):n=j:goto2170
 2067 if mid$(a$,k,1)>"9"ormid$(a$,k,1)<"0" then print"invalid line #":goto 2020
 2070 k$=k$+mid$(a$,k,1)
 2080 nextk
 2090 if k=5 or val(k$)=ze or val(k$)>ln goto2020
 2100 j=val(k$):n=j
 2110 a$=right$(a$,(len(a$)-k))
 2120 let k$=""
 2130 for k=1 to len(a$)
 2140 if mid$(a$,k,1)<>" "thenk$=k$+mid$(a$,k,1)
 2150 nextk
 2160 a$=k$
 2162 if left$(a$,1)="l"thengoto2020
 2170 fori=1to5step2
 2180 k=int(i/2+1)
 2190 c$(j,k)=mid$(a$,i,2)
 2195 c$(j,k)=left$(c$(j,k)+"  ",2)
 2200 nexti
 2210 ifc$(n,oe)="  "then2250
 2220 ifn<tpthentp=n
 2230 ifn>bpthenbp=n
 2240 goto2320
 2250 if n<>bpgoto2280
 2260 ifbp=1 or c$(bp,1)<>"  "goto2320
 2270 bp=bp-oe:goto2260
 2280 if n<>tpgoto2320
 2290 ifc$(tp,oe)<>"  "thengoto2320
 2300 iftp<>bpandtp<>lnthentp=tp+oe:goto2290
 2310 tp=oe
 2320 pp=n
 2330 ifn<tpthenpp=tp:goto2380
 2340 nu=ze
 2350 ifpp=tpornu=0thengoto2380
 2360 ifc$(pp,oe)<>"  "thennu=nu+oe
 2370 pp=pp-oe:goto2350
 2380 p1=pp:p2=pp
 2385 ifc$(n,1)="  "then2020
 2390 gosub1000
 2391 if er=1 then print"illegal op-code"
 2392 if er=2 then print"invalid op-code"
 2393 if er=3 then print"invalid length operand"
 2394 if er=4 then print"illegal operand"
 2400 goto2020
 2590 rem ****** watch/nowatch
 2600 input"watch what address : ";qz$:xq$=right$(("0000"+qz$),4)
 2610 gosub15000:ifer=1then2600
 2620 wq=xq:wq$=xq$:goto2020
 2630 ifwa<>1then2640
 2635 print"address ";wq$;"=  <before> $";:et=peek(wq):gosub40000
 2636 printright$(hb$,2)
 2640 if peek(r)=0 thenprint"no program in memory":print:goto2645
 2641 sysr
 2645 ifwa<>1then2660
 2650 print"address ";wq$;"=  <after > $";:et=peek(wq):gosub40000
 2655 printright$(hb$,2)
 2660 goto2020
 2700 rem ********** dump memory
 2710 dc$="0000"
 2720 input"dump from what address ";dm$
 2730 xq$=right$((dc$+dm$),4):gosub15000:if er=1 then2720
 2740 dm=xq
 2750 print"{clr}dumping from address $";xq$
 2755 g=dm
 2760 formm=gto(g+176)step8:f$=""
 2765 et=mm:gosub40000:printhb$;" : ";
 2770 formw=0to7:mq(mw)=peek(mm+mw)
 2775 a=mq(mw):ifa<32ora>127ora>159thenf$=f$+chr$(32):goto2780
 2776 f$=f$+chr$(a)
 2780 h=int(mq(mw)/16):l=mq(mw)-16*h
 2785 printmid$(d$,h+1,1)+mid$(d$,l+1,1);
 2789 nextmw:printspc(8);f$
 2790 nextmm
 2795 getk$:ifk$=""then2795
 2800 ifk$<>"m"theng=mm:goto2760
 2810 goto2020
 3000 rem
 3005 ifa$="" goto2020
 3010 rem ******** comandi
 3020 k$=left$(a$,tw)
 3030 ifk$="en"then5000
 3040 ifk$="qu"thenstop
 3044 ifk$="wa"thenwa=1:goto2600
 3046 ifk$="nw"thenwa=0:goto2020
 3050 ifk$="li"then4000
 3060 ifk$="lo"then7000
 3070 ifk$="me"then6000
 3080 ifk$="ne"thenrun
 3090 ifk$="ru"thengoto2630
 3100 ifk$="sa"then8000
 3110 ifk$="ch"then9150
 3115 ifk$="du"then2700
 3119 print"invalid command "
 3120 goto2000
 4000 rem
 4010 rem ******* routine list
 4020 p1=tp:p2=bp
 4025 iflen(a$)<5then4040
 4030 n1=asc(mid$(a$,6,1))
 4040 iflen(a$)>fr and n1>47 and n1<58 then p1=val(mid$(a$,5,3))
 4045 print"{clr}"
 4050 gosub1000
 4060 goto2020
 5000 rem
 5010 rem ******* routine enter
 5020 g=r:print"entering at address $";:et=g:gosub40000:printhb$
 5040 forj=tptobp
 5050 ifc$(j,oe)="  "thengoto5470
 5060 ifmid$(c$(j,tw),1,1)<>"l"then5380
 5070 poke g,ze:pokeg+oe,ze:pokeg+tw,ze:pokeg+tr,ze
 5080 j1=val(mid$(c$(j,tw),tw,1)+c$(j,tr))
 5090 ifleft$(c$(j,2),1)="l"thenprintj;" : ";c$(j,1)+" "+c$(j,2)+c$(j,3):goto5100
 5095 printj;" : ";c$(j,1);" ";c$(j,2);c$(j,3)
 5100 ifj1<zeorj1>lnthen5460
 5110 jj$=c$(j,1):gosub20000:cj=jj
 5120 ifleft$(c$(j,2),1)<>"l"then5125
 5121 printj1;" : ";c$(j1,1)+" "+c$(j1,2)+c$(j1,3):goto5130
 5125 printj1;" : ";c$(j1,1);" ";c$(j1,2);" ";c$(j1,3)
 5130 if abs(cj)<>oethengoto5460
 5140 dd=(j1<j)-(j1>j)
 5150 ja=g:dp=ze
 5160 ifj1=jthengoto5270
 5170 cl=j+dd
 5180 n1=ze:ifc$(cl,oe)="  "thengoto5220
 5190 ifleft$(c$(cl,2),1)="l"goto5200
 5192 n1=oe-(c$(cl,tw)<>"  ")-(c$(cl,tr)<>"  "):goto5220
 5200 jj$=c$(cl,1):gosub20000:tj=jj
 5210 n1=((tj=oe)*tr+(tj=-oe)*tw)*-1
 5220 ifcl=j1anddd>0goto5270
 5230 dp=dp+n1
 5240 ifcl=j1thengoto5270
 5250 cl=cl+dd
 5260 goto5180
 5270 ifcj=1thenja=ja+dd*dp+(dd>0)*-3:goto5310
 5280 ifdd>zethendp=dp+2
 5290 ifdp>126anddd<zethengoto5460
 5300 ifdp>129anddd>zethengoto5460
 5310 xq$=mid$(c$(j,1),1,2):gosub10000:v=xq
 5320 pokeg,v:g=g+oe
 5330 ifcj=oe thenpoke g,ja-int(ja/qk)*qk:g=g+oe:pokeg,int(ja/qk):g=g+oe:goto5360
 5340 ifdd<zethendp=256-dp
 5345 ifdp=0thendp=256
 5350 dp=dp-tw:pokeg,dp:g=g+1
 5360 print"ok"
 5370 goto5470
 5380 fori=1to5step2
 5390 k=int(i/tw+oe)
 5400 xq$=mid$(c$(j,k),1,2):gosub10000:v=xq
 5410 ifer=1orv=-1thengoto5440
 5420 pokeg,v
 5430 g=g+oe
 5440 nexti
 5450 goto5470
 5460 print"** error-branch out of range **"
 5470 nextj
 5480 goto2020
 6000 co$=""
 6010 rem ******* disassembler
 6020 dc$="0000"
 6030 input "disassemble from what address ";dm$
 6035 xq$=right$((dc$+dm$),4):gosub15000:if er=1 then6030
 6038 dm=xq
 6039 print"{clr}disassembling from address $";xq$
 6040 g=dm:f=0:fm=0
 6050 f=f+1:co$=""
 6060 fori=1to3
 6070 v(i)=peek(g):h=int(v(i)/16):l=v(i)-16*h
 6080 r$(i)=mid$(d$,h+1,1)+mid$(d$,l+1,1)
 6090 g=g+1:nexti
 6100 fori=1topc(v(1)+1):co$=co$+r$(i):nexti
 6110 gosub30000
 6115 et=dm:gosub40000:printhb$;": ";
 6117 fori=1topc(y)
 6120 printr$(i);" ";
 6130 nexti
 6134 ww=15-(len(co$)+pc(y)):printspc(ww);di$
 6138 g=(g-3)+pc(y):dm=g
 6140 if f<>22thengoto6050
 6150 getk$:ifk$=""then6150
 6160 ifk$<>"m"thenf=ze:goto6050
 6200 goto2020
 7000 rem
 7010 rem ******* load
 7020 print"{clr}"
 7030 print"load program"
 7035 input"input filename";n$
 7037 ifn$=""then7035
 7040 open1,dev,0,n$
 7041 t=0:ff=0
 7045 fori=1to200:cd$(i)="":j$(i)=""
 7046 t=t+1
 7047 get#1,i$(i)
 7048 ifi$(i)=chr$(13)thenff=0:goto7058
 7049 ifi$(i)=","thenff=1:goto7047
 7050 if ff=1 goto 7057
 7051 if i$(i)>chr$(47) andi$(i)<chr$(58) and ff=0 thenj$(i)=j$(i)+i$(i):goto7047
 7054 ifi$(i)="*"then7059
 7055 ifi$(i)=" "then7047
 7057 cd$(i)=cd$(i)+i$(i):goto7047
 7058 nexti
 7059 close1
 7060 fori=1tot-1
 7061 x(i)=val(j$(i)):y=1
 7062 forj=1to3
 7063 c$(x(i),j)=mid$(cd$(i),y,2)
 7066 c$(x(i),j)=left$(c$(x(i),j)+"  ",2)
 7067 y=y+2
 7068 nextj:nexti
 7069 fori=1to200
 7070 tp=i
 7080 ifc$(i,1)<>"  "then7100
 7090 nexti
 7100 fori=200to1 step-1
 7110 bp=i
 7120 ifc$(i,1)<>"  "then7140
 7130 nexti
 7140 goto2020
 8000 rem
 8010 rem ******* save
 8020 input"enter name : ";n$
 8030 ifn$=""then8020
 8035 r$=","
 8040 open1,dev,1,n$
 8050 fori=1to200
 8052 ifc$(i,1)="  "then8080
 8055 co$=c$(i,1)+c$(i,2)+c$(i,3)
 8060 print#1,i;r$co$
 8080 nexti
 8090 print#1,"*":close1
 8100 goto2020
 9000 rem
 9010 rem ******* initialization
 9020 ze=0:oe=1:tw=oe+oe:tr=oe+tw:fr=tw+tw:qk=256:mr=2020:ln=200
 9030 dima$(15),j$(200),x(200)
 9040 tp=ln:bp=oe:rem line buffer
 9050 dimc$(ln,tr),i$(1200)
 9055 dev=peek(658)
 9060 print"{cyn}{clr}            initializing"
 9070 fori=oetoln
 9080 forj=oetotr
 9090 c$(i,j)="  "
 9100 nextj
 9120 nexti
 9125 dim pc(256),ds$(256),r$(7),cd$(200),mq(176)
 9126 fora=1to256:readpc(a),ds$(a):nexta
 9130 d$="0123456789abcdef"
 9150 print"{clr}"
 9160 input "locate program at address : ";xq$:xq$=left$(xq$+"0000",4)
 9170 gosub15000:if er=1 or xq=0 then9160
 9175 r=xq:poker,0
 9180 print"{clr}"
 9185 et=r:gosub40000
 9190 print"program to be located at address $";hb$
 9191 goto2020
 9198 rem all spaces in data statements must be typed in
 9199 data1,brk,2,"ora ($  ,x)",1,???,1,???,1,???,2,ora $,2,asl $,1,???
 9200 data1,php,2,ora #$,1,as\ a,1,???,1,???,3,ora $,3,asl $,1,???
 9201 data2,"bpl "
 9202 data2,"ora ($  ),y",1,???,1,???,1,???,2,"ora $  ,x",2,"asl $  ,x"
 9203 data1,???,1,clc,3,"orc $    ,y",1,???,1,???,1,???,3,"ora $    ,x"
 9204 data3,"asl $    ,x",1,???,3,jsr ,2,"and ($  ,x)",1,???,1,???,2,"bit $"
 9205 data2,and $,2,rol $,1,???,1,plp,2,and #$,1,rol a,1,???,3,"bit $"
 9206 data3,and $,3,rol $,1,???,2,bmi $,2,"and ($  ),y"
 9207 data1,???,1,???,1,???,2,"and $  ,x"
 9208 data2,"rol $  ,x",1,???,1,sec,3,"and $    ,y",1,???,1,???,1,???
 9209 data3,"and $    ,x",3,"rol $    ,x",1,???,1,rti,2,"eor ($  ,x)",1,???
 9210 data1,???,1,???,2,eor $,2,lsr $,1,???,1,pha,2,eor #$,1,lsr a,1,???
 9211 data3,jmp ,3,eor$,3,lsr $,1,???,2,"bvc "
 9212 data2,"eor ($  ),y",1,???
 9213 data1,???,1,???,2,"eor $  ,x",2,"lsr $  ,x",1,???,1,cli,3,"eor $    ,y"
 9214 data1,???,1,???,1,???,3,"eor $    ,x",3,"lsr $    ,x",1,???,1,rts
 9215 data2,"adc ($  ,x)",1,???,1,???,1,???,2,adc $,2,ror $,1,???,1,pla
 9313 data2,adc #$,1,ror a,1,???,3,jmp (,3,adc $,3,ror $,1,???
 9314 data2,bvs ,2,"adc ($  ),y"
 9315 data1,???,1,???,1,???,2,"adc $  ,x",2,"ror $  ,x",1,???,1,"sei"
 9316 data3,"adc $    ,y",1,???,1,???,1,???,3,"adc $    ,x",3,"ror $    ,x"
 9317 data1,???,1,???,2,"sta ($  ,x)",1,???,1,???,2,sty $,2,sta $,2,"stx $"
 9318 data1,???,1,dey,1,???,1,txa,1,???,3,sty $,3,sta $,3,stx $,1,???
 9319 data2,bcc ,2,"sta ($  ,x)"
 9320 data1,???,1,???,2,"sty $  ,x",2,"sta $  ,x"
 9321 data2,"stx $  ,y",1,???,1,tya,3,"sta $    ,y"
 9322 data1,txs,1,???,1,???,3,"sta $    ,x",1,???,1,???,2,"ldy #$"
 9323 data2,"lda ($  ,x)",2,ldx #$,1,???,2,ldy $,2,lda $,2,ldx $,1,???
 9324 data1,tay,2,lda #$,1,tax,1,???,3,ldy $,3,lda $,3,ldx $,1,???
 9325 data2,bcs ,2,"lda ($  ),y",1,???,1,???,2,"ldy $  ,x",2,"lda $  ,x"
 9326 data2,"ldx $  ,y",1,???,1,clv,3,"lda $    ,y",1,tsx,1,???,3,"ldy $    ,x"
 9327 data3,"lda $    ,x",3,"ldx $    ,y",1,???,2,cpy #$,2,"cmp ($  ,x)"
 9329 data1,???,1,???,2,cpy $,2,cmp $,2,dec $,1,???,1,iny,2,cmp #$,1,dex
 9331 data1,???,3,cpy $,3,cmp $,3,dec $,1,???,2,"bne ",2,"cmp ($  ),y"
 9333 data1,???,1,???,1,???,2,"cmp $  ,x",2,"dec $  ,x",1,???,1,cld
 9335 data3,"cmp $    ,y",1,???,1,???,1,???,3,"cmp $    ,x",3,"dec $    ,x"
 9337 data1,???,2,cpx #$,2,"sbc ($  ,x)",1,???,1,???,2,cpx $,2,"sbc $"
 9339 data2,inc $,1,???,1,inx,2,sbc #$,1,nop,1,???,3,cpx $,3,"sbc $"
 9341 data3,inc $,1,???,2,beq ,2,"sbc ($  ),y",1,???,1,???,1,???
 9343 data2,"sbc $  ,x",2,"inc $  ,x",1,???,1,sed,3,"sbc $    ,y",1,???,1,???
 9345 data1,???,3,"sbc $    ,x",3,"inc $    ,x",1,???
10000 ifxq$=""thenxq=-1:er=1:return
10005 as=asc(left$(xq$,1))-48:ifas>22thener=1:return
10006 if as<10andas>-1thengoto10010
10007 as=as-7:ifas<10thener=1:return
10010 xq=asc(right$(xq$,1))-48:ifxq>22thener=1:return
10016 ifxq<10andxq>-1thengoto10020
10017 xq=xq-7:ifxq<10thener=1:return
10020 xq=xq+16*as:er=0:return
15000 qq$=left$(xq$,2):qw$=right$(xq$,2)
15005 xq$=qq$:gosub10005:qq=256*xq
15007 ifer=1thenreturn
15010 xq$=qw$:gosub10005
15020 xq=xq+qq:xq$=qq$+qw$
15030 return
20000 jj=(jj$="90")+(jj$="b0")+(jj$="f0")+(jj$="30")+(jj$="d0")+(jj$="10")
20010 jj=(jj+(jj$="50")+(jj$="70"))-((jj$="4c")+(jj$="6c")+(jj$="20"))
20020 return
30000 xq$=left$(co$,2):ifxq$="  "thendi$="":return
30001 fl=0:sh=0:er=0
30002 gosub10000:y=xq+1:xq=0
30003 gosub32000
30004 ifer=2andfm=1then30011
30005 ifer>0orxq=-1thenc$(j,1)="  ":return
30010 jj$=xq$:gosub20000
30011 ifpc(y)=1thendi$=ds$(y):return
30015 di$=left$(ds$(y),5)
30020 ifjj<>0then30140
30030 ifright$(di$,1)="("orright$(di$,1)="#"thendi$=di$+"$"
30040 ifpc(y)=2thendi$=di$+right$(co$,2)
30050 if pc(y)=3then30090
30060 if len(ds$(y))=9thendi$=di$+right$(ds$(y),2)
30070 if len(ds$(y))=11thendi$=di$+right$(ds$(y),3)
30080 return
30090 op$=right$(co$,2)+mid$(co$,3,2)
30100 if len(ds$(y))=5thendi$=di$+op$
30110 if len(ds$(y))=10thendi$=di$+op$+right$8ds$(y),1)
30120 if len(ds$(y))=11thendi$=di$+op$+right$(ds$(y),2)
30130 return
30140 op$=right$(co$,2)+mid$(co$,3,2)
30150 ifmid$(co$,3,1)="l"thendi$=ds$(y)+right$(co$,(len(co$)-2)):sh=1
30157 ifjj=1andfm=1thendi$=di$+op$
30170 ifjj=1andfm=0andsh=0andlen(ds$(y))=4thendi$=di$+op$
30175 ifjj=1 and fm=0 and sh=0 and len(ds$(y))=5 then di$=ds$(y)+op$+")"
30180 ifjj<>-1orfm<>1thenreturn
30190 xq$=right$(co$,2):gosub10000:zz=(g-3)+pc(y)
30200 ifxq>127thenxq=-1*(256-xq)
30210 et=zz+xq:gosub40000
30220 di$=di$+hb$:return
32000 ifer=1goto32090
32010 ifds$(y)="???"thener=2:goto32090
32020 iflen(co$)<>pc(y)*2andmid$(co$,3,1)<>"l"thener=3:goto32090
32030 forfi=2 to len(co$)
32040 ifmid$(co$,3,1)="l"then32080
32050 ifmid$(co$,fi,1)<chr$(48)thener=4
32060 ifmid$(co$,fi,1)>chr$(57)and mid$(co$,fi,1)<chr$(65)thener=4
32070 if mid$(co$,fi,1)>chr$(70)thener=4
32080 nextfi
32090 return
40000 hb$="":ifet>65535thenet=et-65536:goto40000
40003 forrr=3to0step-1
40005 rt=int(et/(16^rr))
40010 et=et-rt*16^rr:rt=(rt+48)-7*(rt>9)
40015 hb$=hb$+chr$(rt):nextrr
40020 return
60000 rem **********chexsum
60010 rem warning proof read this section
60020 rem carefully
62000 t=peek(62)*256+peek(61)+1
62010 input"to printer (y or n ) ";q$
62011 if q$<>"y" then 62020
62015 close4,4:open4,4:cmd4:printchr$(1);chr$(129)
62020 printchr$(147);"check sum :-":link=peek(44)*256+peek(43):e=62000
62100 rem****main loop
62120 t=link
62130 link=peek(t+1)*256+peek(t)
62135 ln=peek(t+3)*256+peek(t+2)
62136 if ln>e then print:print"total=";ch:close4,4:end
62137 s$=str$(ln):l=len(s$)-1:s$=mid$(s$,2,l)
62138 printspc(6-l);s$;
62140 cs=0:n=0:c=0
62150 forp=t+4 to link-2:pk=peek(p)
62160 if pk=143 then p=link-2:goto62190
62165 if pk=34 thenc=(c=0)
62170 if c=0 and pk=32 then 62190
62180 if pk=137 thenn=n+1:cs=cs+(203orn):pk=164
62185 n=n+1:cs=cs+(pkorn)
62190 nextp:ch=ch+cs:print"=";right$(str$(cs),len(str$(cs))-1):goto62120
62999 rem

