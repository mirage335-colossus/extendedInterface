_volatile() {
	[[ "$tmpPrefix" == "" ]] && return 1
	mkdir -p "$scriptAbsoluteFolder""$tmpPrefix"
	! [[ -e "$scriptAbsoluteFolder""$tmpPrefix" ]] && return 1
	
	if mountpoint "$scriptAbsoluteFolder""$tmpPrefix" > /dev/null 2>&1
	then
		sudo -n chown "$USER":"$USER" "$scriptAbsoluteFolder""$tmpPrefix"
		return 0
	fi
	
	sudo -n mount -t ramfs ramfs "$scriptAbsoluteFolder""$tmpPrefix"
	
	if mountpoint "$scriptAbsoluteFolder""$tmpPrefix" > /dev/null 2>&1
	then
		sudo -n chown "$USER":"$USER" "$scriptAbsoluteFolder""$tmpPrefix"
		return 0
	fi
	
	mountpoint "$scriptAbsoluteFolder""$tmpPrefix" > /dev/null 2>&1 && return 0
	return 1
}

_volatile_umount() {
	[[ "$tmpPrefix" == "" ]] && return 1
	mkdir -p "$scriptAbsoluteFolder""$tmpPrefix"
	! [[ -e "$scriptAbsoluteFolder""$tmpPrefix" ]] && return 1
	
	sudo -n umount "$scriptAbsoluteFolder""$tmpPrefix"
}
_volatile_unmount() {
	_volatile_umount "$@"
}


# Similar function used by 'flipKey' .
_sweep_branch() {
	_if_cygwin && ! _discoverResource-cygwinNative-ProgramFiles 'sdelete' 'sdelete' false
	
	if ! [[ -e "$1" ]]
	then
		return 1
	fi
	
	if [[ -d "$1" ]]
	then
		return 1
	fi
	
	if man wipe 2> /dev/null | grep 'Berke Durak' > /dev/null && man wipe 2> /dev/null | grep '\-Q <number\-of\-passes>' > /dev/null && man wipe 2> /dev/null | grep '\-s (silent mode)' > /dev/null
	then
		wipe -q -f -s "$@" > /dev/null
		return 0
	fi
	
	if _if_cygwin && type 'sdelete' > /dev/null 2>&1
	then
		local currentCygwinMSWpath
		currentCygwinMSWpath=$(cygpath --windows "$1")
		shift
		sdelete -p 2 -r -nobanner "$currentCygwinMSWpath"
		return 0
	fi
	
	
	return 1
	
}

_sweep() {
	[[ "$1" == "" ]] && return 1
	[[ -d "$1" ]] && return 1
	
	_sweep_branch "$@"
	
	[[ -e "$1" ]] && rm -f "$@"
	
	! [[ -e "$1" ]] && return 0
	return 1
}


# RESERVED. No production use.
_clean() {
	false
}


