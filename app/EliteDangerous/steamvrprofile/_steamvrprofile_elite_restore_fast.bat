@echo off
echo **********************************************************************
echo *****RESTORE*****
echo SteamVR Profiler
echo fast
echo **********************************************************************

REM Terminate - SteamVR (Ensure video parameter changes take effect.)
taskkill /IM vrmonitor.exe
timeout /NOBREAK 1
taskkill /IM vrmonitor.exe
taskkill /IM vrmonitor.exe
taskkill /IM vrmonitor.exe
timeout /NOBREAK 7
taskkill /F /IM vrmonitor.exe
timeout /NOBREAK 1


cd "C:\Program Files (x86)\Steam\config\"

@echo on
@echo **
copy /Y "steamvr.vrsettings.elite_fast" "steamvr.vrsettings"
@echo off
timeout 3
