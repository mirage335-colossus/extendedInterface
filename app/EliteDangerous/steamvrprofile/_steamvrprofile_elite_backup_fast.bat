@echo off
echo **********************************************************************
echo *****BACKUP*****
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
copy /Y "steamvr.vrsettings" "steamvr.vrsettings.elite_fast"
@echo off
timeout 3
