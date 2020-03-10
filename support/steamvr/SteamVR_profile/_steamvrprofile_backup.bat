@echo off
echo **********************************************************************
echo *****BACKUP*****
echo SteamVR Profiler
echo %1
echo **********************************************************************

REM Terminate - SteamVR (Ensure video parameter changes take effect.)
CALL C:\core\infrastructure\extendedInterface\support\steamvr\terminate_steamvr.bat



@echo on

@echo **
cd "C:\Program Files (x86)\Steam\config\"
copy /Y "steamvr.vrsettings" "steamvr.vrsettings.bak.%1"

@echo **
cd "%LOCALAPPDATA%"\openvr
copy /Y "steamvr.vrsettings" "steamvr.vrsettings.bak.%1"

@echo off



timeout 3
