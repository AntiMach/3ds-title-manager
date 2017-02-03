set str=%~1
set return=0
:loop
if defined str (
	set str=!str:~1!
	set /a return+=1
	goto loop
)