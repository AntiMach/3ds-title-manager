set prefix=%2

if "%3" == "type" (
	echo !%prefix%1!
	echo !%prefix%2!
	echo !%prefix%3!
	echo !%prefix%4!
	echo !%prefix%5!
	echo !%prefix%6!
	goto :EOF
)

set text=%~1
call getlength %1
set /a length=!return! - 1
for /l %%r in (1,1,6) do (
	set line%%r=
)
for /l %%a in (0,1,!length!) do (
	set char=!text:~%%a,1!
	if "!char!" == "a" (
		set line1=!line1!мллллллм  
		set line2=!line2!лл    лл  
		set line3=!line3!ллммммлл  
		set line4=!line4!ллпппплл  
		set line5=!line5!лл    лл  
		set line6=!line6!лп    пл  
	)
	if "!char!" == "b" (
		set line1=!line1!лллллллм  
		set line2=!line2!лл    лл  
		set line3=!line3!ллммммлп  
		set line4=!line4!ллпппплм  
		set line5=!line5!лл    лл  
		set line6=!line6!лллллллп  
	)
	if "!char!" == "c" (
		set line1=!line1!мллллллп  
		set line2=!line2!лл        
		set line3=!line3!лл        
		set line4=!line4!лл        
		set line5=!line5!лл        
		set line6=!line6!пллллллм  
	)
	if "!char!" == "d" (
		set line1=!line1!лллллллм  
		set line2=!line2!лл    лл  
		set line3=!line3!лл    лл  
		set line4=!line4!лл    лл  
		set line5=!line5!лл    лл  
		set line6=!line6!лллллллп  
	)
	if "!char!" == "e" (
		set line1=!line1!лллллллп  
		set line2=!line2!лл        
		set line3=!line3!ллмммм    
		set line4=!line4!ллпппп    
		set line5=!line5!лл        
		set line6=!line6!лллллллм  
	)
	if "!char!" == "3" (
		set line1=!line1!лллллллм  
		set line2=!line2!      лл  
		set line3=!line3!  ммммлл  
		set line4=!line4!  пппплл  
		set line5=!line5!      лл  
		set line6=!line6!лллллллп  
	)
	if "!char!" == "f" (
		set line1=!line1!лллллллп  
		set line2=!line2!лл        
		set line3=!line3!ллмммм    
		set line4=!line4!ллпппп    
		set line5=!line5!лл        
		set line6=!line6!лп        
	)
	if "!char!" == "g" (
		set line1=!line1!мллллллп  
		set line2=!line2!лл        
		set line3=!line3!лл  мммм  
		set line4=!line4!лл   плл  
		set line5=!line5!лл    лл  
		set line6=!line6!пллллллп  
	)
	if "!char!" == "h" (
		set line1=!line1!лм    мл  
		set line2=!line2!лл    лл  
		set line3=!line3!ллммммлл  
		set line4=!line4!ллпппплл  
		set line5=!line5!лл    лл  
		set line6=!line6!лп    пл  
	)
	if "!char!" == "i" (
		set line1=!line1!пллллллп  
		set line2=!line2!   лл     
		set line3=!line3!   лл     
		set line4=!line4!   лл     
		set line5=!line5!   лл     
		set line6=!line6!мллллллм  
	)
	if "!char!" == "j" (
		set line1=!line1!лллллллл  
		set line2=!line2!      лл  
		set line3=!line3!      лл  
		set line4=!line4!лм    лл  
		set line5=!line5!лл    лл  
		set line6=!line6!пллллллп  
	)
	if "!char!" == "k" (
		set line1=!line1!лм    мл  
		set line2=!line2!лл    лл  
		set line3=!line3!ллммммлп  
		set line4=!line4!ллпппплм  
		set line5=!line5!лл    лл  
		set line6=!line6!лп    пл  
	)
	if "!char!" == "l" (
		set line1=!line1!лм        
		set line2=!line2!лл        
		set line3=!line3!лл        
		set line4=!line4!лл        
		set line5=!line5!лл        
		set line6=!line6!лллллллм  
	)
	if "!char!" == "m" (
		set line1=!line1!ллм  млл  
		set line2=!line2!лллллллл  
		set line3=!line3!лл пп лл  
		set line4=!line4!лл    лл  
		set line5=!line5!лл    лл  
		set line6=!line6!лп    пл  
	)
	if "!char!" == "n" (
		set line1=!line1!ллм   мл  
		set line2=!line2!ллллм лл  
		set line3=!line3!лл плллл  
		set line4=!line4!лл   плл  
		set line5=!line5!лл    лл  
		set line6=!line6!лп    пл  
	)
	if "!char!" == "o" (
		set line1=!line1!мллллллм  
		set line2=!line2!лл    лл  
		set line3=!line3!лл    лл  
		set line4=!line4!лл    лл  
		set line5=!line5!лл    лл  
		set line6=!line6!пллллллп  
	)
	if "!char!" == "p" (
		set line1=!line1!лллллллм  
		set line2=!line2!лл    лл  
		set line3=!line3!ллммммлл  
		set line4=!line4!ллппппп   
		set line5=!line5!лл        
		set line6=!line6!лп        
	)
	if "!char!" == "q" (
		set line1=!line1!мллллллм  
		set line2=!line2!лл    лл  
		set line3=!line3!лл    лл  
		set line4=!line4!лл мм лл  
		set line5=!line5!лл плллл  
		set line6=!line6!пллллллп  
	)
	if "!char!" == "r" (
		set line1=!line1!лллллллм  
		set line2=!line2!лл    лл  
		set line3=!line3!ллммммлп  
		set line4=!line4!ллпппплм  
		set line5=!line5!лл    лл  
		set line6=!line6!лп    лл  
	)
	if "!char!" == "s" (
		set line1=!line1!мллллллм  
		set line2=!line2!лл    пп  
		set line3=!line3!ллммммм   
		set line4=!line4! ппппплл  
		set line5=!line5!мм    лл  
		set line6=!line6!пллллллп  
	)
	if "!char!" == "t" (
		set line1=!line1!пллллллп  
		set line2=!line2!   лл     
		set line3=!line3!   лл     
		set line4=!line4!   лл     
		set line5=!line5!   лл     
		set line6=!line6!   лл     
	)
	if "!char!" == "u" (
		set line1=!line1!лм    мл  
		set line2=!line2!лл    лл  
		set line3=!line3!лл    лл  
		set line4=!line4!лл    лл  
		set line5=!line5!лл    лл  
		set line6=!line6!пллллллп  
	)
	if "!char!" == "v" (
		set line1=!line1!лм    мл  
		set line2=!line2!лл    лл  
		set line3=!line3!плм  млп  
		set line4=!line4! лл  лл   
		set line5=!line5! лл  лл   
		set line6=!line6!  пллп    
	)
	if "!char!" == "w" (
		set line1=!line1!лм    мл  
		set line2=!line2!лл мм лл  
		set line3=!line3!лл лл лл  
		set line4=!line4!лл лл лл  
		set line5=!line5!лл лл лл  
		set line6=!line6!пллппллп  
	)
	if "!char!" == "x" (
		set line1=!line1!лм    мл  
		set line2=!line2!лл    лл  
		set line3=!line3!плммммлп  
		set line4=!line4!млпппплм  
		set line5=!line5!лл    лл  
		set line6=!line6!лп    пл  
	)
	if "!char!" == "y" (
		set line1=!line1!лм    мл  
		set line2=!line2!лл    лл  
		set line3=!line3!ллммммлл  
		set line4=!line4! ппппплл  
		set line5=!line5!мм    лл  
		set line6=!line6!пллллллп  
	)
	if "!char!" == "z" (
		set line1=!line1!пллллллл  
		set line2=!line2!     млл  
		set line3=!line3!   мллп   
		set line4=!line4! мллп     
		set line5=!line5!ллп       
		set line6=!line6!лллллллм  
	)
	
	if "!char!" == " " (
		set line1=!line1!    
		set line2=!line2!    
		set line3=!line3!    
		set line4=!line4!    
		set line5=!line5!    
		set line6=!line6!    
	)
	
)
if "%3" == "centered" if "%4" NEQ "" (
	call getlength %1
	set spaces=!return!
	
	set text=%~1
	set text=!text: =!
	call getlength !text!
	set /a spaces-=!return!
	
	set /a length+=1 - !spaces!
	set /a width=!length!*10 - 2
	set /a width+=!spaces!*4
	set /a width=!width!/2
	set /a tocenter=%4 / 2
	set /a toadd=!tocenter! - !width!
	for /l %%n in (1,1,!toadd!) do (
		for /l %%a in (1,1,6) do (
			set line%%a= !line%%a!
		)
	)
)

for /l %%a in (1,1,6) do (
	set !prefix!%%a=!line%%a!
)