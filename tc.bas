    1 REM TS-Pico Commander
    2 REM 3 August 2025
    3 REM By Ryan Gray
    4 REM 
# Init, Get the current path, Load directory info, and Draw the file screen
    5 GO SUB 9000: GO SUB 50: GO SUB 60: GO SUB 20
# Print key for help on first run
    6 PRINT AT 21,9; INK 0; PAPER 7;"? for help       v0.97"
# Jump to key loop
    7 GO TO 79
# Get FRAMES clock sub
    8 LET c=256*(256*PEEK 23674+PEEK 23673)+PEEK 23672: RETURN 
# NOP tpi cmd sync to force waiting for non-busy pico
    9 GO SUB 8: LET c0=c: LET u=1: REM NOP tpi cmd sync
   10 SAVE "tpi:nop": RETURN 
# SAVE tpi cmd u$, caller doesn't handle error
   11 GO SUB 8: LET c0=c: LET u=1: REM SAVE tpi, caller doesn't handle error
   12 SAVE u$: IF u>=0 THEN RETURN 
   13 PRINT INVERSE 1;"Failed: SAVE """;u$;"""": GO TO 834
# LOAD tpi cmd u$, caller doesn't handle error
   14 GO SUB 8: LET c0=c: LET u=1: REM LOAD tpi, caller doesn't handle error
   15 LOAD u$: IF u>=0 THEN RETURN 
   16 PRINT INVERSE 1;"Failed: LOAD """;u$;"""": GO TO 834
# LOAD dirinfo data
   17 GO SUB 8: LET c0=c: LET u=1: REM Load dirinfo data
   18 LOAD "" DATA a$(): RETURN 
# Draw current file screen sub
   19 REM Show listing
   20 INK fg: PAPER bg: BORDER bd: CLS 
   21 PRINT INK df; PAPER bd;p$
   22 PRINT INK 5; PAPER 0;" &  "; INK 0; PAPER 7;" NAME             "; PAPER 2; INK 4;"\ :"; INK 5; PAPER 0;"\:  SIZE   "
   23 IF rd THEN INK bd: PAPER ff: PLOT 0,166: DRAW 0,1: DRAW 1,0: PLOT 254,167: DRAW 1,0: DRAW 0,-1: INK fg: PAPER bg
   24 LET r=18: IF r+t>n THEN LET r=n-t
   25 FOR i=t TO r+t
   27 PRINT b$(i)
   29 NEXT i
   30 IF t<=m AND m<t+19 THEN PRINT AT m-t+2,0; FLASH 1; OVER 1; INK 8; PAPER 8;"    "
   31 LET h=1: GO SUB 150
   32 LET h=0
   34 PRINT AT 2,0;: REM move from bottom
   39 REM Status bar
   40 PRINT AT 21,0; INK 5; PAPER 0;" tpiCmdr"; INK 0; PAPER 7;"\:                        ";CHR$ 8;">" AND t+19<n;AT 0,0;
   42 IF m>0 THEN PRINT AT 21,9; INK 0; PAPER 7;m$;
   43 IF rd THEN INK bd: PAPER ff: PLOT 0,1: DRAW 0,-1: DRAW 1,0: PLOT 254,0: DRAW 1,0: DRAW 0,1: INK fg: PAPER bg
   48 RETURN 
# Get directory path sub
   49 REM Get path
   50 DIM p$(32)
   52 GO SUB 9: LET u$="tpi:path": GO SUB 14
   54 FOR i=0 TO 31
   56 LET p$(i+1)=SCREEN$ (4,i)
   57 NEXT i
   58 RETURN 
# Load directory info
   60 GO SUB 9: LET u$="tpi:dirinfo.tap": GO SUB 14
## Reset mounted file and top of listing
   61 LET m=-1: LET t=2: PRINT 
   62 GO SUB 9: GO SUB 17: REM LOAD "" DATA a$()
## Parse info
   63 PRINT '"Working";
   64 LET d=VAL a$(1): LET f=VAL a$(2): LET n=d+f+2: DIM z(n): DIM y(n): DIM l$(n): DIM b$(n,38): DIM e(n)
### Parse any directory names
   65 IF d=0 THEN GO TO 70
   66 FOR i=3 TO d+2: PRINT ".";: LET k$=a$(i,1): LET k=CODE k$
#### Set jump letter
   67 LET l$(i)=k$: IF k>=65 AND k<=90 THEN LET l$(i)=CHR$ (k+32)
#### Set display string
   68 LET b$(i)=d$+">   "+a$(i, TO 28)+g$+g$: LET y(i)=1: LET z(i)=32
   69 NEXT i
### Parse any file names
   70 IF f=0 THEN GO TO 75
   71 FOR i=d+3 TO n: PRINT ".";: LET y(i)=5: LET z(i)=22: LET k$=a$(i,5): LET k=CODE k$
#### Set jump letter
   72 LET l$(i)=k$: IF k>=65 AND k<=90 THEN LET l$(i)=CHR$ (k+32)
#### Set display string
   73 LET b$(i)=f$+a$(i, TO 4)+g$+a$(i,5 TO 22)+f$+a$(i,23 TO )
   74 NEXT i
### Finish display array
   75 LET b$(2)=h$
### Set .. name and listing page top
   76 LET a$(2)="..": LET s=2: IF q AND t$=".." THEN LET s=q: LET q=0: GO SUB 140
### Set jump letter
   77 LET l$(2)=".": LET y(2)=1: LET z(2)=2: IF p$="/TAP                            " THEN LET b$(2,8)=" ": LET a$(2,2)=" ": LET z(2)=1
   78 RETURN 
# Main key input loop
   79 LET j$="": INPUT ""
   80 LET k$=INKEY$: LET k=CODE k$: IF k$="" THEN GO TO 80: REM Main key input loop
   81 IF k=13 THEN GO TO 200: REM Enter
   82 IF (k=10 OR k$=" ") AND s<n THEN GO SUB 150: LET s=s+1: LET x=1: GO TO 160: REM sh+6 Down
   83 IF k=11 AND s>2 THEN GO SUB 150: LET s=s-1: GO TO 160: REM sh+7 Up
   84 IF k=8 AND s-19>=2 THEN GO SUB 150: LET s=s-19: GO TO 160: REM sh+5 pgup
   85 IF k=9 AND s+19<=n THEN GO SUB 150: LET s=s+19: GO TO 160: REM sh+8 pgdn
   86 IF k=9 AND t+19<=n THEN GO SUB 150: LET s=t+19: GO TO 160: REM sh+8 pgdn close to end
   87 IF k$="#" OR k$="&" THEN LET j$="&": INPUT "": PRINT #0; INK df;j$: GO TO 80
   88 IF k$>="0" AND k$<="9" THEN IF j$<>"" THEN LET j$=j$+k$: INPUT "": PRINT #0; INK df;j$: LET k$="": LET i=VAL j$(2 TO ): IF f>i THEN GO SUB 150: LET s=d+3+i: GO TO 160: REM num jump
   90 IF k=12 AND j$<>"" THEN LET j$=j$( TO LEN j$-1): INPUT "": PRINT #0; INK df;j$: GO TO 80: REM sh+0
   91 IF k=200 THEN IF m>=1 THEN CLS : GO TO 4000: REM >= ffw
   92 IF k=199 THEN IF m>=1 THEN CLS : GO TO 4100: REM <= rew
   93 IF k$="." THEN LET t$="..": GO TO 310: REM CD ..
   94 IF k$="/" THEN LET t$="verbose": GO TO 4800: REM sym+V
   95 IF k=7 THEN GO SUB 150: LET s=2: LET j$="": GO TO 160: REM sh+1 jump to first file
   96 IF k$=":" THEN GO TO 400: REM tpi cmd
   97 IF k$="+" THEN GO TO 470: REM sym+K tapdir
   98 IF k=172 THEN LET t$="getinfo": GO TO 4200: REM sym+I
   99 IF k$="=" THEN LET t$="getlog": GO TO 4700: REM sym+L
  100 IF k$="%" THEN LET t$="close": LET m=0: GO SUB 4500: PRINT AT 0,0;: GO SUB 21: GO TO 79
  101 IF k$="^" THEN LET t$="gethelp": GO TO 4300: REM sym+H
  102 IF k$="?" THEN GO TO 3000: REM TC help
  103 IF k$="-" THEN GO TO 200: REM sym+J mount+LOAD ""
  104 IF k$="!" THEN GO TO 650: REM Reset
  105 IF k=205 THEN GO TO 1200: REM STEP (sym+D) MD
  106 IF k=226 THEN GO TO 460: REM sym+A Append
  107 IF k=96 THEN GO TO 500: REM sym+X
  108 IF k$="_" THEN GO TO 1100: REM sym+0 Delete file  
  109 IF k$>="!" AND k$<="z" THEN IF j$="" THEN GO TO 170: REM letter jump
#  108 IF k=6 THEN REM sh+2
#  109 IF k=4 THEN REM sh+3
#  110 IF k=5 THEN REM sh+4
#  111 IF k=15 THEN REM sh+9
  129 IF NOT x THEN GO TO 80
# Find length of selected name
  130 IF a$(s,z(s))<>" " THEN LET x=0: GO TO 80
  134 LET k$=INKEY$: LET k=CODE k$: IF k$<>"" THEN GO TO 81
  136 IF z(s)>y(s) THEN LET z(s)=z(s)-1: GO TO 130
  139 GO TO 80
  140 REM Calc page top t from s
  142 LET t=2+19*INT ((s-2)/19)
  144 IF t<2 THEN LET t=2
  146 IF t>n THEN LET t=n-18: GO TO 144
  148 RETURN 
# Redraw current selection line (h=1 highlight it, or h=0 not)
  150 PRINT AT s-t+2,0; INVERSE h;b$(s);
  152 IF s=m THEN PRINT AT s-t+2,0; INVERSE h; FLASH 1; OVER 1; INK 8; PAPER 8;"    "
  154 RETURN 
# Update page top t to include displaying current selection s, and redraw if needed
  160 REM Disp is b$(t TO t+18) update t to include s and redraw if needed
  161 LET r=t+18: IF r>n THEN LET r=n: REM disp is t to r
  162 IF s>=t AND s<=r THEN LET h=1: GO SUB 150: LET h=0: GO TO 129
  163 GO SUB 140
  166 GO SUB 20: INPUT "": PRINT #0; INK df;j$: GO TO 129
# Skip to next entry starting with letter k$
  169 REM Skip to letter
  170 LET t$=l$(s)
  171 LET i=0: LET h=0: GO SUB 150
#  172 IF k$>="a" AND k$<="z" THEN LET k$=CHR$ (CODE k$-32)
  173 IF k$=t$ THEN IF s<n THEN IF l$(s+1)=k$ THEN LET s=s+1: GO SUB 150: GO TO 160
  174 IF k$=t$ AND s=n THEN GO TO 79
  175 LET s=s+1: IF s>n THEN LET s=2: LET i=1
  176 LET t$=l$(s)
  178 IF k$<>t$ AND i=0 THEN GO TO 175
  179 GO TO 160
# Get end column of name of selection into z(s) and trimmed name into t$
  180 REM Put trimmed a$(s) into t$ 
  182 IF a$(s,z(s))<>" " THEN GO TO 188
  184 FOR j=z(s) TO y(s) STEP -1: IF a$(s,j)<>" " THEN LET z(s)=j: GO TO 188
  186 NEXT j
  188 LET t$=a$(s,y(s) TO z(s)): RETURN 
# Get selected file size into sz
#  190 LET sz=VAL a$(s,23 TO 30)
#  193 IF a$(s,31)="K" THEN LET sz=sz*1024
#  194 LET sz=sz/1024/16
#  196 IF sz<1 THEN LET sz=1
#  198 RETURN 
# Enter pressed on item
  199 REM Enter pressed on item
  200 IF m=s THEN GO TO 238: REM Already mounted
  201 INPUT "": PRINT #0; INK df;a$(s,y(s) TO z(s)): GO SUB 180: IF s<=d+2 THEN GO TO 300: REM is a dir
  202 LET h=0: GO SUB 150: LET h=1: GO SUB 150: REM File as displayed
  203 LET m=s
  204 REM Get .ext
  205 LET e$="": LET l=LEN t$
  206 FOR i=l TO 1 STEP -1
  207 IF t$(i)="." THEN LET e$=t$(i TO l): LET n$=t$( TO i-1): GO TO 210
  208 NEXT i
## Get file extension, ask if needed to confirm or get
  209 LET n$=t$
  210 IF e$="" THEN GO TO 226
  211 INPUT "": IF l-i>=3 THEN GO TO 230
  212 LET x$="": IF e$=".ta" OR e$=".TA" OR e$=".t" OR e$=".T" THEN LET x$=".tap"
  213 IF e$=".dc" OR e$=".DC" OR e$=".d" OR e$=".D" THEN LET x$=".dck"
  214 IF e$=".bi" OR e$=".BI" OR e$=".b" OR e$=".B" THEN LET x$=".bin"
  215 IF e$=".ro" OR e$=".RO" OR e$=".r" OR e$=".R" THEN LET x$=".rom"
  216 IF x$<>"" THEN PRINT #0; INK df;"Is the extension """;(x$);"""? (y/n)";
  220 IF x$="" THEN PRINT #0; INK df;"Found extension of """;(e$);""","'"correct (y/n)? ";
  221 LET k$=INKEY$: IF k$="" THEN GO TO 221
  222 IF k$="n" OR k$="N" THEN PRINT #0;k$: GO TO 226
  223 IF k$<>"y" AND k$<>"Y" THEN GO TO 221
  224 PRINT #0;k$: IF x$<>"" THEN LET e$=x$: GO TO 229
  225 GO TO 230
  226 INPUT "What is the extension? ";e$
  227 IF e$="" THEN GO TO 230
  228 IF e$(1)<>"." THEN LET e$="."+e$
  229 LET t$=n$+e$
## Mount the file
  230 PRINT #0; INK df;"Mounting: ";t$
  231 GO SUB 9
  232 IF e$="" OR LEN t$-LEN e$>10 THEN PRINT #0;" (as ""&";a$(s, TO 3);""")": LET u$="tpi:&"+a$(s, TO 3): GO SUB 760: GO TO 235
  234 LET u$="tpi:"+t$: GO SUB 760
  235 IF u<0 THEN GO SUB 450: GO TO 2008
# Set color of file to normal in case it was error color
  236 LET e(s)=0: LET b$(s,8)=CHR$ fg
  237 LET m$=t$
  238 ON ERR RESET : IF oe THEN ON ERR GO TO oe
  239 IF e$=".tap" OR e$=".TAP" THEN CLS : GO TO 250
  240 IF e$="" THEN GO TO 248: REM no ext, mount only
  241 IF e$=".dck" OR e$=".DCK" THEN GO TO 260
  242 IF e$=".rom" OR e$=".ROM" THEN GO TO 260
  244 IF e$=".bin" OR e$=".BIN" THEN GO TO 260
  246 REM Other type, just mount only
  248 INPUT "": GO TO 2008
  250 IF k=45 THEN GO TO 600: REM Skip to LOAD ""
  252 IF k=226 THEN GO TO 4150: REM On-demand mount for append
  254 GO TO 4030
## DCK ROM BIN loading
  260 REM DCK ROM BIN loading
  262 IF k$="-" THEN GO TO 600
  264 PRINT #0; INK df;"Load (y/n)? ";
  270 LET k$=INKEY$: IF k$="" THEN GO TO 270
  280 IF k$="y" OR k$="Y" THEN PRINT #0;k$: GO TO 600
  282 IF k$="n" OR k$="N" THEN PRINT #0;k$: GO TO 2008
  290 GO TO 270
  300 REM cd
  302 LET q=s
  310 LET u$="tpi:cd "+t$
  311 INPUT "": PRINT #0; INK df;u$
  320 GO SUB 9: GO SUB 710
  321 IF u<0 THEN GO SUB 450
  330 INPUT "": GO TO 2000
# General tpi command (except for mounting)
  400 REM tpi command
  410 INPUT "tpi:";t$
  420 IF t$="" THEN GO SUB 20: GO TO 79
  430 IF t$="dir" OR t$="path" OR t$="tapdir" THEN GO TO 4400
  432 IF LEN t$>=3 AND t$( TO 3)="cd " THEN LET m=0
  440 GO TO 4300
  450 INPUT FLASH 1;"Failed"; FLASH 0;": ";(t$)'"Press Enter:";k$
# Set color of file name to error color
  452 LET e(s)=1: IF s<d+2 THEN LET b$(s,2)=CHR$ 2
  453 LET b$(s,8)=CHR$ 2
  454 RETURN 
  459 REM Append toggle
# If selected file is not mounted, then mount it first
  460 IF s=m THEN GO TO 4150
  462 IF m<1 AND s<d+2 THEN BEEP 0.1,10: GO TO 79
  464 GO TO 200
  469 REM tapdir
  470 IF s=m THEN CLS : GO TO 4030
  472 IF m<1 AND s<d+2 THEN BEEP 0.1,10: GO TO 79
  474 GO TO 200
# Switch running from AROS to BASIC and exit
## We could use the Toolkit method to stash these vars and restore regular BASIC vars for the BASIC system, but that would need MC
  500 REM Switch running from AROS to BASIC
  502 IF m=-1 THEN LET t$="close": GO SUB 4500: REM unmount dirinfo.tap
  510 INK 0: PAPER 7: BORDER 7: CLS 
  512 IF oe THEN ON ERR RESET  
  520 IF NOT dock THEN STOP : REM Already in HOME bank
  522 GO SUB 530
  523 INPUT "Turn off DOCK on NEW (y/N)? ";k$
  524 IF k$="y" OR k$="Y" THEN GO TO 529
#                      1111111111222222222233
#     PRINT "01234567890123456789012345678901"
  525 PRINT '"To turn off running the DOCK"
  526 PRINT "program after NEW, use:"
  527 PRINT " SAVE ""tpi:memdock""CODE 2,0"
  528 POKE 23750,0: STOP 
  529 SAVE "tpi:memdock"CODE 2,0: POKE 23750,0: STOP 
  530 PRINT "Exiting DOCK bank to HOME bank."
  532 PRINT "Use NEW to run TC again, or use"
  534 PRINT " POKE 23750,128: RUN"
  536 PRINT "to preserve the BASIC program."
  538 PRINT '"If you switch DOCK banks, use"
  540 PRINT " SAVE ""tpi:memdock""CODE m,n"
  542 PRINT "first, where m is 1 for SRAM or"
  544 PRINT "2 for flash, and n is the bank"
  546 PRINT "that TC was loaded into."
  559 RETURN 
# Do a LOAD "" on mounted file (handling if in DOCK and if .dck file)
  600 IF m<1 THEN BEEP 0.1,0: GO TO 2008
  601 INK 0: PAPER 7: BORDER 7: CLS : ON ERR RESET 
  602 IF dock THEN GO TO 604
  603 LOAD "": STOP 
  604 IF e$=".dck" OR e$=".DCK" OR e$=".rom" OR e$=".ROM" OR e$=".bin" OR e$=".BIN" THEN GO TO 607
  605 PRINT "Use NEW to run TC again."
  606 POKE 23750,0: LOAD "": STOP 
  607 GO SUB 530
  608 PRINT '"To run "; INK 2;a$(s,y(s) TO z(s)); INK 0;","'"you need to do "; INK 1;"LOAD """""; INK 0;" manually"'"after the system restarts."'': INPUT "Restart (Y/n)? ";k$
  609 IF k$="n" OR k$="N" THEN GO TO 2008
  610 SAVE "tpi:memdock"CODE 2,0: POKE 23750,0: NEW 
  620 IF m<1 THEN BEEP 0.1,0: GO TO 2008
## LOAD code from .tap
  622 LOAD ""CODE 
  624 GO TO 4230
## MERGE from .tap
  630 MERGE ""
  632 INPUT "Exit to BASIC? (y/N):";k$
  634 IF k$="y" OR k$="Y" THEN GO TO 500
  636 GO TO 4230
# "Reset" by closing file and change to root dir
  649 REM Reset
  650 GO SUB 9
  652 LET u$="tpi:close": GO SUB 11
  660 GO SUB 9
  662 LET u$="tpi:cd /": GO SUB 11
  670 LET m=0
  680 GO TO 2000
# SAVE tpi cmd u$, caller handles error
  709 REM SAVE tpi, caller handles error
  710 GO SUB 8: LET c0=c: LET u=1
  712 SAVE u$
  714 RETURN 
# LOAD tpi cmd u$, caller handles error
  759 REM LOAD tpi, caller handles error
  760 GO SUB 8: LET c0=c: LET u=1
  762 LOAD u$
  764 RETURN 
# LOAD dirinfo data
  779 REM Load dirinfo data
  780 GO SUB 8: LET c0=c: LET u=1
  784 LOAD "" DATA a$()
  786 RETURN 
  799 REM Main ON ERR handler
# Caller sets u$ to tpi command, including "tpi:".
# Caller then uses GO SUB 9 to sync with idle pico.
# Caller then uses GO SUB 11 or 710 to issue u$ as a SAVE command.
# If the call returns, the command suceeded. If an immediate error occurred, 
# then the routine will stop the program after printing the error.
# If you want to handle an immediate error (file does not exist when mounting 
# for example), call GO SUB 710 and check if u<0 on return.
# When call returns, if u>0 then command suceeded immediately. If it is 0, then
# the command had to wait but suceeded. If u<0 then the command failed 
# immediately, meaning the command was bad, the file or directory was not found,
# but the pico is still responding. 
# For example:
#   GO SUB 9: REM Wait for idle
#   LET u$="tpi:cd "+d$
#   GO SUB 11: REM SAVE tpi
#   IF u<0 THEN PRINT "Directory ";d$;" not found"
# For a LOAD tpi command, call GO SUB 14 or 760
# Main ON ERR handler
## Get details of error
  800 LET err=PEEK 23739
  802 LET lin=PEEK 23736+256*PEEK 23737
  804 LET stm=PEEK 23738
## Get time since c0
  806 GO SUB 8: LET i=c-c0
  810 IF i>=300 THEN GO TO 830: REM Timeout
  812 IF err=13 OR err=21 THEN GO TO 850: REM Break
  814 IF err<>19 THEN GO TO 834: REM Not error J
  816 IF u>0 THEN LET u=-1: RETURN : REM Immediate error
  818 LET u=0: REM Reset after 1st error
  820 PAUSE 20: REM Wait a bit before retry
  822 GO TO lin: REM Retry command
  830 IF err<>19 THEN GO TO 834: REM Other err timeout
## Pico not responding, reset ON ERR, show error and stop
  832 PRINT INVERSE 1;"TS-Pico not responding."
  834 ON ERR RESET 
  836 PRINT INVERSE 1;"Error ";c$(err+1);" ";lin;":";stm
  839 STOP 
## Error from a BREAK 
  850 ON ERR RESET 
  852 INPUT "BREAK: (S)top or (C)ontinue?";k$
  854 IF k$="s" OR k$="S" THEN STOP 
  856 ON ERR GO TO oe
  858 GO TO 2000
# Sniff tapdir listing to get current file name into t$ (not used yet)
  899 REM Sniff tapdir listing (type in t$, name in u$)
  900 LET i=5: LET t$="": LET u$=""
  910 IF SCREEN$ (i,0)=">" THEN GO TO 920
  912 LET i=i+1
  914 IF i>21 THEN RETURN 
  918 GO TO 910
  920 IF SCREEN$ (i,19)="N" THEN GO TO 930
# This could be used to customize the tapdir menu, but it
# will make it slower to show the screen each time.
  922 LET j=31
  924 LET k$=SCREEN$ (i,j): LET j=j-1
  926 IF k$=" " AND j>=22 THEN GO TO 924
  928 LET u$=k$+u$: GO TO 924
  930 LET i=i+1: IF SCREEN$ (i,19)="Y" THEN RETURN 
  932 FOR j=1 TO 10
  934 LET k$=SCREEN$ (i,j+21)
  936 LET t$=t$+k$
  938 NEXT j
  939 RETURN 
# Get mounted file extension from getinfo screen
  950 CLS : GO SUB 9: LET i=11
  952 LET u$="tpi:getinfo": GO SUB 11
  954 IF SCREEN$ (i,0)<>">" THEN LET i=i+1: GO TO 954
  956 LET i=i-1: LET j=31: LET e$=""
  958 IF SCREEN$ (i,j)=" " THEN LET j=j-1: GO TO 958
  960 LET e$=e$+SCREEN$ (i,j): IF e$(1)="." THEN RETURN 
  962 IF j=0 THEN LET j=31: LET i=i-1
  964 IF e$=": none" THEN LET e$="": RETURN 
  966 GO TO 960
# Delete (tpi:rm) Directory only right now. Should change ts-pico to rm=delete file and rmdir=delete directory
 1099 REM Delete
 1100 GO SUB 180
 1104 IF s<3 OR s>d+2 THEN BEEP 0.1,0: GO TO 79: REM rmdir only for now
 1106 INPUT "Remove "+t$+" (y/N)?";k$
 1108 IF k$<>"y" AND k$<>"Y" THEN GO TO 79
 1110 LET u$="tpi:rm "+t$
 1112 PRINT #0; INK df;u$
 1114 GO SUB 9
 1116 GO SUB 710: INPUT ""
 1118 IF u>=0 THEN GO TO 1122
 1120 INPUT "rm failed. Press enter: ";k$
 1122 GO TO 2000
# Make new directory (tpi:md)
 1199 REM Make Dir
 1200 INPUT "New dir name: ";t$
 1202 IF t$="" THEN GO TO 79
 1204 IF LEN t$>10 THEN BEEP 0.1,0: GO TO 1200
 1206 LET u$="tpi:md "+t$
 1210 PRINT #0; INK df;u$
 1212 GO SUB 9
 1214 GO SUB 710: INPUT ""
 1216 IF u>=0 THEN GO TO 1220
 1218 INPUT "md failed. Press enter: ";k$
 1220 GO TO 2000
# Main display and re-get dirinfo
 2000 CLS : PRINT ''
 2002 GO SUB 50
 2004 GO SUB 60
 2008 GO SUB 20
 2010 GO TO 79
# Show key help
 3000 REM help
 3002 CLS 
 3004 PRINT INK 5; PAPER 0;" TIMEX "; INK 0; PAPER 7;" TS-Pico Commander "; INK 2; PAPER 0;" H"; INK 6;"e"; INK 4;"l"; INK 5;"p "
 3005 PRINT INK df;"Up/Down"; INK fg;" Move selection"
 3006 PRINT INK df;"Space  "; INK fg;" Move down"
 3007 PRINT INK df;"<- / ->"; INK fg;" Page up/down"
 3008 PRINT INK df;"EDIT   "; INK fg;" Move to first file"
 3009 PRINT INK df;"&nnn   "; INK fg;" Skip to file by number"
 3010 PRINT INK df;"DELETE "; INK fg;" Backspace skip to number"
 3011 PRINT INK df;"a-z    "; INK fg;" Skip to file by letter"
 3012 PRINT INK df;"Enter  "; INK fg;" Mount file or change dir"
 3013 PRINT INK df;"%      "; INK fg;" Close mounted file"
 3014 PRINT INK df;". or / "; INK fg;" cd .. or cd /"
 3015 PRINT INK df;">=     "; INK fg;" ffw & tapdir"
 3016 PRINT INK df;"<=     "; INK fg;" rew & tapdir"
 3020 PRINT INK df;"sym+J  "; INK fg;" LOAD """"   sym+K  tapdir"
 3022 PRINT INK df;"sym+I  "; INK fg;" getinfo   sym+D  md"
 3024 PRINT INK df;"sym+H  "; INK fg;" gethelp   sym+A  append"
 3026 PRINT INK df;"sym+L  "; INK fg;" getlog    sym+V  verbose"
 3028 PRINT INK df;":      "; INK fg;" Enter a tpi command"
 3030 PRINT INK df;"!      "; INK fg;" Reset: close,cd /"
 3032 PRINT INK df;"sym+0  "; INK fg;" Remove empty directory"
 3034 PRINT INK df;"sym+X  "; INK fg;" Quit program"
 3090 INPUT "Press enter:";t$
 3099 GO TO 2008
# Fast-forward (tpi:ffw) Reshows tapdir after
 4000 REM ffw
 4020 GO SUB 9: LET u$="tpi:ffw": GO SUB 11
 4030 GO SUB 9: LET u$="tpi:tapdir": GO SUB 14
#Load Merge Code Append <= >= X
 4050 PRINT #0; INK df; INVERSE 1;"L"; INVERSE 0;"oad "; INVERSE 1;"C"; INVERSE 0;"ode ";
# MERGE could be available in the utility version
# 4052 IF dock THEN PRINT #0;INK df; INVERSE 1;"M"; INVERSE 0;"erge ";
 4054 PRINT #0; INK df; INVERSE 1;"A"; INVERSE 0;"ppend ";
 4056 PRINT #0; INK df; INVERSE 1;"<="; INVERSE 0;" "; INVERSE 1;">=";
 4058 PRINT #0; INK df;" "; INVERSE 1;"X"
 4060 LET k$=INKEY$: LET k=CODE k$: IF k$="" THEN GO TO 4060
 4061 INPUT ""
 4062 IF k=200 THEN PRINT AT 0,0;: GO TO 4000
 4064 IF k=199 THEN PRINT AT 0,0;: GO TO 4100
 4066 IF k$="l" THEN GO TO 600
 4068 IF k$="c" THEN GO TO 620
 4070 IF k$="a" THEN GO TO 4150
# 4070 IF k$="m" AND dock THEN GO TO 600
 4098 GO TO 2008
 4099 REM rew
 4100 GO SUB 9: LET u$="tpi:rew": GO SUB 11
 4130 GO TO 4030
 4150 LET t$="append"
 4154 GO TO 4800
# Other common pattern helpers
 4200 REM SAVE tpi cmd, no reload
 4210 CLS 
 4212 LET u$="tpi:"+t$
 4214 PRINT #0; INK df;u$
 4220 GO SUB 9: GO SUB 11
 4230 INPUT ""
 4232 PRINT #0; INK df;"Press a key..."
 4234 PAUSE 0: INPUT ""
 4236 GO TO 2008
 4300 REM SAVE tpi cmd, reload
 4310 CLS 
 4320 LET u$="tpi:"+t$
 4330 PRINT #0; INK df;u$
 4340 GO SUB 9: GO SUB 11
 4350 INPUT "": PRINT #0; INK df;"Press a key..."
 4360 PAUSE 0: INPUT ""
 4370 GO TO 2000
## LOAD tpi cmd, reload
 4400 REM LOAD tpi cmd, reload
 4410 CLS : LET u$="tpi:"+t$
 4420 PRINT #0; INK df;u$
 4430 GO SUB 9: GO SUB 14
 4440 GO TO 4322
## SAVE tpi, no reload, no CLS or prompt or redraw
 4500 REM SAVE tpi, no reload, no CLS or prompt or redraw
 4510 LET u$="tpi:"+t$
 4520 PRINT #0; INK df;u$
 4530 GO SUB 9: GO SUB 11
 4540 INPUT ""
 4550 RETURN 
 4599 REM SAVE tpi, no reload, no echo, no prompt
 4600 CLS : LET u$="tpi:"+t$
 4610 GO SUB 9: GO SUB 11
 4620 GO TO 4350
 4699 REM SAVE tpi, no reload, no prompt
 4700 CLS : LET u$="tpi:"+t$
 4702 PRINT #0; INK df;u$
 4704 GO SUB 9: GO SUB 11
 4706 INPUT ""
 4708 GO TO 2008
 4799 REM Save tpi, no reload, no prompt, getinfo 
 4800 CLS : LET u$="tpi:"+t$
 4810 PRINT #0; INK df;u$
 4820 GO SUB 9: GO SUB 11
 4830 INPUT ""
 4840 LET t$="getinfo"
 4850 GO TO 4200
# Initialization
 9000 REM Init
 9001 LET p=60: LET t$="": LET x=0
#: LET sz=1
 9002 LET fg=7: LET bg=1: LET bd=bg
 9003 LET ff=5: LET df=6: LET rd=1
 9004 LET s=-1: LET t=2: LET m=0
 9005 LET p$="": LET q=0: LET h=0
 9006 LET d$=CHR$ 16+CHR$ df: LET f$=CHR$ 16+CHR$ ff: LET g$=CHR$ 16+CHR$ fg
 9007 LET h$=d$+">   ..                          "+g$+g$
 9009 LET oe=800: REM line num for ON ERR handling, 0=no on err
 9010 INK bg: PAPER bg: BORDER bd
 9011 FLASH 0: BRIGHT 0: OVER 0
 9012 INVERSE 0: CLS 
 9013 PRINT INK 5; PAPER 0;" TIMEX "; INK 0; PAPER 7;" TS-Pico Commander "; INK 5; PAPER 0;" 0.97 "
 9014 LET c$="0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ"
 9015 LET c0=0: LET j$="": DIM m$(22)
 9019 REM Set error handling
 9020 IF oe THEN ON ERR GO TO oe
 9029 REM Turn off tpi:verbose
 9030 LET u$="tpi:verbose"
 9032 GO SUB 9: GO SUB 11
 9040 IF SCREEN$ (2,0)="V" THEN GO SUB 9: GO SUB 11
 9050 INK fg
## Determine if we are running from the DOCK bank
 9060 LET nxt=PEEK 23637+256*PEEK 23638
 9062 LET nxtlin=256*PEEK nxt+PEEK (nxt+1)
 9064 LET dock=nxtlin<>9062
 9099 RETURN 
# Variables
# a$(n,32)=dirinfo
# b$(n,38) same but with three sets of color control codes added
# d=num if dirs in a$
# e(n) = If file mounting had an error previously
# f=num if files in a$
# n=d+f+2 = rows of a$
# z(i)=end of a$(i),i>2
# y(i)=start of a$(i)
# l$(n) holds the uppercase first letter of each file name
# p$(32)=path
# s=selected file
# m=mounted file num (-1 if dirinfo.tap is mounted)
# x = Are we determining the file name length?
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
# e$ = file extension
# f$ = ff color codes
# g$ = fg color codes
# h$ = constant ".." dir entry to set in b$(2)
# j$ = multi-digit typing for jumping by number
# m$ = mounted file name (with corrected extension)
# oe = ON ERR error handling enabled
#
# Steps for a dck file:
#
# LOAD "tpi:foo.dck": Mount dock file
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

