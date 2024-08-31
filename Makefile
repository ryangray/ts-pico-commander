# Makefile for tc

tc.tap: tc.bas
	zmakebas -n tc -o tc.tap tc.bas
tca.tap: tc.bas
	zmakebas -a 1 -n tc -o tca.tap tc.bas
tca.dck: tca.tap
	tap2cart tca.tap
