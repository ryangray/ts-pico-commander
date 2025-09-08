   10 REM No file mounted!
   20 PAPER 7: INK 0: BORDER 7: FLASH 0: INVERSE 0
  100 GO SUB 500
  103 PRINT INK 0; PAPER 5;"LOAD ""tpi:..."" to mount from SD"
  104 PRINT "LOAD ""tpi:name.tap""  "; INK 1;"by name"
  105 PRINT "LOAD ""tpi:&nn""       "; INK 1;"by index #"
  106 PRINT "LOAD ""name"" "; INK 1;"loads from tap file"
  107 PRINT INK 0; PAPER 5; BRIGHT 0;"SAVE ""tpi:..."" for commands    "
  109 PRINT INK 1; PAPER 5;"            [CODE n,m]=optional"
  111 PRINT "SAVE ""tpi:close"" "; INK 1;"->unmount file"
  112 PRINT "SAVE ""tpi:tapdir""  "; INK 1;"[CODE 0/1,n]"
  113 PRINT "SAVE ""tpi:ffw""     "; INK 1;"[CODE n,0/1]"
  114 PRINT "SAVE ""tpi:rew""     "; INK 1;"[CODE n,0/1]"
  115 PRINT "SAVE ""tpi:append""  "; INK 1;"[CODE 0/1,1]"
  116 PRINT "SAVE ""tpi:dir""     "; INK 1;"[CODE idx,1]"
  117 PRINT "SAVE ""tpi:cd <name>"" "; INK 1;"[CODE 1,0]"
  118 PRINT "SAVE ""tpi:path""      "; INK 1;"[CODE 1,0]"
  119 PRINT "SAVE ""tpi:gethelp "; INK 1;"[.]"""
  120 PRINT "SAVE ""tpi:gethelp "; INK 1;"[command]"""
  130 GO SUB 300
  140 IF CODE k$=13 THEN GO TO 200
  150 GO TO 400
  200 GO SUB 500
  203 PRINT INK 0; PAPER 5;"         More commands         "
  204 PRINT "SAVE ""tpi:md <name>"" "; INK 1;"[CODE 1,0]"
  205 PRINT "SAVE ""tpi:rm <name>"" "; INK 1;"[CODE 1,0]"
  206 PRINT "SAVE ""tpi:getinfo"""
  207 PRINT "SAVE ""tpi:getlog""  "; INK 1;"[CODE n,0]"
  208 PRINT "SAVE ""tpi:getlog""CODE 0,255"
  209 PRINT "SAVE ""tpi:loglevel"" "; INK 1;"[CODE n,1]"
  210 PRINT "SAVE ""tpi:memboot"" "; INK 1;"[CODE loc,n]"
  211 PRINT "SAVE ""tpi:memdock"" "; INK 1;"[CODE loc,n]"
  212 PRINT "SAVE ""tpi:blkrcv""  "; INK 1;"[CODE n,m]"
  213 PRINT "SAVE ""tpi:zx48""    "; INK 1;"[CODE 1,0]"
  214 PRINT INK 0; PAPER 5;" TS-Pico mode "; INK 1;"<=>"; INK 0;" Hardware mode"
  215 PRINT """tpi:sdcard""  "; INK 1;"<=>"; INK 0;" ""tpi:tape"""
  216 PRINT """tpi:picopt""  "; INK 1;"<=>"; INK 0;" ""tpi:ts2040"""
  217 PRINT INK 0; PAPER 5;"SAVE ""name"" "; INK 1;"Save to name.tap if"'"            append mode is off."
  280 GO SUB 300
  290 IF CODE k$=13 THEN GO TO 100
  299 GO TO 400
  300 PRINT #0; INK 1;"ENTER for more        Other key SPACE for menu         to exit";
  310 LET k$=INKEY$: IF k$="" THEN GO TO 310
  320 INPUT ""
  330 IF k$=" " THEN CLS : STOP : LOAD ""
  340 RETURN 
  400 GO SUB 500
  410 PRINT "To load this again at any time:"''
  420 PRINT INK 1;"  SAVE ""tpi:close"""''
  430 PRINT INK 1;"  LOAD """""
  490 STOP 
  500 CLS 
  510 PRINT INK 5; PAPER 0;" TIMEX "; INK 0; PAPER 7; BRIGHT 1;" sinclair 2068 "; BRIGHT 0; INK 5; PAPER 0;" TS-Pico "
  520 PRINT 
  530 PRINT INK 7; PAPER 2;"    -- No file mounted! --     "
  540 PRINT 
  590 RETURN 
