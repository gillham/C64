%'�****************************** B$'� GENERAL INITIALISATION f.'�****************************** t/'BASE � 16 �0'� �(PTR$)��(E$)��255 � � : � 19000 �3'DEV � 1 �8'�� HEX(X) � (X � 15)�48�((X � 15)�9)�7 �B'�� DEC(X) � X�48�(X�57)�7 
	L'FALSE � 0 : TRUE � �1 %	V'� 53281,1 : � 53280,15 I	t'�****************************** k	u'� CONTROL ROUTINE FOR MONITOR �	v'�****************************** �	~'� EXIT TO BASIC,MEMORY MODIFY,MEMORY DUMP,MACHINE CODE EXCUTE 
'� LOAD MACHINE CODE FILE,SAVE MACHINE CODE FILE 
�'� DISASSEMBLER *
�'� FILE EDITOR :
�'� ASSEMBLER D
�'� END J
�'� T
�'X � 0 �
�'� "��--------- MACHINE CODE MONITOR ---------�" �

(� T$ �
(� T$��"END" � � �5) X ")" T$ : X� X�1 : � 10250 �
(� X�15 � � Y � X � 15 : � : � (� "COMMAND ( 0 -" X�1 " ) : ";: � T (<(� T�0 � T�X � 10100 bA(� T�0 � � "�                  BYE�" : � 1: � �F(� T � 13100,13300,13500,14300,14100,15800,24800,20000 �P(� 10100 ��*�****************************** ��*� CONVERT DECIMAL TO HEX �*�****************************** !+T � H : H$ � "" a+H$ � �(�HEX(T��(T�16)�16))�H$ : T � �(T�16) : � T�0 � 11020 g*+� �\+�****************************** �]+� BYTE INTO HEX �^+�****************************** �f+H � �(AD) : AD � AD�1 �p+� 11000 z+� �(H$)�2 � H$ � "0"�H$ �+O2$ � O2$�H$ �+� @�+�****************************** [�+� INPUT FINISH ADDRESS �+�****************************** ��+H$ � "" ��+� "FINISH ADDRESS ( IN HEX) : "; H$ : � 11950 ��+� ERR � H�0 � H�65535 � 11200 ��+EA � H : � �+�****************************** (�+� INPUT FILE NAME F�+� 25500 : � DEV�4 � 11290 S�+IN$ � "" {�+� " FILE NAME : "; IN$ : T � �(IN$) �,� T�16 � T�0 � � "FILE NAME INVALID" : � 11260 �,� �J.�****************************** �K.� ASK CONTINUE ? L.�****************************** R.T$ � "" >T.� "CONTINUE ( Y/N ) : "; T$ a^.� T$�"Y" � CO � TRUE : � 11895 �h.� T$��"N" � � "�"; : � 11850 �r.CO � FALSE �w.� ��.�****************************** ��.� CONVERT HEX IN H$ TO DEC IN H �.�****************************** /�.ERR � FALSE : H � 0 : � �(H$)�0 � 12030 C�.� X � 1 � �(H$) l�.T � �DEC(�(�(H$,X,1))): H � H�BASE�T ��.� T�BASE�1 � T�0 � ERR � TRUE ��.� X ��.� �/�****************************** �/� INPUT START ADDRESS �/�****************************** 
/H$ � "" ;/� "START ADDRESS ( IN HEX ) : "; H$ : �11950 ]0/� ERR � H�0 � H�65535 � 12060 l:/AD � H : � ��/�****************************** ��/� HEX LOADER ��/�****************************** ��/T1$ � "" ��/� X1 � 1 � �(T$) � 2 )�/T1$ � T1$��(�DEC(�(�(T$,X1,1)))�16��DEC(�(�(T$,X1�1,1)))) 2�/� X1 8�/� \�2�****************************** m�2� GET 1 BYTE ��2�****************************** ��2H$ � "" ��2� "BYTE ( IN HEX ) : "; H$ ��2� 11950 ��2� ERR � H�0 � H�255 � � "�" : � 13000 ��2� ,3�****************************** 0-3� MEMORY MODIFY T.3�****************************** `63� 12050 �@3H � AD : � 11000 : � H$ �6) "/" ; : O2$ � "" �T3� 11100 : AD � AD�1 : � H$ �6) ; �^3T$ � "" �h3� " +,-,I,E : "; T$ r3� T$�"+" � AD�65535 � AD � AD�1 : � 13120 2|3� T$�"-" � AD�0 � AD � AD�1 : � 13120 C�3� T$�"E" � � c�3� T$��"I" � �"��" : � 13120 ��3� 13000 : � AD,H : � 13120 ��3�****************************** ��3� DUMP MEMORY TO SCREEN ��3�****************************** ��3� 12050 4� "�" : � X1 � 1 � 18 : H � AD : � 11000 B4O2$ � "" : O1$ � H$ : O3$ � "" S&4� X2 � 0 � 7 o04� 11100 : O2$ � O2$�" " �?4� H�31 � H�95 � O3$ � O3$��(H) : � 13380 �A4O3$ � O3$�"." �D4� X2 �N4� O1$ �5) O2$ �31) O3$ �X4� X1 �b4� : � 11850 : � CO � 13320  �4� $�4�****************************** ?�4� MACHINE CODE EXECUTE c�4�****************************** z�4� 12050 : � AD : � �7�****************************** �7� MACHINE CODE SAVE �7�****************************** �7� 11250 : � 12050 : � 11200 >#7T$ � "N" : � DEV�8 � � "OVERWRITE EXISTING FILE ( Y/N ) : "; T$ ]$7� T$�"Y" � IN$ � "@0:"�IN$ |(7� DEV�8 � IN$ � IN$�",S,W" �-7� SA�EA � 14190 �27� 2,DEV,2,IN$ : � 2,AD : � 2,EA �F7� X � AD � EA : � 2,�(X) : � : � 2 : � 2 �n7� �7�****************************** #�7� MACHINE CODE LOAD G�7�****************************** p�7� 11250 : � DEV�8 � IN$ � IN$�",S,R" ��7� 2,DEV,0,IN$ : � 2,SA,EA : � ST � � 2 : � �8� X � SA � EA : � 2,T : � X,T : � : � 2 : � ��;�****************************** �;� ADD OPERAND IN OP TO O1$ 6�;�****************************** [�;� OP�1 � 15450,15500,15550,15600 ~�;� OP�6 � OP�10 � O1$ � O1$�"(" ��;� 11100 ��;O1$ � O1$�"$" : T$ � H$ � <� OP�9 � 15390 �
<� 11100 �<O1$ � O1$�H$ �<O1$ � O1$�T$ 	(<� OP�9 � OP�8 � O1$ � O1$�")" /2<� OP��(OP�3)�3�1 � O1$ � O1$�",X" U<<� OP��(OP�3)�3�2 � O1$ � O1$�",Y" pF<� OP�7 � O1$ � O1$�")" vP<� �Z<�****************************** �[<� ACCUMULAT0R (OP=0) �\<�****************************** �d<O1$ � O1$�"A" ��<� IMPLIED (OP=1) �<� (�<�****************************** ?�<� IMMEDIATE (OP=2) c�<�****************************** o�<� 11100 ��<O1$ � O1$�"#$"�H$ ��<� ��<�****************************** ��<� RELATIVE (OP=3) ��<�****************************** ��<� 11100 =� H�127 � H � H�256 =H � H�AD &=� 11000 ;"=O1$ � O1$�"$"�H$ A,=� eT=�****************************** �U=� DISASSEMBLE INSTRUCTION �V=�****************************** �^=O2$ � "" �c=� 11100 : H � H�1 �h=� H�255 � H � 3 �r=T � �(�(TA$(0),H,1)) �=O1$ � �(TA$(2),T�3�1,3)�" " :�=OP � �(�(TA$(1),�((H�1)�2),1)) X�=� (H � 1) �1 � OP � OP�16 i�=OP � OP � 15 o�=� ��=�****************************** ��=� DISASSEMBLE MEMORY AREA ��=�****************************** ��=� 12050 ��=� "�" : � I � 1 � 20 �=H � AD : � 11000 : � H$ �6) ; 2�=� 15700 : � 15300 E�=� O2$ �14) O1$ M�=� I S�=� _�=� 11850 p>� CO � 15820 v>� �8J�****************************** �9J� INITALISE DECODER TABLES �:J�****************************** �=JBASE � 16 	?J�� DEC(X) � X�48�(X�57)�7 BJ� TA$(4) ECJT$ �    "0A223838382202382422023838220238" tDJT$ � T$�"09223838382202380D22383838220238" �EJT$ � T$�"1C013838060127382601273806012738" �FJT$ � T$�"07013838380127382C01383838012738"  GJT$ � T$�"2917383838172038231720381B172038" 0 HJT$ � T$�"0B173838381720380F17383838172038" _ IJT$ � T$�"2A00383838002838250028381B002838" z JJ� 12200 : TA$(0) � T1$ � KJT$ �    "0C003838380028382E00383838002838" � LJT$ � T$�"382F3838312F303816383538312F3038" !MJT$ � T$�"032F3838312F3038372F3638382F3838" 6!NJT$ � T$�"1F1D1E381F1D1E38331D32381F1D1E38" e!OJT$ � T$�"041D38381F1D1E38101D34381F1D1E38" �!PJT$ � T$�"13113838131114381A11153813111438" �!QJT$ � T$�"08113838381114380E11383838111438" �!RJ� 12200 : TA$(0) � TA$(0)�T1$ "SJT$ �    "122B3838122B1838192B2138122B1838" A"TJT$ � T$�"052B3838382B18382D2B3838382B18" c"UJ� 12200 : TA$(0) � TA$(0)�T1$ �"VJT$ �    "1711166112011CC1381114411B111AA1" �"WJT$ � T$�"C71166611201CCC1381114411B111AA1" �"XJT$ � T$�"171116611201CCC1381114411B111AA1" #YJT$ � T$�"1711166112019CC1381114411B111AA1" N#ZJT$ � T$�"171166611111CCC1381144511B111A11" }#[JT$ � T$�"272166611211CCC1381144511B11AAB1" �#\JT$ � T$�"271166611211CCC1381114411B111AA1" �#]JT$ � T$�"271166611211CCC1381114411B111A" �#^J� 12200 : TA$(1) � T1$��(160) 9$`JTA$(2) �        "ADCANDASLBCCBCSBEQBITBMIBNEBPLBRKBVCBVS" w$aJTA$(2) � TA$(2)�"CLCCLDCLICLVCMPCPXCPYDECDEXDEYEORINCINX" �$bJTA$(2) � TA$(2)�"INYJMPJSRLDALDXLDYLSRNOPORAPHAPHPPLAPLP" �$cJTA$(2) � TA$(2)�"ROLRORRTIRTSSBCSECSEDSEISTASTXSTYTAXTAY" %dJTA$(2) � TA$(2)�"TSXTXATXSTYA???" E%fJTA$(2) � TA$(2)�"BYTWRDDBYENDORGPRTSYM" t%gJT$ �    "61210690B0F02430D01000507018D858" �%hJT$ � T$�"B8CDECCCCECA884DEEE8C84C20ADAEAC" �%iJT$ � T$�"4AEA0D480868282A6A4060ED38F8788D" �%jJT$ � T$�"8E8CAAA8BA8A9A98" &kJ� 12200 : TA$(3) � T1$ ;&lJT$ �    "FF11FFFFFF090AFFFF1D0EFFFF051EFF" j&mJT$ � T$�"FF15FFFFFFFFFFFFFF01FFFFFF1916FF" �&nJT$ � T$�"FF2DFFFF2C293EFFFF3D2EFFFF2526FF" �&oJT$ � T$�"FF35FFFFFFFFFFFFFF31FFFFFF3936FF" �&pJT$ � T$�"FF51FFFFFF495EFFFF5D4EFF6C4546FF" &'qJT$ � T$�"FF55FFFFFFFFFFFFFF41FFFFFF5956FF" U'rJT$ � T$�"FF6DFFFFFF697EFFFF7D6EFFFF6566FF" p'sJ� 12200 : TA$(4) � T1$ �'tJT$ �    "FF75FFFFFFFFFFFFFF71FFFFFF7976FF" �'uJT$ � T$�"FF91FFFF949D96FFFFFFFFFF848586FF" �'vJT$ � T$�"FF95FFFFFFFFFFFFFF81FFFFFF99FFFF" ,(wJT$ � T$�"BCB1BEFFA0A9A2FFFFBDFFAFA4A5A6FF" [(xJT$ � T$�"FFB5FFFFFFFFFFFFFFA1FFFFB4B9B6FF" �(yJT$ � T$�"FFD1FFFFC0C9DEFFFFDDFFFFC4C5C6FF" �(zJT$ � T$�"FFD5FFFFFFFFFFFFFFC1FFFFFFD9D6FF" �({J� 12200 : TA$(4) � TA$(4)�T1$ 
)|JT$ �    "FFF1FFFFE0E9FEFFFFFDFFFFE4E5E6FF" 7)}JT$ � T$�"FFF5FFFFFFFFFFFFFFE1FFFFFFF9F6" Y)~J� 12200 : TA$(4) � TA$(4)�T1$ ~)�JSM � 50 : SE � 0 : � STABLE$(SM) �)�J� ERR$(18) �)�JERR$(1) � "SINGLE BYTE OUT OF RANGE" �)�JERR$(2) � "DOUBLE BYTE OUT OF RANGE" *�JERR$(3) � "INVALID OPRAND OR OPCODE" )*�JERR$(4) � "INVALID OPERATOR" M*�JERR$(5) � "INDEX IS NOT X OR Y" u*�JERR$(6) � "LABEL NOT ALPHA-NUMERIC" �*�JERR$(7) � "INCORRECT NUMBER BASE" �*�JERR$(8) � "LABEL DEFINED TWICE" �*�JERR$(10) � "BRANCH OUT OF RANGE" +�JERR$(11) � "UNDEFINED LABEL" 0+�JERR$(12) � "ONLY SINGLE CHR. EXPECTED" U+�JERR$(14) � "OUT OF SYMBOL SPACE" w+�JERR$(15) � "DIVISION BY ZERO" �+�JERR$(18) � "ADDRESSING MODE NOT AVAILBLE WITH THIS OPCODE" �+N� FI$(254) : � 24300 �+N� �+ N�****************************** ,!N� GENERATE ASSEMBLY LISTING =,"N�****************************** f,%NSE � 0 : FMAX � �(PTR$) : SY � FALSE �,*N� " ERROR ONLY LISTING ( Y/N ) :"; T$ �,4NEO � �(T$,1)�"Y" �,9N� " ASSEMBLE TO MEMORY ( Y/N ) :"; T$ �,=NAM � �(T$,1)�"Y" ->NAD � 0 : � SET START ADDRESS -HN� Q � 1 � FMAX B-RNIN$ � FILE$(�(�(PTR$,Q,1))) : O$ � "" N-\N� 26400 d-fN� EXIT � Q�FMAX�1 l-pN� Q y-uNT � �(X) �-zNAD � 0 : EC � 0 : � "ADD.  DATA     SOURCE CODE" �-�N� Q � 1 � FMAX �-�NIN$ � FILE$(�(�(PTR$,Q,1))) : O$ � "" �-�NQ1 � AD .�N� 27600 .�N� ERR � 20250 &.�N� EO � 20222 ;.�NH � Q1 : � 11000 G.�NQ$ � H$ l.�NQ2 � 3 : � �(O$)�Q2 � Q2 � �(O$) �.�NQ1$ �"" : � O$�"" � 20221 �.�N� Q3 � 1 � Q2 �.�NH � �(�(O$,Q3,1)) : � 11000 �.�N� �(H$)�1 � H$ � "0"�H$ �.�NQ1$ � Q1$�H$ : � Q3 /�N� Q$ �6��(Q$)) Q1$ �8��(Q1$)) ; : � 28100 9/�N� � AM � O$�"" � 20250 i/O� X � 1 � �(O$) : � Q1�X�1,�(�(O$,X,1)) : � �/O� EXIT � Q � FMAX�1 : � LEAVE LOOP �/$O� Q �/.O� : � " TOTAL ERRORS IN FILE ---" EC : � �/8O� SY � � 26900 �/BO� �(650) �� 0 � �2 : �2 : � 20300 0GO� T$ : � T$�"" � 20295 0LO� C0�Y�****************************** U0�Y� FILE EDITOR y0�Y�****************************** �0�Y� FILE EDITOR �0�Y� FIND LINE NUMBER IN 'LN' IN FILE �0�YT � �(PTR$)�1 : T2 � �1 �0 ZT � T�1 : � T��0 � � 23080 1
ZT1 � �(�(PTR$,T,1)) 61ZT2 � �(�(FI$(T1),1,1))�256��(�(FI$(T1),2,1)) J1Z� T2�LN � 23040 o1(ZERR � �(T2�LN) : � ERR � T � T�1 u12Z� �1<Z�****************************** �1=Z� ADD LINE TO FILE �1>Z�****************************** �1AZ� LN�0 � LN�65535 � 23215 �1FZ� 23020 *2PZ� � ERR � T1 � �(�(PTR$,T,1)) : � 23150 M2ZZ� E$�"" � ERR � TRUE : � 23220 l2dZT1 � �(E$)  : E$ � �(E$,2) 2nZT2 � �(LN�256) �2xZFI$(T1) � �(LN�T2�256)��(T2)�IN$ �2�Z� � ERR � 23220 �2�ZT$ � "" : T1$ � "" �2�Z� T�1 � T$ � �(PTR$,T�1) 3�Z� T���(PTR$) � T1$ � �(PTR$,T) '3�ZPTR$ � T$��(T1)�T1$ 73�ZERR � FALSE =3�Z� a3[�****************************** �3[� DELETE LINE POINTED AT BY T �3[�****************************** �3[T$ � "" : T1$ � "" �3[� T�1 � T$ � �(PTR$,T�1) �3"[� T��(PTR$) � T1$ � �(PTR$,T�1) 4,[E$ � E$��(PTR$,T,1) )46[PTR$ � T$�T1$ /4@[� S4h[�****************************** t4i[� LIST LINES POINTED AT BY T �4j[�****************************** �4r[� �(�(FI$(T),1,1))�256��(�(FI$(T),2,1)) �6) ; �4|[� �(FI$(T),3) �4�[� 5�[�****************************** &5�[� START AND FINISH POINTERS J5�[�****************************** `5�[LN � SL : � 23020 k5�[SP � T �5�[LN � FL : � 23020 �5�[FP � T �5�[� ERR � FP � FP�1 �5�[� FP��(PTR$) � FP � �(PTR$) �5\� �50\�****************************** 61\� LOAD FILE FROM DEVICE ,62\�****************************** 86:\� 11250 W6?\� DEV�8 � IN$ � IN$�",S,R" h6N\�2,DEV,0,IN$ �6S\�2 , IN$ : � ST � � 23650 �6X\� IN$��"END" � � 24000 : � 23900 : � 23100 : � 23635 �6b\� 2 �6l\� �6�\�****************************** 7�\� SAVE FILE TO DEVICE /7�\�****************************** ;7�\� 11250 Z7�\� DEV�8 � IN$ � IN$�",S,W" �7�\T$ � "N" : � DEV�8 � � "OVERWRITE EXISTING FILE ( Y/N ) : "; T$ �7�\� T$�"Y" � IN$ � "@0:"�IN$ �7�\�2,DEV,2,IN$ : � 2 �7�\SL � 0 : FL � 65536 8�\� 24420 : �2 , "END" 8�\�2 : � 2 8�\� <8\]�****************************** X8]]� REMOVE LEADING SPACES |8^]�****************************** �8f]� T � 1 � �(IN$) �8p]� �(IN$,T,1)�" " � � T �8�]IN$ � �(IN$,T) : � �8�]�****************************** �8�]� GET LINE NUMBER !9�]�****************************** 19�]LN � �65536 a9�]� �(IN$)�0 � IN$�"0" � �(IN$,1)�"9" � 24090 v9�]� T � 1 � �(IN$) �9�]� �(IN$,T,1)��"9" � �(IN$,T,1)��"0" � � T �9^LN � �(�(IN$,T�1)) : IN$ � �(IN$,T) �9^� �9�^�****************************** :�^�  FIRST AND LAST LINES 6:�^�****************************** d:�^IN$ � "" : � "FIRST - LAST LINES : "; IN$ �:�^SL � 0 : FL � 65535 : T3 � 0 : ERR � FALSE �:�^� �(IN$)�0 � 24295 �:�^� 24000 �:�^� LN��0 � SL � LN : � 24260 �:�^� LN��65536 � FL � �LN : � 24295 (;�^� 23900 : � �(IN$)�0 � FL � SL : � 24295 E;�^IN$ � �(IN$,2) : � 23900 h;�^� �(IN$)�0 � � 24000 : FL � LN �;�^ERR � SL�0 � SL�65535 � FL�0 � FL�65535 � ERR : � �;�^�****************************** �;�^� INITALISE FILE �;�^�****************************** :<�^PTR$ � "" : E$ � "" : � X � 0 � 254 : E$ � E$��(X) : � : � ^<P_�****************************** o<Q_� LIST LINES �<R_�****************************** �<Z_� 24200 : � ERR � 24460 �<d_� "�" : � 23500 : � FP�SP� FP�0 � 24460 =n_� T1 � SP � FP : T � �(�(PTR$,T1,1)) : � 23400 : � : � >=�_� �(650)�0 � � T$ : � T$�"" � 24455 D=�_� h=�_�****************************** }=�_� DELETE LINE(S) �=�_�****************************** �=�_� 24200 : � ERR � 24460 �=�_� 23500 : � FP�SP � 24560 >�_T � SP : � T1 � SP � FP : � 23300 : � >�_� />`�****************************** C>`� INPUT LINE(S) g>`�****************************** q>"`� "�" �>,`IN$ � "" : � IN$ : � 24000 : � LN��65536 � 24665 �>J`� 23900 : � �(IN$)�0 � 24680 �>T`� 23100 : � � ERR � 24620 �>Y`� ?h`� 23020 : � � ERR � � 23300 ?r`� 24620 ;?|`�****************************** ^?}`� RENUMBER FILE IN STEPS OF 10 �?~`�****************************** �?�`LN � 10 : ERR � FALSE �?�`� �(PTR$)�1 � 24780 �?�`� T � 1 � �(PTR$) �?�`T1 � �(�(PTR$,T,1)) @�`FI$(T1) � �(LN��(LN�256)�256)��(LN�256)��(FI$(T1),3) .@�`LN � LN�10 : � 4@�`� X@�`�****************************** o@�`� FILE EDITOR MENU �@�`�****************************** �@�`� "�� ------------ FILE EDITOR ------------" �@a� "      0) EXIT FROM FILE EDITOR" Aa� "      1) INPUT LINE(S)" *Aa� "      2) LIST LINE(S)" JAa� "      3) DELETE LINE(S)" iA&a� "      4) RENUMBER FILE" �A0a� "      5) INITIALISE FILE" �A:a� "      6) LOAD FILE" �ADa� "      7) SAVE FILE" �ANa� "      8) ADD MACHINE CODE TO FILE" BSa� "      9) CHANGE DEVICE NUMBER" 5BXa� " COMMAND ( 0-9 ) : "; CO DBla� CO�0 � � �Bva� CO�0 � � CO � 24600,24400,24500,24700,24300,23600,23700,25000 �B�a� CO�8 � � CO�8 � 25500 �B�a� 24800 �B�a�****************************** �B�a� ADD TO FILE FROM MEMORY C�a�****************************** 6C�a� 12050 : � 11200 : � 24200 NC�a� XY � AD � EA � 15 vC�aIN$ � " BYT " : LN � SL : SL � SL�5 �C�a� XZ � 0 � 14 : O2$ � "" �C�a� 11100 : IN$ � IN$�"$"�H$ �Cb� XZ�14 � AD��EA � IN$ � IN$�"." : � XZ �Cb� 23100 : � XY : � D�c�****************************** 4D�c� CHANGE DEVICE NUMBER XD�c�****************************** gD�c� �19) DEV �D�c� "�NEW DEVICE NUMBER:";DEV �D�c� �D�e�****************************** �D�e� SYMBOL UP TO COLON ETC. �D�e�****************************** E�eH$ � "" : T1 � �(IN$) E�ePTR � PTR�1 2E�e� T1�PTR � 26060 JE�eT � �(�(IN$,PTR,1)) ]E�e� T�32 � 26020 �E�e� T��58 � T��59 � H$ � H$��(T) : � 26020 �E�e� �E�e�****************************** �E�e� OPERAND TYPE TO BE USED �E�e�****************************** F�eT6 � PTR : � 26000 FfERR � FALSE 8Ff� �(H$)�0 � OP � 1 : � RFf� H$�"A" � OP � 0 : � nF!f� �(H$)�35 � OP � 2 : � zF:fOP � 12 �FDf� �(H$,1)�"(" � OP � OP�3 �FNfT � 1 : T1 � �(H$) �FXfT2 � �(�(H$,T,1)) �Fbf� T2��46 � T�T1 � T � T�1 : � 26200 Glf� T2��46 � 26275 GvfT � T�1 : � T�T1 � 26270 5G�fT2 � �(�(H$,T,1)) WG�f� T2�89 � OP � OP�1 : � 26275 yG�f� T2�88 � OP � OP�2 : � 26275 �G�f� NOT A VALID INDEX �G�fEN � 5 : � 28000 �G�f�(OP�12)�((PO�2�PO�6)�(PO�6�PO�10)�PO�12�PO�11)� OP � 3 �G�f� ZERO PAGE OPRANDS 
H�f� OP�10 � � "H�fT7 � PTR : PTR � T6 .H�f� 28600 MH�f� ERR � RESULT�255 � 26292 [H�fOP � OP�6 hH�fPTR � T7 nH�f� �H�f�****************************** �H�f� EVALUATE OPCODE �H�f�****************************** �H�fT1 � 3 : T � PO �H�fT � �(�(TA$(T1),T�1,1)) I�f� T�255 � ERR � TRUE : � CI�fT1 � 4 : T2 � �(�(TA$(1),�(T�2�1),1)) cI�f� (1 � T)�0 � T2 � �(T2�16) tI�fT2 � T2 � 15 �I�f� T2��OP � 26320 �IgO$ � O$��(T) �IgERR � FALSE �Ig� �I g�****************************** �I!g� DO PASS 1 ASSEMBLY ON IN$ J"g�****************************** bJ%g� "                                        " ; �J&g� "                                       " ; �J'g� "" ;: � 28100 �J*gPASS � 1 : EXIT � FALSE : PTR � 2 �J4g� 28850 K>g� � ERR � 26540 "KHg� T�58 � �(H$)�0 � 26420 8KRg� T�59 � T��1 � � DK\g� 28700 PKpg� 28850 dKzg� � ERR � 26540 �K�g� T�58 � �(H$)�0 � 26420 �K�g� �K�g� PO�55 � � 26600 : � 26556 �K�g� 26100 �K�g� 26300 : � ERR � OP�3 � OP�7 � OP � OP�6 : � 26552 �K�g� 26560 L�g� �(IN$)�PTR � � EXIT � 26420 L�g� CL�g�****************************** UL�g� BYTE LENGTH yL�g�****************************** �L�gAD � AD�1 �L�g� OP�1 � AD � AD�1 �L�g� OP�8 � AD � AD�1 �L�g� �L�g�******************************  M�g� CALCULATE DIRECTIVE LENGTH $M�g�****************************** 4M�gT1 � �(IN$) ZM�g� PO�56 � 26720 : � BYT DIRECTIVE �Mh� PO�60 � � 28600 : AD � RESULT : � DEAL WITH ORG DIRECTIVE �Mh� PO�59 � EXIT � TRUE �Mh� PO�58 � � : � END & ORG DIRECTIVES �Mh� FIND LEN. OF WRD & DBY NhAD � AD�2 N$hPTR � PTR�1 )N.h� PTR�T1 � � AN8hT � �(�(IN$,PTR,1)) WNBh� T�58 � T�59 � � kNLh� T��46 � 26660 wNVh� 26650 �N`h� LENGTH FOR BYT. �NjhAD � AD�1 �NthPTR � PTR�1 �N~h� PTR�T1 � � �N�hT � �(�(IN$,PTR,1)) �N�h� T�58 � T�59 � � �N�h� T��46 � 26740 
O�h� 26730 .Oi�****************************** POi� DUMP SYMBOL TABLE TO SCREEN tOi�****************************** �Oi� SE�1 � 26975 �O#i� �O(i� X � 0 � SE�1 �O2i� �(ST$(X),6) �10) ; �O<iH � �(�(ST$(X),8))�256��(�(ST$(X),7)) �OFi� 11000 �OPi� H$  PZi� X )P_i� " TOTAL NUMBER OF SYMBOLS ---" SE /Pdi� SPxi�****************************** jPyi� EVALUATE OPERAND �Pzi�****************************** �P�iERR � FALSE �P�i� OP�2 � � �P�i� OP�3 � 27500 �P�i� OP�2 � 27400 �P�i� 28600 �P�i� ERR � �(O$)�0 � � /Q�i� (RESULT�0 � RESULT�255) � OP�9 � EN � 1 : � 28000 _Q�i� RESULT�0 � RESULT�65535 � EN� 2 : � 28000 rQ�i� OP�9 � 27140 �Q�iT � �(RESULT�256) �Q�iRESULT � RESULT�T�256 �Q�i� 27140 �Q�iRESULT � T �QjO$ � O$��(RESULT) �Qj� �Q@j�****************************** RAj� DIRECTIVE OPERAND EVALUATOR CRBj�****************************** SREjERR � FALSE vRJj� PO�60 � � 28600 : AD �RESULT �RNj� PO�62 � SY � TRUE �ROj� PO�61 � � 2,4 : � 2 : � "ADD.  DATA     SOURCE CODE" �RTj� PO�59 � EXIT � TRUE �R^j� PO�58 � � 	Shj� PO�56 � 27330 $Srj� DBY & WRD DIRECTIVES 0S|j� 28600 aS�j� RESULT�0 � RESULT�65535 � EN � 2 : � 28000 �S�j� PO�58 � RESULT � �(RESULT�256)�256�(RESULT��(RESULT�256)�256) �S�j� 27280 REVERSES HI. & LO. BYTES IF DIRECTIVE IS DBY �S�jT1 �T : � 27100 : AD � AD�2 T�j� T1�32 � � 28150 (T�j� T1�46 � 27260 .T�j� BT�j� BYT DIRECTIVE NT�j� 28600 }T�j� RESULT�0 � RESULT�255 � EN � 1 : � 28000 �T�j� 27140 : AD � AD�1 �T�j� T�32 � � 28150 �T�j� T�46 � 27340 �T�j� �Tk�****************************** U	k� EVALUATE IMMEDIATE EXPRESSION /U
k�****************************** FUkT5 � PTR : � 26000 ^Uk� �(H$)��35 � 27480 zU&k� �(H$,2,1)�"'" � 27450 �U0kPTR � T5 �U2k� PTR��(IN$) � 27446 �U4k� �(�(IN$,PTR,1))��35 � PTR � PTR�1 : � 27442 �U6kOP � 8 : � 27050 : OP � 2 �U8k� V:k� SINGLE CHR. EXPECTED (VDk� �(H$)��3 � 27480 BVNkO$ � O$��(H$,3,1) : � NVXkEN � 12 ZVbk� 28000 ~Vlk�****************************** �Vmk� EVALUATE RELATIVE EXPRESSION �Vnk�****************************** �Vvk� 28600 �V�k� �(O$)�0 � ERR � �  W�kRESULT � RESULT�AD %W�k� RESULT�0 � RESULT � RESULT�256 JW�k� RESULT�256 � RESULT��0 � 27140 VW�kEN � 10 bW�k� 28000 �W�k�****************************** �W�k� DO PASS 2 ASSEMBLY �W�k�****************************** �W�kPASS � 2 �W�kO$ � "" �W�kEXIT � FALSE : ERR � FALSE X�kPTR � 2 X�k� 28850 'X�k� � ERR � 27720 DXl� T�58 � �(H$)�0 � 27630 hXl� T�59 � T��1 � ERR � FALSE : � tXl� 28700 �Xl� 28850 �X l� � ERR � 27720 �X*l� T�58 � �(H$)�0 � 27630 �X/l� T�59 � T��1 � ERR � FALSE : � �X4lEN � 3 : � 28000 
YHl� PO�55 � � 27200 : � 27745 8YKlT5 � PTR : � 26100 : T8 � PTR  : PTR � T5 VYMl� 26300 : � � ERR � 27730 �YOl� OP�7 � OP�3 � OP � OP�6 : PTR � T5 : � 27725 �YPlEN � 18 : � 28000 �YQl� THIS BIT ATTEMPS TO MATCH ABSLOUTE ADD MODE TO OPCODE IF ZP HAS FAILED �YRl� 26560 #Z\l� � ERR � �(O$)�0 � � 27000 : PTR � T8 EZal� �(IN$)�PTR � � EXIT � 27630 KZfl� oZ`m�****************************** �Zam� ASSEMBLER ERROR ROUTINE �Zbm�****************************** �Zem� PTR��300 � PASS��2 � 28050 : � SUPRESS SECONDARY ERRORS IN LINE [jm� �14) ; : � 28100 [omEC � EC�1 G[tm� X � �13 � PTR : � "=" ;: � X : � "�" e[~m� "   " ERR$(EN) " ERROR" �[�mPTR � 300 : ERR � TRUE �[�m� �[�m�****************************** �[�m� PRINT IN$ TO THE SCREEN �[�m�****************************** \�m� 256��(�(IN$,2,1))��(�(IN$,1,1)) �(IN$,3) !\�m� E\�m�****************************** f\�m� SYMBOL TO NON-LETTER/DIGIT �\�m�****************************** �\ nH$ � "" : T � �1 �\nPTR � PTR�1 �\
n� PTR��(IN$) � 28210 �\nT � �(�(IN$,PTR,1)) �\n� T�32 � �(H$)�0 � 28160 )]n� T�48 � T�90 � ( T�57 � T�65 ) � 28210 D](nH$ � H$��(T) : � 28165 J]2n� n]Zn�****************************** �][n� FIND LABEL IN ST$ �]\n�****************************** �]dnERR � FALSE : H � 0 : T1 � 0 �]nn� �(H$)�6 � H$ � H$�" " : � 28270 ^xn� T1�SE � ERR � TRUE : � =^�n� �(ST$(T1),1,6)��H$ � T1 � T1�1 : � 28280 q^�nH � �(�(ST$(T1),8,1))�256��(�(ST$(T1),7,1)) : � �^�n�****************************** �^�n� EVALUATE LABEL OR NUMBER �^�n�****************************** �^�n� 28150 _�n� T�40 � �(H$)�0 � � 28150 _�nT1 � �(H$) O_�n� (T��1 � T�32 � T�58 � T�59 � T�41 � T�46) � T1 � 0 � � b_�n� T1�0 � 28390 �_�n� �(H$)��57 � H � �(H$) : � 28492 �_�n� 28250 : � FIND LABEL IN SYMBOL TABLE �_�n� ERR � EN � 11 : H � 0 : � 28000 �_�n� 28492 `�n� HEX,OCTAL OR BINARY NUMBERS EVALUATE %`�nT2 � T : � 28150 ;`�n� �(H$)�0 � 28450 O`o� T2�36 � 28470 p`o� T2�37 � BASE � 2 : � 28470 �`o� T2�38 � BASE � 8 : � 28470 �`"o� INVALID LABEL �`,oH � 0 : EN � 6 : � 28000 �`6o� TEST IF VALID NUMBER �`;o� 11950 a@oBASE � 16 : � DEFAULT BASE -aJo� ERR � H � 0 : EN � 7 : � 28000 ]aLoPTR � PTR�1 : � 28150 : � GET NEXT OPERATOR caOo� �aTo�****************************** �aUo� EVALUATE TERM WITH * OR / �aVo�****************************** �a^o� 28300 : TERM � H �aho� PTR��(IN$) � � )bro� T�42 � � 28300 : TERM � �(TERM�H) : � 28520 9b�o� T��47 � � Eb�o� 28300 nb�o� H�0 � TERM � 0 : EN � 15 : � 28000 �b�oTERM � �(TERM�H) �b�o� 28520 �b�o�****************************** �b�o� EVALUATE EXPRESSION �b�o�****************************** c�oERR � FALSE c�o� 28500 : RESULT � TERM Zc�o�T��1� T�32 � T�58 � T�59 � T�41 � T�46 � PTR��(IN$) � � �c�o� T�43 � � 28500 : RESULT � �(RESULT�TERM) : � 28620 �c�o� T�45 � � 28500 : RESULT � �(RESULT�TERM) : � 28620 �c�oRESULT � 0 : EN � 4 : � 28000 dp�****************************** 3dp� ADD SYMBOL TO SYMBOL TABLE Wdp�****************************** �d&p� SE��SM � EXIT � TRUE : PASS � 2 : EN � 14 : � 28000 �d0p� 28250 : � � ERR � 28830 �dDpT$ � �(H$�"       ",6) �dIpTB � PTR �dNp� 28150 : � DOES = FOLLOW  eXp� T��61 � PTR � TB : RE � AD : � 28780 5ebpT0 � T : � 28600 @elpEN � 0 |evp� RE�0 � RE�65535 � ST$(SE)�T$��(0)��(0)��(2) : � 28810 �e�pST$(SE) � T$��(RE��(RE�256)�256)��(�(RE�256)) �e�pSE � SE�1 �e�p� �e�p� PASS�1 � �(ST$(T1))�9 � ST$(T1) � ST$(T1)��(8) f�p� PASS��2 � 28840 Cf�pTA � PTR : � 28150 : � T��61 � PTR � TA : � 28840 {f�p� 26000 : � SCAN PAST = SIGN (IF PRESENT) ON PASS 2 �f�p� PASS��2 � �(ST$(T1))�9 � � �f�pEN � �(�(ST$(T1),9,1)) : � 28000 �f�p�****************************** g�p� TEST FOR OPCODE/DIRECTIVE )g�p�****************************** 5g�p� 28150 Eg�pERR � FALSE Ug�pPTR � PTR�1 lg�p� �(H$)��3 � 28940 xg�pPO � �2 �g�pPO � PO�3 �g�p� H$��(TA$(2),PO,3) � 28950 �gq� (PO�3)���(TA$(2)) � 28910 �gqERR � TRUE �gqPO � (PO�1)�3 �g qERR � (PO�56) � ERR h*q� PO�56 � PO � PO�1 h4q� 4h8�� CHECKSUM PROGRAM @h9�� 63810 Lh:�� 63840 `h;�� FL��0 � 63802 fh<�� �hB��� DEEK(X) � �(X)�256��(X�1) �hL�� DATA FOR MACHINE CODE �hM�� *** �hN�� 165,076,166,077,133,212,134,213,032,225 	iO�� 200,216,160,001,177,193,133,078,240,013 7iP�� 200,177,193,133,076,200,177,193,133,077 eiQ�� 200,169,000,133,075,177,193,240,006,024 �iR�� 101,075,200,208,244,096 �iS�� -1 �iV�� PUT DATA INTO MEMORY �iW�AD � 1024 �iX�� �iY�� T$: � T$��"***" � 63833 	jZ�� T : � T��0 � � AD,T : AD � AD�1 : � 63834 Aj[�DEV � 3 : IN$ � "" : � "OUTPUT DEVICE NUMBER "; DEV jj\�� DEV�1 � DEV�4 � � "FILE NAME ";IN$ �j]�R$ � �(13) : S$ � "***************************************"�R$ �j^�� �j`�� DO INITALISATION �ja�FL � 0 : � "FIRST LINE "; FL : � FL�0 � � kb�LL � 65536 : � "LAST LINE "; LL 4kc�� "MODULE NAME ";M$ Fkd�� 1,DEV,2,IN$ �ke��1,S$ R$�(40��(M$))�2)M$R$ R$"LINE NUMBERS"FL"TO"LL;R$S$R$ �kj�� ACTUAL PROGRAM �kk�LN � FL : C � 0 : C1 � 0 �kl�� 76,LN��(LN�256)�256 : � 77,LN�256 
lm�� 1024 : CS � �(75) : LN � �DEEK(76)�1 -lt�� FORMAT OUTPUT INTO 3 COLUMNS alu�T$ � �(�(LN�1)�"      ",6)��(�(CS)�"       ",7) llv��1,T$; �lx�C � C�1 : � C��3 � �1 : C � 0 : C1 � C1 � 1 �ly�� C1��20 � DEV�3 � C1 � 0 : � 63898 �lz�� LN��LL � �(78) � 63852 �l{�� 1 : � m��� T$ : � T$�"" � 63898 m���   