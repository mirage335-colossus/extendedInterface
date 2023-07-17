
; ATTRIBUTION - May be largely attributable to ChatGPT-4/copilot used by mirage335 .
; ATTRIBUTION - https://nsis.sourceforge.io/Sample_installation_script_for_an_application
; ATTRIBUTION - https://nsis.sourceforge.io/A_simple_installer_with_start_menu_shortcut_and_uninstaller
; ATTRIBUTION - https://nsis.sourceforge.io/Embedding_other_installers


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



; Set the output directory and file name
OutFile "..\..\..\extIface.exe"

SetCompressor /SOLID /FINAL lzma

Section
  SetOutPath "C:\core\infrastructure\extendedInterface"
  File /r "..\..\..\extendedInterface\*"
SectionEnd


Section "Install"
  SetOutPath "C:\core\infrastructure\extendedInterface\_local\ubcp"
  File /r "..\..\..\extendedInterface-accessories\parts\ubcp\package_ubcp-core\ubcp\*"
SectionEnd







