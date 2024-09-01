    1 REM TS-Pico Commander v0.7
    2 REM 31 Aug 2024
    3 REM By Ryan Gray
    4 REM
   10 GO SUB 9000
   12 GO SUB 50
   14 GO SUB 60
   16 GO SUB 20
   17 PRINT AT 21,1; INK bg; PAPER ff;"? for help";
   18 GO TO 80
   19 REM Show listing
   20 CLS 
   21 PRINT p$;
   22 PRINT '; INK bg; PAPER ff;" #  FILE NAME              SIZE "
   23 IF rd THEN INK bg: PAPER ff: PLOT 0,166: DRAW 0,1: DRAW 1,0: PLOT 254,167: DRAW 1,0: DRAW 0,-1: INK fg: PAPER bg
   24 LET r=18: IF r+t>n THEN LET r=n-t
   25 FOR i=0 TO r
   26 LET x=i+t: LET h=(x=s)
   27 IF x<=d+2 THEN PRINT INK df; INVERSE h;"    ";a$(x, TO 28);: GO TO 35
   34 PRINT INVERSE h; FLASH (x=m);a$(x, TO 4); FLASH 0; INK ff;a$(x,5 TO 22); INK fg;a$(x,23 TO );
   35 NEXT i
   36 LET h=0
   37 GO SUB 40
   38 RETURN 
   39 REM Status bar
   40 PRINT AT 21,0; INK bg; PAPER ff;"                   TS-Pico Cmdr ";
   41 IF t+19<n THEN PRINT INK bg; PAPER ff;CHR$ 8;".";AT 21,0;
   42 IF m THEN PRINT AT 21,1; INK bg; PAPER ff;a$(m,y(m) TO z(m));
   43 IF rd THEN INK bg: PAPER ff: PLOT 0,1: DRAW 0,-1: DRAW 1,0: PLOT 254,0: DRAW 1,0: DRAW 0,1: INK fg: PAPER bg
   48 RETURN 
   49 REM Get path
   50 CLS : DIM p$(32)
   52 LOAD "tpi:path"
   54 FOR i=0 TO 31
   56 LET p$(i+1)=SCREEN$ (2,i)
   57 NEXT i
   58 RETURN 
   59 REM Load dirinfo.tap
   60 LOAD "tpi:dirinfo.tap": PAUSE p: LET m=0
   61 LOAD "" DATA a$(): CLS : PRINT p$''"Working";
   62 LET d=VAL a$(1): LET f=VAL a$(2)
   63 LET n=d+f+2: DIM z(n): DIM y(n): DIM l$(n)
   64 IF d=0 THEN GO TO 70
   65 FOR i=1+2 TO d+2: LET y(i)=1
   66 PRINT ".";
   67 LET z(i)=32: LET l$(i)=a$(i,1)
   68 IF l$(i)>="a" AND l$(i)<="z" THEN LET l$(i)=CHR$ (CODE l$(i)-32)
   69 NEXT i
   70 IF f=0 THEN GO TO 75
   71 FOR i=d+3 TO n: LET y(i)=5: PRINT ".";
   72 LET z(i)=22: LET l$(i)=a$(i,5)
   73 IF l$(i)>="a" AND l$(i)<="z" THEN LET l$(i)=CHR$ (CODE l$(i)-32)
   74 NEXT i
   75 REM Add ".." dir at a$(2)
   76 LET a$(1)=STR$ d+"."+STR$ f: REM save d&f in row 1 as d.f
   77 LET a$(2)="..": LET s=2: IF q AND t$=".." THEN LET s=q: LET q=0
   78 LET l$(2)=".": LET y(2)=1: LET z(2)=2: RETURN 
   79 REM Main key input loop
   80 LET k$=INKEY$: LET k=CODE k$: IF k$="" THEN GO TO 80
   81 IF (k$=" " OR k=10) AND s<n THEN GO SUB 150: LET s=s+1: GO TO 160
   82 IF k=11 AND s>2 THEN GO SUB 150: LET s=s-1: GO TO 160
   83 IF k=96 THEN GO TO 500: REM sym+X
   84 IF k=13 THEN GO TO 200
   85 IF k$="." THEN LET t$="..": GO TO 310
   86 IF k$="/" THEN LET t$="verbose": GO SUB 4500: GO TO 2008
   87 IF k$>="0" AND k$<="9" AND f>k-CODE "0" THEN GO SUB 150: LET s=d+3+k-CODE "0": GO TO 160
   88 IF k=6 THEN REM sh+2
   89 IF k=4 THEN REM sh+3
   90 IF k=5 THEN REM sh+4
   91 IF k=12 THEN REM GO TO 1100: REM sh+0
   92 IF k=15 THEN REM sh+9
   93 IF k=9 AND s+19<=n THEN GO SUB 150: LET s=s+19: GO TO 160
   94 IF k=9 AND t+19<=n THEN GO SUB 150: LET s=t+19: GO TO 160
   95 IF k=8 AND s-19>=2 THEN GO SUB 150: LET s=s-19: GO TO 160
   96 IF k$="?" THEN GO TO 3000
   97 IF k$=":" THEN GO TO 400
   98 IF k=200 THEN GO TO 4000: REM >=
   99 IF k=199 THEN GO TO 4100: REM <=
  100 IF k$="+" THEN CLS : GO TO 4030
  101 IF k=172 THEN LET t$="getinfo": GO TO 4200: REM sym+I
  102 IF k$="=" THEN LET t$="getlog": GO TO 4700: REM sym+L
  103 IF k$="%" THEN LET t$="close": LET m=0: GO SUB 4500: PRINT AT 0,0;: GO SUB 21: GO TO 80
  104 IF k$="^" THEN LET t$="gethelp": GO TO 4700: REM sym+H
  105 IF k$="-" THEN GO TO 200
  106 IF k$="!" THEN GO TO 700
  107 IF k=7 THEN GO SUB 150: LET s=2: GO TO 160: REM sh+1
  108 IF k=205 THEN GO TO 1200: REM STEP sym+D
  109 IF k=226 THEN BEEP 0.1,10*(m>0): IF m THEN LET t$="append": GO TO 4200: REM sym+A
  120 IF k$>="!" AND k$<="z" THEN GO TO 170
  149 GO TO 80
  150 IF s<=d+2 THEN PRINT AT s-t+2,0; INK df; INVERSE h;"    ";a$(s, TO 28);: GO TO 154
  152 PRINT AT s-t+2,0; INVERSE h; FLASH (s=m);a$(s, TO 4); FLASH 0; INK ff;a$(s,5 TO 22); INK fg;a$(s,23 TO );
  154 RETURN 
  160 REM Disp is a$(t TO t+18) update t to include s and redraw if needed
  161 LET r=t+18: IF r>n THEN LET r=n: REM disp is t to r
  162 IF s<t THEN LET t=2+19*INT ((s-2)/19): GO TO 166: REM prev pg
  163 IF s>r THEN LET t=2+19*INT ((s-2)/19): GO TO 166: REM next pg
  164 LET h=1: GO SUB 150
  165 LET h=0: GO TO 80
  166 IF t<2 THEN LET t=2
  167 IF t>n THEN LET t=n-18: GO TO 166
  168 GO TO 2008
  169 REM Skip to letter
  170 LET t$=l$(s)
  171 LET i=0: GO SUB 150
  172 IF k$>="a" AND k$<="z" THEN LET k$=CHR$ (CODE k$-32)
  173 IF k$=t$ THEN IF s<n THEN IF l$(s+1)=k$ THEN LET s=s+1: GO SUB 150: GO TO 160
  174 IF k$=t$ AND s=n THEN GO TO 80
  175 LET s=s+1: IF s>n THEN LET s=2: LET i=1
  176 LET t$=l$(s)
  178 IF k$<>t$ AND i=0 THEN GO TO 175
  179 GO TO 160
  199 REM Enter pressed on item
  200 GO SUB 800: REM get real z(s)
  201 LET t$=a$(s,y(s) TO z(s)): REM File as displayed
  202 IF s<=d+2 THEN GO TO 300: REM dir
  204 PRINT #0;"Mounting: ";t$
  206 GO SUB 1000: REM get ext
  208 LOAD "tpi:*"+a$(s, TO 3): PAUSE p
  210 IF e$="" THEN LET m=s: GO TO 230: REM no ext
  212 IF e$=".dck" OR e$=".DCK" THEN CLS : LOAD "": GO TO 1
  214 IF e$=".tap" OR e$=".TAP" THEN CLS : LET m=s: GO TO 240
  230 INPUT "": GO TO 80
  240 IF k$="-" THEN GO TO 600
  250 GO TO 4030
  299 REM cd
  300 LET t$=a$(s,y(s) TO z(s))
  302 LET q=s
  310 PRINT #0;"tpi:cd ";t$
  320 SAVE "tpi:cd "+t$: PAUSE p
  322 LET m=0
  330 INPUT "": GO TO 2000
  400 REM tpi command
  410 INPUT "tpi:";t$
  420 IF t$="" THEN GO TO 80
  430 IF t$="dir" OR t$="path" OR t$="tapdir" THEN GO TO 4400
  432 IF LEN t$>=3 AND t$( TO 3)="cd " THEN LET m=0
  440 GO TO 4300
  499 REM Switch running from AROS to BASIC
  500 REM Should use the Toolkit method to stash these vars and restore regular BASIC vars for the BASIC system
  501 IF PEEK 23750=0 THEN BEEP 0.1,10L GO TO 80: REM Already in HOME bank
  580 INK 0: PAPER 7: BORDER 7: CLS 
  585 PRINT "Exiting DOCK bank to HOME bank."'"Use POKE 23750,128: RUN"'"to run TC again."
  590 POKE 23750,0: STOP 
  600 IF NOT m THEN BEEP 0.1,0: GO TO 2008
  602 INK 0: PAPER 7: BORDER 7
  603 CLS 
  604 IF PEEK 23750=128 THEN PRINT "You need to LOAD """" manually": GO TO 585
  606 LOAD ""
  608 GO TO 4230
  610 IF NOT m THEN BEEP 0.1,0: GO TO 2008
  612 LOAD ""CODE 
  614 GO TO 4230
  699 REM Reset
  700 SAVE "tpi:close": PAUSE p
  710 SAVE "tpi:cd /": PAUSE p
  712 LET m=0
  720 GO TO 2000
  799 REM Get len of a$(s)
  800 REM z(s) should be rightmost starting point; 32 for dirs and 22 for files, set in sub 60
  810 FOR j=z(s) TO y(s) STEP -1: IF a$(s,j)<>" " THEN LET z(s)=j: GO TO 830
  820 NEXT j
  830 RETURN 
  899 REM Sniff tapdir listing
  900 LET i=5
  910 IF SCREEN$ (i,0)=">" THEN GO TO 920
  912 LET i=i+1
  914 IF i>21 THEN GO TO 930
  918 GO TO 910
  920 LET j=22: LET t$=""
  921 IF SCREEN$ (i,19)="Y" THEN LET i=i+1
  922 LET k$=SCREEN$ (i,j)
  924 IF k$=" " THEN GO TO 930
  926 LET t$=t$+k$: LET j=j+1
  928 IF j>31 THEN GO TO 930
  929 GO TO 922
  930 RETURN 
 1000 REM 
 1002 FOR i=z(s) TO y(s) STEP -1
 1004 IF a$(s,i)="." THEN GO TO 1008
 1006 NEXT i
 1008 IF a$(s,i)="." THEN LET e$=a$(s,i TO z(s)): RETURN 
 1009 LET e$="": RETURN 
 1099 REM Delete
 1100 GO SUB 800
 1102 LET t$=a$(s,y(s) TO z(s))
 1104 IF s<3 OR s>d+2 THEN BEEP 0.1,0: GO TO 80
 1106 INPUT "Remove "+t$+" (y/N)?";k$
 1108 IF k$<>"y" AND k$<>"Y" THEN GO TO 80
 1110 PRINT #0;"tpi:rm "+t$
 1112 SAVE "tpi:rm "+t$: PAUSE p
 1114 INPUT "": GO TO 2000
 1199 REM Make Dir
 1200 INPUT "New dir name:";t$
 1202 IF t$="" THEN GO TO 80
 1204 IF LEN t$>10 THEN BEEP 0.1,0: GO TO 1200
 1210 PRINT #0;"tpi:md ";t$
 1212 SAVE "tpi:md "+t$: PAUSE p
 1214 GO TO 2000
 2000 GO SUB 50
 2002 GO SUB 60
 2008 GO SUB 20
 2010 GO TO 80
 3000 REM help
 3002 CLS 
 3004 PRINT INVERSE 1;"TS-Pico Commander Help"
 3005 PRINT "UP/DN   Highight name"
 3006 PRINT "<-/->   Page up/down"
 3007 PRINT "Space   Move down"
 3008 PRINT "EDIT    Move to top"
 3009 PRINT "0-9     Skip to file #000-009"
 3010 PRINT "a-z     Skip to file by letter"
 3011 PRINT "Enter   Mount file or change dir"
 3013 PRINT "%       Close mounted file"
 3014 PRINT ". or /  cd .. or cd /"
 3020 PRINT "sym+J   LOAD """"   sym+K  tapdir"
 3022 PRINT "sym+I   getinfo   sym+D  md"
 3024 PRINT "sym+H   gethelp   sym+A  append"
 3026 PRINT "sym+L   getlog    sym+V  verbose"
 3032 PRINT ">=      ffw & tapdir"
 3034 PRINT "<=      rew & tapdir"
 3036 PRINT ":       Enter a tpi command"
 3038 PRINT "!       Reset: close,cd /"
 3090 INPUT "Press enter:";t$
 3099 GO TO 2008
 4000 REM ffw
 4010 IF NOT m THEN GO TO 80
 4012 CLS 
 4020 SAVE "tpi:ffw": PAUSE p
 4030 LOAD "tpi:tapdir": REM PAUSE p
 4040 GO SUB 900
 4050 PRINT #0;"Any key, "; INVERSE 1;"L"; INVERSE 0;"oad, "; INVERSE 1;"C"; INVERSE 0;"ode, "; INVERSE 1;"<="; INVERSE 0;" or "; INVERSE 1;">=";
 4060 LET k$=INKEY$: LET k=CODE k$: IF k$="" THEN GO TO 4060
 4061 INPUT ""
 4062 IF k=200 THEN GO TO 4012
 4064 IF k=199 THEN GO TO 4100
 4066 IF k$="l" THEN GO TO 600
 4068 IF k$="c" THEN GO TO 610
 4098 GO TO 2008
 4100 IF NOT m THEN GO TO 80
 4110 CLS 
 4120 SAVE "tpi:rew": PAUSE p
 4130 GO TO 4030
 4200 REM SAVE tpi cmd, no reload
 4210 CLS 
 4212 PRINT #0;"tpi:";t$
 4220 SAVE "tpi:"+t$: PAUSE p
 4230 INPUT ""
 4232 PRINT #0;"Press a key..."
 4234 PAUSE 0: INPUT ""
 4236 GO TO 2008
 4300 REM SAVE tpi cmd, reload
 4310 CLS 
 4312 PRINT #0;"tpi:";t$
 4320 SAVE "tpi:"+t$: PAUSE p
 4322 INPUT ""
 4324 PRINT #0;"Press a key..."
 4326 PAUSE 0: INPUT ""
 4330 GO TO 2000
 4400 REM LOAD tpi cmd, reload
 4410 CLS 
 4412 PRINT #0;"tpi:";t$
 4420 LOAD "tpi:"+t$: PAUSE p
 4430 GO TO 4322
 4500 REM SAVE tpi, no reload, no CLS or prompt or redraw
 4510 PRINT #0;"tpi:";t$
 4520 SAVE "tpi:"+t$: PAUSE p
 4530 INPUT ""
 4540 RETURN 
 4599 REM SAVE tpi, no reload, no echo, no prompt
 4600 CLS 
 4610 SAVE "tpi:"+t$: PAUSE p
 4620 GO TO 4324
 4699 REM SAVE tpi, no reload, no prompt
 4700 CLS 
 4702 PRINT #0;"tpi:";t$
 4704 SAVE "tpi:"+t$: PAUSE p
 4706 INPUT ""
 4708 GO TO 2008
 9000 REM Init
 9001 LET p=60: LET t$=""
 9002 LET fg=7: LET bg=1: LET bd=bg
 9003 LET ff=5: LET df=6: LET rd=1
 9004 LET s=-1: LET t=2: LET m=0
 9005 LET p$="": LET q=0: LET h=0
 9009 REM Reset ATTR
 9010 INK bg: PAPER bg: BORDER bd
 9011 FLASH 0: BRIGHT 0: OVER 0
 9012 INVERSE 0: CLS 
 9019 REM Turn off tpi:verbose
 9020 SAVE "tpi:verbose"
 9030 IF SCREEN$ (1,0)="V" THEN SAVE "tpi:verbose"
 9040 INK fg: CLS 
 9099 RETURN 
 9100 REM Variables
 9108 REM a$(n,32)=dirinfo
 9110 REM d=num if dirs in a$
 9112 REM f=num if files in a$
 9114 REM n=d+f+2 = rows of a$
 9116 REM z(i)=end of a$(i),i>2
 9118 REM y(i)=start of a$(i)
 9120 REM p$(32)=path
 9122 REM s=selected file
 9124 REM m=mounted file num
 9126 REM k$=INKEY$
 9128 REM t$=tpi cmd or a file
 9199 RETURN 
