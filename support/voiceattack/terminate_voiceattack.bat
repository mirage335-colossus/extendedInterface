
REM Terminate - VoiceAttack (Ensure correct microphone is available and used.)
CALL "C:\bin\mswadminpriv.bat" cmd.exe /C taskkill /IM VoiceAttack.exe
timeout /NOBREAK 1
CALL "C:\bin\mswadminpriv.bat" cmd.exe /C taskkill /IM VoiceAttack.exe
CALL "C:\bin\mswadminpriv.bat" cmd.exe /C taskkill /IM VoiceAttack.exe
CALL "C:\bin\mswadminpriv.bat" cmd.exe /C taskkill /IM VoiceAttack.exe
timeout /NOBREAK 7
CALL "C:\bin\mswadminpriv.bat" cmd.exe /C taskkill /F /IM VoiceAttack.exe
timeout /NOBREAK 1



