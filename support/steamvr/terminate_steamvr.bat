REM Terminate - SteamVR (Ensure video parameter changes take effect.)
REM CALL C:\core\infrastructure\extendedInterface\support\steamvr\terminate_steamvr.bat

REM Terminate - SteamVR (Ensure video parameter changes take effect.)
taskkill /IM "Virtual Desktop.exe"
taskkill /IM vrmonitor.exe

CALL "C:\bin\mswadminpriv.bat" cmd.exe /C taskkill /IM "Virtual Desktop.exe"
CALL "C:\bin\mswadminpriv.bat" cmd.exe /C taskkill /IM vrmonitor.exe


CALL C:\core\infrastructure\extendedInterface\support\steamvr\running_steamvr.bat || GOTO TRUE
timeout /NOBREAK 1
CALL C:\core\infrastructure\extendedInterface\support\steamvr\running_steamvr.bat || GOTO TRUE

REM Intended to allow user to answer any interactive warning messages blocking graceful SteamVR shutdown.
timeout 7


taskkill /IM "Virtual Desktop.exe"
taskkill /IM vrmonitor.exe

CALL "C:\bin\mswadminpriv.bat" cmd.exe /C taskkill /IM "Virtual Desktop.exe"
CALL "C:\bin\mswadminpriv.bat" cmd.exe /C taskkill /IM vrmonitor.exe

taskkill /IM "Virtual Desktop.exe"
taskkill /IM vrmonitor.exe

CALL "C:\bin\mswadminpriv.bat" cmd.exe /C taskkill /IM "Virtual Desktop.exe"
CALL "C:\bin\mswadminpriv.bat" cmd.exe /C taskkill /IM vrmonitor.exe

taskkill /IM "Virtual Desktop.exe"
taskkill /IM vrmonitor.exe
taskkill /IM vrserver.exe

CALL "C:\bin\mswadminpriv.bat" cmd.exe /C taskkill /IM "Virtual Desktop.exe"
CALL "C:\bin\mswadminpriv.bat" cmd.exe /C taskkill /IM vrmonitor.exe
CALL "C:\bin\mswadminpriv.bat" cmd.exe /C taskkill /IM vrserver.exe


CALL C:\core\infrastructure\extendedInterface\support\steamvr\running_steamvr.bat || GOTO TRUE
timeout /NOBREAK 3
CALL C:\core\infrastructure\extendedInterface\support\steamvr\running_steamvr.bat || GOTO TRUE



taskkill /F /IM "Virtual Desktop.exe"
taskkill /F /IM vrmonitor.exe
taskkill /F /IM vrserver.exe

CALL "C:\bin\mswadminpriv.bat" cmd.exe /C taskkill /F /IM "Virtual Desktop.exe"
CALL "C:\bin\mswadminpriv.bat" cmd.exe /C taskkill /F /IM vrmonitor.exe
CALL "C:\bin\mswadminpriv.bat" cmd.exe /C taskkill /F /IM vrserver.exe

CALL C:\core\infrastructure\extendedInterface\support\steamvr\running_steamvr.bat || GOTO TRUE
timeout /NOBREAK 1
CALL C:\core\infrastructure\extendedInterface\support\steamvr\running_steamvr.bat || GOTO TRUE








REM 008-Steam-SteamVR-OPTIONAL
REM REM timeout /NOBREAK 1
REM tasklist /nh /fi "imagename eq vrmonitor.exe" | find /i "vrmonitor.exe" > nul || (start "" "steam://rungameid/250820")




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


