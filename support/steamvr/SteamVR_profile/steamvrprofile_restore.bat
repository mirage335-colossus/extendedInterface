@echo off
echo **********************************************************************
echo *****RESTORE*****
echo SteamVR Profiler
echo %1
echo **********************************************************************

REM Terminate - SteamVR (Ensure video parameter changes take effect.)
REM CALL C:\core\infrastructure\extendedInterface\support\steamvr\terminate_steamvr.bat



@echo on

@echo **
cd "C:\Program Files (x86)\Steam\config\"
copy /Y "steamvr.vrsettings.bak.%1" "steamvr.vrsettings"

@echo **
cd "%LOCALAPPDATA%"\openvr
copy /Y "steamvr.vrsettings.bak.%1" "steamvr.vrsettings"


@echo off




echo ________
echo WARNING: SteamVR Restart Required!
timeout 3
