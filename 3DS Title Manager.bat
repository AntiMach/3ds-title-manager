:: ############################################################################################################################################
:: Fun stuff! Feel free to use these if you want :)
::
:: ☺	☻	♥	♦	♣	♠	♂	♀	♫	☼	►	◄	↕	‼	¶	§	▬	↨	↑	↓	∟	↔	▲	▼
:: 																							
:: 1	2	3	4	5	6	11	12	14	15	16	17	18	19	20	21	22	23	24	25	28	29	30	31
:: ############################################################################################################################################

@echo off
setlocal enabledelayedexpansion
title 3DS_Title_Manager
path !path!;!CD!\.data\bat;!CD!\.data\bin
call setwindow 100 50
batbox /h 0
color 17
set quit=0
set return=0
set playmusic=No
set music=.NONE
set totalmusics=0
for /f "delims=" %%a in ('dir .data\bgm /a:a /b') do (
	if "%%~xa" == ".mp3" set /a totalmusics+=1
	if !totalmusics! == 1 set defaultmusic=%%a
)
if !totalmusics! == 0 (
	(echo set playmusic=No)> .data\settings.txt
	(echo set music=.NONE)>> .data\settings.txt
)

if exist ".data\settings.txt" (
	for /f "tokens=1-2 delims=,=" %%a in (.data\settings.txt) do (
		if !totalmusics! GTR 0 ( 
			if "%%a=%%b" == "set music=.NONE" (
				goto setupsettings
			)
		)
		if "%%a" == "set playmusic" (
			set checktoplay=%%b
		) 
		if "%%a" == "set music" if "!checktoplay!" == "Yes" (
			if not exist ".data\bgm\%%b" (
				call centertext "A music was trying to be loaded, but it doesn't seem to exist." 24 100
				call fade in
				batbox /w 1000
				call fade out
				if not exist "%%b" goto music_setup
			)
		)
	)
)

if not exist ".data\settings.txt" (
	:setupsettings
	call centertext "Play music (you can change this setting on the settings menu at any time)? [Y/N]" 24 100
	call fade in
	batbox /k
	if !errorlevel! NEQ 78 if !errorlevel! NEQ 89 if !errorlevel! NEQ 110 if !errorlevel! NEQ 121 goto setupsettings 
	if !errorlevel! == 78 (
		(echo set playmusic=No)> .data\settings.txt
		(echo set music=!defaultmusic!)>> .data\settings.txt
	)
	if !errorlevel! == 110 (
		(echo set playmusic=No)> .data\settings.txt
		(echo set music=!defaultmusic!)>> .data\settings.txt
	)
	if !errorlevel! == 89 (
		set playmusic=Yes
		set music=.TOSET
	)
	if !errorlevel! == 121 (
		set playmusic=Yes
		set music=.TOSET
	)
	call fade out
)

if "!music!" == ".TOSET" goto music_setup
:load
for /f "delims=" %%a in (.data\settings.txt) do %%a
call centertext "Loading..." 25 100
call fade in
set musicplaying=0
for /f "delims=" %%a in ('tasklist /fi "WINDOWTITLE eq bgm" /fi "IMAGENAME eq cmd.exe"') do if "%%a" NEQ "INFO: No tasks are running which match the specified criteria." set musicplaying=1
if exist ".data\bgm\!music!" if !musicplaying! == 0 if "!playmusic!" == "Yes" (
	call playbgm ".data\bgm\!music!" loop
	call waitforconsole "3DS_Title_Manager" "bgm"
)
goto premain

:music_setup
set opt=1
set maxopt=0
for /f "delims=" %%a in ('dir ".data\bgm" /a:a /b') do (
	if "%%~xa" == ".mp3" (
		set /a maxopt+=1
		set name!maxopt!=%%~na
	)
)
cls
call centertext "Select a music to be played" 1 100
batbox /g 0 2 /d "____________________________________________________________________________________________________"
set toclean=
for /l %%a in (1,1,!maxopt!) do (
	set /a y=%%a + 3
	batbox /g 3 !y! /d "!name%%a!"
	set toclean=/g 1 !y! /a 32 !toclean!
)
call fade in
:music_setup_main
set /a y=!opt! + 3
batbox !toclean! /g 1 !y! /a 16 /k

if !errorlevel! == 327 (
	set /a opt-=1
)
if !errorlevel! == 335 (
	set /a opt+=1
)
if !errorlevel! == 13 (
	(echo set playmusic=Yes) > .data\settings.txt
	(echo set music=!name%opt%!.mp3) >> .data\settings.txt
	call fade out
	goto load
)

if !opt! GTR !maxopt! set opt=1
if !opt! LSS 1 set opt=!maxopt!
goto music_setup_main

:: ############################################################################################################################################
::                                                                  MAIN MENU
:: ############################################################################################################################################

:premain
call fade out
set opt=1
set maxopt=7
call hugetext "3ds title" title centered 100
call hugetext "manager" extractor centered 100
cls
echo.
echo !title1!
echo !title2!
echo !title3!
echo !title4!
echo !title5!
echo !title6!
echo.
echo !extractor1!
echo !extractor2!
echo !extractor3!
echo !extractor4!
echo !extractor5!
echo !extractor6!
echo.
call centertext "A batch tool by TheMachinumps. Inspiration from the 3DSHackingToolkit by Asia81" 15 100
batbox /g 0 16 /d "____________________________________________________________________________________________________"
echo.
echo    Extract a title           ^|   Unpacks everything from a .3DS or .CIA file
echo    Extract RomFS and ExeFS   ^|   Extracts the RomFS file from .3DS, .CIA or .CXI files
echo    Rebuild RomFS and ExeFS   ^|   Rebuilds RomFS to be used with Hans, and the ExeFS
echo    Rebuild a title           ^|   Repacks everything that was unpacked from a .3DS or .CIA file
echo    Build CIA from 3DSX       ^|   Builds a .CIA file from a .3DSX file 
echo    Settings                  ^|   Edit settings of the batch tool
echo    Exit                      ^|   Close the application
echo.
echo  Use the arrow keys to move the cursor
echo  Press enter to select an option
echo.
echo  CREDITS:
echo    Quiet      - Joe Richards
echo    cmdmp3     - Jim Lawless
echo    3dstool    - Sun Daowen
echo    ctrtool    - Neimod, 3DSGuy ^& Profi200
echo    makerom    - 3DSGuy ^& Profi200
echo    bannertool - Steveice10
echo    cxitool    - fincs
echo    batbox     - DarkBatcher

set toclean=
for /l %%a in (1,1,!maxopt!) do (
	set /a y=%%a + 17
	set toclean=/g 1 !y! /a 32 !toclean!
)

call fade in
:main
set /a y=!opt! + 17
batbox !toclean! /g 1 !y! /a 16 /k

if !errorlevel! == 327 (
	set /a opt-=1
)
if !errorlevel! == 335 (
	set /a opt+=1
)
if !errorlevel! == 13 (
	call fade out
	if !opt! == 1 goto unpack_title
	if !opt! == 2 goto romfs_x
	if !opt! == 3 goto romfs_c
	if !opt! == 4 goto repack_title
	if !opt! == 5 goto build_3dsx
	if !opt! == 6 goto settings
	if !opt! == 7 exit
)

if !opt! GTR !maxopt! set opt=1
if !opt! LSS 1 set opt=!maxopt!
goto main

:: ############################################################################################################################################
::                                                                   SETTINGS
:: ############################################################################################################################################

:settings
set opt=1
set maxopt=5
call hugetext "settings" title centered 100
cls
echo.
echo !title1!
echo !title2!
echo !title3!
echo !title4!
echo !title5!
echo !title6!
batbox /g 0 7 /d "____________________________________________________________________________________________________"
echo.
echo    Play music on launch:
echo    Select music to play:
echo    Play music
echo    Stop music
echo    Return
echo.
echo  Use the arrow keys to move the cursor
echo  Press enter to select an option
echo.

set musicnmopt=1
set musicmaxopt=0
for /f "delims=" %%a in ('dir .data\bgm /a:a /b') do (
	if "%%~xa" == ".mp3" (
		set /a musicmaxopt+=1
		set musicnm!musicmaxopt!=%%~na
		call getlength "%%~na"
		if !return! GTR 50 (
			for /f %%b in ("!musicmaxopt!") do set shortmusicnm%%b=!musicnm%%b:~0,50!...
		)
		if "%%a" == "!music!" set musicnmopt=!musicmaxopt!
	)
)
set toclean=
for /l %%a in (1,1,!maxopt!) do (
	set /a y=%%a + 8
	set toclean=/g 1 !y! /a 32 !toclean!
)

call fade in
:settingsmain
set /a y=!opt! + 8
if !playmusic! == Yes ( set preopt=/c 0x1A /a 17 /c 0x1F ) else ( set preopt=/a 32 )
if !playmusic! == No ( set aftopt=/c 0x1A /a 16 /c 0x1F) else ( set aftopt=/a 32 )
set musicopt=/g 25 9 /d "         " /g 25 9 !preopt! /d " !playmusic! " !aftopt!
if !musicmaxopt! GTR 0 (
	if defined shortmusicnm!musicnmopt! (
		set music_name=!shortmusicnm%musicnmopt%!
	) else (
		set music_name=!musicnm%musicnmopt%!
	)
	if !musicnmopt! GTR 1 ( set preopt=/c 0x1A /a 17 /c 0x1F ) else ( set preopt=/a 32 )
	if !musicnmopt! LSS !musicmaxopt! ( set aftopt=/c 0x1A /a 16 /c 0x1F ) else ( set aftopt=/a 32 )
) else (
	set music_name=No musics found...
	set preopt=/a 32
	set aftopt=/a 32
)
set musicnmopt_disp=/g 25 10 /d "                                                            " /g 25 10 !preopt! /d " !music_name! " !aftopt!

batbox !toclean! !musicopt! !musicnmopt_disp! /g 1 !y! /a 16 /k

if !errorlevel! == 327 (
	set /a opt-=1
)
if !errorlevel! == 335 (
	set /a opt+=1
)

if !errorlevel! == 330 if !playmusic! == Yes if !opt! == 1 (
	set playmusic=No
)
if !errorlevel! == 332 if !playmusic! == No if !opt! == 1 (
	set playmusic=Yes
)

if !errorlevel! == 330 if !opt! == 2 (
	set /a musicnmopt-=1
)
if !errorlevel! == 332 if !opt! == 2 (
	set /a musicnmopt+=1
)
if !musicnmopt! GTR !musicmaxopt! set musicnmopt=!musicmaxopt!
if !musicnmopt! LSS 1 set musicnmopt=1
if !musicmaxopt! GTR 0 set music=!musicnm%musicnmopt%!.mp3

if !errorlevel! == 13 (
	if !opt! == 3 (
		set musicplaying=0
		for /f "delims=" %%a in ('tasklist /fi "WINDOWTITLE eq bgm" /fi "IMAGENAME eq cmd.exe"') do if "%%a" NEQ "INFO: No tasks are running which match the specified criteria." set musicplaying=1
		if !musicplaying! == 1 (
			taskkill /fi "WINDOWTITLE eq bgm" /fi "IMAGENAME eq cmd.exe" > nul 2>&1
			taskkill /fi "WINDOWTITLE eq wait" /fi "IMAGENAME eq cmd.exe" > nul 2>&1
			set musicplaying=0
		)
		if exist ".data\bgm\!music!" if !musicplaying! == 0 if "!playmusic!" == "Yes" (
			call playbgm ".data\bgm\!music!" loop
			call waitforconsole "3DS_Title_Manager" "bgm"
		)
	)
	if !opt! == 4 (
		taskkill /fi "WINDOWTITLE eq bgm" /fi "IMAGENAME eq cmd.exe" > nul 2>&1
		taskkill /fi "WINDOWTITLE eq wait" /fi "IMAGENAME eq cmd.exe" > nul 2>&1
	)
	if !opt! == 5 (
		if !musicmaxopt! GTR 0 (
			(echo set playmusic=!playmusic!) > ".data\settings.txt"
			(echo set music=!musicnm%musicnmopt%!.mp3) >> ".data\settings.txt"
		) else (
			(echo set playmusic=No) > ".data\settings.txt"
			(echo set music=.NONE) >> ".data\settings.txt"
		)
		goto premain
	)
)

if !opt! GTR !maxopt! set opt=1
if !opt! LSS 1 set opt=!maxopt!
goto settingsmain

:: ############################################################################################################################################
::                                                              TITLE UNPACKER MENU
:: ############################################################################################################################################

:unpack_title
set opt=1
set maxopt=0
for /f "delims=" %%a in ('dir /a:a /b') do (
	if "%%~xa" == ".3ds" (
		set /a maxopt+=1
		set name!maxopt!=%%a
	) else if "%%~xa" == ".cia" (
		set /a maxopt+=1
		set name!maxopt!=%%a
	)
)
cls
call centertext "Select a title to extract the contents from" 1 100
batbox /g 0 2 /d "____________________________________________________________________________________________________"
set /a maxopt+=1
set name!maxopt!=Return
set toclean=
for /l %%a in (1,1,!maxopt!) do (
	set /a y=%%a + 3
	batbox /g 3 !y! /d "!name%%a!"
	set toclean=/g 1 !y! /a 32 !toclean!
)
call fade in
:unpack_title_main
set /a y=!opt! + 3
batbox !toclean! /g 1 !y! /a 16 /k

if !errorlevel! == 327 (
	set /a opt-=1
)
if !errorlevel! == 335 (
	set /a opt+=1
)
if !errorlevel! == 13 (
	if !opt! == !maxopt! goto premain
	set filenm=!name%opt%!
	for /f "delims=" %%a in ("!filenm!") do set filext=%%~xa
	for /f "delims=" %%a in ("!filenm!") do set titledir=%%~na - !filext:~1,3!
	if exist "!titledir!" (
		call fade out
		call centertext "There already exists a directory with the extracted title. Do you want to overwrite it? [Y/N]" 24 100
		call fade in
		:unpacked_exists
		batbox /k
		if !errorlevel! == 110 (
			call fade out
			goto unpack_title
		)
		if !errorlevel! == 78 (
			call fade out
			goto unpack_title
		)
		if !errorlevel! NEQ 89 if !errorlevel! NEQ 121 goto unpacked_exists
		rd /s /q "!titledir!" > nul 2>&1
	)
	md "!titledir!"
	if "!filext!" == ".3ds" (
		call fade out
		call centertext "Extracting partitions... (This might take a while)" 24 100
		call fade in
		3dstool -xtf 3ds "!filenm!" --header "!titledir!/ncch-header.bin" -0 "!titledir!/part-0.cxi" -1 "!titledir!/part-1.cfa" -2 "!titledir!/part-2.cfa" -6 "!titledir!/part-6.cfa" -7 "!titledir!/part-7.cfa" > nul 2>&1
		if exist "!titledir!/part-0.cxi" (
			call fade out
			call centertext "Extracting partition 0... (This might take a while as well)" 24 100
			call fade in
			if not exist "!titledir!/Partition 0" md "!titledir!/Partition 0"
			3dstool -xtf cxi "!titledir!/part-0.cxi" --header "!titledir!/Partition 0/ncch-header.bin" --exh "!titledir!/Partition 0/Ex-Header.bin" --romfs "!titledir!/Partition 0/Romfs.bin" --exefs "!titledir!/Partition 0/Exefs.bin" --plain "!titledir!/Partition 0/PlainRGN.bin" --logo "!titledir!/Partition 0/LogoLZ.bin" > nul 2>&1
			del /f /q "!titledir!\part-0.cxi" > nul 2>&1
		)
		if exist "!titledir!/part-1.cfa" (
			call fade out
			call centertext "Extracting partition 1..." 24 100
			call fade in
			if not exist "!titledir!/Partition 1" md "!titledir!/Partition 1"
			3dstool -xtf cfa "!titledir!/part-1.cfa" --header "!titledir!/Partition 1/ncch-header.bin" --romfs "!titledir!/Partition 1/ManualRomfs.bin" > nul 2>&1
			del /f /q "!titledir!\part-1.cfa" > nul 2>&1
		)
		if exist "!titledir!/part-2.cfa" (
			call fade out
			call centertext "Extracting partition 2..." 24 100
			call fade in
			if not exist "!titledir!/Partition 2" md "!titledir!/Partition 2"
			3dstool -xtf cfa "!titledir!/part-2.cfa" --header "!titledir!/Partition 2/ncch-header.bin" --romfs "!titledir!/Partition 2/DownloadPlayRomfs.bin" > nul 2>&1
			del /f /q "!titledir!\part-2.cfa" > nul 2>&1
		)
		if exist "!titledir!/part-6.cfa" (
			call fade out
			call centertext "Extracting partition 6..." 24 100
			call fade in
			if not exist "!titledir!/Partition 6" md "!titledir!/Partition 6"
			3dstool -xtf cfa "!titledir!/part-6.cfa" --header "!titledir!/Partition 6/ncch-header.bin" --romfs "!titledir!/Partition 6/N3DSUpdateRomfs.bin" > nul 2>&1
			del /f /q "!titledir!\part-6.cfa" > nul 2>&1
		)
		if exist "!titledir!/part-7.cfa" (
			call fade out
			call centertext "Extracting partition 7..." 24 100
			call fade in
			if not exist "!titledir!/Partition 7" md "!titledir!/Partition 7"
			3dstool -xtf cfa "!titledir!/part-7.cfa" --header "!titledir!/Partition 7/ncch-header.bin" --romfs "!titledir!/Partition 7/O3DSUpdateRomfs.bin" > nul 2>&1
			del /f /q "!titledir!\part-7.cfa" > nul 2>&1
		)
		if exist "!titledir!/Partition 0" (
			call fade out
			call centertext "Extracting RomFS... (This might take a while too)" 24 100
			call fade in
			3dstool -xtf romfs "!titledir!/Partition 0/Romfs.bin" --romfs-dir "!titledir!/Partition 0/RomFSdir"> nul 2>&1
			del /f /q "!titledir!\Partition 0\Romfs.bin" > nul 2>&1
			call fade out
			call centertext "Extracting ExeFS..." 24 100
			call fade in
			3dstool -xutf exefs "!titledir!/Partition 0/Exefs.bin" --header "!titledir!/Partition 0/ExeSF-header.bin" --exefs-dir "!titledir!/Partition 0/ExeFSdir"> nul 2>&1
			del /f /q "!titledir!\Partition 0\Exefs.bin" > nul 2>&1
			ren "!titledir!\Partition 0\ExeFSdir\banner.bnr" "banner.bin" > nul 2>&1
			ren "!titledir!\Partition 0\ExeFSdir\icon.icn" "icon.bin" > nul 2>&1
			3dstool -xtf banner "!titledir!/Partition 0/ExeFSdir/banner.bin" --banner-dir "!titledir!/Partition 0/Banner-dir" > nul 2>&1
			ren "!titledir!\Partition 0\Banner-dir\banner0.bcmdl" "banner.cgfx"
		)
		if exist "!titledir!/Partition 1" (
			call fade out
			call centertext "Extracting Manual..." 24 100
			call fade in
			3dstool -xtf romfs "!titledir!/Partition 1/ManualRomfs.bin" --romfs-dir "!titledir!/Partition 1/ManualRomFS-dir"> nul 2>&1
			del /f /q "!titledir!\Partition 1\ManualRomfs.bin" > nul 2>&1
		)
		if exist "!titledir!/Partition 2" (
			call fade out
			call centertext "Extracting Download and Play..." 24 100
			call fade in
			3dstool -xtf romfs "!titledir!/Partition 2/DownloadPlayRomfs.bin" --romfs-dir "!titledir!/Partition 2/DownloadPlayRomFS-dir"> nul 2>&1
			del /f /q "!titledir!\Partition 2\DownloadPlayRomfs.bin" > nul 2>&1
		)
		if exist "!titledir!/Partition 6" (
			call fade out
			call centertext "Extracting N3DS Updates..." 24 100
			call fade in
			3dstool -xtf romfs "!titledir!/Partition 6/N3DSUpdateRomfs.bin" --romfs-dir "!titledir!/Partition 6/N3DSUpdateRomFS-dir"> nul 2>&1
			del /f /q "!titledir!\Partition 6\N3DSUpdateRomfs.bin" > nul 2>&1
		)
		if exist "!titledir!/Partition 7" (
			call fade out
			call centertext "Extracting O3DS Updates..." 24 100
			call fade in
			3dstool -xtf romfs "!titledir!/Partition 7/O3DSUpdateRomfs.bin" --romfs-dir "!titledir!/Partition 7/O3DSUpdateRomFS-dir"> nul 2>&1
			del /f /q "!titledir!\Partition 7\O3DSUpdateRomfs.bin" > nul 2>&1
		)
	)
	if "!filext!" == ".cia" (
		call fade out
		call centertext "Extracting partitions... (This might take a while)" 24 100
		call fade in
		ctrtool --content="!titledir!/partition" "!filenm!" > nul 2>&1
		ren "!titledir!\partition.0000.*" "part-0.cxi" > nul 2>&1
		ren "!titledir!\partition.0001.*" "part-1.cfa" > nul 2>&1
		ren "!titledir!\partition.0002.*" "part-2.cfa" > nul 2>&1
		if exist "!titledir!/part-0.cxi" (
			call fade out
			call centertext "Extracting partition 0... (This might take a while as well)" 24 100
			call fade in
			if not exist "!titledir!/Partition 0" md "!titledir!/Partition 0"
			3dstool -xtf cxi "!titledir!/part-0.cxi" --header "!titledir!/Partition 0/ncch-header.bin" --exh "!titledir!/Partition 0/Ex-Header.bin" --romfs "!titledir!/Partition 0/Romfs.bin" --exefs "!titledir!/Partition 0/Exefs.bin" --plain "!titledir!/Partition 0/PlainRGN.bin" --logo "!titledir!/Partition 0/LogoLZ.bin" > nul 2>&1
			del /f /q "!titledir!\part-0.cxi" > nul 2>&1
		)
		if exist "!titledir!/part-1.cfa" (
			call fade out
			call centertext "Extracting partition 1..." 24 100
			call fade in
			if not exist "!titledir!/Partition 1" md "!titledir!/Partition 1"
			3dstool -xtf cfa "!titledir!/part-1.cfa" --header "!titledir!/Partition 1/ncch-header.bin" --romfs "!titledir!/Partition 1/ManualRomfs.bin" > nul 2>&1
			del /f /q "!titledir!\part-1.cfa" > nul 2>&1
		)
		if exist "!titledir!/part-2.cfa" (
			call fade out
			call centertext "Extracting partition 2..." 24 100
			call fade in
			if not exist "!titledir!/Partition 2" md "!titledir!/Partition 2"
			3dstool -xtf cfa "!titledir!/part-2.cfa" --header "!titledir!/Partition 2/ncch-header.bin" --romfs "!titledir!/Partition 2/DownloadPlayRomfs.bin" > nul 2>&1
			del /f /q "!titledir!\part-2.cfa" > nul 2>&1
		)
		if exist "!titledir!/Partition 0" (
			call fade out
			call centertext "Extracting RomFS... (This might take a while too)" 24 100
			call fade in
			3dstool -xtf romfs "!titledir!/Partition 0/Romfs.bin" --romfs-dir "!titledir!/Partition 0/RomFSdir"> nul 2>&1
			del /f /q "!titledir!\Partition 0\Romfs.bin" > nul 2>&1
			call fade out
			call centertext "Extracting ExeFS..." 24 100
			call fade in
			3dstool -xutf exefs "!titledir!/Partition 0/Exefs.bin" --header "!titledir!/Partition 0/ExeSF-header.bin" --exefs-dir "!titledir!/Partition 0/ExeFSdir"> nul 2>&1
			del /f /q "!titledir!\Partition 0\Exefs.bin" > nul 2>&1
			ren "!titledir!\Partition 0\ExeFSdir\banner.bnr" "banner.bin" > nul 2>&1
			ren "!titledir!\Partition 0\ExeFSdir\icon.icn" "icon.bin" > nul 2>&1
			3dstool -xtf banner "!titledir!/Partition 0/ExeFSdir/banner.bin" --banner-dir "!titledir!/Partition 0/Banner-dir" > nul 2>&1
			ren "!titledir!\Partition 0\Banner-dir\banner0.bcmdl" "banner.cgfx"
		)
		if exist "!titledir!/Partition 1" (
			call fade out
			call centertext "Extracting Manual..." 24 100
			call fade in
			3dstool -xtf romfs "!titledir!/Partition 1/ManualRomfs.bin" --romfs-dir "!titledir!/Partition 1/ManualRomFS-dir"> nul 2>&1
			del /f /q "!titledir!\Partition 1\ManualRomfs.bin" > nul 2>&1
		)
		if exist "!titledir!/Partition 2" (
			call fade out
			call centertext "Extracting Download and Play..." 24 100
			call fade in
			3dstool -xtf romfs "!titledir!/Partition 2/DownloadPlayRomfs.bin" --romfs-dir "!titledir!/Partition 2/DownloadPlayRomFS-dir"> nul 2>&1
			del /f /q "!titledir!\Partition 2\DownloadPlayRomfs.bin" > nul 2>&1
		)
	)
	call fade out
	call centertext "Done. Press any key continue." 24 100
	call fade in
	pause > nul
	call fade out
	goto unpack_title
)

if !opt! GTR !maxopt! set opt=1
if !opt! LSS 1 set opt=!maxopt!
goto unpack_title_main

:romfs_x
set opt=1
set maxopt=0
for /f "delims=" %%a in ('dir /a:a /b') do (
	if "%%~xa" == ".cia" (
		set /a maxopt+=1
		set name!maxopt!=%%a
		set ext!maxopt!=%%~xa
	)
	if "%%~xa" == ".cxi" (
		set /a maxopt+=1
		set name!maxopt!=%%a
		set ext!maxopt!=%%~xa
	)
	if "%%~xa" == ".3ds" (
		set /a maxopt+=1
		set name!maxopt!=%%a
		set ext!maxopt!=%%~xa
		
	)
)
cls
call centertext "Select a file to get the files from" 1 100
batbox /g 0 2 /d "____________________________________________________________________________________________________"
set /a maxopt+=1
set name!maxopt!=Return
set toclean=
for /l %%a in (1,1,!maxopt!) do (
	set /a y=%%a + 3
	batbox /g 3 !y! /d "!name%%a!"
	set toclean=/g 1 !y! /a 32 !toclean!
)
call fade in
:romfs_x_main
set /a y=!opt! + 3
batbox !toclean! /g 1 !y! /a 16 /k

if !errorlevel! == 327 (
	set /a opt-=1
)
if !errorlevel! == 335 (
	set /a opt+=1
)
if !errorlevel! == 13 (
	if !opt! == !maxopt! goto premain
	set filenm=!name%opt%!
	set filext=!ext%opt%!
	for /f "delims=" %%a in ("!filenm!") do set romfsdir=%%~na - Dir
	if exist "!romfsdir!" (
		call fade out
		call centertext "There already exists a directory with the extracted data. Do you want to overwrite it? [Y/N]" 24 100
		call fade in
		:romfsdir_exists
		batbox /k
		if !errorlevel! == 110 (
			call fade out
			goto romfs_x
		)
		if !errorlevel! == 78 (
			call fade out
			goto romfs_x
		)
		if !errorlevel! NEQ 89 if !errorlevel! NEQ 121 goto romfsdir_exists
		rd /s /q "!romfsdir!" > nul 2>&1
	)
	md "!romfsdir!"
	if "!filext!" == ".cia" (
		call fade out
		call centertext "Extracting Partitions... (This might take a while)" 24 100
		call fade in
		ctrtool --content="!romfsdir!\part" "!filenm!"> nul 2>&1
		del /f /q "!romfsdir!\part.0001.*" > nul 2>&1
		del /f /q "!romfsdir!\part.0002.*" > nul 2>&1
		ren "!romfsdir!\part.0000.*" "part-0.cxi" > nul 2>&1
		call fade out
		call centertext "Extracting RomFS... (This might take a while as well)" 24 100
		call fade in
		ctrtool --romfsdir="!romfsdir!\RomFSdir" "!romfsdir!\part-0.cxi" > nul 2>&1
		call fade out
		call centertext "Extracting ExeFS..." 24 100
		call fade in
		3dstool -xtf cxi "!romfsdir!\part-0.cxi" --exefs "!romfsdir!\ExeFS.bin" > nul 2>&1
		3dstool -xutf exefs "!romfsdir!\ExeFS.bin" --exefs-dir "!romfsdir!\ExeFSdir" --header "!romfsdir!\ExeFS-header.bin" > nul 2>&1
		ren "!romfsdir!\ExeFSdir\banner.bnr" banner.bin > nul 2>&1
		ren "!romfsdir!\ExeFSdir\icon.icn" icon.bin > nul 2>&1
		del /f /q "!romfsdir!\ExeFS.bin" > nul 2>&1
		del /f /q "!romfsdir!\part-0.cxi" > nul 2>&1
	)
	if "!filext!" == ".3ds" (
		call fade out
		call centertext "Extracting Partition... (This might take a while)" 24 100
		call fade in
		3dstool -xtf 3ds "!filenm!" -0 "!romfsdir!\part-0.cxi"
		call fade out
		call centertext "Extracting RomFS... (This might take a while as well)" 24 100
		call fade in
		ctrtool --romfsdir="!romfsdir!\RomFSdir" "!romfsdir!\part-0.cxi" > nul 2>&1
		call fade out
		call centertext "Extracting ExeFS..." 24 100
		call fade in
		3dstool -xtf cxi "!romfsdir!\part-0.cxi" --exefs "!romfsdir!\ExeFS.bin" > nul 2>&1
		3dstool -xutf exefs "!romfsdir!\ExeFS.bin" --exefs-dir "!romfsdir!\ExeFSdir" --header "!romfsdir!\ExeFS-header.bin" > nul 2>&1
		ren "!romfsdir!\ExeFSdir\banner.bnr" banner.bin > nul 2>&1
		ren "!romfsdir!\ExeFSdir\icon.icn" icon.bin > nul 2>&1
		del /f /q "!romfsdir!\ExeFS.bin" > nul 2>&1
		del /f /q "!romfsdir!\part-0.cxi" > nul 2>&1
	)
	if "!filext!" == ".cxi" (
		call fade out
		call centertext "Extracting RomFS... (This might take a while)" 24 100
		call fade in
		ctrtool --romfsdir="!romfsdir!\RomFSdir" "!filenm!" > nul 2>&1
		call fade out
		call centertext "Extracting ExeFS..." 24 100
		call fade in
		3dstool -xtf cxi "!filenm!" --exefs "!romfsdir!\ExeFS.bin" > nul 2>&1
		3dstool -xutf exefs "!romfsdir!\ExeFS.bin" --exefs-dir "!romfsdir!\ExeFSdir" --header "!romfsdir!\ExeFS-header.bin" > nul 2>&1
		ren "!romfsdir!\ExeFSdir\banner.bnr" banner.bin > nul 2>&1
		ren "!romfsdir!\ExeFSdir\icon.icn" icon.bin > nul 2>&1
		del /f /q "!romfsdir!\ExeFS.bin" > nul 2>&1
	)
	call fade out
	call centertext "Done. Press any key continue." 24 100
	call fade in
	pause > nul
	call fade out
	goto romfs_x
)

if !opt! GTR !maxopt! set opt=1
if !opt! LSS 1 set opt=!maxopt!
goto romfs_x_main

:romfs_c
set opt=1
set maxopt=0
for /f "delims=" %%a in ('dir /a:d /b') do (
	call getlength "%%a"
	set /a return-=3
	set check=%%a
	for /f "delims=" %%b in ("!return!") do set check=!check:~%%b!
	if "!check!" == "Dir" (
		set /a return-=3
		set /a maxopt+=1
		set name=%%a
		for /f "delims=" %%b in ("!return!") do set name!maxopt!=!name:~0,%%b!
	)
)
cls
call centertext "Select a directory with the extracted RomFS and ExeFS to rebuild" 1 100
batbox /g 0 2 /d "____________________________________________________________________________________________________"
set /a maxopt+=1
set name!maxopt!=Return
set toclean=
for /l %%a in (1,1,!maxopt!) do (
	set /a y=%%a + 3
	batbox /g 3 !y! /d "!name%%a!"
	set toclean=/g 1 !y! /a 32 !toclean!
)
call fade in
:romfs_c_main
set /a y=!opt! + 3
batbox !toclean! /g 1 !y! /a 16 /k

if !errorlevel! == 327 (
	set /a opt-=1
)
if !errorlevel! == 335 (
	set /a opt+=1
)
if !errorlevel! == 13 (
	if !opt! == !maxopt! goto premain
	set romfsdir=!name%opt%! - Dir
	set outdir=!name%opt%! - RomFS ^& ExeFS
	if exist "!outdir!" (
		call fade out
		call centertext "There already exists extracted data for that game. Do you want to overwrite them? [Y/N]" 24 100
		call fade in
		:romfs_exists
		batbox /k
		if !errorlevel! == 110 (
			call fade out
			goto romfs_c
		)
		if !errorlevel! == 78 (
			call fade out
			goto romfs_c
		)
		if !errorlevel! NEQ 89 if !errorlevel! NEQ 121 goto romfs_exists
		rd /s /q "!outdir!" > nul 2>&1
	)
	md "!outdir!"
	call fade out
	call centertext "Rebuilding RomFS.bin... (This might take a while)" 24 100
	call fade in
	3dstool -ctf romfs "!outdir!\RomFS.bin" --romfs-dir "!romfsdir!\RomFSdir" > nul 2>&1
	call fade out
	call centertext "Rebuilding ExeFS.bin..." 24 100
	call fade in
	ren "!romfsdir!\ExeFSdir\banner.bin" banner.bnr > nul 2>&1
	ren "!romfsdir!\ExeFSdir\icon.bin" icon.icn > nul 2>&1
	3dstool -ctf exefs "!outdir!\ExeFS.bin" --exefs-dir "!romfsdir!\ExeFSdir" --header "!romfsdir!\ExeFS-header.bin" > nul 2>&1
	call fade out
	call centertext "Done. Press any key continue." 24 100
	call fade in
	pause > nul
	call fade out
	goto romfs_c
)

if !opt! GTR !maxopt! set opt=1
if !opt! LSS 1 set opt=!maxopt!
goto romfs_c_main

:repack_title
set opt=1
set maxopt=0
for /f "delims=" %%a in ('dir /a:d /b') do (
	call getlength "%%a"
	set /a return-=3
	set check=%%a
	for /f "delims=" %%b in ("!return!") do set check=!check:~%%b!
	set name=%%a
	if "!check!" == "3ds" (
		set /a return-=3
		set /a maxopt+=1
		set name!maxopt!=%%a
		for /f "delims=" %%b in ("!return!") do set out!maxopt!=!name:~0,%%b! - Edit.3ds
	)
	if "!check!" == "cia" (
		set /a return-=3
		set /a maxopt+=1
		set name!maxopt!=%%a
		for /f "delims=" %%b in ("!return!") do set out!maxopt!=!name:~0,%%b! - Edit.cia
	)
)
cls
call centertext "Select a title directory to rebuild" 1 100
batbox /g 0 2 /d "____________________________________________________________________________________________________"
set /a maxopt+=1
set name!maxopt!=Return
set toclean=
for /l %%a in (1,1,!maxopt!) do (
	set /a y=%%a + 3
	batbox /g 3 !y! /d "!name%%a!"
	set toclean=/g 1 !y! /a 32 !toclean!
)
call fade in
:repack_title_main
set /a y=!opt! + 3
batbox !toclean! /g 1 !y! /a 16 /k

if !errorlevel! == 327 (
	set /a opt-=1
)
if !errorlevel! == 335 (
	set /a opt+=1
)
if !errorlevel! == 13 (
	if !opt! == !maxopt! goto premain
	set titledir=!name%opt%!
	set filenm=!out%opt%!
	for /f "delims=" %%a in ("!out%opt%!") do set filext=%%~xa
	if exist "!filenm!" (
		call fade out
		call centertext "There already exists an edited version of that title. Do you want to overwrite it? [Y/N]" 24 100
		call fade in
		:title_exists
		batbox /k
		if !errorlevel! == 110 (
			call fade out
			goto repack_title
		)
		if !errorlevel! == 78 (
			call fade out
			goto repack_title
		)
		if !errorlevel! NEQ 89 if !errorlevel! NEQ 121 goto title_exists
		del /q "!filenm!" > nul 2>&1
	)
	if "!filext!" == ".cia" (
		call fade out
		call centertext "Rebuilding RomFS..." 24 100
		call fade in
		3dstool -ctf romfs "!titledir!\Partition 0\RomFS.bin" --romfs-dir "!titledir!\Partition 0\RomFSdir" > nul 2>&1
		call fade out
		call centertext "Rebuilding Banner..." 24 100
		call fade in
		ren "!titledir!\Partition 0\Banner-dir\banner.cgfx" "banner0.bcmdl"
		3dstool -ctf banner "!titledir!\Partition 0\ExeFSdir\banner.bin" --banner-dir "!titledir!\Partition 0\Banner-dir" > nul 2>&1
		ren "!titledir!\Partition 0\Banner-dir\banner0.bcmdl" "banner.cgfx"
		call fade out
		call centertext "Rebuilding ExeFS..." 24 100
		call fade in
		ren "!titledir!\Partition 0\ExeFSdir\banner.bin" banner.bnr > nul 2>&1
		ren "!titledir!\Partition 0\ExeFSdir\icon.bin" icon.icn > nul 2>&1
		3dstool -cztf exefs "!titledir!\Partition 0\ExeFS.bin" --exefs-dir "!titledir!\Partition 0\ExeFSdir" --header "!titledir!\Partition 0\ExeSF-header.bin"> nul 2>&1
		ren "!titledir!\Partition 0\ExeFSdir\banner.bnr" banner.bin > nul 2>&1
		ren "!titledir!\Partition 0\ExeFSdir\icon.icn" icon.bin > nul 2>&1
		call fade out
		call centertext "Rebuilding partition #0..." 24 100
		call fade in
		3dstool -ctf cxi "!titledir!\part-0.cxi" --exefs "!titledir!\Partition 0\ExeFS.bin" --romfs "!titledir!\Partition 0\RomFS.bin" --header "!titledir!\Partition 0\ncch-header.bin" --exh "!titledir!\Partition 0\Ex-Header.bin" --plain "!titledir!\Partition 0\PlainRGN.bin" --logo "!titledir!\Partition 0\LogoLZ.bin" > nul 2>&1
		del /q "!titledir!\Partition 0\ExeFS.bin" > nul 2>&1
		del /q "!titledir!\Partition 0\RomFS.bin" > nul 2>&1
		
		set arg1=
		if exist "!titledir!\Partition 1" (
			call fade out
			call centertext "Rebuilding ManualRomFS..." 24 100
			call fade in
			3dstool -ctf romfs "!titledir!\Partition 1\RomFS.bin" --romfs-dir "!titledir!\Partition 1\ManualRomFS-dir" > nul 2>&1
			call fade out
			call centertext "Rebuilding partition #1..." 24 100
			call fade in
			3dstool -ctf cfa "!titledir!\part-1.cfa" --romfs "!titledir!\Partition 1\RomFS.bin" --header "!titledir!\Partition 1\ncch-header.bin" > nul 2>&1
			del /q "!titledir!\Partition 1\RomFS.bin" > nul 2>&1
			set arg1=-content "!titledir!\part-1.cfa":1
		)
		
		set arg2=
		if exist "!titledir!\Partition 2" (
			call fade out
			call centertext "Rebuilding DownloadPlayRomFS..." 24 100
			call fade in
			3dstool -ctf romfs "!titledir!\Partition 2\RomFS.bin" --romfs-dir "!titledir!\Partition 2\DownloadPlayRomFS-dir" > nul 2>&1
			call fade out
			call centertext "Rebuilding partition #2..." 24 100
			call fade in
			3dstool -ctf cfa "!titledir!\part-2.cfa" --romfs "!titledir!\Partition 2\RomFS.bin" --header "!titledir!\Partition 2\ncch-header.bin" > nul 2>&1
			del /q "!titledir!\Partition 2\RomFS.bin" > nul 2>&1
			set arg2=-content "!titledir!\part-2.cfa":2
		)
		
		call fade out
		call centertext "Repacking cia file..." 24 100
		call fade in
		makerom -f cia -content "!titledir!\part-0.cxi":0 !arg1! !arg2! -o "!filenm!" > nul 2>&1
		del /q "!titledir!\part-0.cxi" > nul 2>&1
		del /q "!titledir!\part-1.cfa" > nul 2>&1
		del /q "!titledir!\part-2.cfa" > nul 2>&1
	)
	if "!filext!" == ".3ds" (
		call fade out
		call centertext "Rebuilding RomFS..." 24 100
		call fade in
		3dstool -ctf romfs "!titledir!\Partition 0\RomFS.bin" --romfs-dir "!titledir!\Partition 0\RomFSdir" > nul 2>&1
		call fade out
		call centertext "Rebuilding Banner..." 24 100
		call fade in
		ren "!titledir!\Partition 0\Banner-dir\banner.cgfx" "banner0.bcmdl"
		3dstool -ctf banner "!titledir!\Partition 0\ExeFSdir\banner.bin" --banner-dir "!titledir!\Partition 0\Banner-dir" > nul 2>&1
		ren "!titledir!\Partition 0\Banner-dir\banner0.bcmdl" "banner.cgfx"
		call fade out
		call centertext "Rebuilding ExeFS..." 24 100
		call fade in
		ren "!titledir!\Partition 0\ExeFSdir\banner.bin" banner.bnr > nul 2>&1
		ren "!titledir!\Partition 0\ExeFSdir\icon.bin" icon.icn > nul 2>&1
		3dstool -cztf exefs "!titledir!\Partition 0\ExeFS.bin" --exefs-dir "!titledir!\Partition 0\ExeFSdir" --header "!titledir!\Partition 0\ExeSF-header.bin"> nul 2>&1
		ren "!titledir!\Partition 0\ExeFSdir\banner.bnr" banner.bin > nul 2>&1
		ren "!titledir!\Partition 0\ExeFSdir\icon.icn" icon.bin > nul 2>&1
		call fade out
		call centertext "Rebuilding partition #0..." 24 100
		call fade in
		3dstool -ctf cxi "!titledir!\part-0.cxi" --exefs "!titledir!\Partition 0\ExeFS.bin" --romfs "!titledir!\Partition 0\RomFS.bin" --header "!titledir!\Partition 0\ncch-header.bin" --exh "!titledir!\Partition 0\Ex-Header.bin" --plain "!titledir!\Partition 0\PlainRGN.bin" --logo "!titledir!\Partition 0\LogoLZ.bin" > nul 2>&1
		del /q "!titledir!\Partition 0\ExeFS.bin" > nul 2>&1
		del /q "!titledir!\Partition 0\RomFS.bin" > nul 2>&1
		
		call fade out
		call centertext "Rebuilding ManualRomFS..." 24 100
		call fade in
		3dstool -ctf romfs "!titledir!\Partition 1\RomFS.bin" --romfs-dir "!titledir!\Partition 1\ManualRomFS-dir" > nul 2>&1
		call fade out
		call centertext "Rebuilding partition #1..." 24 100
		call fade in
		3dstool -ctf cfa "!titledir!\part-1.cfa" --romfs "!titledir!\Partition 1\RomFS.bin" --header "!titledir!\Partition 1\ncch-header.bin" > nul 2>&1
		del /q "!titledir!\Partition 1\RomFS.bin" > nul 2>&1
		
		call fade out
		call centertext "Rebuilding DownloadPlayRomFS..." 24 100
		call fade in
		3dstool -ctf romfs "!titledir!\Partition 2\RomFS.bin" --romfs-dir "!titledir!\Partition 2\DownloadPlayRomFS-dir" > nul 2>&1
		call fade out
		call centertext "Rebuilding partition #2..." 24 100
		call fade in
		3dstool -ctf cfa "!titledir!\part-2.cfa" --romfs "!titledir!\Partition 2\RomFS.bin" --header "!titledir!\Partition 2\ncch-header.bin" > nul 2>&1
		del /q "!titledir!\Partition 2\RomFS.bin" > nul 2>&1
		
		
		if exist "!titledir!\Partition 6" (
			call fade out
			call centertext "Rebuilding N3DSUpdateRomFS..." 24 100
			call fade in
			3dstool -ctf romfs "!titledir!\Partition 6\RomFS.bin" --romfs-dir "!titledir!\Partition 6\N3DSUpdateRomFS-dir" > nul 2>&1
			call fade out
			call centertext "Rebuilding partition #6..." 24 100
			call fade in
			3dstool -ctf cfa "!titledir!\part-6.cfa" --romfs "!titledir!\Partition 6\RomFS.bin" --header "!titledir!\Partition 6\ncch-header.bin" > nul 2>&1
			del /q "!titledir!\Partition 6\RomFS.bin" > nul 2>&1
		)
		call fade out
		call centertext "Rebuilding O3DSUpdateRomFS..." 24 100
		call fade in
		3dstool -ctf romfs "!titledir!\Partition 7\RomFS.bin" --romfs-dir "!titledir!\Partition 7\O3DSUpdateRomFS-dir" > nul 2>&1
		call fade out
		call centertext "Rebuilding partition #7..." 24 100
		call fade in
		3dstool -ctf cfa "!titledir!\part-7.cfa" --romfs "!titledir!\Partition 7\RomFS.bin" --header "!titledir!\Partition 7\ncch-header.bin" > nul 2>&1
		del /q "!titledir!\Partition 7\RomFS.bin" > nul 2>&1
		
		call fade out
		call centertext "Repacking 3ds file..." 24 100
		call fade in
		3dstool -ctf 3ds "!filenm!" --header "!titledir!\ncch-header.bin" -0 "!titledir!\part-0.cxi" -1 "!titledir!\part-1.cfa" -2 "!titledir!\part-2.cfa" -6 "!titledir!\part-6.cfa" -7 "!titledir!\part-7.cfa" > nul 2>&1
		del /q "!titledir!\part-0.cxi" > nul 2>&1
		del /q "!titledir!\part-1.cfa" > nul 2>&1
		del /q "!titledir!\part-2.cfa" > nul 2>&1
		del /q "!titledir!\part-6.cfa" > nul 2>&1
		del /q "!titledir!\part-7.cfa" > nul 2>&1
	)
	call fade out
	call centertext "Done. Press any key continue." 24 100
	call fade in
	pause > nul
	call fade out
	goto repack_title
)

if !opt! GTR !maxopt! set opt=1
if !opt! LSS 1 set opt=!maxopt!
goto repack_title_main

:build_3dsx
set opt=1
set maxopt=0
for /f "delims=" %%a in ('dir /a:a /b') do (
	if "%%~xa" == ".3dsx" (
		set /a maxopt+=1
		set name!maxopt!=%%~na
		set fullname!maxopt!=%%a
	)
)
cls
call centertext "Select a .3dsx file to build a .cia file with" 1 100
batbox /g 0 2 /d "____________________________________________________________________________________________________"
set /a maxopt+=1
set fullname!maxopt!=Return
set toclean=
for /l %%a in (1,1,!maxopt!) do (
	set /a y=%%a + 3
	batbox /g 3 !y! /d "!fullname%%a!"
	set toclean=/g 1 !y! /a 32 !toclean!
)
call fade in
:build_3dsx_main
set /a y=!opt! + 3
batbox !toclean! /g 1 !y! /a 16 /k

if !errorlevel! == 327 (
	set /a opt-=1
)
if !errorlevel! == 335 (
	set /a opt+=1
)
if !errorlevel! == 13 (
	if !opt! == !maxopt! goto premain
	set banner=0
	if exist "!name%opt%!-banner" (
		call fade out
		call centertext "Build banner from !name%opt%!-banner folder? (y/n)" 24 100
		call fade in
		:banner
		batbox /k
		
		if !errorlevel! == 121 (
			set banner=1
			goto aft_banner
		)
		if !errorlevel! == 89 (
			set banner=1
			goto aft_banner
		)
		
		if !errorlevel! == 110 (
			set banner=0
			goto skip_banner
		)
		if !errorlevel! == 78 (
			set banner=0
			goto skip_banner
		)
		goto banner
		:aft_banner
		call fade out
		call centertext "Building banner.bin..." 24 100
		call fade in
		bannertool makebanner -i "!name%opt%!-banner/banner.png" -a "!name%opt%!-banner/banner.wav" -o "!name%opt%!-banner/banner.bin" > nul 2>&1
	)
	:skip_banner
	call fade out
	call centertext "Building !name%opt%!.cia..." 24 100
	call fade in
	if !banner! == 1 (
		cxitool -b "!name%opt%!-banner/banner.bin" "!name%opt%!.3dsx" "!name%opt%!.cxi" > nul 2>&1
	) else (
		cxitool "!name%opt%!.3dsx" "!name%opt%!.cxi" > nul 2>&1
	)
	makerom -f cia -o "!name%opt%!.cia" -i "!name%opt%!.cxi:0:0" > nul 2>&1
	del /q "!name%opt%!.cxi" > nul 2>&1
	del /q "!name%opt%!-banner\banner.bin" > nul 2>&1
	call fade out
	call centertext "Done. Press any key continue." 24 100
	call fade in
	pause > nul
	call fade out
	goto build_3dsx
)

if !opt! GTR !maxopt! set opt=1
if !opt! LSS 1 set opt=!maxopt!
goto build_3dsx_main