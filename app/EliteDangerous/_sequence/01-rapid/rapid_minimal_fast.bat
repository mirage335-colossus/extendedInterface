
REM Depends:
REM 'mswadminpriv.bat' - 'nircmd elevate'


REM Terminate - VoiceAttack (Ensure correct microphone is available and used.)
CALL C:\core\infrastructure\extendedInterface\support\voiceattack\terminate_voiceattack.bat


REM 001-simpit
CALL "C:\core\infrastructure\extendedInterface\support\steamvr\SteamVR_UniManager\simpit.bat"

REM 002-_steamvrprofile_elite_restore
REM CALL "C:\core\infrastructure\extendedInterface\app\EliteDangerous\steamvrprofile\_steamvrprofile_elite_restore.bat"

REM 002-_steamvrprofile_elite_restore_fast
CALL "C:\core\infrastructure\extendedInterface\app\EliteDangerous\steamvrprofile\_steamvrprofile_elite_restore_fast.bat"


REM Terminate - SteamVR (Ensure video parameter changes take effect.)
CALL C:\core\infrastructure\extendedInterface\support\steamvr\terminate_steamvr.bat



REM 005-EVGA Precision X1 (if installed)
cd "C:\Program Files\EVGA\Precision X1"
tasklist /nh /fi "imagename eq PrecisionX_x64.exe" | find /i "PrecisionX_x64.exe" > nul || (start /MIN "" "C:\Program Files\EVGA\Precision X1\PrecisionX_x64.exe" 0)

REM 008-tmux
REM taskkill /F /IM tmux.exe
REM tasklist /nh /fi "imagename eq tmux.exe" | find /i "tmux.exe" > nul || (start /MIN "" C:\cygwin64\bin\mintty.exe -i /Cygwin-Terminal.ico /bin/bash --login -i -c '/usr/bin/tmux')
REM timeout /NOBREAK 12
REM taskkill /IM mintty.exe


REM 008-Steam
REM https://forums.nexusmods.com/index.php?/topic/6387951-start-steam-silently-on-system-startup-simply-stated/

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

REM 008-Steam-SteamVR-OPTIONAL
REM Terminate - SteamVR (Ensure video parameter changes take effect.)
REM CALL C:\core\infrastructure\extendedInterface\support\steamvr\terminate_steamvr.bat
REM start "" "steam://rungameid/250820"
REM tasklist /nh /fi "imagename eq vrmonitor.exe" | find /i "vrmonitor.exe" > nul || (start "" "steam://rungameid/250820")

REM 015-VoiceAttack - AS ADMIN - Elite
cd "C:\Program Files (x86)\VoiceAttack"
CALL "C:\bin\mswadminpriv.bat" cmd.exe /C start /MIN /D "C:\Program Files (x86)\VoiceAttack" "" "C:\Program Files (x86)\VoiceAttack\VoiceAttack.exe" -profile "COVAS-Elite"


REM 020- -JoystickGremlin-  - AS ADMIN - Elite
CALL "C:\bin\mswadminpriv.bat" cmd.exe /C taskkill /IM joystick_gremlin.exe
CALL "C:\bin\mswadminpriv.bat" cmd.exe /C taskkill /F /IM joystick_gremlin.exe
timeout /NOBREAK 1
cd "C:\Program Files (x86)\H2ik\Joystick Gremlin"
CALL "C:\bin\mswadminpriv.bat" cmd.exe /C start /MIN /D "C:\Program Files (x86)\H2ik\Joystick Gremlin" "" "C:\Program Files (x86)\H2ik\Joystick Gremlin\joystick_gremlin.exe" --profile "C:\core\infrastructure\extendedInterface\support\joystickgremlin\Sim - Elite.xml" --enable --start-minimized

REM 020-TARGET
REM cd "C:\Program Files (x86)\Thrustmaster\TARGET"
REM start /MIN "" "C:\Program Files (x86)\Thrustmaster\TARGET\x64\TARGETGUI.exe"


timeout /NOBREAK 35

REM ATTENTION: Disable if VirtualDesktop is to be started by voice command.
REM 015-VoiceAttack - AS ADMIN - SHELL-MSW - construct screen
REM cd "C:\Program Files (x86)\VoiceAttack"
REM CALL "C:\bin\mswadminpriv.bat" cmd.exe /C start /MIN /D "C:\Program Files (x86)\VoiceAttack" "" "C:\Program Files (x86)\VoiceAttack\VoiceAttack.exe" -profile "SHELL-MSW" -command "construct screen virtualdesktop procedure"

REM 080-VirtualDesktop
tasklist /nh /fi "imagename eq Virtual Desktop.exe" | find /i "Virtual Desktop.exe" > nul || (start "" "steam://rungameid/382110")
REM start "" "steam://rungameid/382110"


REM 690-VoiceAttack - AS ADMIN - Elite - construct desk relaxed
REM CALL "C:\bin\mswadminpriv.bat" cmd.exe /C taskill /IM OVRdrop.exe
REM CALL "C:\bin\mswadminpriv.bat" cmd.exe /C taskill /F /IM OVRdrop.exe
REM cd "C:\Program Files (x86)\VoiceAttack"
REM CALL "C:\bin\mswadminpriv.bat" cmd.exe /C start /MIN /D "C:\Program Files (x86)\VoiceAttack" "" "C:\Program Files (x86)\VoiceAttack\VoiceAttack.exe" -profile "COVAS-Elite" -command "construct desk relaxed"




REM 200-Discord
REM taskkill /IM Discord.exe
REM cd "%USERPROFILE%\AppData\Local\Discord\"
REM start /MIN "" %USERPROFILE%\AppData\Local\Discord\Update.exe --processStart Discord.exe


REM 201-TeamSpeak
REM taskkill /IM ts3client_win64.exe
REM cd "C:\Program Files\TeamSpeak 3 Client"
REM start /MIN "" "C:\Program Files\TeamSpeak 3 Client\ts3client_win64.exe"

REM 590-Atom - Mission
REM taskkill /IM atom.exe
REM cd "%USERPROFILE%\AppData\Local\atom\app-1.36.1"
REM start "" cmd /c atom "C:\core\sequence\elite\901-doc" "C:\core\sequence\elite\930-mission"




REM 600-EDMC
REM cd "C:\Program Files (x86)\EDMarketConnector"
REM start /MIN "" "C:\Program Files (x86)\EDMarketConnector\EDMarketConnector.exe"


REM 601-EDEngineer




REM timeout /NOBREAK 40

REM 690-VoiceAttack - AS ADMIN - Elite - construct desk relaxed
REM CALL "C:\bin\mswadminpriv.bat" cmd.exe /C taskill /IM OVRdrop.exe
REM CALL "C:\bin\mswadminpriv.bat" cmd.exe /C taskill /F /IM OVRdrop.exe
REM cd "C:\Program Files (x86)\VoiceAttack"
REM CALL "C:\bin\mswadminpriv.bat" cmd.exe /C start /MIN /D "C:\Program Files (x86)\VoiceAttack" "" "C:\Program Files (x86)\VoiceAttack\VoiceAttack.exe" -profile "COVAS-Elite" -command "construct desk relaxed"





REM 798- -SimFFB-
REM taskkill /IM -simFFB-.exe
REM cd "C:\core\infrastructure\extendedInterface\app\Elite\_sequence\05-maintenance\_lib\simffb"
REM start /MIN "" "C:\core\infrastructure\extendedInterface\app\Elite\_sequence\05-maintenance\_lib\simffb\-SimFFB-.exe"

REM 799- OBS Studio
REM tasklist /nh /fi "imagename eq obs64.exe" | find /i "obs64.exe" > nul || (start "" "C:\Program Files (x86)\obs-studio\bin\64bit\obs64.exe")





REM timeout /NOBREAK 15

REM 799-VoiceAttack - AS ADMIN - Elite - rapid complete -OPTIONAL
REM 799-VoiceAttack - AS ADMIN - Elite - arrange desk -OPTIONAL
cd "C:\Program Files (x86)\VoiceAttack"
CALL "C:\bin\mswadminpriv.bat" cmd.exe /C start /MIN /D "C:\Program Files (x86)\VoiceAttack" "" "C:\Program Files (x86)\VoiceAttack\VoiceAttack.exe" -profile "COVAS-Elite" -command "rapid complete"

timeout 3
start "" cmd /c "echo ***** RAPID COMPLETE ***** &echo(&timeout 10"

