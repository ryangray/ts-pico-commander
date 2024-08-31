    1 REM Read TS-Pico directory
    2 REM from its dirinfo.tap
    3 REM TODO: Integrate parts of ../helper/v1c/tpi.bas 
    4 REM TODO: Add cursor selection of file/dir
    5 REM Make keys select names, and space to bring up input prompt
    6 REM Could make shift 1 and 2 move up down and leave letters to type in
    7 REM a virtual input line at #0. Shift 7 is CD .. 
    8 REM Shift 5/8 are pgup/dn, shift+0 is rm, shift+9 is md, sym+D is tapdir
   10 GO SUB 9000
   12 GO TO 2000
   19 REM Show listing
   20 CLS : PRINT p$;
   22 LET l=2
   23 PRINT '; INVERSE 1;"FILE NAME                   SIZE"
   24 FOR i=0 TO d-1: LET l=l+1
   26 PRINT INK df;a$(i+3);
   27 IF l=21 THEN LET l=0: GO SUB 40: IF NOT m THEN RETURN 
   28 NEXT i
   32 FOR i=0 TO f-1: LET l=l+1
   33 LET x=i+d+3
   34 PRINT a$(x, TO 4); INK ff;a$(x,5 TO 22); INK fg;a$(x,23 TO );
   35 IF l=21 THEN LET l=0: GO SUB 40: IF NOT m THEN RETURN 
   36 NEXT i
   38 RETURN 
   39 REM More listing?
   40 PRINT #0;"More? (y/n)"
   42 PAUSE 0
   44 LET k$=INKEY$
   46 LET m=(k$<>"n" AND k$<>"N")
   48 RETURN 
   49 REM Get path
   50 CLS : DIM p$(32)
   52 LOAD "tpi:path"
   54 FOR i=0 TO 31
   56 LET p$(i+1)=SCREEN$ (2,i)
   57 NEXT i
   58 RETURN 
   59 REM Load dirinfo.tap
   60 CLS : LOAD "tpi:dirinfo.tap": PAUSE p
   61 LOAD "" DATA a$(): CLS : PRINT "Working..."
   62 LET d=VAL a$(1): LET f=VAL a$(2)
   63 LET n=d+f+2: DIM z(n): DIM y(n)
   64 FOR i=1+2 TO d+2: LET y(i)=1
   66 FOR j=32 TO 1 STEP -1: IF a$(i,j)<>" " THEN LET z(i)=j: GO TO 68
   67 NEXT j
   68 NEXT i
   70 FOR i=d+3 TO n: LET y(i)=5
   72 FOR j=22 TO 5 STEP -1: IF a$(i,j)<>" " THEN LET z(i)=j: GO TO 74
   73 NEXT j
   74 NEXT i
   78 RETURN 
 1999 REM Main input
 2000 GO SUB 60
 2002 GO SUB 50
 2008 GO SUB 20
 2010 INPUT "tpi:";t$
 2012 IF t$="" THEN STOP 
 2014 IF t$="?" THEN GO TO 2070
 2016 IF t$(1)="*" THEN GO TO 2052
 2018 IF t$="=" THEN LET t$="tapdir"
 2020 IF t$="+" THEN LET t$="ffw"
 2022 IF t$="-" THEN LET t$="rew"
 2024 IF t$="." THEN LET t$="path"
 2026 IF t$=".." THEN LET t$="cd .."
 2028 IF t$="dir" THEN GO TO 2004
 2030 IF t$="tapdir" THEN GO TO 2058
 2034 IF t$="ffw" THEN SAVE "tpi:ffw": GO TO 2056
 2036 IF t$="rew" THEN SAVE "tpi:rew": GO TO 2056
 2038 IF LEN t$>3 THEN IF t$( TO 3)="cd " THEN GO TO 2046
 2040 IF LEN t$>4 THEN IF t$(LEN t$-3 TO )=".tap" OR t$(LEN t$-3 TO )=".TAP" THEN GO TO 2052
 2042 SAVE "tpi:"+t$
 2044 GO TO 2008
 2046 SAVE "tpi:"+t$: PAUSE p
 2048 SAVE "tpi:cd ."
 2050 GO TO 2004
 2052 REM Mount a .tap file
 2054 LOAD "tpi:"+t$
 2056 PAUSE p
 2058 CLS : LOAD "tpi:tapdir"
 2060 PAUSE p
 2062 INPUT "tpi:";t$
 2064 IF t$=" " THEN LOAD ""
 2066 IF t$="  " THEN MERGE "": STOP 
 2068 GO TO 2012
 2070 REM Helper help
 2072 GO TO 2008
 9000 REM Init
 9001 LET p=60
 9002 LET fg=7: LET bg=1: LET bd=bg
 9003 LET ff=5: LET df=6
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
 9122 REM l=print lines
 9124 REM m=1=show more lines
 9126 REM k$=INKEY$
 9199 RETURN 
