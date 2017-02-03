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

if not exist ".data\settings.txt" (
	:setupsettings
	call centertext "Play music (you can change this setting on the settings menu at any time)? [Y/N]" 24 100
	call fade in
	batbox /k
	if !errorlevel! == 78 (
		(echo set playmusic=No)> .data\settings.txt
		goto skipcheck
	)
	if !errorlevel! == 110 (
		(echo set playmusic=No)> .data\settings.txt
		goto skipcheck
	)
	if !errorlevel! == 89 (
		(echo set playmusic=Yes)> .data\settings.txt
		goto skipcheck
	)
	if !errorlevel! == 121 (
		(echo set playmusic=Yes)> .data\settings.txt
		goto skipcheck
	)
	goto setupsettings
	:skipcheck
	call fade out
)
set playmusic=No
for /f "delims=" %%a in (.data\settings.txt) do %%a
call centertext "Loading..." 25 100
call fade in
set musicplaying=0
for /f "delims=" %%a in ('tasklist /fi "WINDOWTITLE eq bgm" /fi "IMAGENAME eq cmd.exe"') do if "%%a" NEQ "INFO: No tasks are running which match the specified criteria." set musicplaying=1
if exist .data\bgm\Bgm.mp3 if !musicplaying! == 0 if "!playmusic!" == "Yes" (
	call playbgm .data\bgm\Bgm.mp3 loop
	call waitforconsole "3DS_Title_Manager" "bgm"
)

:: ############################################################################################################################################
::                                                                  MAIN MENU
:: ############################################################################################################################################

:premain
call fade out
set opt=1
set maxopt=6
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
echo    Extract a title     ^|   Unpacks everything from a .3DS or .CIA file
echo    Extract RomFS.bin   ^|   Extracts the RomFS file from .3DS, .CIA or .CXI files (Partition #0)
echo    Rebuild RomFS.bin   ^|   Rebuilds RomFS to be used with Hans
echo    Rebuild a title     ^|   Repacks everything that was unpacked from a .3DS or .CIA file
echo    Settings            ^|   Edit settings of the batch tool
echo    Exit                ^|   Close the application
echo.
echo  Use the arrow keys to move the cursor
echo  Press enter to select an option
echo.
echo  CREDITS:
echo    Quiet   - Joe Richards
echo    cmdmp3  - Jim Lawless
echo    3dstool - Sun Daowen
echo    ctrtool - Neimod, 3DSGuy ^& Profi200
echo    makerom - 3DSGuy ^& Profi200
echo    batbox  - DarkBatcher

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
	if !opt! == 5 goto settings
	if !opt! == 6 exit
)

if !opt! GTR !maxopt! set opt=1
if !opt! LSS 1 set opt=!maxopt!
goto main

:: ############################################################################################################################################
::                                                                   SETTINGS
:: ############################################################################################################################################

:settings
set opt=1
set maxopt=4
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
echo    Play music
echo    Stop music
echo    Return
echo.
echo  Use the arrow keys to move the cursor
echo  Press enter to select an option
echo.

set toclean=
for /l %%a in (1,1,!maxopt!) do (
	set /a y=%%a + 8
	set toclean=/g 1 !y! /a 32 !toclean!
)

call fade in
:settingsmain
set /a y=!opt! + 8
if !playmusic! == Yes ( set preopt=/a 17 ) else ( set preopt=/a 32 )
if !playmusic! == No ( set aftopt=/a 16 ) else ( set aftopt=/a 32 )
batbox !toclean! /g 25 9 /d "         " /g 25 9 !preopt! /d " !playmusic! " !aftopt! /g 1 !y! /a 16 /k

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
if !errorlevel! == 13 (
	if !opt! == 2 (
		for /f "delims=" %%a in ('tasklist /fi "WINDOWTITLE eq bgm" /fi "IMAGENAME eq cmd.exe"') do if "%%a" NEQ "INFO: No tasks are running which match the specified criteria." set musicplaying=1
		if exist .data\bgm\Bgm.mp3 if !musicplaying! == 0 if "!playmusic!" == "Yes" (
			call playbgm .data\bgm\Bgm.mp3 loop
			call waitforconsole "3DS_Title_Manager" "bgm"
		)
	)
	if !opt! == 3 (
		taskkill /fi "WINDOWTITLE eq bgm" /fi "IMAGENAME eq cmd.exe" > nul 2>&1
		taskkill /fi "WINDOWTITLE eq wait" /fi "IMAGENAME eq cmd.exe" > nul 2>&1
	)
	if !opt! == 4 (
		(echo set playmusic=!playmusic!)>".data\settings.txt"
		call fade out
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
			call centertext "Extracting RomFS..." 24 100
			call fade in
			3dstool -xtf romfs "!titledir!/Partition 0/Romfs.bin" --romfs-dir "!titledir!/Partition 0/RomFS-dir"> nul 2>&1
			del /f /q "!titledir!\Partition 0\Romfs.bin" > nul 2>&1
			call fade out
			call centertext "Extracting ExeFS..." 24 100
			call fade in
			3dstool -xutf exefs "!titledir!/Partition 0/Exefs.bin" --header "!titledir!/Partition 0/ExeSF-header.bin" --exefs-dir "!titledir!/Partition 0/ExeFS-dir"> nul 2>&1
			del /f /q "!titledir!\Partition 0\Exefs.bin" > nul 2>&1
			ren "!titledir!\Partition 0\ExeFS-dir\banner.bnr" "banner.bin" > nul 2>&1
			ren "!titledir!\Partition 0\ExeFS-dir\icon.icn" "icon.bin" > nul 2>&1
			3dstool -xtf banner "!titledir!/Partition 0/ExeFS-dir/banner.bin" --banner-dir "!titledir!/Partition 0/Banner-dir" > nul 2>&1
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
			call centertext "Extracting RomFS..." 24 100
			call fade in
			3dstool -xtf romfs "!titledir!/Partition 0/Romfs.bin" --romfs-dir "!titledir!/Partition 0/RomFS-dir"> nul 2>&1
			del /f /q "!titledir!\Partition 0\Romfs.bin" > nul 2>&1
			call fade out
			call centertext "Extracting ExeFS..." 24 100
			call fade in
			3dstool -xutf exefs "!titledir!/Partition 0/Exefs.bin" --header "!titledir!/Partition 0/ExeSF-header.bin" --exefs-dir "!titledir!/Partition 0/ExeFS-dir"> nul 2>&1
			del /f /q "!titledir!\Partition 0\Exefs.bin" > nul 2>&1
			ren "!titledir!\Partition 0\ExeFS-dir\banner.bnr" "banner.bin" > nul 2>&1
			ren "!titledir!\Partition 0\ExeFS-dir\icon.icn" "icon.bin" > nul 2>&1
			3dstool -xtf banner "!titledir!/Partition 0/ExeFS-dir/banner.bin" --banner-dir "!titledir!/Partition 0/Banner-dir" > nul 2>&1
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
call centertext "Select a file to get the RomFS from" 1 100
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
	for /f "delims=" %%a in ("!filenm!") do set romfsdir=%%~na - RomFSDir
	if exist "!romfsdir!" (
		call fade out
		call centertext "There already exists a directory with the extracted RomFS. Do you want to overwrite it? [Y/N]" 24 100
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
		call centertext "Extracting RomFS..." 24 100
		call fade in
		ctrtool --content="!romfsdir!\part" "!filenm!"> nul 2>&1
		del /f /q "!romfsdir!\part.0001.*" > nul 2>&1
		del /f /q "!romfsdir!\part.0002.*" > nul 2>&1
		ren "!romfsdir!\part.0000.*" "part-0.cxi" > nul 2>&1
		ctrtool --romfsdir="!romfsdir!" "!romfsdir!\part-0.cxi" > nul 2>&1
		del /f /q "!romfsdir!\part-0.cxi" > nul 2>&1
	)
	if "!filext!" == ".3ds" (
		call fade out
		call centertext "Extracting RomFS..." 24 100
		call fade in
		ctrtool --romfsdir="!romfsdir!" "!filenm!" > nul 2>&1
	)
	if "!filext!" == ".cxi" (
		call fade out
		call centertext "Extracting RomFS..." 24 100
		call fade in
		ctrtool --romfsdir="!romfsdir!" "!filenm!" > nul 2>&1
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
	set /a return-=8
	set check=%%a
	for /f "delims=" %%b in ("!return!") do set check=!check:~%%b!
	if "!check!" == "RomFSDir" (
		set /a return-=3
		set /a maxopt+=1
		set name=%%a
		for /f "delims=" %%b in ("!return!") do set name!maxopt!=!name:~0,%%b!
	)
)
cls
call centertext "Select a RomFS directory to rebuild" 1 100
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
	set romfsdir=!name%opt%! - RomFSDir
	set filenm=!name%opt%! RomFS.bin
	if exist "!filenm!" (
		call fade out
		call centertext "There already exists a RomFS.bin for that game. Do you want to overwrite it? [Y/N]" 24 100
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
		del /q "!filenm!" > nul 2>&1
	)
	call fade out
	call centertext "Rebuilding RomFS.bin..." 24 100
	call fade in
	3dstool -ctf romfs "!filenm!" --romfs-dir "!romfsdir!" > nul 2>&1
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
	if "!filext!" == ".3ds" (
		call fade out
		call centertext "Rebuilding RomFS..." 24 100
		call fade in
		3dstool -ctf romfs "!titledir!\Partition 0\RomFS.bin" --romfs-dir "!titledir!\Partition 0\RomFS-dir" > nul 2>&1
		call fade out
		call centertext "Rebuilding ExeFS..." 24 100
		call fade in
		ren "!titledir!\Partition 0\ExeFS-dir\banner.bin" banner.bnr > nul 2>&1
		ren "!titledir!\Partition 0\ExeFS-dir\icon.bin" icon.icn > nul 2>&1
		3dstool -cztf exefs "!titledir!\Partition 0\ExeFS.bin" --exefs-dir "!titledir!\Partition 0\ExeFS-dir" --header "!titledir!\Partition 0\ExeSF-header.bin"> nul 2>&1
		ren "!titledir!\Partition 0\ExeFS-dir\banner.bnr" banner.bin > nul 2>&1
		ren "!titledir!\Partition 0\ExeFS-dir\icon.icn" icon.bin > nul 2>&1
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
		
		
		call fade out
		call centertext "Repacking cia file..." 24 100
		call fade in
		makerom -f cia -content "!titledir!\part-0.cxi":0 -content "!titledir!\part-1.cfa":1 -content "!titledir!\part-2.cfa":2 -o "!filenm!" > nul 2>&1
		del /q "!titledir!\part-0.cxi" > nul 2>&1
		del /q "!titledir!\part-1.cfa" > nul 2>&1
		del /q "!titledir!\part-2.cfa" > nul 2>&1
	)
	if "!filext!" == ".3ds" (
		call fade out
		call centertext "Rebuilding RomFS..." 24 100
		call fade in
		3dstool -ctf romfs "!titledir!\Partition 0\RomFS.bin" --romfs-dir "!titledir!\Partition 0\RomFS-dir" > nul 2>&1
		call fade out
		call centertext "Rebuilding ExeFS..." 24 100
		call fade in
		ren "!titledir!\Partition 0\ExeFS-dir\banner.bin" banner.bnr > nul 2>&1
		ren "!titledir!\Partition 0\ExeFS-dir\icon.bin" icon.icn > nul 2>&1
		3dstool -cztf exefs "!titledir!\Partition 0\ExeFS.bin" --exefs-dir "!titledir!\Partition 0\ExeFS-dir" --header "!titledir!\Partition 0\ExeSF-header.bin"> nul 2>&1
		ren "!titledir!\Partition 0\ExeFS-dir\banner.bnr" banner.bin > nul 2>&1
		ren "!titledir!\Partition 0\ExeFS-dir\icon.icn" icon.bin > nul 2>&1
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



























