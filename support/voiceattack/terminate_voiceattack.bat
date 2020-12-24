

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

GOTO FALSE







:_stop

REM Terminate - VoiceAttack (Ensure correct microphone is available and used.)
CALL "C:\bin\mswadminpriv.bat" cmd.exe /C taskkill /IM VoiceAttack.exe
tasklist /nh /fi "imagename eq VoiceAttack.exe" | find /i "VoiceAttack.exe" > nul || GOTO done
timeout /NOBREAK 1
CALL "C:\bin\mswadminpriv.bat" cmd.exe /C taskkill /IM VoiceAttack.exe
CALL "C:\bin\mswadminpriv.bat" cmd.exe /C taskkill /IM VoiceAttack.exe
CALL "C:\bin\mswadminpriv.bat" cmd.exe /C taskkill /IM VoiceAttack.exe
tasklist /nh /fi "imagename eq VoiceAttack.exe" | find /i "VoiceAttack.exe" > nul || GOTO done
REM timeout /NOBREAK 7
timeout /NOBREAK 2

CALL "C:\bin\mswadminpriv.bat" cmd.exe /C taskkill /F /IM VoiceAttack.exe
timeout /NOBREAK 3



GOTO FALSE


:done
timeout /NOBREAK 1


IF /I "%hookAction%" EQU "_restart" GOTO _start

GOTO TRUE


:_force

REM RESERVED

GOTO FALSE




:_restart

GOTO _stop


GOTO FALSE


:_start


REM 015-VoiceAttack - AS ADMIN
cd "C:\Program Files (x86)\VoiceAttack"
CALL "C:\bin\mswadminpriv.bat" cmd.exe /C start /MIN /D "C:\Program Files (x86)\VoiceAttack" "" "C:\Program Files (x86)\VoiceAttack\VoiceAttack.exe"




GOTO TRUE





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




























