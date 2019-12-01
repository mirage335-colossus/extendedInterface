
REM Depends:
REM 'mswadminpriv.bat' - 'nircmd elevate'




REM 001-simpit
CALL "C:\core\infrastructure\extendedInterface\support\steamvr\SteamVR_UniManager\simpit.bat"


REM 008-tmux
taskkill /F /IM tmux.exe
tasklist /nh /fi "imagename eq tmux.exe" | find /i "tmux.exe" > nul || (start /MIN "" C:\cygwin64\bin\mintty.exe -i /Cygwin-Terminal.ico /bin/bash --login -i -c '/usr/bin/tmux')


REM 008-Steam
echo prepare - steam
@echo off
setlocal disableDelayedExpansion

:Variables
set InputFile=config\loginusers.vdf
set OutputFile=config\loginusers-temp.vdf
set "_strFind0=		"WantsOfflineMode"		"0""
set "_strReplace0=		"WantsOfflineMode"		"1""
set "_strFind1=		"SkipOfflineModeWarning"		"0""
set "_strReplace1=		"SkipOfflineModeWarning"		"1""

:Replace
>"%OutputFile%" (
  for /f "usebackq delims=" %%A in ("%InputFile%") do (
    if "%%A" equ "%_strFind0%" (echo %_strReplace0%) else if "%%A" equ "%_strFind1%" (echo %_strReplace1%) else (echo %%A)
  )
)

MOVE "%OutputFile%" "%InputFile%"
@echo on
REM start "" "C:\Program Files (x86)\Steam\Steam.exe" -silent
tasklist /nh /fi "imagename eq Steam.exe" | find /i "Steam.exe" > nul || (start "" "C:\Program Files (x86)\Steam\Steam.exe" -silent)


REM 015-VoiceAttack - AS ADMIN - fa18c
REM cd "C:\Program Files (x86)\VoiceAttack"
REM CALL "C:\bin\mswadminpriv.bat" cmd.exe /C start /MIN /D "C:\Program Files (x86)\VoiceAttack" "" "C:\Program Files (x86)\VoiceAttack\VoiceAttack.exe"


REM 020- -JoystickGremlin-  - AS ADMIN - fa18c
CALL "C:\bin\mswadminpriv.bat" cmd.exe /C taskkill /IM joystick_gremlin.exe
CALL "C:\bin\mswadminpriv.bat" cmd.exe /C taskkill /F /IM joystick_gremlin.exe
timeout /NOBREAK 1
cd "C:\Program Files (x86)\H2ik\Joystick Gremlin"
CALL "C:\bin\mswadminpriv.bat" cmd.exe /C start /MIN /D "C:\Program Files (x86)\H2ik\Joystick Gremlin" "" "C:\Program Files (x86)\H2ik\Joystick Gremlin\joystick_gremlin.exe" --profile "C:\core\infrastructure\extendedInterface\support\joystickgremlin\Sim - DCS - FA18C.xml" --enable --start-minimized


REM 020-TARGET
REM cd "C:\Program Files (x86)\Thrustmaster\TARGET"
REM start /MIN "" "C:\Program Files (x86)\Thrustmaster\TARGET\x64\TARGETGUI.exe"


REM 080-VoiceAttack - AS ADMIN - fa18c - construct screen -OPTIONAL
cd "C:\Program Files (x86)\VoiceAttack"
CALL "C:\bin\mswadminpriv.bat" cmd.exe /C start /MIN /D "C:\Program Files (x86)\VoiceAttack" "" "C:\Program Files (x86)\VoiceAttack\VoiceAttack.exe" -profile "COVAS-DCS-FA18C" -command "construct screen"


REM 200-Discord
taskkill /IM Discord.exe
cd "C:\Users\commonadmin\AppData\Local\Discord\"
start /MIN "" C:\Users\commonadmin\AppData\Local\Discord\Update.exe --processStart Discord.exe


REM 201-TeamSpeak
taskkill /IM ts3client_win64.exe
cd "C:\Program Files\TeamSpeak 3 Client"
start /MIN "" "C:\Program Files\TeamSpeak 3 Client\ts3client_win64.exe"


REM 202-SimpleRadioStandalone
CALL "C:\bin\mswadminpriv.bat" cmd.exe /C taskkill /IM SR-ClientRadio.exe
cd "C:\Program Files\DCS-SimpleRadio-Standalone"
start /MIN "" "C:\Program Files\DCS-SimpleRadio-Standalone\SR-ClientRadio.exe"

REM 550-DCS-Waypoint-Editor
taskkill /IM dcs_wp_editor.exe
cd "C:\Users\commonadmin\Documents\project\_permanent\virtual\DCS\sequence\DCS\_bin\dcs_wp_editor"
start /MIN "" "C:\Users\commonadmin\Documents\project\_permanent\virtual\DCS\sequence\DCS\_bin\dcs_wp_editor\dcs_wp_editor.exe"

REM 552-Google Earth Pro
taskkill /IM googleearth.exe
cd "C:\Program Files\Google\Google Earth Pro\client\"
start /MIN "" "C:\Program Files\Google\Google Earth Pro\client\googleearth.exe"

REM 590-Atom - Mission
taskkill /IM atom.exe
cd "C:\Users\commonadmin\AppData\Local\atom\app-1.36.1"
start /MIN "" C:\Users\commonadmin\AppData\Local\atom\atom.exe "C:\Users\commonadmin\Documents\project\_permanent\virtual\DCS\sequence\DCS\_doc" "C:\Users\commonadmin\Documents\project\_permanent\virtual\DCS\sequence\DCS\mission"



timeout /NOBREAK 40

REM 690-VoiceAttack - AS ADMIN - fa18c - construct desk relaxed
CALL "C:\bin\mswadminpriv.bat" cmd.exe /C taskill /IM OVRdrop.exe
CALL "C:\bin\mswadminpriv.bat" cmd.exe /C taskill /F /IM OVRdrop.exe
cd "C:\Program Files (x86)\VoiceAttack"
CALL "C:\bin\mswadminpriv.bat" cmd.exe /C start /MIN /D "C:\Program Files (x86)\VoiceAttack" "" "C:\Program Files (x86)\VoiceAttack\VoiceAttack.exe" -profile "COVAS-DCS-FA18C" -command "construct desk relaxed"



timeout /NOBREAK 15

REM 798- -SimFFB-
taskkill /IM -simFFB-.exe
cd "C:\core\installations\vJoyManagement\_bin"
start /MIN "" "C:\core\installations\vJoyManagement\_bin\-SimFFB-.exe"


REM 799-VoiceAttack - AS ADMIN - fa18c - arrange desk -OPTIONAL
cd "C:\Program Files (x86)\VoiceAttack"
CALL "C:\bin\mswadminpriv.bat" cmd.exe /C start /MIN /D "C:\Program Files (x86)\VoiceAttack" "" "C:\Program Files (x86)\VoiceAttack\VoiceAttack.exe" -profile "COVAS-DCS-FA18C" -command "arrange desk"


start "" cmd /c "echo ***** RAPID COMPLETE ***** &echo(&timeout 10"
timeout 3



REM simulators
REM start "" explorer.exe "C:\Users\commonadmin\Documents\specdesk\--"
