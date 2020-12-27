

REM Start 'LeapService' - 'construct hands' by default
REM CALL "C:\bin\mswadminpriv.bat" cmd.exe /C start /MIN /D "C:\WINDOWS\system32" "" "C:\WINDOWS\system32\sc.exe" start LeapService

REM Stop 'LeapService' - 'destruct hands' by default
CALL "C:\bin\mswadminpriv.bat" cmd.exe /C start /MIN /D "C:\WINDOWS\system32" "" "C:\WINDOWS\system32\sc.exe" stop LeapService



REM 015-VoiceAttack - AS ADMIN - Elite
cd "C:\Program Files (x86)\VoiceAttack"
CALL "C:\bin\mswadminpriv.bat" cmd.exe /C start /MIN /D "C:\Program Files (x86)\VoiceAttack" "" "C:\Program Files (x86)\VoiceAttack\VoiceAttack.exe" -profile "SIM-Elite"

REM 020- -JoystickGremlin-  - AS ADMIN - Elite
CALL "C:\bin\mswadminpriv.bat" cmd.exe /C taskkill /IM joystick_gremlin.exe
CALL "C:\bin\mswadminpriv.bat" cmd.exe /C taskkill /F /IM joystick_gremlin.exe
timeout /NOBREAK 1
cd "C:\Program Files (x86)\H2ik\Joystick Gremlin"
CALL "C:\bin\mswadminpriv.bat" cmd.exe /C start /MIN /D "C:\Program Files (x86)\H2ik\Joystick Gremlin" "" "C:\Program Files (x86)\H2ik\Joystick Gremlin\joystick_gremlin.exe" --profile "C:\core\infrastructure\extendedInterface\support\joystickgremlin\Sim - Elite.xml" --enable --start-minimized







CALL "C:\core\infrastructure\extendedInterface\support\pimaxexperience\toSequence_sequence_explorer.bat" "C:\core\sequence\elite"

CALL "C:\core\infrastructure\extendedInterface\support\pimaxexperience\toSequence_sequence_explorer-vd-steam.bat" "C:\core\sequence\elite"

