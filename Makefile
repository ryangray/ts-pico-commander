# Makefile for tc

check: tcn.tap
	grep -v -e "^#" -e "^$$" tc.bas > tc-check1.bas
	listbasic tcn.tap > tc-check2.bas
	code -d tc-check1.bas tc-check2.bas

tcn.tap: tc.bas
	zmakebas -n tc -o tcn.tap tc.bas

tc.tap: tc.bas
	zmakebas -a 1 -n tc -o tc.tap tc.bas

tc.dck: tc.tap
	tap2cart tc.tap

sd: tc.tap
	cp tc.tap /media/ryan/LEXAR64/TAP

nofile_menu.tap: tc.bas
	zmakebas -a 1 -n menu -o nofile_menu.tap tc.bas

nofile_help.tap: nofile_help.bas
	zmakebas -a 1 -n "No file!" -o nofile_help.tap nofile_help.bas

nofile.tap: nofile_help.tap nofile_menu.tap
	cat nofile_help.tap nofile_menu.tap > nofile.tap

getnew:
	listbasic /media/ryan/LEXAR64/TAP/tc.tap > tc-new.bas
	code -d tc-new.bas tc.bas

dist: menu.zip

menu.zip: tc.dck tc.tap tc.bas nofile.tap nofile_help.bas
	zip menu.zip tc.tap tc.dck tc.bas nofile.tap nofile_help.bas
