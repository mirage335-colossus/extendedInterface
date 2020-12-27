

REM https://serverfault.com/questions/22443/do-windows-batch-files-have-a-construction/22541#22541
set args=%1
shift
:do
if [%1] == [] goto done
set args=%args% %1
shift
goto do
:done


REM Depends:
REM 'mswadminpriv.bat' - 'nircmd elevate'

REM If previously stopped (presumably by VoiceAttack or similar macro), ensure 'LeapService' has started before PimaxExperience.
CALL "C:\bin\mswadminpriv.bat" cmd.exe /C start /MIN /D "C:\WINDOWS\system32" "" "C:\WINDOWS\system32\sc.exe" start LeapService



REM Requires nircmdc, relevant Batch script, and Pimax headset sound device to be renamed 'PimaxAudioUSB'.
CALL C:\bin\PimaxAudioUSB_default.bat

REM Terminate - VoiceAttack (Ensure correct microphone is available and used.)
CALL C:\core\infrastructure\extendedInterface\support\voiceattack\terminate_voiceattack.bat

REM 015-VoiceAttack - AS ADMIN
REM cd "C:\Program Files (x86)\VoiceAttack"
REM CALL "C:\bin\mswadminpriv.bat" cmd.exe /C start /MIN /D "C:\Program Files (x86)\VoiceAttack" "" "C:\Program Files (x86)\VoiceAttack\VoiceAttack.exe"
start "" cmd /c C:\core\infrastructure\extendedInterface\support\voiceattack\terminate_voiceattack.bat _restart

REM 005-EVGA Precision X1 (if installed)
cd "C:\Program Files\EVGA\Precision X1"
tasklist /nh /fi "imagename eq PrecisionX_x64.exe" | find /i "PrecisionX_x64.exe" > nul || (start /MIN "" "C:\Program Files\EVGA\Precision X1\PrecisionX_x64.exe" 0)








REM WARNING: May display an unnecessary minimized window.
start /MIN "" "C:\Program Files\Pimax\PVRHome\PVRHome_orig.exe" %args%
REM "C:\Program Files\Pimax\PVRHome\PVRHome_orig.exe" %args%

timeout 3
start "" cmd /c "echo ***** HOOK COMPLETE ***** &echo(&timeout 5"



