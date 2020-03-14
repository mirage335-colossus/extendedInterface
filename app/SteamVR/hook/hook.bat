
REM Depends:
REM 'mswadminpriv.bat' - 'nircmd elevate'

REM Requires nircmdc, relevant Batch script, and Pimax headset sound device to be renamed 'PimaxAudioUSB'.
CALL C:\bin\PimaxAudioUSB_default.bat

REM Terminate - VoiceAttack (Ensure correct microphone is available and used.)
CALL C:\core\infrastructure\extendedInterface\support\voiceattack\terminate_voiceattack.bat

REM 015-VoiceAttack - AS ADMIN
cd "C:\Program Files (x86)\VoiceAttack"
CALL "C:\bin\mswadminpriv.bat" cmd.exe /C start /MIN /D "C:\Program Files (x86)\VoiceAttack" "" "C:\Program Files (x86)\VoiceAttack\VoiceAttack.exe"

REM 005-EVGA Precision X1 (if installed)
cd "C:\Program Files\EVGA\Precision X1"
tasklist /nh /fi "imagename eq PrecisionX_x64.exe" | find /i "PrecisionX_x64.exe" > nul || (start /MIN "" "C:\Program Files\EVGA\Precision X1\PrecisionX_x64.exe" 0)

REM *****
REM VirtualDesktop should usually be configured to work acceptably well with any configuration.
REM (ie. do not push VirtualDesktop's own supersampling to >2.52x Total SR or less depending on hardware)

REM 001-simpit
REM CALL "C:\core\infrastructure\extendedInterface\support\steamvr\SteamVR_UniManager\simpit.bat"

REM 002-_steamvrprofile_dcs_restore
REM CALL "C:\core\infrastructure\extendedInterface\app\VirtualBox\steamvrprofile\_steamvrprofile_dcs_restore.bat"

REM 002-_steamvrprofile_dcs_restore_fast
REM CALL "C:\core\infrastructure\extendedInterface\app\VirtualBox\steamvrprofile\_steamvrprofile_dcs_restore_fast.bat"


cd C:\core\infrastructure\extendedInterface\support\steamvr\
CALL C:\core\infrastructure\extendedInterface\support\steamvr\hook_lock.bat _stop
CALL C:\core\infrastructure\extendedInterface\support\steamvr\hook_lock.bat _start




REM WARNING: Usually displays an unnecessary minimized window.
REM start /MIN "" "C:\Program Files\Pimax\PVRHome\PVRHome_orig.exe"

timeout 3
start "" cmd /c "echo ***** HOOK COMPLETE ***** &echo(&timeout 5"



