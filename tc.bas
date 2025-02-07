    1 REM TS-Pico Commander v0.92
    2 REM 4 Nov 2024
    3 REM By Ryan Gray
    4 REM 
    8 GO TO 10
    9 LET f=256*(256*PEEK 23674+PEEK 23673)+PEEK 23672: RETURN
   10 GO SUB 9000
   12 GO SUB 50
   14 GO SUB 60
   16 GO SUB 20
   17 PRINT AT 21,1; INK bg; PAPER ff;"? for help";
   18 GO TO 80
   19 REM Show listing
   20 INK fg: PAPER bg: BORDER bd: CLS 
   21 PRINT PAPER bd;p$;
   22 PRINT '; INK bg; PAPER ff;" #  FILE NAME              SIZE "
   23 IF rd THEN INK bd: PAPER ff: PLOT 0,166: DRAW 0,1: DRAW 1,0: PLOT 254,167: DRAW 1,0: DRAW 0,-1: INK fg: PAPER bg
   24 LET r=18: IF r+t>n THEN LET r=n-t
   25 FOR i=t TO r+t
   27 PRINT b$(i)
   29 NEXT i
   30 LET h=1: GO SUB 150
   32 LET h=0
   34 GO SUB 40
   38 RETURN 
   39 REM Status bar
   40 PRINT AT 21,0; INK bg; PAPER ff;"                       TPI Cmdr ";
   41 IF t+19<n THEN PRINT INK bg; PAPER ff;CHR$ 8;".";AT 21,0;
   42 IF m THEN PRINT AT 21,1; INK bg; PAPER ff;a$(m,y(m) TO z(m));
   43 IF rd THEN INK bd: PAPER ff: PLOT 0,1: DRAW 0,-1: DRAW 1,0: PLOT 254,0: DRAW 1,0: DRAW 0,1: INK fg: PAPER bg
   48 RETURN 
   49 REM Get path
   50 CLS : DIM p$(32)
   51 GO SUB 770
   52 LET u$="tpi:path": GO SUB 750
   54 FOR i=0 TO 31
   56 LET p$(i+1)=SCREEN$ (2,i)
   57 NEXT i
   58 RETURN 
   60 GO SUB 770: LET u$="tpi:dirinfo.tap": GO SUB 750
   61 LET m=0
   62 GO SUB 770: GO SUB 780: REM LOAD "" DATA a$()
   63 CLS : PRINT p$''"Working";
   64 LET d=VAL a$(1): LET f=VAL a$(2): LET n=d+f+2: DIM z(n): DIM y(n): DIM l$(n): DIM b$(n,36): DIM e(n)
   65 IF d=0 THEN GO TO 70
   66 FOR i=1+2 TO d+2: LET y(i)=1: PRINT ".";
   67 LET b$(i)=d$+"    "+a$(i, TO 28)+g$: LET z(i)=32: LET l$(i)=a$(i,1)
   68 IF l$(i)>="a" AND l$(i)<="z" THEN LET l$(i)=CHR$ (CODE l$(i)-32)
   69 NEXT i
   70 IF f=0 THEN GO TO 75
   71 FOR i=d+3 TO n: LET y(i)=5: LET z(i)=22: LET l$(i)=a$(i,5): PRINT ".";
   72 IF l$(i)>="a" AND l$(i)<="z" THEN LET l$(i)=CHR$ (CODE l$(i)-32)
   73 LET b$(i)=a$(i, TO 4)+f$+a$(i,5 TO 22)+g$+a$(i,23 TO )
   74 NEXT i
   75 LET b$(2)=h$
   76 LET a$(2)="..": LET s=2: IF q AND t$=".." THEN LET s=q: LET q=0
   77 LET l$(2)=".": LET y(2)=1: LET z(2)=2
   78 RETURN 
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
  106 IF k$="!" THEN GO TO 650
  107 IF k=7 THEN GO SUB 150: LET s=2: GO TO 160: REM sh+1
  108 IF k=205 THEN GO TO 1200: REM STEP sym+D
  109 IF k=226 THEN BEEP 0.1,10*(m>0): IF m THEN LET t$="append": GO TO 4200: REM sym+A
  120 IF k$>="!" AND k$<="z" THEN GO TO 170
  149 GO TO 80
  150 IF s<=d+2 THEN PRINT AT s-t+2,0; INK df; INVERSE h;"    ";a$(s, TO 28);: GO TO 154
  152 PRINT AT s-t+2,0; INVERSE h; FLASH (s=m);a$(s, TO 4); FLASH 0; INK (ff*(e(s)=0)+2*(e(s)<>0));a$(s,5 TO 22); INK fg;a$(s,23 TO );
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
  171 LET i=0: LET h=0: GO SUB 150
  172 IF k$>="a" AND k$<="z" THEN LET k$=CHR$ (CODE k$-32)
  173 IF k$=t$ THEN IF s<n THEN IF l$(s+1)=k$ THEN LET s=s+1: GO SUB 150: GO TO 160
  174 IF k$=t$ AND s=n THEN GO TO 80
  175 LET s=s+1: IF s>n THEN LET s=2: LET i=1
  176 LET t$=l$(s)
  178 IF k$<>t$ AND i=0 THEN GO TO 175
  179 GO TO 160
  180 REM Get len of a$(s)
  182 FOR j=z(s) TO y(s) STEP -1: IF a$(s,j)<>" " THEN LET z(s)=j: RETURN 
  184 NEXT j
  190 LET sz=VAL a$(s,23 TO 30)
  193 IF a$(s,31)="K" THEN LET sz=sz*1024
  194 LET sz=sz/1024/16
  196 IF sz<1 THEN LET sz=1
  198 RETURN 
  199 REM Enter pressed on item
  200 IF m=s THEN GO TO 237
  201 LET h=0: GO SUB 150: LET h=1: GO SUB 150: GO SUB 180: LET t$=a$(s,y(s) TO z(s)): REM File as displayed
  202 IF s<=d+2 THEN GO TO 300: REM dir
  203 LET m=s
  204 REM Get .ext
  206 LET e$="": LET l=LEN t$
  208 FOR i=l TO 1 STEP -1
  210 IF t$(i)="." THEN LET e$=t$(i TO l): LET n$=t$( TO i-1): GO TO 216
  212 NEXT i
  214 LET n$=t$
  216 IF e$="" THEN INPUT "What is the extension? ";e$: GO TO 226
  218 IF l-i>=3 THEN GO TO 230
  220 PRINT #0;"Found extension of """;VAL$ "e$";""","'"correct (y/n)? ";
  221 LET k$=INKEY$: IF k$="" THEN GO TO 221
  222 IF k$="y" OR k$="Y" THEN PRINT #0;k$: GO TO 230
  223 IF k$="n" OR k$="N" THEN PRINT #0;k$: GO TO 225
  224 GO TO 221
  225 INPUT "What is the extension? ";e$
  226 IF e$="" THEN GO TO 230
  228 IF e$(1)<>"." THEN LET e$="."+e$
  229 LET t$=n$+e$
  230 PRINT #0;"Mounting: ";t$
  231 GO SUB 770
  232 IF e$="" OR LEN t$-LEN e$>10 THEN PRINT #0;" (as ""&";a$(s, TO 3);""")": LET u$="tpi:&"+a$(s, TO 3): GO SUB 760: GO TO 235
  234 LET u$="tpi:"+t$: GO SUB 760
  235 IF u<0 THEN GO SUB 450: GO TO 2008
  236 LET e(s)=0: LET b$(s,6)=CHR$ ff
  237 ON ERR \*: IF oe THEN ON ERR GO TO oe
  238 IF e$=".tap" OR e$=".TAP" THEN CLS : GO TO 250
  239 IF e$="" THEN GO TO 248: REM no ext, mount only
  240 IF e$=".dck" OR e$=".DCK" THEN GO TO 260
  242 IF e$=".rom" OR e$=".ROM" THEN GO TO 260
  244 IF e$=".bin" OR e$=".BIN" THEN GO TO 260
  246 REM Other type, just mount only
  248 INPUT "": GO TO 2008
  250 IF k$="-" THEN GO TO 600
  252 GO TO 4030
  260 REM DCK ROM BIN loading
  262 IF k$="-" THEN GO TO 600
  264 PRINT #0;"Load (y/n)? ";
  270 LET k$=INKEY$: IF k$="" THEN GO TO 270
  280 IF k$="y" OR k$="Y" THEN PRINT #0;k$: GO TO 600
  282 IF k$="n" OR k$="N" THEN PRINT #0;k$: GO TO 2008
  290 GO TO 270
  300 REM cd
  302 LET q=s
  310 LET u$="tpi:cd "+t$
  311 PRINT #0;u$
  320 GO SUB 770: GO SUB 710
  321 IF u<0 THEN GO SUB 450
  330 INPUT "": GO TO 2000
  400 REM tpi command
  410 INPUT "tpi:";t$
  420 IF t$="" THEN GO TO 80
  430 IF t$="dir" OR t$="path" OR t$="tapdir" THEN GO TO 4400
  432 IF LEN t$>=3 AND t$( TO 3)="cd " THEN LET m=0
  440 GO TO 4300
  450 INPUT FLASH 1;"Failed"; FLASH 0;": ";VAL$ "t$"'"Press Enter:";k$
  452 LET e(s)=1: IF s<d+2 THEN LET b$(s,2)=CHR$ 2
  453 LET b$(s,6)=CHR$ 2
  454 RETURN 
  499 REM Switch running from AROS to BASIC
  500 REM Should use the Toolkit method to stash these vars and restore regular BASIC vars for the BASIC system
  510 INK 0: PAPER 7: BORDER 7: CLS 
  512 IF oe THEN ON ERR \*
  520 IF NOT dock THEN STOP : REM Already in HOME bank
  530 PRINT "Exiting DOCK bank to HOME bank."
  532 PRINT "Use NEW to run TC again, or use"
  534 PRINT " POKE 23750,128: RUN"
  536 PRINT "to preserve the BASIC program."
  538 PRINT "If you switch DOCK banks, use"
  540 PRINT " SAVE ""tpi:memdock""CODE m,n"
  542 PRINT "first, where m,n is the bank"
  544 PRINT "that TC was loaded into."
  590 POKE 23750,0: STOP 
  600 IF NOT m THEN BEEP 0.1,0: GO TO 2008
  601 INK 0: PAPER 7: BORDER 7: CLS : ON ERR \*
  602 IF dock THEN GO TO 604
  603 LOAD "": STOP 
  604 IF e$=".dck" OR e$=".DCK" THEN GO TO 607
  605 PRINT "Use NEW to run TC again."
  606 POKE 23750,0: LOAD "": STOP 
  607 PRINT "Exiting DOCK bank to HOME bank."
  608 PRINT '"To run ";a$(s,y(s) TO z(s));","'"you need to do LOAD """" manually"'"after the system restarts."'': INPUT "Restart (Y/n)? ";k$
  609 IF k$="n" OR k$="N" THEN GO TO 2008
  610 SAVE "tpi:memdock"CODE 2,0: POKE 23750,0: NEW 
  620 IF NOT m THEN BEEP 0.1,0: GO TO 2008
  622 LOAD ""CODE 
  624 GO TO 4230
  630 MERGE ""
  632 INPUT "Exit to BASIC? (y/N):";k$
  634 IF k$="y" OR k$="Y" THEN GO TO 500
  636 GO TO 4230
  649 REM Reset
  650 GO SUB 770
  652 LET u$="tpi:close": GO SUB 700
  660 GO SUB 770
  662 LET u$="tpi:cd /": GO SUB 700
  670 LET m=0
  680 GO TO 2000
  699 REM SAVE tpi, caller doesn't handle error
  700 GO SUB 9: LET f0=f: LET u=1
  702 SAVE u$
  704 IF u>=0 THEN RETURN 
  706 PRINT INVERSE 1;"Failed: SAVE """;u$;""""
  708 GO TO 834
  709 REM SAVE tpi, caller handles error
  710 GO SUB 9: LET f0=f: LET u=1
  712 SAVE u$
  714 RETURN 
  749 REM LOAD tpi, caller doesn't handle error
  750 GO SUB 9: LET f0=f: LET u=1
  752 LOAD u$
  754 IF u>=0 THEN RETURN 
  756 PRINT INVERSE 1;"Failed: LOAD """;u$;""""
  758 GO TO 834
  759 REM LOAD tpi, caller handles error
  760 GO SUB 9: LET f0=f: LET u=1
  762 LOAD u$
  764 RETURN 
  769 REM NOP tpi cmd sync
  770 GO SUB 9: LET f0=f: LET u=1
  774 SAVE "tpi:nop"
  778 RETURN 
  779 REM Load dirinfo data
  780 GO SUB 9: LET f0=f: LET u=1
  784 LOAD "" DATA a$()
  786 RETURN 
  799 REM Main ON ERR handler
  800 LET err=PEEK 23739
  802 LET lin=PEEK 23736+256*PEEK 23737
  804 LET stm=PEEK 23738
  806 GO SUB 9: LET i=f-f0
  810 IF i>=300 THEN GO TO 830: REM Timeout
  812 IF err=13 OR err=21 THEN GO TO 850: REM Break
  814 IF err<>19 THEN GO TO 834: REM Not error J
  816 IF u>0 THEN LET u=-1: RETURN : REM Immediate error
  818 LET u=0: REM Reset after 1st error
  820 PAUSE 20: REM Wait a bit before retry
  822 GO TO lin: REM Retry command
  830 IF err<>19 THEN GO TO 834: REM Other err timeout
  832 PRINT INVERSE 1;"TS-Pico not responding."
  834 ON ERR \*
  836 PRINT INVERSE 1;"Error ";c$(err+1);" ";lin;":";stm
  839 STOP 
  850 ON ERR \*
  852 INPUT "BREAK: (S)top or (C)ontinue?";k$
  854 IF k$="s" OR k$="S" THEN STOP 
  856 ON ERR GO TO oe
  858 GO TO 2000
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
 1099 REM Delete
 1100 GO SUB 180
 1102 LET t$=a$(s,y(s) TO z(s))
 1104 IF s<3 OR s>d+2 THEN BEEP 0.1,0: GO TO 80
 1106 INPUT "Remove "+t$+" (y/N)?";k$
 1108 IF k$<>"y" AND k$<>"Y" THEN GO TO 80
 1110 LET u$="tpi:rm "+t$
 1112 PRINT #0;u$
 1114 GO SUB 770
 1116 GO SUB 710: INPUT ""
 1118 IF u>=0 THEN GO TO 1122
 1120 INPUT "rm failed. Press enter: ";k$
 1122 GO TO 2000
 1199 REM Make Dir
 1200 INPUT "New dir name: ";t$
 1202 IF t$="" THEN GO TO 80
 1204 IF LEN t$>10 THEN BEEP 0.1,0: GO TO 1200
 1206 LET u$="tpi:md "+t$
 1210 PRINT #0;u$
 1212 GO SUB 770
 1214 GO SUB 710: INPUT ""
 1216 IF u>=0 THEN GO TO 1220
 1218 INPUT "md failed. Press enter: ";k$
 1220 GO TO 2000
 2000 GO SUB 50
 2002 GO SUB 60
 2008 GO SUB 20
 2010 GO TO 80
 3000 REM help
 3002 CLS 
 3004 PRINT INVERSE 1;"TS-Pico Commander Help"
 3005 PRINT "Up/Down Move selection"
 3006 PRINT "Space   Move down"
 3007 PRINT "<-/->   Page up/down"
 3008 PRINT "EDIT    Move to first file"
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
 3039 PRINT "sym+X   Quit program"
 3090 INPUT "Press enter:";t$
 3099 GO TO 2008
 4000 REM ffw
 4010 IF NOT m THEN GO TO 80
 4012 CLS 
 4020 GO SUB 770: LET u$="tpi:ffw": GO SUB 700
 4030 GO SUB 770: LET u$="tpi:tapdir": GO SUB 750
 4040 GO SUB 900
 4050 PRINT #0; INVERSE 1;"L"; INVERSE 0;"oad, "; INVERSE 1;"C"; INVERSE 0;"ode, ";
# 4052 IF dock THEN PRINT #0; INVERSE 1;"M"; INVERSE 0;"erge, ";
 4054 PRINT #0; INVERSE 1;"<="; INVERSE 0;" or "; INVERSE 1;">=";
 4060 LET k$=INKEY$: LET k=CODE k$: IF k$="" THEN GO TO 4060
 4061 INPUT ""
 4062 IF k=200 THEN GO TO 4012
 4064 IF k=199 THEN GO TO 4100
 4066 IF k$="l" THEN GO TO 600
 4068 IF k$="c" THEN GO TO 620
# 4070 IF k$="m" AND dock THEN GO TO 600
 4098 GO TO 2008
 4100 IF NOT m THEN GO TO 80
 4110 CLS 
 4120 GO SUB 770: LET u$="tpi:rew": GO SUB 700
 4130 GO TO 4030
 4200 REM SAVE tpi cmd, no reload
 4210 CLS 
 4212 LET u$="tpi:"+t$
 4214 PRINT #0;u$
 4220 GO SUB 770: GO SUB 700
 4230 INPUT ""
 4232 PRINT #0;"Press a key..."
 4234 PAUSE 0: INPUT ""
 4236 GO TO 2008
 4300 REM SAVE tpi cmd, reload
 4310 CLS 
 4312 LET u$="tpi:"+t$
 4314 PRINT #0;u$
 4320 GO SUB 770: GO SUB 700
 4322 INPUT ""
 4324 PRINT #0;"Press a key..."
 4326 PAUSE 0: INPUT ""
 4330 GO TO 2000
 4400 REM LOAD tpi cmd, reload
 4410 CLS 
 4412 LET u$="tpi:"+t$
 4414 PRINT #0;u$
 4420 GO SUB 770: GO SUB 750
 4430 GO TO 4322
 4500 REM SAVE tpi, no reload, no CLS or prompt or redraw
 4510 LET u$="tpi:"+t$
 4512 PRINT #0;u$
 4520 GO SUB 770: GO SUB 700
 4530 INPUT ""
 4540 RETURN 
 4599 REM SAVE tpi, no reload, no echo, no prompt
 4600 CLS 
 4610 LET u$="tpi:"+t$
 4612 GO SUB 770: GO SUB 700
 4620 GO TO 4324
 4699 REM SAVE tpi, no reload, no prompt
 4700 CLS 
 4701 LET u$="tpi:"+t$
 4702 PRINT #0;u$
 4704 GO SUB 770: GO SUB 700
 4706 INPUT ""
 4708 GO TO 2008
 9000 REM Init
 9001 LET p=60: LET t$="": LET sz=1
 9002 LET fg=7: LET bg=1: LET bd=bg
 9003 LET ff=5: LET df=6: LET rd=1
 9004 LET s=-1: LET t=2: LET m=0
 9005 LET p$="": LET q=0: LET h=0
 9006 LET d$=CHR$ 16+CHR$ df: LET f$=CHR$ 16+CHR$ ff: LET g$=CHR$ 16+CHR$ fg
 9007 LET h$=d$+"    ..                          "+g$
 9009 LET oe=800: REM line num for ON ERR handling, 0=no on err
 9010 INK bg: PAPER bg: BORDER bd
 9011 FLASH 0: BRIGHT 0: OVER 0
 9012 INVERSE 0: CLS 
 9013 LET c$="0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ"
 9014 LET f0=0
 9019 REM Set error handling
 9020 IF oe THEN ON ERR GO TO oe
 9029 REM Turn off tpi:verbose
 9030 LET u$="tpi:verbose"
 9032 GO SUB 770: GO SUB 700
 9040 IF SCREEN$ (1,0)="V" THEN GO SUB 770: GO SUB 700
 9050 INK fg: CLS 
 9060 LET nxt=PEEK 23637+256*PEEK 23638
 9062 LET nxtlin=256*PEEK nxt+PEEK (nxt+1)
 9064 LET dock=nxtlin<>9062
 9099 RETURN 
# Variables
# a$(n,32)=dirinfo
# b$(n,36) same but with two sets of color control codes added
# d=num if dirs in a$
# f=num if files in a$
# n=d+f+2 = rows of a$
# z(i)=end of a$(i),i>2
# y(i)=start of a$(i)
# l$(n) holds the uppercase first letter of each file name
# p$(32)=path
# s=selected file
# m=mounted file num
# k$=INKEY$ k=CODE k$
# t$=tpi cmd or a file
# h=1 if line drawn is for selected file
# t=row in a$ and b$ of top line of listing on screen
# fg,gb = main foreground, background colors
# bd = border color
# ff = file foreground color
# df = directory foreground color
# rd = 
# d$ = df color codes
# f$ = ff color codes
# g$ = fg color codes
# h$ = constant ".." dir entry to set in b$(2)
# e$ = file extension
# oe = ON ERR error handling enabled
#
# 9199 REM Load machine code
# 9200 LET rt=PEEK 23730+256*PEEK 23731
# 9202 RETURN
#
# 9300 RESTORE
# 9302 LET ok=1: READ nb
# 9304 FOR a=1 TO nb
# 9306 READ x: IF PEEK (rt+a)<>x THEN LET ok=0: RETURN
# 9308 NEXT a
# 9310 RETURN
#
# 9400 CLEAR rt-nb
# 9402 GO SUB 9200
# 9404 RESTORE
# 9406 READ nb
# 9408 FOR a=1 TO nb
# 9410 READ x: POKE rt+a, x
# 9412 NEXT a
# 9414 RETURN
#
# 9500 DATA 0
#
# Steps for a dck file:
#
# SAVE "tpi:foo.dck": Mount dock file
# LOAD "" - Invoke dckupdate.tap which does the following:
#   Prompt for location 1 for SRAM, 2 for Flash
#   Prompt for slot sl=0:2:14
# SAVE "tpi:memdock"CODE loc,sl : Select location for Dock bank to be mapped to
# Patch MC to skip flash erase if loc=1
# SAVE "tpi:blkrcv" : ? Does this transfer now or queue data for transfer later?
# RANDOMIZE USR 32800 : Flash erasing LOWER 32Kb block
# RANDOMIZE USR 32600 : Flash erasing UPPER 32Kb block
# RANDOMIZE USR 32870 : Writing LOWER 32Kb block
# RANDOMIZE USR 32670 : Writing UPPER 32Kb block
# NEW : With the right data in mapped DOCK bank, the code will be run on restart

