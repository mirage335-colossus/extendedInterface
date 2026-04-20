;===== Top matter - NSIS installer script for extendedInterface =====
; ATTRIBUTION - May be largely attributable to ChatGPT-4/copilot used by mirage335 .
; ATTRIBUTION - https://nsis.sourceforge.io/Sample_installation_script_for_an_application
; ATTRIBUTION - https://nsis.sourceforge.io/A_simple_installer_with_start_menu_shortcut_and_uninstaller
; ATTRIBUTION - https://nsis.sourceforge.io/Embedding_other_installers
; ATTRIBUTION - https://stackoverflow.com/questions/3265141/executing-batch-file-in-nsis-installer

;===== Enable a disk log with timestamp =====
!include "FileFunc.nsh"
!insertmacro GetTime

!macro CoreLog TEXT
  CreateDirectory "C:\core\logs"

  ; ${GetTime} "" "L" day month year dow hour min sec
  ${GetTime} "" "L" $0 $1 $2 $3 $4 $5 $6

  ; zero-pad with correct mapping
  IntFmt $0 "%02i" $0 ; day
  IntFmt $1 "%02i" $1 ; month
  IntFmt $2 "%04i" $2 ; year
  IntFmt $4 "%02i" $4 ; hour
  IntFmt $5 "%02i" $5 ; minute
  IntFmt $6 "%02i" $6 ; second

  ; pick your preferred format:
  ; ISO style:
  StrCpy $R0 "$2-$1-$0 $4:$5:$6"
  ; or European dd-mm-yyyy:
  ; StrCpy $R0 "$0-$1-$2 $4:$5:$6"

  ClearErrors
  FileOpen $9 "C:\core\logs\extIface_installer.log" a
  IfErrors +3
    FileSeek $9 0 END
    FileWrite $9 "$R0 | ${TEXT}$\r$\n"
    FileClose $9
!macroend

; Ask for elevated privileges to write c:\core 
RequestExecutionLevel admin
; Reqire a /S to enable silent install 
SilentInstall normal
; Show this license agreement before installing
LicenseData "..\..\license-installer.txt"

; Demographic inputs 
Name "extendedInterface"
Icon ".\icon\icon.ico"
OutFile "..\..\..\extIface.exe"
;https://github.com/mirage335/extendedInterface/
!define APPNAME "extendedInterface"
!define COMPANYNAME "extendedInterface"
!define DESCRIPTION "extendedInterface"
!define HELPURL "https://github.com/mirage335/extendedInterface/"
!define UPDATEURL "https://github.com/mirage335/extendedInterface/"
!define ABOUTURL "https://github.com/mirage335/extendedInterface/"
!define INSTALLSIZE 2900000
;!define INSTALLSIZE 6500000

;/SOLID
SetCompressor /FINAL lzma

; Show license page, no directory page, and installation files page 
Page license
;Page directory
Page instfiles

;===== Install Section ===== 
Section "Install"
  !insertmacro CoreLog "== Starting extendedInterface installer "

  ; Set all-users scope for installed files and registry entries
  SetShellVarContext all

  ; Old code & comments 
  ;https://stackoverflow.com/questions/2565215/checking-if-the-application-is-running-in-nsis-before-uninstalling
  ;ExecWait "TaskKill /IM bash.exe /F"

  ;https://stackoverflow.com/questions/2565215/checking-if-the-application-is-running-in-nsis-before-uninstalling
  ;cmd /c for /f "tokens=1,2" %i in ('tasklist') do (if /i %i EQU bash.exe fsutil file createnew .\bashExe.bz 0) & del .\bashExe.bz

  ; Ensure no cygwin bash.exe processes are running 
  Delete "$TEMP\extIface_bashExe.bzy"
  !macro IsRunningInstall
  Delete "$TEMP\extIface_bashExe.bzy"
  ExecWait "cmd /c for /f $\"tokens=1,2$\" %i in ('tasklist') do (if /i %i EQU bash.exe fsutil file createnew $TEMP\extIface_bashExe.bzy 0)"
  IfFileExists $TEMP\extIface_bashExe.bzy 0 notRunningInstall
    ;we have atleast one main window active
    !insertmacro CoreLog "Detected running bash.exe process. Please close bash.exe and retry."
    MessageBox MB_OK|MB_ICONEXCLAMATION "Please close  bash.exe  and retry." /SD IDOK
    Abort
  notRunningInstall:
  !macroEnd
  ; Run the macro we just defined to check for running bash.exe 
  !insertmacro IsRunningInstall
  !insertmacro CoreLog ".. All bash processes closed."

  ; Rename former extendedInterface and cygwin home backups to unique name 
  ; Generate a random alphanumeric string
  System::Call 'KERNEL32::GetTickCount()i.r0'
  System::Call 'ADVAPI32::CryptAcquireContext(i0,t""i0,i0,i0,i0)i.r1'
  System::Call 'ADVAPI32::CryptGenRandom(ir1,i10,i0)i'
  System::Call 'ADVAPI32::CryptReleaseContext(ir1,i0)i'
  IntCmp $0 0 0 +3
  IntOp $0 $0 * -1
  ; Rename the folder pair 
  ;GUARD - Ensures non-random path '*-prev' is not occupied - presently.
  Rename "C:\core\infrastructure\extendedInterface-home-backup-prev" "C:\core\infrastructure\extendedInterface-home-backup-prev-$0"
  Rename "C:\core\infrastructure\ubcp-home-backup-prev" "C:\core\infrastructure\ubcp-home-backup-prev-$0"
  DetailPrint "$0"
  Sleep 2500

  ; Rename former _local copies of extendedInterface and cygwin homes backup to unique names 
  ; Generate a random alphanumeric string
  System::Call 'KERNEL32::GetTickCount()i.r0'
  System::Call 'ADVAPI32::CryptAcquireContext(i0,t""i0,i0,i0,i0)i.r1'
  System::Call 'ADVAPI32::CryptGenRandom(ir1,i10,i0)i'
  System::Call 'ADVAPI32::CryptReleaseContext(ir1,i0)i'
  IntCmp $0 0 0 +3
  IntOp $0 $0 * -1
  ; Rename the folder pair 
  ;ATTENTION
  Rename "C:\core\infrastructure\extendedInterface\_local\ubcp\cygwin\home" "C:\core\infrastructure\extendedInterface-home-backup-$0"
  Rename "C:\core\infrastructure\ubcp\cygwin\home" "C:\core\infrastructure\ubcp-home-backup-$0"
  DetailPrint "$0"
  Sleep 2500
  !insertmacro CoreLog ".. Renamed old home backups."

  ; Remove old installed files
  RMDir /r "C:\core\infrastructure\extendedInterface"
  ;RMDir /r /REBOOTOK "C:\core\infrastructure\extendedInterface"
  RMDir /r "C:\core\infrastructure\ubcp"
  ;RMDir /r /REBOOTOK "C:\core\infrastructure\ubcp"
  RMDir /r "C:\core\infrastructure\ubiquitous_bash"
  ;RMDir /r /REBOOTOK "C:\core\infrastructure\ubiquitous_bash"
  RMDir /r "C:\core\infrastructure\_bash.bat"
  ;RMDir /r /REBOOTOK "C:\core\infrastructure\_bash.bat"
  !insertmacro CoreLog ".. Removed old installed files."

  ; Copy new installed files 
  SetOutPath "C:\core\infrastructure\extendedInterface"
  File /r "..\..\..\extendedInterface-accessories\parts\extendedInterface\*"
  !insertmacro CoreLog ".. Copied extendedInterface files to C:\core\infrastructure\extendedInterface."

  SetOutPath "C:\core\infrastructure\extendedInterface\_local\ubcp"
  File /r "..\..\..\extendedInterface-accessories\parts\ubcp\package_ubcp-core\ubcp\*"
  !insertmacro CoreLog ".. Copied ubcp files to C:\core\infrastructure\extendedInterface\_local\ubcp."
  
  CopyFiles "C:\core\infrastructure\extendedInterface\_local\ubcp\*" "C:\core\infrastructure\ubcp\"
  !insertmacro CoreLog ".. Copied _local\ubcp files to C:\core\infrastructure\ubcp."

  SetOutPath "C:\core\infrastructure\ubiquitous_bash"
  File /r "..\..\..\extendedInterface-accessories\parts\ubcp\package_ubcp-core\ubiquitous_bash\*"
  !insertmacro CoreLog ".. Copied ubiquitous_bash from ubcp\package_ubcp-core to C:\core\infrastructure\ubiquitous_bash."
  
  SetOutPath "C:\core\infrastructure\"
  File "..\..\..\extendedInterface-accessories\parts\ubcp\package_ubcp-core\_bash.bat"
  !insertmacro CoreLog ".. Copied _bash.bat from ubcp\package_ubcp-core to C:\core\infrastructure\_bash.bat."
 
  ; Old code & comments 
  ;;ATTENTION
  ;IfFileExists "C:\core\infrastructure\ubcp-home-backup-$0" 0 +3
  ;Delete "C:\core\infrastructure\extendedInterface\_local\ubcp\cygwin\home"
  ;CopyFiles "C:\core\infrastructure\extendedInterface-home-backup-$0\*" "C:\core\infrastructure\extendedInterface\_local\ubcp\cygwin\home\"

  ;;ATTENTION
  ;IfFileExists "C:\core\infrastructure\ubcp-home-backup-$0" 0 +3
  ;Delete "C:\core\infrastructure\ubcp\cygwin\home"
  ;CopyFiles "C:\core\infrastructure\ubcp-home-backup-$0\*" "C:\core\infrastructure\ubcp\cygwin\home\"

  ;;ATTENTION
  ;IfFileExists "C:\core\infrastructure\ubcp-home-backup-uninstalled" 0 +3
  ;Delete "C:\core\infrastructure\extendedInterface\_local\ubcp\cygwin\home"
  ;CopyFiles "C:\core\infrastructure\extendedInterface-home-backup-uninstalled\*" "C:\core\infrastructure\extendedInterface\_local\ubcp\cygwin\home\"

  ;;ATTENTION
  ;IfFileExists "C:\core\infrastructure\ubcp-home-backup-uninstalled" 0 +3
  ;Delete "C:\core\infrastructure\ubcp\cygwin\home"
  ;CopyFiles "C:\core\infrastructure\ubcp-home-backup-uninstalled\*" "C:\core\infrastructure\ubcp\cygwin\home\"

  ; Backup and deploy adjacent installed repositories; iconArt, issues, 
  Rename "C:\core\infrastructure\iconArt" "C:\core\infrastructure\iconArt-backup-$0"
  SetOutPath "C:\core\infrastructure\iconArt"
  File /r "..\..\..\extendedInterface-accessories\parts\iconArt\*"

  Rename "C:\core\info\issues" "C:\core\info\issues-backup-$0"
  SetOutPath "C:\core\info\issues"
  File /r "..\..\..\extendedInterface-accessories\parts\issues\*"
  !insertmacro CoreLog ".. Deployed adjacent installed repositories; iconArt, issues."

  ; ===== Registry tweaks =====
  ; Reisuse All Users scope just in case 
  SetShellVarContext all
  ;;TODO - May be better for portability to migrate these steps to '_setupInstall' . Unless, MSW admin privileges, MSW startup dir, file copying, etc, are not as reliable from that context.

  ExecWait "regedit.exe /s C:\core\infrastructure\extendedInterface\support\explorer\_thirdparty\Disable_Windows_Key_Hotkeys.reg"
  ExecWait "regedit.exe /s C:\core\infrastructure\extendedInterface\support\000-OS\MSW\AutoEndTasks\Turn_On_AutoEndTasks_for_all_users.reg"
  ExecWait "regedit.exe /s C:\core\infrastructure\extendedInterface\support\000-OS\MSW\disableShake\Disable Aero Shake.reg"
  ExecWait "regedit.exe /s C:\core\infrastructure\extendedInterface\support\000-OS\MSW\GameDVR_disable\GameDVR_disable.reg"
  
  ExecWait "regedit.exe /s C:\core\infrastructure\extendedInterface\support\000-OS\MSW\Disable_Show_more_options_context_menu\Disable_Show_more_options_context_menu.reg"
  
  ;https://www.youtube.com/watch?v=5wBxYQdN96s&t=321s
  ; 'Extra Monitors DO Hurt Your Gaming Performance'
  ;  'If the contents of that window need to be changing, all that optimization goes out the window.'
  ;ExecWait "regedit.exe /s C:\core\infrastructure\extendedInterface\support\000-OS\MSW\ShowSecondsInSystemClock\Show Seconds In System Clock.reg"

  ; May be needed for DLSS , which may now be more relevant for simulators.
  ;ExecWait "regedit.exe /s C:\core\infrastructure\extendedInterface\support\000-OS\MSW\disableHardwareAssistedGPUScheduling\Hardware Accelerated GPU Scheduling - Disable.reg"
  
  ExecWait "regedit.exe /s C:\core\infrastructure\extendedInterface\support\000-OS\MSW\zSettings\updates-getLatest\Turn_ON_Get_latest_updates_as_soon_as_they_are_available.reg"
  
  ExecWait "regedit.exe /s C:\core\infrastructure\extendedInterface\support\000-OS\MSW\HardwareEnforcedStackProtection\Enable_Kernel_Mode_Hardware_Enforced_Stack_Protection.reg"
  
  ;Configuring this by default seems possibly unhelpful.
  ;RegEdit seems ineffective for this.
  ;ExecWait "regedit.exe /s C:\core\infrastructure\extendedInterface\support\000-OS\MSW\LocalSecurityAuthorityProtection\Turn_ON_Local_Security_Authority_protection_with_UEFI_Lock.reg"
    
  ;RegEdit seems ineffective for this.
  ExecWait "regedit.exe /s C:\core\infrastructure\extendedInterface\support\000-OS\MSW\disableNewsAndInterests\Disable-AllowNewsAndInterests.reg"

  ExecWait "regedit.exe /s C:\core\infrastructure\extendedInterface\support\000-OS\MSW\disableExplorerAutoComplete\disableExplorerAutoComplete.reg"
  !insertmacro CoreLog ".. Applied registry tweaks."

  ; Populate startup folder with support apps
  ; ATTENTION: Startups may be copied again.
  CopyFiles "C:\core\infrastructure\extendedInterface\support\000-OS\MSW\blockWinP\blockWinP.exe" "$SMSTARTUP"
  CopyFiles "C:\core\infrastructure\extendedInterface\support\000-OS\MSW\remapCopilotButton\remapCopilotButton.exe" "$SMSTARTUP"

  ; Setup Command Prompt shortcut 
  ExpandEnvStrings $5 %COMSPEC%

  ; Run companion install scripts 
  ExecWait '"$5" /C "C:\core\infrastructure\extendedInterface\support\000-OS\MSW\FreeCAD_NewDocument\install.bat"'
  ;ExecWait "cmd.exe /c C:\core\infrastructure\extendedInterface\support\000-OS\MSW\FreeCAD_NewDocument\install.bat"
  ;CreateDirectory "$WINDIR\ShellNew"
  ;CopyFiles "C:\core\infrastructure\extendedInterface\support\000-OS\MSW\FreeCAD_NewDocument\FreeCAD_Document.FCStd" "$WINDIR\ShellNew\"
  !insertmacro CoreLog ".. FreeCAD New Document setup complete."

  ; Setup lbom.xml for syntax-highlighting courtesy of Kate
  CreateDirectory "$LOCALAPPDATA\org.kde.syntax-highlighting\syntax"
  CopyFiles "C:\Users\mirage335\AppData\Local\org.kde.syntax-highlighting\syntax\lbom.xml" "$LOCALAPPDATA\org.kde.syntax-highlighting\syntax\"

  ; Copy helpers to C:\ 
  CopyFiles "C:\core\infrastructure\extendedInterface\support\000-OS\MSW\root\*" "C:\"

  SetOutPath "C:\"
  File /r "..\..\..\extendedInterface-accessories\parts\_bash.bat.lnk"

  ; nircmd helpers 
  SetOutPath "$WINDIR"
  File /r "..\..\..\extendedInterface-accessories\parts\extendedInterface_bundle\nircmd\*"
  !insertmacro CoreLog ".. Copied Kate, _bash.bat, nircmd helpers to C:\ and %WINDIR%."

  # OpenSSH-Win64-v9.2.2.0.msi
  ;start /wait
  SetOutPath "$TEMP\extendedInterface_bundle\openssh"
  File /r "..\..\..\extendedInterface-accessories\parts\extendedInterface_bundle\openssh\*"
  IfSilent +2
  ExecWait '"msiexec" /i "$TEMP\extendedInterface_bundle\openssh\OpenSSH-Win64-v9.2.2.0.msi"'
  IfSilent 0 +2
  ExecWait '"msiexec" /i "$TEMP\extendedInterface_bundle\openssh\OpenSSH-Win64-v9.2.2.0.msi" /passive /norestart'
  !insertmacro CoreLog ".. Installed OpenSSH."
  
  # gh_2.38.0_windows_amd64.msi
  ;start /wait
  SetOutPath "$TEMP\extendedInterface_bundle\gh"
  File /r "..\..\..\extendedInterface-accessories\parts\extendedInterface_bundle\gh\*"
  IfSilent +2
  ExecWait '"msiexec" /i "$TEMP\extendedInterface_bundle\gh\gh_2.38.0_windows_amd64.msi"'
  IfSilent 0 +2
  ExecWait '"msiexec" /i "$TEMP\extendedInterface_bundle\gh\gh_2.38.0_windows_amd64.msi" /passive /norestart'
  !insertmacro CoreLog ".. Installed GitHub CLI."

  ; Old qalculate installer
  ;start /wait
  #SetOutPath "$TEMP\extendedInterface_bundle\qalculate"
  #File /r "..\..\..\extendedInterface-accessories\parts\extendedInterface_bundle\qalculate\*"
  #IfSilent +2
  #ExecWait '"msiexec" /i "$TEMP\extendedInterface_bundle\qalculate\qalculate-4.7.0-x64.msi"'
  #IfSilent 0 +2
  #ExecWait '"msiexec" /i "$TEMP\extendedInterface_bundle\qalculate\qalculate-4.7.0-x64.msi" /passive /norestart'

  ; New qalculate installer
  ;start /wait
  SetOutPath "$TEMP\extendedInterface_bundle\qalculate"
  File /r "..\..\..\extendedInterface-accessories\parts\extendedInterface_bundle\qalculate\*"
  IfSilent +2
  ExecWait '"msiexec" /i "$TEMP\extendedInterface_bundle\qalculate\qalculate-4.8.1-x64.msi"'
  IfSilent 0 +2
  ExecWait '"msiexec" /i "$TEMP\extendedInterface_bundle\qalculate\qalculate-4.8.1-x64.msi" /passive /norestart'
  !insertmacro CoreLog ".. Installed qalculate "

  SetOutPath "$TEMP\extendedInterface_bundle\tigervnc"
  File /r "..\..\..\extendedInterface-accessories\parts\extendedInterface_bundle\tigervnc\*"
  IfSilent +2
  ExecWait "$TEMP\extendedInterface_bundle\tigervnc\tigervnc64-1.13.1.exe"
  IfSilent 0 +2
  ExecWait "$TEMP\extendedInterface_bundle\tigervnc\tigervnc64-1.13.1.exe /silent"
  !insertmacro CoreLog ".. Installed TigerVNC."

  SetOutPath "$TEMP\extendedInterface_bundle\kate"
  File /r "..\..\..\extendedInterface-accessories\parts\extendedInterface_bundle\kate\*"
  IfSilent +2
  ExecWait "$TEMP\extendedInterface_bundle\kate\kate-23.04.3-2102-windows-cl-msvc2019-x86_64.exe"
  IfSilent 0 +2
  ExecWait "$TEMP\extendedInterface_bundle\kate\kate-23.04.3-2102-windows-cl-msvc2019-x86_64.exe /S"
  !insertmacro CoreLog ".. Installed Kate."

  SetOutPath "$TEMP\extendedInterface_bundle\vjoy"
  File /r "..\..\..\extendedInterface-accessories\parts\extendedInterface_bundle\vjoy\*"
  IfSilent +2
  ExecWait "$TEMP\extendedInterface_bundle\vjoy\vJoy-v2.1.9.1\vJoySetup.exe"
  IfSilent 0 +2
  ExecWait "$TEMP\extendedInterface_bundle\vjoy\vJoy-v2.1.9.1\vJoySetup.exe /VERYSILENT /SUPPRESSMSGBOXES /NORESTART"
  !insertmacro CoreLog ".. Installed vJoy."

  SetOutPath "$TEMP\extendedInterface_bundle\joystickgremlin"
  File /r "..\..\..\extendedInterface-accessories\parts\extendedInterface_bundle\joystickgremlin\*"
  IfSilent +2
  ExecWait '"msiexec" /i "$TEMP\extendedInterface_bundle\joystickgremlin\Joystick.Gremlin.R13.3.msi"'
  IfSilent 0 +2
  ExecWait '"msiexec" /i "$TEMP\extendedInterface_bundle\joystickgremlin\Joystick.Gremlin.R13.3.msi" /passive /norestart'
  !insertmacro CoreLog ".. Installed Joystick Gremlin."

  SetOutPath "C:\Program Files (x86)\H2ik\Joystick Gremlin"
  File /r "..\..\..\extendedInterface-accessories\parts\extendedInterface_bundle\joystickgremlin\Joystick.Gremlin.R13.3.debug\*"
  !insertmacro CoreLog ".. Deployed Joystick Gremlin debug files."

  ; Repeat command processor setup just in case 
  ExpandEnvStrings $5 %COMSPEC%

  ; Big install of ubuiquitous_bash 
  ExecWait '"$5" /C "C:\core\infrastructure\extendedInterface\_bin.bat" _bin /cygdrive/c/core/infrastructure/extendedInterface/ubiquitous_bash.sh _setup_install $0'
  DetailPrint "ubiquitous_bash _setupInstall $0"
  !insertmacro CoreLog ".. Ran /cygdrive/c/core/infrastructure/extendedInterface/ubiquitous_bash.sh _setup_install $0" 
  Sleep 2500

  ;cmd /C "C:\core\infrastructure\ubiquitous_bash\_bin.bat" _bin /cygdrive/c/core/infrastructure/extendedInterface/ubiquitous_bash.sh _setup_install-permissions
  ExpandEnvStrings $5 %COMSPEC%
  ;ExecWait '"$5" /C ""C:\core\infrastructure\ubiquitous_bash\_bin.bat" _bin _messagePlain_probe_cmd chmod 600 /home/root/.ssh/id_*'
  ;ExecWait '"$5" /C ""C:\core\infrastructure\ubiquitous_bash\_bin.bat" _bin _messagePlain_probe_cmd chmod 755 /home/root/.ssh/id_*.pub'
  ;_setup_install-permissions
  #todo is the $0 below needed? 
  ExecWait '"$5" /C "C:\core\infrastructure\ubiquitous_bash\_bin.bat" _bin /cygdrive/c/core/infrastructure/extendedInterface/ubiquitous_bash.sh _setup_install-permissions $0'
  DetailPrint '"$0"'
  !insertmacro CoreLog ".. Ran /cygdrive/c/core/infrastructure/extendedInterface/ubiquitous_bash.sh _setup_install-permissions $0" 
  Sleep 2500

  ; Backup some other previous backups to unique names 
  ; Generate a random alphanumeric string
  System::Call 'KERNEL32::GetTickCount()i.r0'
  System::Call 'ADVAPI32::CryptAcquireContext(i0,t""i0,i0,i0,i0)i.r1'
  System::Call 'ADVAPI32::CryptGenRandom(ir1,i10,i0)i'
  System::Call 'ADVAPI32::CryptReleaseContext(ir1,i0)i'
  IntCmp $0 0 0 +3
  IntOp $0 $0 * -1
  ;GUARD - Ensures non-random path '*-prev' is not occupied - for the future.
  Rename "C:\core\infrastructure\extendedInterface-home-backup-prev" "C:\core\infrastructure\extendedInterface-home-backup-prev-prev-$0"
  Rename "C:\core\infrastructure\ubcp-home-backup-prev" "C:\core\infrastructure\ubcp-home-backup-prev-prev-$0"
  DetailPrint "$0"
  Sleep 2500
  !insertmacro CoreLog ".. Backed up previous backups with unique suffix $0."

  ; Setup CMD yet again... Is this needed??? 
  ExpandEnvStrings $5 %COMSPEC%
  ExecWait '"$5" /C "C:\core\infrastructure\ubiquitous_bash\_setupUbiquitous_nonet.bat"'
  !insertmacro CoreLog ".. Ran ubiquitous_bash _setupUbiquitous_nonet."

  ; More initialization for startup folder 
  ; ATTENTION: Startups may be copied again.  
  ;CopyFiles "C:\DropTerm.lnk" "$SMSTARTUP"
  ;CopyFiles "C:\_DropTerm-startup.lnk" "$SMSTARTUP"
  CopyFiles "C:\_DropTerm-startup.bat.lnk" "$SMSTARTUP"
  CopyFiles "C:\docker_wsl_config.bat" "$SMSTARTUP"
  !insertmacro CoreLog ".. Copied DropTerm, docker_wls startup files to $SMSTARTUP."

  ; And again? 
  ExpandEnvStrings $5 %COMSPEC%
  ; Long test - is the "sanity"? 
  ExecWait '"$5" /C "C:\core\infrastructure\extendedInterface\_bin.bat" _test_rotten'
  !insertmacro CoreLog ".. Ran extendedInterface _test_rotten check."

  Exec "explorer.exe C:\core\infrastructure\extendedInterface\README-installer.pdf"
  !insertmacro CoreLog ".. Opened README-installer.pdf."
  !insertmacro CoreLog "== extendedInterface installer portion completed successfully."

  # Uninstaller - See function un.onInit and section "uninstall" for configuration
	writeUninstaller "C:\core\infrastructure\extIface-uninst.exe"
  !insertmacro CoreLog ".. Wrote uninstaller to C:\core\infrastructure\extIface-uninst.exe"

  # Start Menu
	;createDirectory "$SMPROGRAMS\${COMPANYNAME}"
	;createShortCut "$SMPROGRAMS\${COMPANYNAME}\${APPNAME}.lnk" "$INSTDIR\app.exe" "" "$INSTDIR\logo.ico"
 
	# Registry information for add/remove programs
	WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${COMPANYNAME} ${APPNAME}" "DisplayName" "${COMPANYNAME} - ${APPNAME} - ${DESCRIPTION}"
	WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${COMPANYNAME} ${APPNAME}" "UninstallString" "$\"C:\core\infrastructure\extIface-uninst.exe$\""
	WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${COMPANYNAME} ${APPNAME}" "QuietUninstallString" "$\"C:\core\infrastructure\extIface-uninst.exe$\" /S"
	WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${COMPANYNAME} ${APPNAME}" "InstallLocation" "$\"C:\core\infrastructure\extendedInterface$\""
	WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${COMPANYNAME} ${APPNAME}" "DisplayIcon" "$\"C:\core\infrastructure\extendedInterface\_lib\nsis\icon\icon.ico$\""
	WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${COMPANYNAME} ${APPNAME}" "Publisher" "$\"${COMPANYNAME}$\""
	WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${COMPANYNAME} ${APPNAME}" "HelpLink" "$\"${HELPURL}$\""
	WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${COMPANYNAME} ${APPNAME}" "URLUpdateInfo" "$\"${UPDATEURL}$\""
	WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${COMPANYNAME} ${APPNAME}" "URLInfoAbout" "$\"${ABOUTURL}$\""
	;WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${COMPANYNAME} ${APPNAME}" "DisplayVersion" "$\"${VERSIONMAJOR}.${VERSIONMINOR}.${VERSIONBUILD}$\""
	;WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${COMPANYNAME} ${APPNAME}" "VersionMajor" ${VERSIONMAJOR}
	;WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${COMPANYNAME} ${APPNAME}" "VersionMinor" ${VERSIONMINOR}
	# There is no option for modifying or repairing the install
	WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${COMPANYNAME} ${APPNAME}" "NoModify" 1
	WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${COMPANYNAME} ${APPNAME}" "NoRepair" 1
	# Set the INSTALLSIZE constant (!defined at the top of this script) so Add/Remove Programs can accurately report the size
	WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${COMPANYNAME} ${APPNAME}" "EstimatedSize" ${INSTALLSIZE}
  !insertmacro CoreLog ".. Wrote registry uninstall information."
  !insertmacro CoreLog "== Installation of extendedInterface completed successfully."

SectionEnd



function un.onInit
	SetShellVarContext all
 
	#Verify the uninstaller - last chance to back out
	MessageBox MB_OKCANCEL "Permanantly remove ${APPNAME}? If you made custom changes these may be lost!" IDOK next
		Abort
	next:
    Nop
functionEnd
 
section "uninstall"
  
  ;https://stackoverflow.com/questions/2565215/checking-if-the-application-is-running-in-nsis-before-uninstalling
  ExecWait "TaskKill /IM bash.exe /F"

  ;https://stackoverflow.com/questions/2565215/checking-if-the-application-is-running-in-nsis-before-uninstalling
  ;cmd /c for /f "tokens=1,2" %i in ('tasklist') do (if /i %i EQU bash.exe fsutil file createnew .\bashExe.bz 0) & del .\bashExe.bz
  Delete "$TEMP\extIface_bashExe.bzy"
  !macro IsRunningUninstall
  Delete "$TEMP\extIface_bashExe.bzy"
  ExecWait "cmd /c for /f $\"tokens=1,2$\" %i in ('tasklist') do (if /i %i EQU bash.exe fsutil file createnew $TEMP\extIface_bashExe.bzy 0)"
  IfFileExists $TEMP\extIface_bashExe.bzy 0 notRunningUninstall
    ;we have atleast one main window active
    MessageBox MB_OK|MB_ICONEXCLAMATION "Please close  bash.exe  and retry." /SD IDOK
    Abort
  notRunningUninstall:
  !macroEnd
  
  !insertmacro IsRunningUninstall





	# Remove Start Menu launcher
	;delete "$SMPROGRAMS\${COMPANYNAME}\${APPNAME}.lnk"
	# Try to remove the Start Menu folder - this will only happen if it is empty
	;rmDir "$SMPROGRAMS\${COMPANYNAME}"
 

  ; Generate a random alphanumeric string
  System::Call 'KERNEL32::GetTickCount()i.r0'
  System::Call 'ADVAPI32::CryptAcquireContext(i0,t""i0,i0,i0,i0)i.r1'
  System::Call 'ADVAPI32::CryptGenRandom(ir1,i10,i0)i'
  System::Call 'ADVAPI32::CryptReleaseContext(ir1,i0)i'
  IntCmp $0 0 0 +3
  IntOp $0 $0 * -1


	# Remove files
  #RMDir /r "C:\core\infrastructure\extendedInterface-home-backup-uninstalled"
  Rename "C:\core\infrastructure\extendedInterface-home-backup-uninstalled" "C:\core\infrastructure\extendedInterface-home-backup-uninstalled-$0"
	Rename "C:\core\infrastructure\extendedInterface\_local\ubcp\cygwin\home" "C:\core\infrastructure\extendedInterface-home-backup-uninstalled"
  #RMDir /r "C:\core\infrastructure\ubcp-home-backup-uninstalled"
  Rename "C:\core\infrastructure\ubcp-home-backup-uninstalled" "C:\core\infrastructure\ubcp-home-backup-uninstalled-$0"
  Rename "C:\core\infrastructure\ubcp\cygwin\home" "C:\core\infrastructure\ubcp-home-backup-uninstalled"
  DetailPrint '"$0"'
  Sleep 2500




  ;RMDir /r "C:\core\infrastructure\extendedInterface"
  RMDir /r /REBOOTOK "C:\core\infrastructure\extendedInterface"
  ;RMDir /r "C:\core\infrastructure\ubcp"
  RMDir /r /REBOOTOK "C:\core\infrastructure\ubcp"
  ;RMDir /r "C:\core\infrastructure\ubiquitous_bash"
  RMDir /r /REBOOTOK "C:\core\infrastructure\ubiquitous_bash"
  ;RMDir /r "C:\core\infrastructure\_bash.bat"
  RMDir /r /REBOOTOK "C:\core\infrastructure\_bash.bat"



  # Rename AND/OR Remove  adjacent installed repositories.
  Rename "C:\core\infrastructure\iconArt" "C:\core\infrastructure\iconArt-uninstalled-$0"
  ;RMDir /r "C:\core\infrastructure\ubiquitous_bash"
  RMDir /r /REBOOTOK "C:\core\infrastructure\iconArt"
  ;...


 
	# Always delete uninstaller as the last action
	delete "C:\core\infrastructure\extIface-uninst.exe"
 
	# Try to remove the install directory - this will only happen if it is empty
	;rmDir $INSTDIR
 
	# Remove uninstaller information from the registry
	DeleteRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${COMPANYNAME} ${APPNAME}"
sectionEnd








