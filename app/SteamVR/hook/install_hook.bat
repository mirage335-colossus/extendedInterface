
taskkill /IM PVRHome.exe
timeout /NOBREAK 1
taskkill /F /IM PVRHome.exe

IF NOT EXIST "C:\Program Files\Pimax\PVRHome\PVRHome_orig_Data" CALL "C:\bin\mswadminpriv.bat" cmd.exe /C xcopy /Y /E /C /I "C:\Program Files\Pimax\PVRHome\PVRHome_Data" "C:\Program Files\Pimax\PVRHome\PVRHome_orig_Data"

IF NOT EXIST "C:\Program Files\Pimax\PVRHome\PVRHome_orig.exe" CALL "C:\bin\mswadminpriv.bat" cmd.exe /C COPY /Y "C:\Program Files\Pimax\PVRHome\PVRHome.exe" "C:\Program Files\Pimax\PVRHome\PVRHome_orig.exe"

@echo on
@echo **
CALL "C:\bin\mswadminpriv.bat" cmd.exe /C copy /Y "C:\core\infrastructure\extendedInterface\app\SteamVR\hook\hook.exe" "C:\Program Files\Pimax\PVRHome\PVRHome.exe"
@echo off
timeout 3




