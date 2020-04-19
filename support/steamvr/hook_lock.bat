

@echo off
REM Depends:
REM 'mswadminpriv.bat' - 'nircmd elevate'

REM SINGLE THREAD LOCK
REM https://superuser.com/questions/1035043/how-can-i-tell-if-my-batch-file-is-running
@echo on

SET hookAction=_stop
IF /I "%1" EQU "_stop" SET hookAction=_stop
IF /I "%1" EQU "_force" SET hookAction=_force
IF /I "%1" EQU "_start" SET hookAction=_start
IF /I "%1" EQU "_restart" SET hookAction=_restart
IF /I "%1" EQU "_start_vd" SET hookAction=_start_vd
IF /I "%1" EQU "_restart_vd" SET hookAction=_restart_vd


@echo off
:: Note - this extra call is to avoid a bug with %~f0 when the script
::        is executed with quotes around the script name.
call :getLock
exit /b

:getLock
:: The CALL will fail if another process already has a write lock on the script
call :main 9>>"%~f0"
exit /b

:main
:: Body of your script goes here. Only one process can ever get here
:: at a time. The lock will be released upon return from this routine,
:: or when the script terminates for any reason

IF /I "%hookAction%" EQU "_stop" GOTO _stop
IF /I "%hookAction%" EQU "_force" GOTO _force
IF /I "%hookAction%" EQU "_start" GOTO _start
IF /I "%hookAction%" EQU "_restart" GOTO _restart
IF /I "%hookAction%" EQU "_start_vd" GOTO _start
IF /I "%hookAction%" EQU "_restart_vd" GOTO _restart

GOTO FALSE





:_stop

REM Ideally, this will terminate SteamVR, ONLY, if a VR headset startup hook is not actively (re)starting these applications.

REM Terminate - SteamVR (Ensure video parameter changes take effect.)
CALL C:\core\infrastructure\extendedInterface\support\steamvr\terminate_steamvr.bat





GOTO FALSE



:_force

REM RESERVED

GOTO FALSE



:_restart

REM Ideally, this will terminate SteamVR, ONLY, if a VR headset startup hook is not actively (re)starting these applications,
REM then launch a hook ONLY if not immediately launched automatically in response to SteamVR termination.

REM Terminate - SteamVR (Ensure video parameter changes take effect.)
CALL C:\core\infrastructure\extendedInterface\support\steamvr\terminate_steamvr.bat

timeout /NOBREAK 1

CALL "C:\core\infrastructure\extendedInterface\support\steamvr\SteamVR_allow_offline\steam_allow_offline.bat"

REM If hook causes SteamVR to start, it must call this script with _start parameter or similar.
REM IF /I "%hookAction%" EQU "_restart" start "" cmd.exe /C CALL "C:\core\infrastructure\extendedInterface\support\steamvr\hook.bat" _start
REM IF /I "%hookAction%" EQU "_restart_vd" start "" cmd.exe /C CALL "C:\core\infrastructure\extendedInterface\support\steamvr\hook.bat" _start_vd

IF /I "%hookAction%" EQU "_restart" GOTO _start
IF /I "%hookAction%" EQU "_restart_vd" GOTO _start_vd


GOTO FALSE


:_start

REM Terminate - SteamVR (Ensure video parameter changes take effect.)
CALL C:\core\infrastructure\extendedInterface\support\steamvr\terminate_steamvr.bat

timeout /NOBREAK 1

CALL "C:\core\infrastructure\extendedInterface\support\steamvr\SteamVR_allow_offline\steam_allow_offline.bat"

REM 008-Steam
REM echo prepare - steam
REM @echo off
REM setlocal disableDelayedExpansion

REM :Variables
REM set InputFile=config\loginusers.vdf
REM set OutputFile=config\loginusers-temp.vdf
REM set "_strFind0=		"WantsOfflineMode"		"0""
REM set "_strReplace0=		"WantsOfflineMode"		"1""
REM set "_strFind1=		"SkipOfflineModeWarning"		"0""
REM set "_strReplace1=		"SkipOfflineModeWarning"		"1""

REM :Replace
REM >"%OutputFile%" (
REM   for /f "usebackq delims=" %%A in ("%InputFile%") do (
REM     if "%%A" equ "%_strFind0%" (echo %_strReplace0%) else if "%%A" equ "%_strFind1%" (echo %_strReplace1%) else (echo %%A)
REM   )
REM )

REM MOVE "%OutputFile%" "%InputFile%"
REM @echo on
REM start "" "C:\Program Files (x86)\Steam\Steam.exe" -silent
REM tasklist /nh /fi "imagename eq Steam.exe" | find /i "Steam.exe" > nul || (start "" "C:\Program Files (x86)\Steam\Steam.exe" -silent)

REM Wired network startup really should complete BEFORE any desktop GUI is started. MSW apparently disregards this. Therefore, delay.
REM timeout /NOBREAK 20
(ping 8.8.8.8 -n 2 -w 9000) || timeout /NOBREAK 20
REM Testing only. Intended to fail, resulting in 18second delay.
REM (ping 8.8.8.9 -n 2 -w 9000) || timeout /NOBREAK 20

REM 008-Steam-SteamVR-OPTIONAL
REM Terminate - SteamVR (Ensure video parameter changes take effect.)
REM CALL C:\core\infrastructure\extendedInterface\support\steamvr\terminate_steamvr.bat
REM start "" "steam://rungameid/250820"
tasklist /nh /fi "imagename eq vrmonitor.exe" | find /i "vrmonitor.exe" > nul || (start "" "steam://rungameid/250820")


timeout /NOBREAK 1




IF /I "%hookAction%" EQU "_start_vd" GOTO _start_vd
IF /I "%hookAction%" EQU "_restart_vd" GOTO _start_vd



GOTO TRUE




REM WARNING: PREREQUSITE: _start .
:_start_vd

CALL "C:\core\infrastructure\extendedInterface\support\steamvr\SteamVR_allow_offline\steam_allow_offline.bat"


REM Wired network startup really should complete BEFORE any desktop GUI is started. MSW apparently disregards this. Therefore, delay.
REM timeout /NOBREAK 20
(ping 8.8.8.8 -n 2 -w 9000) || timeout /NOBREAK 20
REM Testing only. Intended to fail, resulting in 18second delay.
REM (ping 8.8.8.9 -n 2 -w 9000) || timeout /NOBREAK 20

REM 080-VirtualDesktop
REM tasklist /nh /fi "imagename eq Virtual Desktop.exe" | find /i "Virtual Desktop.exe" > nul || (start "" "steam://rungameid/382110")
start "" "steam://rungameid/382110"





GOTO TRUE









REM _____
GOTO FALSE


:TRUE
timeout /NOBREAK 1
@echo off
echo TRUE
@echo on

exit /b


:FALSE
timeout /NOBREAK 1
@echo off
echo FALSE
@echo on

exit /b 1

