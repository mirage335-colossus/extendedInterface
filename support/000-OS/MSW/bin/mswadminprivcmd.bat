REM BROKEN!
exit

REM runas /user:Administrator %*

REM powershell.exe -Command "Start-Process %* \"/k cd /d %cd%\" -Verb RunAs"

nircmdc elevate %* /k "cd /d %cd%"


pause
