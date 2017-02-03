call getlength %1
set /a x=(%3 / 2) - (!return! / 2)
batbox /g !x! %2 /d %1