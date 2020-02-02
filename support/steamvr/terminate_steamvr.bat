REM Terminate - SteamVR (Ensure video parameter changes take effect.)
REM CALL C:\core\infrastructure\extendedInterface\support\steamvr\terminate_steamvr.bat

REM Terminate - SteamVR (Ensure video parameter changes take effect.)
taskkill /IM vrmonitor.exe
timeout /NOBREAK 1
taskkill /IM vrmonitor.exe
taskkill /IM vrmonitor.exe
taskkill /IM vrmonitor.exe
taskkill /IM vrserver.exe
taskkill /IM "Virtual Desktop.exe"
timeout /NOBREAK 7
taskkill /F /IM vrmonitor.exe
taskkill /F /IM vrserver.exe
taskkill /F /IM "Virtual Desktop.exe"
timeout /NOBREAK 1

REM 008-Steam-SteamVR-OPTIONAL
REM REM taskkill /IM vrmonitor.exe
REM REM timeout /NOBREAK 1
REM REM taskkill /IM vrmonitor.exe
REM REM taskkill /IM vrmonitor.exe
REM REM taskkill /IM vrmonitor.exe
REM REM taskkill /IM vrserver.exe
REM REM taskkill /IM Virtual Desktop.exe
REM REM timeout /NOBREAK 7
REM REM taskkill /F /IM vrmonitor.exe
REM REM taskkill /F /IM vrserver.exe
REM REM timeout /NOBREAK 1
REM REM start "" "steam://rungameid/250820"
REM tasklist /nh /fi "imagename eq vrmonitor.exe" | find /i "vrmonitor.exe" > nul || (start "" "steam://rungameid/250820")

