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

_sweep() {
	[[ -e "$1" ]] && rm -f "$@"
	
	! [[ -e "$1" ]] && return 0
	return 1
}

# RESERVED. No production use.
_clean() {
	false
}


