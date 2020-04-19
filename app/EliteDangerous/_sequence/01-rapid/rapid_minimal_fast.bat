
REM Depends:
REM 'mswadminpriv.bat' - 'nircmd elevate'

CALL C:\core\infrastructure\extendedInterface\support\oculus\_oculus_prohibit.bat
REM CALL C:\core\infrastructure\extendedInterface\support\oculus\_oculus_allow.bat


REM Terminate - VoiceAttack (Ensure correct microphone is available and used.)
CALL C:\core\infrastructure\extendedInterface\support\voiceattack\terminate_voiceattack.bat


REM 001-simpit
CALL "C:\core\infrastructure\extendedInterface\support\steamvr\SteamVR_UniManager\simpit.bat"

REM 002-_steamvrprofile_elite_restore
REM CALL "C:\core\infrastructure\extendedInterface\app\EliteDangerous\steamvrprofile\_steamvrprofile_elite_restore.bat"

REM 002-_steamvrprofile_elite_restore_fast
CALL "C:\core\infrastructure\extendedInterface\app\EliteDangerous\steamvrprofile\_steamvrprofile_elite_restore_fast.bat"


REM 005-EVGA Precision X1 (if installed)
cd "C:\Program Files\EVGA\Precision X1"
tasklist /nh /fi "imagename eq PrecisionX_x64.exe" | find /i "PrecisionX_x64.exe" > nul || (start /MIN "" "C:\Program Files\EVGA\Precision X1\PrecisionX_x64.exe" 0)

REM 008-tmux
REM taskkill /F /IM tmux.exe
tasklist /nh /fi "imagename eq tmux.exe" | find /i "tmux.exe" > nul || (start /MIN "" C:\cygwin64\bin\mintty.exe -i /Cygwin-Terminal.ico /bin/bash --login -i -c '/usr/bin/tmux')
REM timeout /NOBREAK 12
REM taskkill /IM mintty.exe







REM 015-VoiceAttack - AS ADMIN - Elite
cd "C:\Program Files (x86)\VoiceAttack"
CALL "C:\bin\mswadminpriv.bat" cmd.exe /C start /MIN /D "C:\Program Files (x86)\VoiceAttack" "" "C:\Program Files (x86)\VoiceAttack\VoiceAttack.exe" -profile "SIM-Elite"


REM 020- -JoystickGremlin-  - AS ADMIN - Elite
CALL "C:\bin\mswadminpriv.bat" cmd.exe /C taskkill /IM joystick_gremlin.exe
CALL "C:\bin\mswadminpriv.bat" cmd.exe /C taskkill /F /IM joystick_gremlin.exe
timeout /NOBREAK 1
cd "C:\Program Files (x86)\H2ik\Joystick Gremlin"
CALL "C:\bin\mswadminpriv.bat" cmd.exe /C start /MIN /D "C:\Program Files (x86)\H2ik\Joystick Gremlin" "" "C:\Program Files (x86)\H2ik\Joystick Gremlin\joystick_gremlin.exe" --profile "C:\core\infrastructure\extendedInterface\support\joystickgremlin\Sim - Elite.xml" --enable --start-minimized


REM OBSOLETE
REM 020-TARGET
REM cd "C:\Program Files (x86)\Thrustmaster\TARGET"
REM start /MIN "" "C:\Program Files (x86)\Thrustmaster\TARGET\x64\TARGETGUI.exe"




REM ATTENTION: Disable if VirtualDesktop is to be started by voice command.
REM 015-VoiceAttack - AS ADMIN - SHELL-MSW - construct screen
REM cd "C:\Program Files (x86)\VoiceAttack"
REM CALL "C:\bin\mswadminpriv.bat" cmd.exe /C start /MIN /D "C:\Program Files (x86)\VoiceAttack" "" "C:\Program Files (x86)\VoiceAttack\VoiceAttack.exe" -profile "SHELL-MSW" -command "construct screen virtualdesktop procedure"
REM 080-VirtualDesktop
REM tasklist /nh /fi "imagename eq Virtual Desktop.exe" | find /i "Virtual Desktop.exe" > nul || (start "" "steam://rungameid/382110")
REM start "" "steam://rungameid/382110"




REM -----

REM 200-Discord
REM taskkill /IM Discord.exe
REM cd "%USERPROFILE%\AppData\Local\Discord\"
REM start /MIN "" %USERPROFILE%\AppData\Local\Discord\Update.exe --processStart Discord.exe


REM 201-TeamSpeak
REM taskkill /IM ts3client_win64.exe
REM cd "C:\Program Files\TeamSpeak 3 Client"
REM start /MIN "" "C:\Program Files\TeamSpeak 3 Client\ts3client_win64.exe"


REM OBSOLETE
REM 590-Atom - Mission
REM taskkill /IM atom.exe
REM cd "%USERPROFILE%\AppData\Local\atom\app-1.36.1"
REM start "" cmd /c atom "C:\core\sequence\elite\901-doc" "C:\core\sequence\elite\930-mission"


REM 590-panel - Elite
cd "C:\Program Files\Oracle\VirtualBox"
start /MIN "" "C:\Program Files\Oracle\VirtualBox\VirtualBoxVM.exe" --comment "panel - Elite" --startvm "panel - Elite"



REM 600-EDMC
REM cd "C:\Program Files (x86)\EDMarketConnector"
REM start /MIN "" "C:\Program Files (x86)\EDMarketConnector\EDMarketConnector.exe"


REM 601-EDEngineer




REM ATTENTION: Only necessary if experiencing severe unreliability starting OVRDrop while VR app is running.
REM 690-VoiceAttack - AS ADMIN - Elite - construct desk relaxed
REM CALL "C:\bin\mswadminpriv.bat" cmd.exe /C taskill /IM OVRdrop.exe
REM CALL "C:\bin\mswadminpriv.bat" cmd.exe /C taskill /F /IM OVRdrop.exe
REM cd "C:\Program Files (x86)\VoiceAttack"
REM CALL "C:\bin\mswadminpriv.bat" cmd.exe /C start /MIN /D "C:\Program Files (x86)\VoiceAttack" "" "C:\Program Files (x86)\VoiceAttack\VoiceAttack.exe" -profile "SIM-Elite" -command "construct desk relaxed"


REM ATTENTION: Not always desirable, and likely to be overridden on VR app start.
REM 798- -SimFFB-
REM taskkill /IM -simFFB-.exe
REM cd "C:\core\infrastructure\extendedInterface\app\Elite\_sequence\05-maintenance\_lib\simffb"
REM start /MIN "" "C:\core\infrastructure\extendedInterface\app\Elite\_sequence\05-maintenance\_lib\simffb\-SimFFB-.exe"

REM 799- OBS Studio
REM tasklist /nh /fi "imagename eq obs64.exe" | find /i "obs64.exe" > nul || (start "" "C:\Program Files (x86)\obs-studio\bin\64bit\obs64.exe")

REM -----







REM 799-VoiceAttack - AS ADMIN - fa18c - rapid complete -OPTIONAL
REM 799-VoiceAttack - AS ADMIN - fa18c - arrange desk -OPTIONAL
timeout 3
cd "C:\Program Files (x86)\VoiceAttack"
CALL "C:\bin\mswadminpriv.bat" cmd.exe /C start /MIN /D "C:\Program Files (x86)\VoiceAttack" "" "C:\Program Files (x86)\VoiceAttack\VoiceAttack.exe" -profile "SIM-Elite" -command "rapid complete"



REM ATTENTION: Restart of SteamVR with Pimax headsets, automatic or interactive, may not be reliable.
REM Terminate - SteamVR (Ensure video parameter changes take effect.)
REM CALL C:\core\infrastructure\extendedInterface\support\steamvr\terminate_steamvr.bat
REM cd C:\core\infrastructure\extendedInterface\support\steamvr\
REM CALL C:\core\infrastructure\extendedInterface\support\steamvr\hook_lock.bat _restart_vd
echo ________
echo REQUEST
echo ________
echo WARNING: SteamVR Restart Required!

timeout 1

start "" cmd /c "echo ________ &echo REQUEST &echo ________ &echo WARNING: SteamVR Restart Required! &echo. &echo ***** RAPID COMPLETE *****  &echo(&timeout 10"



