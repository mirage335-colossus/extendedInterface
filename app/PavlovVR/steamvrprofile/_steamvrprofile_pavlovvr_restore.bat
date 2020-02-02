@echo off
echo **********************************************************************
echo *****RESTORE*****
echo SteamVR Profiler
echo Primary
echo **********************************************************************

REM Terminate - SteamVR (Ensure video parameter changes take effect.)
REM CALL C:\core\infrastructure\extendedInterface\support\steamvr\terminate_steamvr.bat


cd "C:\Program Files (x86)\Steam\config\"

@echo on
@echo **
copy /Y "steamvr.vrsettings.pavlovvr" "steamvr.vrsettings"
@echo off
echo ________
echo WARNING: SteamVR Restart Required!
timeout 3
