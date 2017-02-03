@echo off
title bgm
:loop
cmdmp3 %1 > nul
if %2 == "loop" goto loop
exit