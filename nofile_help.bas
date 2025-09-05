 10 REM No file mounted!
 20 PAPER 7: INK 0: BORDER 7: FLASH 0: INVERSE 0
100 GO SUB 500
103 PRINT INK 7;PAPER 0;BRIGHT 1;"    Mount a File with LOAD:     "
104 PRINT "LOAD ""tpi:name.ext""   by name"
105 PRINT "LOAD ""tpi:&nn""        by index"
106 PRINT "SAVE ""tpi:tpi:close""  unmount"
#          01234567890123456789012345678901abcd
107 PRINT INK 7;PAPER 0;BRIGHT 1;"  All other commands are SAVE:  "'"SAVE ""tpi:command"": [ ]->option"
109 PRINT """name"" > name.tap if append off"
110 PRINT """tpi:append""[CODE 0/1,1]"
111 PRINT """tpi:dir""[CODE n,1]",
112 PRINT """tpi:path""[CODE 1,0]",
113 PRINT """tpi:cd <name>""[CODE 1,0]"
114 PRINT """tpi:md <name>""[CODE 1,0]"
115 PRINT """tpi:rm <name>""[CODE 1,0]"
#          01234567890123456789012345678901abcd
116 PRINT """tpi:tapdir""[CODE 0/1,n]"
117 PRINT """tpi:ffw"" [CODE n,0/1]"
118 PRINT """tpi:rew"" [CODE n,0/1]"
119 PRINT """tpi:gethelp"""
120 PRINT """tpi:gethelp <command>"""
#
130 GO SUB 300
140 IF CODE k$<>13 THEN STOP
200 GO SUB 500
#                                 01234567890123456789012345678901abcd
203 PRINT INK 7;PAPER 0;BRIGHT 1;"      More SAVE commands:       "
204 PRINT """tpi:getinfo"""
205 PRINT """tpi:getlog"" [CODE n,0]"
206 PRINT """tpi:getlog"" CODE 0,255"
207 PRINT """tpi:verbose""[CODE 0/1,1]"
208 PRINT """tpi:memboot""[CODE n,m]"
209 PRINT """tpi:memdock""[CODE n,m]"
210 PRINT """tpi:blkrcv"" [CODE n,m]"
211 PRINT """tpi:sdcard""","""tpi:picopt"""
212 PRINT """tpi:tape""","""tpi:ts2040"""
213 PRINT """tpi:zx48""[CODE 1,0]"
280 GO SUB 300
290 IF CODE k$=13 THEN GO TO 100
299 STOP
#
300 PRINT #0;"Press SPACE for menu, Enter for more, or other to exit:"
#             01234567890123456789012345678901abcd
310 LET k$=INKEY$: IF k$="" THEN GO TO 310
320 IF k$=" " THEN INPUT "": CLS: LOAD ""
330 RETURN
500 CLS
510 PRINT INK 5; PAPER 0;" TIMEX ";INK 0;PAPER 7; BRIGHT 1;" sinclair 2068 "; BRIGHT 0;INK 5;PAPER 0;" TS-Pico "
520 PRINT
530 PRINT FLASH 1; INK 2;"    -- No file mounted! --     "
590 RETURN
