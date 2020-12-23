
REM BROKEN!
exit /b 0


cd "C:\Program Files (x86)\Steam\config\"
copy "chaperone_info.vrchap.simpit" "chaperone_info.vrchap"

cd "%LOCALAPPDATA%"\openvr
copy "chaperone_info.vrchap.simpit" "chaperone_info.vrchap"

cd "C:\ProgramData\pimax\runtime"
REM copy "chaperone_info.vrchap.simpit" "chaperone_info.vrchap"
del chaperone_info.vrchap

cd "C:\Program Files (x86)\Steam\config\oculus"
REM copy "chaperone_info.vrchap.simpit" "chaperone_info.vrchap"
del driver_oculus.vrchap




