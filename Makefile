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

getnew:
	listbasic tc.tap > tc-new.bas
	code -d tc-new.bas tc.bas
