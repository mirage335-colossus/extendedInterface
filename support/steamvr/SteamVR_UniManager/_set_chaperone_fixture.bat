
REM BROKEN!
exit /b 0


cd "C:\Program Files (x86)\Steam\config\"
copy /Y "chaperone_info.vrchap" "chaperone_info.vrchap.fixture"

cd "%LOCALAPPDATA%"\openvr
copy /Y "chaperone_info.vrchap" "chaperone_info.vrchap.fixture"
