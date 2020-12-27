





REM CALL "C:\core\infrastructure\extendedInterface\support\pimaxexperience\toSequence_sequence_explorer" "%1"

REM CALL "C:\core\infrastructure\extendedInterface\support\steamvr\hook_lock.bat" _start_vd

CALL "C:\core\infrastructure\extendedInterface\support\steamvr\SteamVR_allow_offline\steam_allow_offline.bat"
(ping 8.8.8.8 -n 2 -w 9000) || timeout /NOBREAK 20
REM start "" "steam://rungameid/382110"

start "" "C:\Program Files (x86)\Steam\steamapps\common\Virtual Desktop\Virtual Desktop.exe"
