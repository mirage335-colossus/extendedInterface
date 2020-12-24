
;Depends:
;'mswadminpriv.bat' - 'nircmd elevate'

;Run, "C:\Program Files (x86)\VoiceAttack\VoiceAttack.exe" -profile "SHELL-MSW" -command "construct screen", C:\Program Files (x86)\VoiceAttack, Min

;Run, "C:\bin\mswadminpriv.bat" cmd.exe /C start /MIN /D "C:\Program Files (x86)\VoiceAttack" "" "C:\Program Files (x86)\VoiceAttack\VoiceAttack.exe" -profile "SHELL-MSW" -command "construct screen", C:\Program Files (x86)\VoiceAttack, Min

RUN, "C:\core\infrastructure\extendedInterface\app\PimaxExperience\hook\hook.bat"


