


tasklist /nh /fi "imagename eq vrmonitor.exe" | find /i "vrmonitor.exe" > nul
SET running_vrmonitor=%errorlevel%
tasklist /nh /fi "imagename eq vrserver.exe" | find /i "vrserver.exe" > nul
SET running_vrserver=%errorlevel%
tasklist /nh /fi "imagename eq Virtual Desktop.exe" | find /i "Virtual Desktop.exe" > nul
SET running_VirtualDesktop=%errorlevel%

IF not %running_vrmonitor%==0 IF not %running_vrserver%==0 IF not %running_VirtualDesktop%==0 GOTO :FALSE



echo TRUE


exit /b 0



:FALSE
@echo off
echo FALSE
@echo on

exit /b 1
