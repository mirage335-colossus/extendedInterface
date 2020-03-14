
REM Terminate - VoiceAttack (Ensure correct microphone is available and used.)
CALL "C:\bin\mswadminpriv.bat" cmd.exe /C taskkill /IM VoiceAttack.exe
tasklist /nh /fi "imagename eq VoiceAttack.exe" | find /i "VoiceAttack.exe" > nul || GOTO done
timeout /NOBREAK 1
CALL "C:\bin\mswadminpriv.bat" cmd.exe /C taskkill /IM VoiceAttack.exe
CALL "C:\bin\mswadminpriv.bat" cmd.exe /C taskkill /IM VoiceAttack.exe
CALL "C:\bin\mswadminpriv.bat" cmd.exe /C taskkill /IM VoiceAttack.exe
tasklist /nh /fi "imagename eq VoiceAttack.exe" | find /i "VoiceAttack.exe" > nul || GOTO done
timeout /NOBREAK 7

CALL "C:\bin\mswadminpriv.bat" cmd.exe /C taskkill /F /IM VoiceAttack.exe
timeout /NOBREAK 1


:done
timeout /NOBREAK 1


