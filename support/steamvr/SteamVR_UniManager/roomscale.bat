
REM BROKEN!
exit /b 0


cd "C:\Program Files (x86)\Steam\config\"
copy "chaperone_info.vrchap.roomscale" "chaperone_info.vrchap"

cd "%LOCALAPPDATA%"\openvr
copy "chaperone_info.vrchap.roomscale" "chaperone_info.vrchap"
