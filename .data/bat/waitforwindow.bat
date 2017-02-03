@echo off
title wait
:retry
timeout /t 1 /nobreak > nul
for /f "usebackq delims=" %%a in (`tasklist /fi "WINDOWTITLE eq %~1" /fi "IMAGENAME eq cmd.exe"`) do if "%%a" NEQ "INFO: No tasks are running which match the specified criteria." goto retry
taskkill /fi "WINDOWTITLE eq %~2" /fi "IMAGENAME eq cmd.exe" > nul
exit