
; ATTRIBUTION - May be largely attributable to ChatGPT-4/copilot used by mirage335 .
; ATTRIBUTION - https://nsis.sourceforge.io/Sample_installation_script_for_an_application
; ATTRIBUTION - https://nsis.sourceforge.io/A_simple_installer_with_start_menu_shortcut_and_uninstaller
; ATTRIBUTION - https://nsis.sourceforge.io/Embedding_other_installers
; ATTRIBUTION - https://stackoverflow.com/questions/3265141/executing-batch-file-in-nsis-installer





RequestExecutionLevel admin




SilentInstall normal
LicenseData "..\..\license-installer.txt"

Name "extendedInterface"
Icon ".\icon\icon.ico"
OutFile "..\..\..\extIface.exe"






;/SOLID
SetCompressor /FINAL lzma


Page license
;Page directory
Page instfiles

;https://github.com/mirage335/extendedInterface/
!define APPNAME "extendedInterface"
!define COMPANYNAME "extendedInterface"
!define DESCRIPTION "extendedInterface"
!define HELPURL "https://github.com/mirage335/extendedInterface/"
!define UPDATEURL "https://github.com/mirage335/extendedInterface/"
!define ABOUTURL "https://github.com/mirage335/extendedInterface/"
!define INSTALLSIZE 6500000


Section "Install"
  SetShellVarContext all

  ; Generate a random alphanumeric string
  System::Call 'KERNEL32::GetTickCount()i.r0'
  System::Call 'ADVAPI32::CryptAcquireContext(i0,t""i0,i0,i0,i0)i.r1'
  System::Call 'ADVAPI32::CryptGenRandom(ir1,i10,i0)i'
  System::Call 'ADVAPI32::CryptReleaseContext(ir1,i0)i'
  IntCmp $0 0 0 +3
  IntOp $0 $0 * -1

  ;GUARD - Ensures non-random path '*-prev' is not occupied - presently.
  Rename "C:\core\infrastructure\extendedInterface-home-backup-prev" "C:\core\infrastructure\extendedInterface-home-backup-$0"
  Rename "C:\core\infrastructure\ubcp-home-backup-prev" "C:\core\infrastructure\ubcp-home-backup-$0"
  DetailPrint "$0"
  Sleep 2500

  ; Generate a random alphanumeric string
  System::Call 'KERNEL32::GetTickCount()i.r0'
  System::Call 'ADVAPI32::CryptAcquireContext(i0,t""i0,i0,i0,i0)i.r1'
  System::Call 'ADVAPI32::CryptGenRandom(ir1,i10,i0)i'
  System::Call 'ADVAPI32::CryptReleaseContext(ir1,i0)i'
  IntCmp $0 0 0 +3
  IntOp $0 $0 * -1


  ;ATTENTION
  Rename "C:\core\infrastructure\extendedInterface\_local\ubcp\cygwin\home" "C:\core\infrastructure\extendedInterface-home-backup-$0"
  Rename "C:\core\infrastructure\ubcp\cygwin\home" "C:\core\infrastructure\ubcp-home-backup-$0"
  DetailPrint "$0"
  Sleep 2500

  RMDir /r "C:\core\infrastructure\extendedInterface"
  ;RMDir /r /REBOOTOK "C:\core\infrastructure\extendedInterface"
  RMDir /r "C:\core\infrastructure\ubcp"
  ;RMDir /r /REBOOTOK "C:\core\infrastructure\ubcp"
  RMDir /r "C:\core\infrastructure\ubiquitous_bash"
  ;RMDir /r /REBOOTOK "C:\core\infrastructure\ubiquitous_bash"
  RMDir /r "C:\core\infrastructure\_bash.bat"
  ;RMDir /r /REBOOTOK "C:\core\infrastructure\_bash.bat"

  SetOutPath "C:\core\infrastructure\extendedInterface"
  File /r "..\..\..\extendedInterface-accessories\parts\extendedInterface\*"

  SetOutPath "C:\core\infrastructure\extendedInterface\_local\ubcp"
  File /r "..\..\..\extendedInterface-accessories\parts\ubcp\package_ubcp-core\ubcp\*"
  
  CopyFiles "C:\core\infrastructure\extendedInterface\_local\ubcp\*" "C:\core\infrastructure\ubcp\"

  SetOutPath "C:\core\infrastructure\ubiquitous_bash"
  File /r "..\..\..\extendedInterface-accessories\parts\ubcp\package_ubcp-core\ubiquitous_bash\*"

  SetOutPath "C:\core\infrastructure\"
  File "..\..\..\extendedInterface-accessories\parts\ubcp\package_ubcp-core\_bash.bat"




  

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









  SetShellVarContext all

  ExecWait "regedit.exe /s C:\core\infrastructure\extendedInterface\support\explorer\_thirdparty\Disable_Windows_Key_Hotkeys.reg"
  ExecWait "regedit.exe /s C:\core\infrastructure\extendedInterface\support\000-OS\MSW\AutoEndTasks\Turn_On_AutoEndTasks_for_all_users.reg"
  ExecWait "regedit.exe /s C:\core\infrastructure\extendedInterface\support\000-OS\MSW\disableShake\Disable Aero Shake.reg"
  ExecWait "regedit.exe /s C:\core\infrastructure\extendedInterface\support\000-OS\MSW\GameDVR_disable\GameDVR_disable.reg"
  
  ;https://www.youtube.com/watch?v=5wBxYQdN96s&t=321s
  ; 'Extra Monitors DO Hurt Your Gaming Performance'
  ;  'If the contents of that window need to be changing, all that optimization goes out the window.'
  ;ExecWait "regedit.exe /s C:\core\infrastructure\extendedInterface\support\000-OS\MSW\ShowSecondsInSystemClock\Show Seconds In System Clock.reg"

  
  ExecWait "regedit.exe /s C:\core\infrastructure\extendedInterface\support\000-OS\MSW\disableHardwareAssistedGPUScheduling\Hardware Accelerated GPU Scheduling - Disable.reg"


  CopyFiles "C:\core\infrastructure\extendedInterface\support\000-OS\MSW\blockWinP\blockWinP.exe" "$SMSTARTUP"

  ExpandEnvStrings $5 %COMSPEC%
  ExecWait '"$5" /C "C:\core\infrastructure\extendedInterface\support\000-OS\MSW\FreeCAD_NewDocument\install.bat"'
  ;ExecWait "cmd.exe /c C:\core\infrastructure\extendedInterface\support\000-OS\MSW\FreeCAD_NewDocument\install.bat"
  ;CreateDirectory "$WINDIR\ShellNew"
  ;CopyFiles "C:\core\infrastructure\extendedInterface\support\000-OS\MSW\FreeCAD_NewDocument\FreeCAD_Document.FCStd" "$WINDIR\ShellNew\"

  CreateDirectory "$LOCALAPPDATA\org.kde.syntax-highlighting\syntax"
  CopyFiles "C:\Users\mirage335\AppData\Local\org.kde.syntax-highlighting\syntax\lbom.xml" "$LOCALAPPDATA\org.kde.syntax-highlighting\syntax\"

  CopyFiles "C:\core\infrastructure\extendedInterface\support\000-OS\MSW\root\*" "C:\"




  SetOutPath "C:\"
  File /r "..\..\..\extendedInterface-accessories\parts\_bash.bat.lnk"


  SetOutPath "$WINDIR"
  File /r "..\..\..\extendedInterface-accessories\parts\extendedInterface_bundle\nircmd\*"


  ;start /wait
  SetOutPath "$TEMP\extendedInterface_bundle\qalculate"
  File /r "..\..\..\extendedInterface-accessories\parts\extendedInterface_bundle\qalculate\*"
  IfSilent +2
  ExecWait '"msiexec" /i "$TEMP\extendedInterface_bundle\qalculate\qalculate-4.7.0-x64.msi"'
  IfSilent 0 +2
  ExecWait '"msiexec" /i "$TEMP\extendedInterface_bundle\qalculate\qalculate-4.7.0-x64.msi" /passive /norestart'


  SetOutPath "$TEMP\extendedInterface_bundle\tigervnc"
  File /r "..\..\..\extendedInterface-accessories\parts\extendedInterface_bundle\tigervnc\*"
  IfSilent +2
  ExecWait "$TEMP\extendedInterface_bundle\tigervnc\tigervnc64-1.13.1.exe"
  IfSilent 0 +2
  ExecWait "$TEMP\extendedInterface_bundle\tigervnc\tigervnc64-1.13.1.exe /silent"


  SetOutPath "$TEMP\extendedInterface_bundle\kate"
  File /r "..\..\..\extendedInterface-accessories\parts\extendedInterface_bundle\kate\*"
  IfSilent +2
  ExecWait "$TEMP\extendedInterface_bundle\kate\kate-23.04.3-2102-windows-cl-msvc2019-x86_64.exe"
  IfSilent 0 +2
  ExecWait "$TEMP\extendedInterface_bundle\kate\kate-23.04.3-2102-windows-cl-msvc2019-x86_64.exe /S"




  SetOutPath "$TEMP\extendedInterface_bundle\vjoy"
  File /r "..\..\..\extendedInterface-accessories\parts\extendedInterface_bundle\vjoy\*"
  IfSilent +2
  ExecWait "$TEMP\extendedInterface_bundle\vjoy\vJoy-v2.1.9.1\vJoySetup.exe"
  IfSilent 0 +2
  ExecWait "$TEMP\extendedInterface_bundle\vjoy\vJoy-v2.1.9.1\vJoySetup.exe /VERYSILENT /SUPPRESSMSGBOXES /NORESTART"


  SetOutPath "$TEMP\extendedInterface_bundle\joystickgremlin"
  File /r "..\..\..\extendedInterface-accessories\parts\extendedInterface_bundle\joystickgremlin\*"
  IfSilent +2
  ExecWait '"msiexec" /i "$TEMP\extendedInterface_bundle\joystickgremlin\Joystick.Gremlin.R13.3.msi"'
  IfSilent 0 +2
  ExecWait '"msiexec" /i "$TEMP\extendedInterface_bundle\joystickgremlin\Joystick.Gremlin.R13.3.msi" /passive /norestart'






  ExpandEnvStrings $5 %COMSPEC%
  ExecWait '"$5" /C "C:\core\infrastructure\extendedInterface\_bin.bat" _setup_install $0'
  DetailPrint '"$0"'
  Sleep 2500

  ; Generate a random alphanumeric string
  System::Call 'KERNEL32::GetTickCount()i.r0'
  System::Call 'ADVAPI32::CryptAcquireContext(i0,t""i0,i0,i0,i0)i.r1'
  System::Call 'ADVAPI32::CryptGenRandom(ir1,i10,i0)i'
  System::Call 'ADVAPI32::CryptReleaseContext(ir1,i0)i'
  IntCmp $0 0 0 +3
  IntOp $0 $0 * -1

  ;GUARD - Ensures non-random path '*-prev' is not occupied - for the future.
  Rename "C:\core\infrastructure\extendedInterface-home-backup-prev" "C:\core\infrastructure\extendedInterface-home-backup-$0"
  Rename "C:\core\infrastructure\ubcp-home-backup-prev" "C:\core\infrastructure\ubcp-home-backup-$0"
  DetailPrint "$0"
  Sleep 2500

  ExpandEnvStrings $5 %COMSPEC%
  ExecWait '"$5" /C "C:\core\infrastructure\ubiquitous_bash\_setupUbiquitous_nonet.bat"'

  ExpandEnvStrings $5 %COMSPEC%
  ExecWait '"$5" /C "C:\core\infrastructure\extendedInterface\_bin.bat" _test_rotten'



  Exec "explorer.exe C:\core\infrastructure\extendedInterface\README-installer.pdf"





  # Uninstaller - See function un.onInit and section "uninstall" for configuration
	writeUninstaller "C:\core\infrastructure\extIface-uninst.exe"


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
 
	# Always delete uninstaller as the last action
	delete "C:\core\infrastructure\extIface-uninst.exe"
 
	# Try to remove the install directory - this will only happen if it is empty
	;rmDir $INSTDIR
 
	# Remove uninstaller information from the registry
	DeleteRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${COMPANYNAME} ${APPNAME}"
sectionEnd








