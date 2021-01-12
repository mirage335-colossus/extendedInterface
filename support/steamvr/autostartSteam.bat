REM Terminate - SteamVR (Ensure video parameter changes take effect.)
REM CALL C:\core\infrastructure\extendedInterface\support\steamvr\terminate_steamvr.bat

timeout /NOBREAK 1

CALL "C:\core\infrastructure\extendedInterface\support\steamvr\SteamVR_allow_offline\steam_allow_offline.bat"


REM 008-Steam
REM echo prepare - steam
REM @echo off
REM setlocal disableDelayedExpansion

:Variables
REM set InputFile=config\loginusers.vdf
REM set OutputFile=config\loginusers-temp.vdf
REM set "_strFind0=		"WantsOfflineMode"		"0""
REM set "_strReplace0=		"WantsOfflineMode"		"1""
REM set "_strFind1=		"SkipOfflineModeWarning"		"0""
REM set "_strReplace1=		"SkipOfflineModeWarning"		"1""

:Replace
REM >"%OutputFile%" (
REM   for /f "usebackq delims=" %%A in ("%InputFile%") do (
REM     if "%%A" equ "%_strFind0%" (echo %_strReplace0%) else if "%%A" equ "%_strFind1%" (echo %_strReplace1%) else (echo %%A)
REM   )
REM )

REM MOVE "%OutputFile%" "%InputFile%"

REM Wired network startup really should complete BEFORE any desktop GUI is started. MSW apparently disregards this. Therefore, delay.
REM timeout /NOBREAK 20
(ping 8.8.8.8 -n 2 -w 9000) || timeout /NOBREAK 20
REM Testing only. Intended to fail, resulting in 18second delay.
REM (ping 8.8.8.9 -n 2 -w 9000) || timeout /NOBREAK 20

@echo on
REM start "" "C:\Program Files (x86)\Steam\Steam.exe" -silent
tasklist /nh /fi "imagename eq Steam.exe" | find /i "Steam.exe" > nul || (start "" "C:\Program Files (x86)\Steam\Steam.exe" -silent)






