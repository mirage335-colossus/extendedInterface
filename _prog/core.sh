##### Core


_experiment() {
	echo test
}




_setup_install-restore() {
    local currentSource
    local currentDestination

    currentSource="$1"
    currentDestination="$2"

    if [[ "$currentSource" == "" ]] || [[ "$currentSource" == "./." ]]
    then
        _messagePlain_bad 'fail: empty: source'
        return 1
    fi
    if [[ "$currentDestination" == "" ]] || [[ "$currentDestination" == "./." ]]
    then
        _messagePlain_bad 'fail: empty: destination'
        return 1
    fi

    
	if [[ ! -e "$currentSource" ]]
	then
		_messagePlain_bad 'fail: missing source: '"$currentSource"
		return 1
	fi
	if [[ ! -e "$currentDestination" ]]
	then
		_messagePlain_bad 'fail: missing destination: '"$currentDestination"
		return 1
	fi
	if ! mkdir -p "$currentSource"
	then
		_messagePlain_bad 'fail: mkdir: source: '"$currentSource"
		return 1
	fi
	if ! mkdir -p "$currentDestination"
	then
		_messagePlain_bad 'fail: missing destination: '"$currentDestination"
		return 1
	fi

	#--exclude ".ssh"
	_messagePlain_probe_cmd rsync -ax --delete --exclude ".bash_profile" --exclude ".bashrc" --exclude ".config" --exclude ".gitconfig" --exclude ".inputrc" --exclude ".lesshst" --exclude ".octave_hist" --exclude ".octaverc" --exclude ".profile" --exclude ".ubcore" --exclude ".ubcorerc_pythonrc.py" --exclude ".ubcorerc-gnuoctave.m" --exclude ".viminfo" --exclude ".wget-hsts" --exclude "bin" "$currentSource" "$currentDestination"
}
_setup_install_procedure() {
	_messageNormal 'init: _setup_install'
	_messagePlain_probe "$@"


	_messagePlain_nominal 'begin: _setup_install'

	if [[ -e /cygdrive/c/core/infrastructure/ubcp-home-backup-"$1" ]]
	then
		#_setup_install-restore /cygdrive/c/core/infrastructure/ubcp-home-backup-"$1"/. "$HOME"/.
		
		# CopyFiles "C:\core\infrastructure\extendedInterface-home-backup-$0\*" "C:\core\infrastructure\extendedInterface\_local\ubcp\cygwin\home\"
		_setup_install-restore /cygdrive/c/core/infrastructure/extendedInterface-home-backup-"$1"/. /cygdrive/c/core/infrastructure/extendedInterface/_local/ubcp/cygwin/home/.

		# CopyFiles "C:\core\infrastructure\ubcp-home-backup-$0\*" "C:\core\infrastructure\ubcp\cygwin\home\"
		_setup_install-restore /cygdrive/c/core/infrastructure/ubcp-home-backup-"$1"/. /cygdrive/c/core/infrastructure/ubcp/cygwin/home/.
	elif [[ -e /cygdrive/c/core/infrastructure/ubcp-home-backup-uninstalled ]]
	then
		#_setup_install-restore /cygdrive/c/core/infrastructure/ubcp-home-backup-uninstalled/. "$HOME"/.

		# CopyFiles "C:\core\infrastructure\extendedInterface-home-backup-uninstalled\*" "C:\core\infrastructure\extendedInterface\_local\ubcp\cygwin\home\"
		_setup_install-restore /cygdrive/c/core/infrastructure/extendedInterface-home-backup-uninstalled/. /cygdrive/c/core/infrastructure/extendedInterface/_local/ubcp/cygwin/home/.

		# CopyFiles "C:\core\infrastructure\ubcp-home-backup-uninstalled\*" "C:\core\infrastructure\ubcp\cygwin\home\"
		_setup_install-restore /cygdrive/c/core/infrastructure/ubcp-home-backup-uninstalled/. /cygdrive/c/core/infrastructure/ubcp/cygwin/home/.
	fi

	_messagePlain_probe_cmd unzip -o "$scriptAbsoluteFolder"/support/000-OS/MSW/root_extra.zip -d /cygdrive/c

	mkdir -p /cygdrive/c/core
	mkdir -p /cygdrive/c/core/_buried
	mkdir -p /cygdrive/c/core/backup/zSpecial/FanControl
	mkdir -p /cygdrive/c/core/infrastructure
	mkdir -p /cygdrive/c/core/installations
	mkdir -p /cygdrive/c/core/investigation

	# MSW really has issues with long paths. Virtual Machines need shared directories.
	# Keeping everything in a short path location is helpful for MSW host and VM guests.
	# "q" quick
	# "p" projects
	mkdir -p /cygdrive/c/q
	mkdir -p /cygdrive/c/q/_slide
	mkdir -p /cygdrive/c/q/Downloads/_buried
	mkdir -p /cygdrive/c/q/Downloads/_preserve
	mkdir -p /cygdrive/c/q/p

	# "p" projects
	# "_cur" current
	# "_def" deferred
	# "_perm" permanent
	# "_pgrnd" playground
	# "_release" release (eg. public websites)
	# "cr" corporate (must be very short, others projects especially may have long paths)
	# "og" org (must be very short, others projects especially may have long paths)
	# z_mirage335-gizmos
	# zSpecial
	mkdir -p /cygdrive/c/q/p
	mkdir -p /cygdrive/c/q/_cur
	mkdir -p /cygdrive/c/q/_def
	mkdir -p /cygdrive/c/q/_perm
	mkdir -p /cygdrive/c/q/_pgrnd
	mkdir -p /cygdrive/c/q/_release
	mkdir -p /cygdrive/c/q/cr
	mkdir -p /cygdrive/c/q/og
	mkdir -p /cygdrive/c/q/z_mirage335-gizmos
	mkdir -p /cygdrive/c/q/zSpecial


	mkdir -p "$USERPROFILE"/_buried/Downloads/_buried
	mkdir -p "$USERPROFILE"/_buried/project/corp
	mkdir -p "$USERPROFILE"/_buried/project/current/_buried

	# Template directory structure created by extendedInterface, but contents should be a separate project to simplify relevant git repository. Possibly a git submodule.
	mkdir -p "$USERPROFILE"/Templates_/_command/mission
	mkdir -p "$USERPROFILE"/Templates_/mechanical
	mkdir -p "$USERPROFILE"/Templates_/_external/generic
	mkdir -p "$USERPROFILE"/Templates_/_external/lib


	# Some MSW apps download very huge amounts of data. Keeping a safe copy of these may help find a way to avoid full redownloading when applying automatic updates.
	mkdir -p /cygdrive/c/core/webCache/_index
	mkdir -p "/cygdrive/c/core/webCache/C/Program Files"
	mkdir -p "/cygdrive/c/core/webCache/C/Program Files (x86)/Steam/steamapps/common"
	mkdir -p "/cygdrive/c/core/webCache/C/Users/user/AppData/Local"
	mkdir -p "/cygdrive/c/core/webCache/C/Users/user/AppData/named/DCS World OpenBeta"
	mkdir -p "/cygdrive/c/core/webCache/C/Users/user/AppData/named/Frontier_Developments"
	mkdir -p "/cygdrive/c/core/webCache/C/Users/user/AppData/named/Microsoft Flight Simulator - Steam"






	reg add "HKEY_CLASSES_ROOT\Directory\shell\OpenWith_ubcp-bash" /v "" /d "Open with ubcp-bash" /f
	reg add "HKEY_CLASSES_ROOT\Directory\shell\OpenWith_ubcp-bash\command" /v "" /d "C:\_bash.bat" /f

	reg add "HKEY_CLASSES_ROOT\Directory\Background\shell\OpenWith_ubcp-bash" /v "" /d "Open with ubcp-bash" /f
	reg add "HKEY_CLASSES_ROOT\Directory\Background\shell\OpenWith_ubcp-bash\command" /v "" /d "C:\_bash.bat" /f

	reg add "HKEY_CLASSES_ROOT\Directory\shell\OpenWith_ubcp-bash-admin" /v "" /d "Open with ubcp-bash-admin" /f
	reg add "HKEY_CLASSES_ROOT\Directory\shell\OpenWith_ubcp-bash\command" /v "" /d "nircmdc elevate cmd /c \"cd \"%V\" && C:\_bash.bat\"" /f

	reg add "HKEY_CLASSES_ROOT\Directory\Background\shell\OpenWith_ubcp-bash-admin" /v "" /d "Open with ubcp-bash-admin" /f
	reg add "HKEY_CLASSES_ROOT\Directory\Background\shell\OpenWith_ubcp-bash-admin\command" /v "" /d "nircmdc elevate cmd /c \"cd \"%V\" && C:\_bash.bat\"" /f

	_messagePlain_nominal 'end: _setup_install'
	return 0
}
_setup_install() {
	local currentExitStatus
	
	mkdir -p /cygdrive/c/core/logs
	_messagePlain_probe_cmd "$scriptAbsoluteLocation" _setup_install_procedure "$@" | tee /cygdrive/c/core/logs/setup_install.log
	#_setup_install_procedure
	currentExitStatus="$?"


	sleep 18
	exit "$?"
}






_test_rotten() {
	"$scriptAbsoluteFolder"/extendedInterface.sh _test "$@"
}

_refresh_anchors() {
	#cp -a "$scriptAbsoluteFolder"/_anchor.bat "$scriptAbsoluteFolder"/_bin.bat
	#cp -a "$scriptAbsoluteFolder"/_anchor.bat "$scriptAbsoluteFolder"/_true.bat
	#cp -a "$scriptAbsoluteFolder"/_anchor.bat "$scriptAbsoluteFolder"/_false.bat

	true
}

_anchor_special() {
	_anchor_configure
	
	"$scriptAbsoluteFolder"/ubiquitous_bash.sh _anchor_configure "$scriptAbsoluteFolder"/_anchor.bat
	

	cp -a "$scriptAbsoluteFolder"/_anchor.bat "$scriptAbsoluteFolder"/_bin.bat
	"$scriptAbsoluteFolder"/ubiquitous_bash.sh _anchor_configure "$scriptAbsoluteFolder"/_bin.bat
	"$scriptAbsoluteFolder"/ubiquitous_bash.sh _anchor_configure "$scriptAbsoluteFolder"/_bin.cmd

	cp -a "$scriptAbsoluteFolder"/_anchor.bat "$scriptAbsoluteFolder"/_bin_rotten.bat
	"$scriptAbsoluteFolder"/extendedInterface.sh _anchor_configure "$scriptAbsoluteFolder"/_bin_rotten.bat
	
	cp -a "$scriptAbsoluteFolder"/_anchor.bat "$scriptAbsoluteFolder"/_true.bat
	"$scriptAbsoluteFolder"/extendedInterface.sh _anchor_configure "$scriptAbsoluteFolder"/_true.bat
	
	cp -a "$scriptAbsoluteFolder"/_anchor.bat "$scriptAbsoluteFolder"/_false.bat
	"$scriptAbsoluteFolder"/extendedInterface.sh _anchor_configure "$scriptAbsoluteFolder"/_false.bat

	
	cp -a "$scriptAbsoluteFolder"/_anchor.bat "$scriptAbsoluteFolder"/_test.bat
	"$scriptAbsoluteFolder"/ubiquitous_bash.sh _anchor_configure "$scriptAbsoluteFolder"/_test.bat
	
	cp -a "$scriptAbsoluteFolder"/_anchor.bat "$scriptAbsoluteFolder"/_test_rotten.bat
	"$scriptAbsoluteFolder"/extendedInterface.sh _anchor_configure "$scriptAbsoluteFolder"/_test_rotten.bat
}


