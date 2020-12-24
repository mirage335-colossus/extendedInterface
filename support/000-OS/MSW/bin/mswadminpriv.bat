REM powershell.exe -Command "Start-Process %* \"/k cd /d %cd%\" -Verb RunAs"

REM nircmdc elevate %* /k "cd /d %cd%"

nircmdc elevate %*
