

;basicloader.prg ==0801==
    0 rem123456789012345678901234567890123456789012345678901234567890123
    1 rem1234567890123456789012345678901234567890123456789012345678901234567890
    2 rem1234567890123456789012345678901234567890123456789012345678901234567890
    3 rem1234567890123456789012345678901234567890123456789012345678901234567890
   20 dev = 8
  100 rem basic extender routine
  110 rem move basic rom into ram at $a000 - $bfff
  120 data 165,1,41,254,133,1,96,160,255,200,32,32,8,190,1,1,32,6,8,138,153,1,1
  130 data 200,208,240,165,1,9,1,133,1,96,32,6,8,24,162,255,232,160,255,200,185
  135 data 75,8,133,20,185,151,8,48,01,96,133,21,185,227,8,129,20,144,235
  139 data 0
  140 ad = 2054
  150 read a : if a<>0 then poke ad,a : ad = ad+1 : goto 150
  155 rem load machine code from tape/disc
  156 input " file name "; in$ : if dev=8 then in$ = in$+",s,r"
  157 open 2,dev,0,in$ : input# 2,sa,ea : for x = sa to ea : input# 2,t : poke x,t
  158 next x : close 2
  160 rem do actual move
  165 poke 2068,0 : poke 2075,0
  170 for x = 160 to 191
  190 poke 2069,x : poke 2076,x
  200 sys 2061
  210 next
  220 poke 2068,1 : poke 2075,1
  221 rem data for rom excute alteration
  223 x = 0 : data 225,167,76,226,167,105,227,167,192
  224 data 173,175,76,174,175,74,175,175,196
  227 data 0
  228 read t1 : if t1=0 then 230
  229 read t2,t3 : poke 2123+x,t1:poke 2199+x,t2:poke 2275+x,t3:x=x+1:goto 228
  230 sys 2087 : rem alter rom
  231 rem alter crunch tokens routine
  232 poke 42500,76 : poke 42501,194 : poke 42502,192
  240 rem alter print token routine
  241 poke 774,150 : poke 775,192
  300 end

