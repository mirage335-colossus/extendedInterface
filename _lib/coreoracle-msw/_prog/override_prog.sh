#Override (Program).
_start_prog() {
	umask 077
	
	stty -echo > /dev/null 2>&1
	
	#[[ "$varStore" != "" ]] && [[ -e "$varStore" ]] && . "$varStore"
	
}

_stop_prog() {
	stty echo > /dev/null 2>&1
}

_prepare_prog() {
	mkdir -p -m 700 "$dataDir"
	chmod 700 "$dataDir"
	mkdir -p -m 700 "$safeTmp"
	chmod 700 "$safeTmp"
	mkdir -p -m 700 "$fileDir"
	chmod 700 "$fileDir"
	
	mkdir -p -m 700 "$shortTmp"
	chmod 700 "$shortTmp"
	
	#mkdir -p -m 700 "$pack"
	#chmod 700 "$pack"
}
