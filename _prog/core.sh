##### Core


_experiment() {
	echo test
}





_setup_install() {
	_messageNormal 'init: _setup_install'
	sleep 25
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


