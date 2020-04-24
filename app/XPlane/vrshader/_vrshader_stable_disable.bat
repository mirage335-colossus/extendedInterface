@echo off

@REM WARNING: Best practice is to edit '_vrshader_refresh_anchors.bat' and run the file to update all copies.
IF /I "%~n0" EQU "_vrshader_refresh_anchors" GOTO _vrshader_refresh_anchors

@REM WARNING: Layout specifically intended to minimize use of MS Batch features which could change.
@REM WARNING: Batch was specifically chosen due to MS apparent commitment to entrentched interests.

@REM -----CONFIGURATION-----
@REM DANGER: Do NOT misconfigure!

SET vrshaderTask=EXCEPTION

IF /I "%~n0" EQU "_vrshader_stable_delete" SET vrshaderTask=_vrshader_delete
IF /I "%~n0" EQU "_vrshader_openbeta_delete" SET vrshaderTask=_vrshader_delete

IF /I "%~n0" EQU "_vrshader_stable_disable" SET vrshaderTask=_vrshader_disable
IF /I "%~n0" EQU "_vrshader_openbeta_disable" SET vrshaderTask=_vrshader_disable


IF /I "%~n0" EQU "_vrshader_stable_backup_shadermod" SET vrshaderTask=_vrshader_backup_shadermod
IF /I "%~n0" EQU "_vrshader_openbeta_backup_shadermod" SET vrshaderTask=_vrshader_backup_shadermod

IF /I "%~n0" EQU "_vrshader_stable_restore_shadermod" SET vrshaderTask=_vrshader_restore_shadermod
IF /I "%~n0" EQU "_vrshader_openbeta_restore_shadermod" SET vrshaderTask=_vrshader_restore_shadermod

IF /I "%~n0" EQU "_vrshader_stable_backup_shaderic" SET vrshaderTask=_vrshader_backup_shaderic
IF /I "%~n0" EQU "_vrshader_openbeta_backup_shaderic" SET vrshaderTask=_vrshader_backup_shaderic

IF /I "%~n0" EQU "_vrshader_stable_restore_shaderic" SET vrshaderTask=_vrshader_restore_shaderic
IF /I "%~n0" EQU "_vrshader_openbeta_restore_shaderic" SET vrshaderTask=_vrshader_restore_shaderic


@REM --Uncomment one to force task.

@REM SET vrshaderTask=_vrshader_delete

@REM SET vrshaderTask=_vrshader_disable

@REM SET vrshaderTask=_vrshader_backup_shadermod
@REM SET vrshaderTask=_vrshader_restore_shadermod

@REM SET vrshaderTask=_vrshader_backup_shaderic
@REM SET vrshaderTask=_vrshader_restore_shaderic

IF /I "%vrshaderTask%" EQU "EXCEPTION" GOTO EXCEPTION



SET vrshaderAppVersion=EXCEPTION

IF /I "%~n0" EQU "_vrshader_stable_delete" SET vrshaderAppVersion=stable
IF /I "%~n0" EQU "_vrshader_stable_disable" SET vrshaderAppVersion=stable
IF /I "%~n0" EQU "_vrshader_stable_backup_shadermod" SET vrshaderAppVersion=stable
IF /I "%~n0" EQU "_vrshader_stable_restore_shadermod" SET vrshaderAppVersion=stable
IF /I "%~n0" EQU "_vrshader_stable_backup_shaderic" SET vrshaderAppVersion=stable
IF /I "%~n0" EQU "_vrshader_stable_restore_shaderic" SET vrshaderAppVersion=stable

IF /I "%~n0" EQU "_vrshader_openbeta_delete" SET vrshaderAppVersion=openbeta
IF /I "%~n0" EQU "_vrshader_openbeta_disable" SET vrshaderAppVersion=openbeta
IF /I "%~n0" EQU "_vrshader_openbeta_backup_shadermod" SET vrshaderAppVersion=openbeta
IF /I "%~n0" EQU "_vrshader_openbeta_restore_shadermod" SET vrshaderAppVersion=openbeta
IF /I "%~n0" EQU "_vrshader_openbeta_backup_shaderic" SET vrshaderAppVersion=openbeta
IF /I "%~n0" EQU "_vrshader_openbeta_restore_shaderic" SET vrshaderAppVersion=openbeta


@REM --Uncomment one to force app version.

@REM SET vrshaderAppVersion=stable
@REM SET vrshaderAppVersion=openbeta

IF /I "%vrshaderAppVersion%" EQU "EXCEPTION" GOTO EXCEPTION



@REM --Edit if needed.

SET vrshaderProfileDir=EXCEPTION
SET vrshaderProgramDir=EXCEPTION

IF /I "%vrshaderAppVersion%" EQU "stable" SET vrshaderProfileDir=%USERPROFILE%\Saved Games\DCS
IF /I "%vrshaderAppVersion%" EQU "stable" SET vrshaderProgramDir=C:\Program Files\Eagle Dynamics\DCS World

IF /I "%vrshaderAppVersion%" EQU "openbeta" SET vrshaderProfileDir=%USERPROFILE%\Saved Games\DCS.openbeta
IF /I "%vrshaderAppVersion%" EQU "openbeta" SET vrshaderProgramDir=C:\Program Files\Eagle Dynamics\DCS World OpenBeta

IF /I "%vrshaderProfileDir%" EQU "EXCEPTION" GOTO EXCEPTION
IF /I "%vrshaderProgramDir%" EQU "EXCEPTION" GOTO EXCEPTION

@REM -----CONFIGURATION-----




@REM -----PROMPT-----
echo **********************************************************************

IF /I "%vrshaderTask%" EQU "_vrshader_delete" echo *****DELETE*****
IF /I "%vrshaderTask%" EQU "_vrshader_disable" echo *****DISABLE*****
IF /I "%vrshaderTask%" EQU "_vrshader_backup_shadermod" echo *****BACKUP SHADERMOD*****
IF /I "%vrshaderTask%" EQU "_vrshader_restore_shadermod" echo *****RESTORE SHADERMOD*****
IF /I "%vrshaderTask%" EQU "_vrshader_backup_shaderic" echo *****BACKUP IC*****
IF /I "%vrshaderTask%" EQU "_vrshader_restore_shaderic" echo *****RESTORE IC*****

echo VR Shader Mod

IF /I "%vrshaderAppVersion%" EQU "stable" echo DCS World
IF /I "%vrshaderAppVersion%" EQU "openbeta" echo DCS World Open Beta

echo "%vrshaderProfileDir%"
echo "%vrshaderProgramDir%"
echo IF INCORRECT STOP AND EDIT THIS FILE

echo **********************************************************************

set /p AREYOUSURE=Are you sure? [y/N]: 
IF /I "%AREYOUSURE%" NEQ "Y" GOTO END

IF /I "%vrshaderTask%" EQU "_vrshader_delete" GOTO _vrshader_delete
IF /I "%vrshaderTask%" EQU "_vrshader_disable" GOTO _vrshader_disable
IF /I "%vrshaderTask%" EQU "_vrshader_backup_shadermod" GOTO _vrshader_backup_shadermod
IF /I "%vrshaderTask%" EQU "_vrshader_restore_shadermod" GOTO _vrshader_restore_shadermod
IF /I "%vrshaderTask%" EQU "_vrshader_backup_shaderic" GOTO _vrshader_backup_shaderic
IF /I "%vrshaderTask%" EQU "_vrshader_restore_shaderic" GOTO _vrshader_restore_shaderic

echo XXXXX EXCEPTION: No function! XXXXX
exit /b
exit'
@REM -----PROMPT-----


@REM () { **********************************************************************
:_vrshader_refresh_anchors
@echo ***** _vrshader_refresh_anchors
@echo on

copy /Y "%~n0".bat _vrshader_stable_delete.bat
copy /Y "%~n0".bat _vrshader_openbeta_delete.bat
copy /Y "%~n0".bat _vrshader_stable_disable.bat
copy /Y "%~n0".bat _vrshader_openbeta_disable.bat
copy /Y "%~n0".bat _vrshader_stable_backup_shadermod.bat
copy /Y "%~n0".bat _vrshader_openbeta_backup_shadermod.bat
copy /Y "%~n0".bat _vrshader_stable_restore_shadermod.bat
copy /Y "%~n0".bat _vrshader_openbeta_restore_shadermod.bat
copy /Y "%~n0".bat _vrshader_stable_backup_shaderic.bat
copy /Y "%~n0".bat _vrshader_openbeta_backup_shaderic.bat
copy /Y "%~n0".bat _vrshader_stable_restore_shaderic.bat
copy /Y "%~n0".bat _vrshader_openbeta_restore_shaderic.bat

@echo off
GOTO COMPLETE
exit /b
exit
@REM } **********************************************************************






@REM () { **********************************************************************
:_vrshader_delete
@echo *****
@echo on

@echo.
del /q "%vrshaderProfileDir%"\fxo
@echo.
del /q "%vrshaderProfileDir%"\fxo.shadermod
@echo.
del /q "%vrshaderProfileDir%"\fxo.ic
@echo.

@echo.
del /q "%vrshaderProfileDir%"\metashaders2
@echo.
del /q "%vrshaderProfileDir%"\metashaders2.shadermod
@echo.
del /q "%vrshaderProfileDir%"\metashaders2.ic
@echo.


@echo.
del /q "%vrshaderProgramDir%"\Mods\terrains\Caucasus\misc\metacache\dcs
@echo.
del /q "%vrshaderProgramDir%"\Mods\terrains\Caucasus\misc\metacache\dcs.shadermod
@echo.
del /q "%vrshaderProgramDir%"\Mods\terrains\Caucasus\misc\metacache\dcs.ic
@echo.

@echo.
del /q "%vrshaderProgramDir%"\Mods\terrains\Nevada\misc\metacache\dcs
@echo.
del /q "%vrshaderProgramDir%"\Mods\terrains\Nevada\misc\metacache\dcs.shadermod
@echo.
del /q "%vrshaderProgramDir%"\Mods\terrains\Nevada\misc\metacache\dcs.ic
@echo.

@echo.
del /q "%vrshaderProgramDir%"\Mods\terrains\Normandy\misc\metacache\dcs
@echo.
del /q "%vrshaderProgramDir%"\Mods\terrains\Normandy\misc\metacache\dcs.shadermod
@echo.
del /q "%vrshaderProgramDir%"\Mods\terrains\Normandy\misc\metacache\dcs.ic
@echo.

@echo.
del /q "%vrshaderProgramDir%"\Mods\terrains\PersianGulf\misc\metacache\dcs
@echo.
del /q "%vrshaderProgramDir%"\Mods\terrains\PersianGulf\misc\metacache\dcs.shadermod
@echo.
del /q "%vrshaderProgramDir%"\Mods\terrains\PersianGulf\misc\metacache\dcs.ic
@echo.

@echo off
GOTO COMPLETE_REBUILD
exit /b
exit
@REM } **********************************************************************


@REM () { **********************************************************************
:_vrshader_disable
@echo *****
@echo on

@echo.
del /q "%vrshaderProfileDir%"\fxo
@echo.

@echo.
del /q "%vrshaderProfileDir%"\metashaders2
@echo.

@echo.
del /q "%vrshaderProgramDir%"\Mods\terrains\Caucasus\misc\metacache\dcs
@echo.

@echo.
del /q "%vrshaderProgramDir%"\Mods\terrains\Nevada\misc\metacache\dcs
@echo.

@echo.
del /q "%vrshaderProgramDir%"\Mods\terrains\Normandy\misc\metacache\dcs
@echo.

@echo.
del /q "%vrshaderProgramDir%"\Mods\terrains\PersianGulf\misc\metacache\dcs
@echo.

@echo off
GOTO COMPLETE_REBUILD
exit /b
exit
@REM } **********************************************************************


@REM () { **********************************************************************
:_vrshader_backup_shadermod
@echo *****
@echo on

@echo.
del /q "%vrshaderProfileDir%"\fxo.shadermod
xcopy /Y /E /C /I "%vrshaderProfileDir%"\fxo "%vrshaderProfileDir%"\fxo.shadermod
@echo.
del /q "%vrshaderProfileDir%"\metashaders2.shadermod
xcopy /Y /E /C /I "%vrshaderProfileDir%"\metashaders2 "%vrshaderProfileDir%"\metashaders2.shadermod
@echo.

@echo.
del /q "%vrshaderProgramDir%"\Mods\terrains\Caucasus\misc\metacache\dcs.shadermod
xcopy /Y /E /C /I "%vrshaderProgramDir%"\Mods\terrains\Caucasus\misc\metacache\dcs "%vrshaderProgramDir%"\Mods\terrains\Caucasus\misc\metacache\dcs.shadermod
@echo.
del /q "%vrshaderProgramDir%"\Mods\terrains\Nevada\misc\metacache\dcs.shadermod
xcopy /Y /E /C /I "%vrshaderProgramDir%"\Mods\terrains\Nevada\misc\metacache\dcs "%vrshaderProgramDir%"\Mods\terrains\Nevada\misc\metacache\dcs.shadermod
@echo.
del /q "%vrshaderProgramDir%"\Mods\terrains\Normandy\misc\metacache\dcs.shadermod
xcopy /Y /E /C /I "%vrshaderProgramDir%"\Mods\terrains\Normandy\misc\metacache\dcs "%vrshaderProgramDir%"\Mods\terrains\Normandy\misc\metacache\dcs.shadermod
@echo.
del /q "%vrshaderProgramDir%"\Mods\terrains\PersianGulf\misc\metacache\dcs.shadermod
xcopy /Y /E /C /I "%vrshaderProgramDir%"\Mods\terrains\PersianGulf\misc\metacache\dcs "%vrshaderProgramDir%"\Mods\terrains\PersianGulf\misc\metacache\dcs.shadermod
@echo.
@echo.

@echo off
GOTO COMPLETE_REBUILD
exit /b
exit
@REM } **********************************************************************

@REM () { **********************************************************************
:_vrshader_restore_shadermod
@echo *****
@echo on

@echo.
del /q "%vrshaderProfileDir%"\fxo
xcopy /Y /E /C /I "%vrshaderProfileDir%"\fxo.shadermod "%vrshaderProfileDir%"\fxo
@echo.
del /q "%vrshaderProfileDir%"\metashaders2
xcopy /Y /E /C /I "%vrshaderProfileDir%"\metashaders2.shadermod "%vrshaderProfileDir%"\metashaders2
@echo.

@echo.
del /q "%vrshaderProgramDir%"\Mods\terrains\Caucasus\misc\metacache\dcs
xcopy /Y /E /C /I "%vrshaderProgramDir%"\Mods\terrains\Caucasus\misc\metacache\dcs.shadermod "%vrshaderProgramDir%"\Mods\terrains\Caucasus\misc\metacache\dcs
@echo.
del /q "%vrshaderProgramDir%"\Mods\terrains\Nevada\misc\metacache\dcs
xcopy /Y /E /C /I "%vrshaderProgramDir%"\Mods\terrains\Nevada\misc\metacache\dcs.shadermod "%vrshaderProgramDir%"\Mods\terrains\Nevada\misc\metacache\dcs
@echo.
del /q "%vrshaderProgramDir%"\Mods\terrains\Normandy\misc\metacache\dcs
xcopy /Y /E /C /I "%vrshaderProgramDir%"\Mods\terrains\Normandy\misc\metacache\dcs.shadermod "%vrshaderProgramDir%"\Mods\terrains\Normandy\misc\metacache\dcs
@echo.
del /q "%vrshaderProgramDir%"\Mods\terrains\PersianGulf\misc\metacache\dcs
xcopy /Y /E /C /I "%vrshaderProgramDir%"\Mods\terrains\PersianGulf\misc\metacache\dcs.shadermod "%vrshaderProgramDir%"\Mods\terrains\PersianGulf\misc\metacache\dcs
@echo.
@echo.

@echo off
GOTO COMPLETE_REBUILD
exit /b
exit
@REM } **********************************************************************



@REM () { **********************************************************************
:_vrshader_backup_shaderic
@echo *****
@echo on

@echo.
del /q "%vrshaderProfileDir%"\fxo.ic
xcopy /Y /E /C /I "%vrshaderProfileDir%"\fxo "%vrshaderProfileDir%"\fxo.ic
@echo.
del /q "%vrshaderProfileDir%"\metashaders2.ic
xcopy /Y /E /C /I "%vrshaderProfileDir%"\metashaders2 "%vrshaderProfileDir%"\metashaders2.ic
@echo.

@echo.
del /q "%vrshaderProgramDir%"\Mods\terrains\Caucasus\misc\metacache\dcs.ic
xcopy /Y /E /C /I "%vrshaderProgramDir%"\Mods\terrains\Caucasus\misc\metacache\dcs "%vrshaderProgramDir%"\Mods\terrains\Caucasus\misc\metacache\dcs.ic
@echo.
del /q "%vrshaderProgramDir%"\Mods\terrains\Nevada\misc\metacache\dcs.ic
xcopy /Y /E /C /I "%vrshaderProgramDir%"\Mods\terrains\Nevada\misc\metacache\dcs "%vrshaderProgramDir%"\Mods\terrains\Nevada\misc\metacache\dcs.ic
@echo.
del /q "%vrshaderProgramDir%"\Mods\terrains\Normandy\misc\metacache\dcs.ic
xcopy /Y /E /C /I "%vrshaderProgramDir%"\Mods\terrains\Normandy\misc\metacache\dcs "%vrshaderProgramDir%"\Mods\terrains\Normandy\misc\metacache\dcs.ic
@echo.
del /q "%vrshaderProgramDir%"\Mods\terrains\PersianGulf\misc\metacache\dcs.ic
xcopy /Y /E /C /I "%vrshaderProgramDir%"\Mods\terrains\PersianGulf\misc\metacache\dcs "%vrshaderProgramDir%"\Mods\terrains\PersianGulf\misc\metacache\dcs.ic
@echo.
@echo.

@echo off
GOTO COMPLETE_REBUILD
exit /b
exit
@REM } **********************************************************************

@REM () { **********************************************************************
:_vrshader_restore_shaderic
@echo *****
@echo on

@echo.
del /q "%vrshaderProfileDir%"\fxo
xcopy /Y /E /C /I "%vrshaderProfileDir%"\fxo.ic "%vrshaderProfileDir%"\fxo
@echo.
del /q "%vrshaderProfileDir%"\metashaders2
xcopy /Y /E /C /I "%vrshaderProfileDir%"\metashaders2.ic "%vrshaderProfileDir%"\metashaders2
@echo.

@echo.
del /q "%vrshaderProgramDir%"\Mods\terrains\Caucasus\misc\metacache\dcs
xcopy /Y /E /C /I "%vrshaderProgramDir%"\Mods\terrains\Caucasus\misc\metacache\dcs.ic "%vrshaderProgramDir%"\Mods\terrains\Caucasus\misc\metacache\dcs
@echo.
del /q "%vrshaderProgramDir%"\Mods\terrains\Nevada\misc\metacache\dcs
xcopy /Y /E /C /I "%vrshaderProgramDir%"\Mods\terrains\Nevada\misc\metacache\dcs.ic "%vrshaderProgramDir%"\Mods\terrains\Nevada\misc\metacache\dcs
@echo.
del /q "%vrshaderProgramDir%"\Mods\terrains\Normandy\misc\metacache\dcs
xcopy /Y /E /C /I "%vrshaderProgramDir%"\Mods\terrains\Normandy\misc\metacache\dcs.ic "%vrshaderProgramDir%"\Mods\terrains\Normandy\misc\metacache\dcs
@echo.
del /q "%vrshaderProgramDir%"\Mods\terrains\PersianGulf\misc\metacache\dcs
xcopy /Y /E /C /I "%vrshaderProgramDir%"\Mods\terrains\PersianGulf\misc\metacache\dcs.ic "%vrshaderProgramDir%"\Mods\terrains\PersianGulf\misc\metacache\dcs
@echo.
@echo.

@echo off
GOTO COMPLETE_REBUILD
exit /b
exit
@REM } **********************************************************************






:COMPLETE_REBUILD
echo.
echo **********************************************************************
echo COMPLETE. 
echo Restart DCS with each terrain to rebuild if necessary.
echo Typical rebuild time, 10min/terrain.
echo **********************************************************************
pause

exit /b
exit

:COMPLETE
echo.
echo **********************************************************************
echo COMPLETE. 
echo **********************************************************************
pause

exit /b
exit

:EXCEPTION
echo XXXXX EXCEPTION XXXXX
exit /b
exit

:END
echo **
echo no action taken
pause

exit /b
exit
