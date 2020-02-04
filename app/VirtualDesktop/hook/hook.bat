
REM Depends:
REM 'mswadminpriv.bat' - 'nircmd elevate'


REM Terminate - VoiceAttack (Ensure correct microphone is available and used.)
CALL C:\core\infrastructure\extendedInterface\support\voiceattack\terminate_voiceattack.bat

REM *****
REM VirtualDesktop should usually be configured to work acceptably well with any configuration.
REM (ie. do not push VirtualDesktop's own supersampling to >2.52x Total SR or less depending on hardware)

REM 001-simpit
REM CALL "C:\core\infrastructure\extendedInterface\support\steamvr\SteamVR_UniManager\simpit.bat"

REM 002-_steamvrprofile_dcs_restore
REM CALL "C:\core\infrastructure\extendedInterface\app\VirtualBox\steamvrprofile\_steamvrprofile_dcs_restore.bat"

REM 002-_steamvrprofile_dcs_restore_fast
REM CALL "C:\core\infrastructure\extendedInterface\app\VirtualBox\steamvrprofile\_steamvrprofile_dcs_restore_fast.bat"

REM Terminate - SteamVR (Ensure video parameter changes take effect.)
REM CALL C:\core\infrastructure\extendedInterface\support\steamvr\terminate_steamvr.bat





REM 005-EVGA Precision X1 (if installed)
cd "C:\Program Files\EVGA\Precision X1"
tasklist /nh /fi "imagename eq PrecisionX_x64.exe" | find /i "PrecisionX_x64.exe" > nul || (start /MIN "" "C:\Program Files\EVGA\Precision X1\PrecisionX_x64.exe" 0)

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

REM 008-Steam-SteamVR-OPTIONAL
REM Terminate - SteamVR (Ensure video parameter changes take effect.)
REM CALL C:\core\infrastructure\extendedInterface\support\steamvr\terminate_steamvr.bat
REM start "" "steam://rungameid/250820"
tasklist /nh /fi "imagename eq vrmonitor.exe" | find /i "vrmonitor.exe" > nul || (start "" "steam://rungameid/250820")


timeout /NOBREAK 1

REM ATTENTION: Disable if VirtualDesktop is to be started by voice command.
REM 015-VoiceAttack - AS ADMIN - SHELL-MSW - construct screen
REM cd "C:\Program Files (x86)\VoiceAttack"
REM CALL "C:\bin\mswadminpriv.bat" cmd.exe /C start /MIN /D "C:\Program Files (x86)\VoiceAttack" "" "C:\Program Files (x86)\VoiceAttack\VoiceAttack.exe" -profile "SHELL-MSW" -command "construct screen virtualdesktop procedure"

REM 080-VirtualDesktop
tasklist /nh /fi "imagename eq Virtual Desktop.exe" | find /i "Virtual Desktop.exe" > nul || (start "" "steam://rungameid/382110")
REM start "" "steam://rungameid/382110"

REM 015-VoiceAttack - AS ADMIN - SHELL-MSW
cd "C:\Program Files (x86)\VoiceAttack"
CALL "C:\bin\mswadminpriv.bat" cmd.exe /C start /MIN /D "C:\Program Files (x86)\VoiceAttack" "" "C:\Program Files (x86)\VoiceAttack\VoiceAttack.exe" -profile "SHELL-MSW"

REM WARNING: Usually displays an unnecessary minimized window.
REM start /MIN "" "C:\Program Files\Pimax\PVRHome\PVRHome_orig.exe"

timeout 3
start "" cmd /c "echo ***** HOOK COMPLETE ***** &echo(&timeout 5"



