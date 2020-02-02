@echo off
echo **********************************************************************
echo *****BACKUP*****
echo SteamVR Profiler
echo fast
echo **********************************************************************

REM Terminate - SteamVR (Ensure video parameter changes take effect.)
CALL C:\core\infrastructure\extendedInterface\support\steamvr\terminate_steamvr.bat


cd "C:\Program Files (x86)\Steam\config\"

@echo on
@echo **
copy /Y "steamvr.vrsettings" "steamvr.vrsettings.dcs_fast"
@echo off
timeout 3
