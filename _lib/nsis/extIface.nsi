
; ATTRIBUTION - May be largely attributable to ChatGPT-4/copilot used by mirage335 .
; ATTRIBUTION - https://nsis.sourceforge.io/Sample_installation_script_for_an_application
; ATTRIBUTION - https://nsis.sourceforge.io/A_simple_installer_with_start_menu_shortcut_and_uninstaller
; ATTRIBUTION - https://nsis.sourceforge.io/Embedding_other_installers
; ATTRIBUTION - https://stackoverflow.com/questions/3265141/executing-batch-file-in-nsis-installer


; copy ubcp home directories
; uninstall (ie. if already installed and updating)


; extract ubcp release to extendedInterface subdir
; call bash scripts to set all filesystem permissions, etc
; extract extendedInterface ".git" repository to core/infrastructure/...
; checkout extendedInterface repository

; call bash scripts to properly create developer ubcp infrastructure

; restore ubcp home directories



; show PDF with instructions to install and correctly configure other soft dependencies (eg. vJoy, VoiceAttack, etc)
 ; PDF instructions must also include calling interactive script through batch file to change USB identifiers for Joystick Gremlin
 ; PDF instructions must also refer to soft dependencies of 'ubiquitous_bash' (eg. TigerVNC, etc)




/*

Provide an NSIS script to
   Install by doing the following:
If not Admin then fail with error message
INSTDIR is   C:\core\infrastructure  and cannot be set to anything else by the user or otherwise
Create directory   C:\core\infrastructure   and fail with error message if this cannot be done
Embed and copy the directory from ../   to C:\core\infrastructure\extendedInterface
Embed and copy the directory from   "$shortTmp"/parts/ubcp/package_ubcp-core/ubcp   to   C:\core\infrastructure\extendedInterface\_local\ubcp
Embed and copy the directory from   "$shortTmp"/parts/ubcp/package_ubcp-core/ubiquitous_bash   to   C:\core\infrastructure\ubiquitous_bash
Copy the directory   C:\core\infrastructure\extendedInterface\_local\ubcp   to  C:\core\infrastructure\ubcp
Embed and copy the file from   "$shortTmp"/parts/ubcp/package_ubcp-core/_bash.bat   to   C:\core\infrastructure\_bash.bat

From working directory   'C:\core\infrastructure\extendedInterface\'   run   'C:\core\infrastructure\extendedInterface\_lib\ubiquitous_bash\_bin.bat' git reset --hard



*/

  RequestExecutionLevel admin


/*

Section
  ; WARNING: Untested.
  ; INSTDIR is C:\core\infrastructure and cannot be set to anything else by the user or otherwise
  SetOutPath "$INSTDIR"

  ; Create directory C:\core\infrastructure and fail with error message if this cannot be done
  CreateDirectory $INSTDIR
  IfErrors 0 +2
  MessageBox MB_OK "Failed to create directory $INSTDIR"
  Quit

  ; Embed and copy the directory from ../ to C:\core\infrastructure\extendedInterface
  File "..\..\..\extendedInterface\*" "/oname=$INSTDIR\extendedInterface\"

  ; Embed and copy the directory from ./parts/ubcp/package_ubcp-core/ubcp to C:\core\infrastructure\extendedInterface\_local\ubcp
  File /r "..\..\extendedInterface\parts\ubcp\package_ubcp-core\ubcp\*" "$INSTDIR\extendedInterface\_local\ubcp\"

  ; Embed and copy the directory from .../parts/ubcp/package_ubcp-core/ubiquitous_bash to C:\core\infrastructure\ubiquitous_bash
  File /r "..\..\extendedInterface\parts\ubcp\package_ubcp-core\ubiquitous_bash\*" "$INSTDIR\ubiquitous_bash\"

  ; Copy the directory C:\core\infrastructure\extendedInterface\_local\ubcp to C:\core\infrastructure\ubcp
  SetOutPath "$INSTDIR\ubcp"
  File /r "$INSTDIR\extendedInterface\_local\ubcp\*" "$INSTDIR\ubcp\"

  ; Embed and copy the file from .../parts/ubcp/package_ubcp-core/_bash.bat to C:\core\infrastructure\_bash.bat
  File "..\..\extendedInterface\parts\ubcp\package_ubcp-core\_bash.bat" "$INSTDIR\_bash.bat"

  ; From working directory C:\core\infrastructure\extendedInterface\, run C:\core\infrastructure\extendedInterface\_lib\ubiquitous_bash\_bin.bat git reset --hard
  SetOutPath "$INSTDIR\extendedInterface"
  ExecWait '"$INSTDIR\extendedInterface\_lib\ubiquitous_bash\_bin.bat" git reset --hard'
SectionEnd

*/


/*


Section "License"
  File "..\..\license-installer.txt"
SectionEnd

*/


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


Section "Install"
  SetShellVarContext all

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

  Delete "C:\core\infrastructure\extendedInterface"
  Delete "C:\core\infrastructure\ubcp"
  Delete "C:\core\infrastructure\ubiquitous_bash"
  Delete "C:\core\infrastructure\_bash.bat"

  SetOutPath "C:\core\infrastructure\extendedInterface"
  File /r "..\..\..\extendedInterface-accessories\parts\extendedInterface\*"

  SetOutPath "C:\core\infrastructure\extendedInterface\_local\ubcp"
  File /r "..\..\..\extendedInterface-accessories\parts\ubcp\package_ubcp-core\ubcp\*"
  
  CopyFiles "C:\core\infrastructure\extendedInterface\_local\ubcp\*" "C:\core\infrastructure\ubcp\"

  SetOutPath "C:\core\infrastructure\ubiquitous_bash"
  File /r "..\..\..\extendedInterface-accessories\parts\ubcp\package_ubcp-core\ubiquitous_bash\*"

  SetOutPath "C:\core\infrastructure\"
  File "..\..\..\extendedInterface-accessories\parts\ubcp\package_ubcp-core\_bash.bat"




  

  ;ATTENTION
  IfFileExists "C:\core\infrastructure\ubcp-home-backup-$0" 0 +3
  Delete "C:\core\infrastructure\extendedInterface\_local\ubcp\cygwin\home"
  CopyFiles "C:\core\infrastructure\extendedInterface-home-backup-$0\*" "C:\core\infrastructure\extendedInterface\_local\ubcp\cygwin\home\"

  ;ATTENTION
  IfFileExists "C:\core\infrastructure\ubcp-home-backup-$0" 0 +3
  Delete "C:\core\infrastructure\ubcp\cygwin\home"
  CopyFiles "C:\core\infrastructure\ubcp-home-backup-$0\*" "C:\core\infrastructure\ubcp\cygwin\home\"



  

  ;ATTENTION
  IfFileExists "C:\core\infrastructure\ubcp-home-backup-uninstalled" 0 +3
  Delete "C:\core\infrastructure\extendedInterface\_local\ubcp\cygwin\home"
  CopyFiles "C:\core\infrastructure\extendedInterface-home-backup-uninstalled\*" "C:\core\infrastructure\extendedInterface\_local\ubcp\cygwin\home\"

  ;ATTENTION
  IfFileExists "C:\core\infrastructure\ubcp-home-backup-uninstalled" 0 +3
  Delete "C:\core\infrastructure\ubcp\cygwin\home"
  CopyFiles "C:\core\infrastructure\ubcp-home-backup-uninstalled\*" "C:\core\infrastructure\ubcp\cygwin\home\"









  SetShellVarContext all

  ExecWait "regedit.exe /s C:\core\infrastructure\extendedInterface\support\explorer\_thirdparty\Disable_Windows_Key_Hotkeys.reg"
  ExecWait "regedit.exe /s C:\core\infrastructure\extendedInterface\support\000-OS\MSW\AutoEndTasks\Turn_On_AutoEndTasks_for_all_users.reg"
  ExecWait "regedit.exe /s C:\core\infrastructure\extendedInterface\support\000-OS\MSW\disableShake\Disable Aero Shake.reg"
  ExecWait "regedit.exe /s C:\core\infrastructure\extendedInterface\support\000-OS\MSW\GameDVR_disable\GameDVR_disable.reg"
  ExecWait "regedit.exe /s C:\core\infrastructure\extendedInterface\support\000-OS\MSW\ShowSecondsInSystemClock\Show Seconds In System Clock.reg"

  
  ExecWait "regedit.exe /s C:\core\infrastructure\extendedInterface\support\000-OS\MSW\disableHardwareAssistedGPUScheduling\Hardware Accelerated GPU Scheduling - Disable.reg"


  CopyFiles "C:\core\infrastructure\extendedInterface\support\000-OS\MSW\blockWinP\blockWinP.exe" "$SMSTARTUP"

  ExpandEnvStrings $0 %COMSPEC%
  ExecWait '"$0" /C "C:\core\infrastructure\extendedInterface\support\000-OS\MSW\FreeCAD_NewDocument\install.bat"'
  ;ExecWait "cmd.exe /c C:\core\infrastructure\extendedInterface\support\000-OS\MSW\FreeCAD_NewDocument\install.bat"
  ;CreateDirectory "$WINDIR\ShellNew"
  ;CopyFiles "C:\core\infrastructure\extendedInterface\support\000-OS\MSW\FreeCAD_NewDocument\FreeCAD_Document.FCStd" "$WINDIR\ShellNew\"

  CreateDirectory "$LOCALAPPDATA\org.kde.syntax-highlighting\syntax"
  CopyFiles "C:\Users\mirage335\AppData\Local\org.kde.syntax-highlighting\syntax\lbom.xml" "$LOCALAPPDATA\org.kde.syntax-highlighting\syntax\"

  CopyFiles "C:\core\infrastructure\extendedInterface\support\000-OS\MSW\root\*" "C:\"




  SetOutPath "C:\"
  File /r "..\..\..\extendedInterface-accessories\parts\_bash.bat.lnk"




  ExpandEnvStrings $0 %COMSPEC%
  ExecWait '"$0" /C "C:\core\infrastructure\extendedInterface\_bin.bat" _setup_install'

  ExpandEnvStrings $0 %COMSPEC%
  ExecWait '"$0" /C "C:\core\infrastructure\extendedInterface\_bin.bat" _setupUbiquitous'

  ExpandEnvStrings $0 %COMSPEC%
  ExecWait '"$0" /C "C:\core\infrastructure\extendedInterface\_bin.bat" _test_rotten'



  Exec "explorer.exe C:\core\infrastructure\extendedInterface\README-installer.pdf"

SectionEnd












