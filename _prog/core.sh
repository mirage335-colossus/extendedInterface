##### Core


_experiment() {
	echo test
}




_setup_install-restore() {
	if [[ ! -e "$1" ]]
	then
		_messagePlain_bad 'fail: missing source: '"$1"
		return 1
	fi
	if [[ ! -e "$2" ]]
	then
		_messagePlain_bad 'fail: missing destination: '"$2"
		return 1
	fi
	if ! mkdir -p "$1"
	then
		_messagePlain_bad 'fail: mkdir: source: '"$1"
		return 1
	fi
	if ! mkdir -p "$2"
	then
		_messagePlain_bad 'fail: missing destination: '"$2"
		return 1
	fi

	_messagePlain_probe_cmd rsync -ax --delete --exclude ".bash_profile" --exclude ".bashrc" --exclude ".config" --exclude ".gitconfig" --exclude ".inputrc" --exclude ".lesshst" --exclude ".octave_hist" --exclude ".octaverc" --exclude ".profile" --exclude ".ssh" --exclude ".ubcore" --exclude ".ubcorerc_pythonrc.py" --exclude ".ubcorerc-gnuoctave.m" --exclude ".viminfo" --exclude ".wget-hsts" --exclude "bin" "$1" "$2"
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



	_messagePlain_nominal 'end: _setup_install'
	return 0
}
_setup_install() {
	local currentExitStatus
	
	mkdir -p /cygdrive/c/core/logs
	_messagePlain_probe_cmd "$scriptAbsoluteLocation" _setup_install_procedure "$@" | tee /cygdrive/c/core/logs/setup_install.log
	#_setup_install_procedure
	currentExitStatus="$?"


	sleep 25
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


