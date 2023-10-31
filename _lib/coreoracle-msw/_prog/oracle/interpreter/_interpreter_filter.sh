# Carefully sanitizes inputs before passing to bash interpreter. Normal users are expected to have severely restricted access to only a few script functions.

#RESERVED for future use or PROHIBITED.
_commKey_interpreter_filter_reserved_procedure() {
	case "$1" in
		EMRG)
			return 1
			;;
		ALRT)
			return 1
			;;
		TEST)
			return 1
			;;
		
		EMER)
			return 1
			;;
		EXMP)
			return 1
			;;
		CMND)
			return 1
			;;
		DATA)
			return 1
			;;
		
		FOWD)
			return 1
			;;
		RECV)
			return 1
			;;
		SMAL)
			return 1
			;;
		RMAL)
			return 1
			;;
		MAIL)
			return 1
			;;
		INBD)
			return 1
			;;
		OTBD)
			return 1
			;;
		ADDR)
			return 1
			;;
		PING)
			return 1
			;;
		PAGE)
			return 1
			;;
		MCST)
			return 1
			;;
		BCST)
			return 1
			;;
		STRM)
			return 1
			;;
		CHON)
			return 1
			;;
		CHOF)
			return 1
			;;
		SCHD)
			return 1
			;;
		SYNC)
			return 1
			;;
		
		MESH)
			return 1
			;;
		BECN)
			return 1
			;;
		NEBR)
			return 1
			;;
		DISC)
			return 1
			;;
	esac
	
	return 0
}

_commKey_interpreter_filter_diag_procedure() {
	case "$1" in
		PASS)
			echo -n 'PASS'
			return 0
			;;
		DIAG)
			echo -n 'TODO'
			return 0
			;;
		SHOW)
			echo -n 'TODO'
			return 0
			;;
	esac
	
	return 1
}

_commKey_interpreter_filter_record_procedure() {
	case "$1" in
		LOGO)
			#Overwrite.
			_commKey_interpreter_log_overwrite
			echo 'PASS'
			return 0
			;;
		LOGA)
			#Append.
			_commKey_interpreter_log_append
			echo -n 'PASS'
			return 0
			;;
		LOGS)
			#Sweep.
			_commKey_interpreter_log_sweep
			echo -n 'PASS'
			return 0
			;;
		LOGX)
			#Truncate.
			_commKey_interpreter_log_truncate
			echo -n 'PASS'
			return 0
			;;
		LOGK)
			#Copy out, all.
			_commKey_interpreter_log_read
			return 0
			;;
		LOGR)
			#Copy out, recent.
			_commKey_interpreter_log_recent
			return 0
			;;
	esac
	
	return 1
}


_commKey_interpreter_filter_usermanager_procedure() {
	if ( ! [[ -e "$3" ]] || [[ $(head -c 1 "$3" 2>/dev/null | tr -dc '0-1') != "1" ]] ) && ! [[ "$(_commKey_interpreter_addrate_log_elapsed)" -gt 3600 ]]
	then
		case "$1" in
			NEWK)
				return 0
				;;
			NEWS)
				return 0
				;;
			NEWU)
				return 0
				;;
		esac
		
		return 1
	fi
	
	case "$1" in
		NEWK)
			_commKey_interpreter_addrate_log
			#RESERVED. Create new key for specified (pseudononymous) user name.
			return 0
			;;
		NEWS)
			_commKey_interpreter_addrate_log
			#RESERVED. New key for self.
			return 0
			;;
		NEWU)
			_commKey_interpreter_addrate_log
			#New key for new (anonymous) user.
			! _generate_commFields-anon && return 1
			return 0
			;;
	esac
	
	return 1
}

# WARNING: Do not allow retrieval of pseudononymous or privileged keys.
_commKey_interpreter_filter_getkey_procedure() {
	local currentSanity
	
	local currentAnonUserid
	currentAnonUserid=$(head -c 24 "$2" 2>/dev/null | tr -dc 'a-zA-Z0-9')
	
	local currentAnonUseridCount
	currentAnonUseridCount=$(echo -n "$currentAnonUserid" | wc -c  | tr -dc '0-9')
	
	[[ "$currentAnonUseridCount" == "24" ]] && currentSanity=true
	
	case "$1" in
		RDYU)
			[[ "$currentSanity" != "true" ]] && return 0
			[[ $(head -c 1 "$dataDir"/anon/"$currentAnonUserid"/internal/readiness) != '1' ]] && echo -n 'FAIL' && return 0
			echo -n 'PASS'
			return 0
			;;
		GKAU)
			[[ "$currentSanity" != "true" ]] && return 0
			cat "$dataDir"/anon/"$currentAnonUserid"/kd/auth 2>/dev/null
			return 0
			;;
		GKDA)
			[[ "$currentSanity" != "true" ]] && return 0
			cat "$dataDir"/anon/"$currentAnonUserid"/kd/data 2>/dev/null
			return 0
			;;
		GKEX)
			[[ "$currentSanity" != "true" ]] && return 0
			cat "$dataDir"/anon/"$currentAnonUserid"/kd/extra 2>/dev/null
			return 0
			;;
		GKCO)
			[[ "$currentSanity" != "true" ]] && return 0
			cat "$dataDir"/anon/"$currentAnonUserid"/kd/counter 2>/dev/null
			return 0
			;;
		GKID)
			[[ "$currentSanity" != "true" ]] && return 0
			cat "$dataDir"/anon/"$currentAnonUserid"/kd/clientid 2>/dev/null
			return 0
			;;
		GKST)
			[[ "$currentSanity" != "true" ]] && return 0
			cat "$dataDir"/anon/"$currentAnonUserid"/kd/status 2>/dev/null
			return 0
			;;
		GKPA)
			[[ "$currentSanity" != "true" ]] && return 0
			cat "$dataDir"/anon/"$currentAnonUserid"/kd/parity 2>/dev/null
			return 0
			;;
		GKEA)
			[[ "$currentSanity" != "true" ]] && return 0
			cat "$dataDir"/anon/"$currentAnonUserid"/kd/excessa 2>/dev/null
			return 0
			;;
		GKEB)
			[[ "$currentSanity" != "true" ]] && return 0
			cat "$dataDir"/anon/"$currentAnonUserid"/kd/excessb 2>/dev/null
			return 0
			;;
		GKEC)
			[[ "$currentSanity" != "true" ]] && return 0
			cat "$dataDir"/anon/"$currentAnonUserid"/kd/excessc 2>/dev/null
			return 0
			;;
		GKED)
			[[ "$currentSanity" != "true" ]] && return 0
			cat "$dataDir"/anon/"$currentAnonUserid"/kd/excessd 2>/dev/null
			return 0
			;;
	esac
	
	return 1
}

_commKey_interpreter_filter_admin_procedure() {
	case "$1" in
		NEWI)
			#New key for new (anonymous) user, immediate.
			! _generate_commFields-anon && return 1
			return 0
			;;
		PURG)
			#Remove users, not ready or without recent LOG entries. Candidate for non-privileged use, or default schedule.
			echo -n 'TODO'
			return 0
			;;
		
		LIST)
			#List keys. Privileged. Mangling all user operations, as well as remote code execution, may be possible.
			# May need to list one user at a time, returning blank for no key at index number.
			echo -n 'TODO'
			return 0
			;;
		NEWL)
			#Add new SSH key to authorized_keys . Privileged. Remote code execution may be possible.
			echo -n 'TODO'
			return 0
			;;
		AKEY)
			#Add key. Prohibited. Any weak key may compromise server.
			echo -n 'FAIL'
			return 0
			;;
			
		DKEY)
			#Disable key. Privileged.
			echo -n 'TODO'
			return 0
			;;
		EKEY)
			#Enable key. Privileged.
			echo -n 'TODO'
			return 0
			;;
		SAFE)
			#Sweep all user data, all users. Privileged.
			echo -n 'TODO'
			return 0
			;;
	esac
	
	return 1
}

_commKey_interpreter_filter_storage_procedure() {
	local currentSanity
	
	local currentFilename
	currentFilename=$(head -c 24 "$2" | tr -dc 'a-zA-Z0-9')
	
	[[ "$currentFilename" != "" ]] && currentSanity=true
	
	# Default, meaningless, unique safety value. Should NEVER be used.
	[[ "$currentFilename" == "" ]] && currentFilename='EgyDyBogjqTLR4IjZo1qovKi'
	
	_set_commFields_fileDir
	
	local currentUnderLimitBool
	currentUnderLimitBool='false'
	local currentOverLimitValue
	if [[ -d "$commfields_fileDir" ]]
	then
		currentOverLimitValue=$(du -s -k "$fileDir"/"EOIoChZqys99eDIY1fX8j4w9" | cut -f1 | cut -f1 -d\  | tr -dc '0-9')
		[[ "$currentOverLimitValue" -lt "650" ]] && currentUnderLimitBool=true
	fi
	
	
	case "$1" in
		STRO)
			[[ "$currentSanity" != "true" ]] && return 0
			#Store file, overwrite.
			[[ "$currentUnderLimitBool" != "true" ]] && return 0
			tail -c +25 "$2" | head -c 6500 > "$commfields_fileDir"/"$currentFilename"
			echo -n 'PASS'
			return 0
			;;
		STRL)
			#Log activity.
			_commKey_interpreter_log_append
			[[ "$currentSanity" != "true" ]] && return 0
			#Store file, overwrite.
			[[ "$currentUnderLimitBool" != "true" ]] && return 0
			tail -c +25 "$2" | head -c 6500  > "$commfields_fileDir"/"$currentFilename"
			echo -n 'PASS'
			return 0
			;;
		RTRV)
			[[ "$currentSanity" != "true" ]] && return 0
			#Retrieve file.
			! [[ -e "$commfields_fileDir"/"$currentFilename" ]] && return 0
			cat "$commfields_fileDir"/"$currentFilename"
			return 0
			;;
		RTRL)
			#Log activity.
			_commKey_interpreter_log_append
			[[ "$currentSanity" != "true" ]] && return 0
			#Retrieve file.
			! [[ -e "$commfields_fileDir"/"$currentFilename" ]] && return 0
			cat "$commfields_fileDir"/"$currentFilename"
			return 0
			;;
		RMFF)
			[[ "$currentSanity" != "true" ]] && return 0
			#Delete file.
			! [[ -e "$commfields_fileDir"/"$currentFilename" ]] && return 0
			rm -f "$commfields_fileDir"/"$currentFilename"
			return 0
			;;
		RMFL)
			#Log activity.
			_commKey_interpreter_log_append
			[[ "$currentSanity" != "true" ]] && return 0
			#Delete file.
			! [[ -e "$commfields_fileDir"/"$currentFilename" ]] && return 0
			rm -f "$commfields_fileDir"/"$currentFilename"
			return 0
			;;
		EXTF)
			[[ "$currentSanity" != "true" ]] && return 0
			#"PASS" if file exists. Blank, or "FAIL", else.
			! [[ -e "$commfields_fileDir"/"$currentFilename" ]] && return 0
			echo -n 'PASS'
			return 0
			;;
		EXTL)
			#Log activity.
			_commKey_interpreter_log_append
			[[ "$currentSanity" != "true" ]] && return 0
			#"PASS" if file exists. Blank, or "FAIL", else.
			! [[ -e "$commfields_fileDir"/"$currentFilename" ]] && return 0
			echo -n 'PASS'
			return 0
			;;
		LSFS)
			# Will list user files.
			[[ -e "$commfields_fileDir" ]] && [[ -d "$commfields_fileDir" ]] && ls -1 "$commfields_fileDir"/
			return 0
			;;
		LSFL)
			#Log activity.
			_commKey_interpreter_log_append
			# Will list user files.
			[[ -e "$commfields_fileDir" ]] && [[ -d "$commfields_fileDir" ]] && ls -1 "$commfields_fileDir"/
			return 0
			;;
		SWPD)
			# Delte all user files.
			[[ -e "$commfields_fileDir" ]] && [[ -d "$commfields_fileDir" ]] && _sweep "$commfields_fileDir"/* > /dev/null 2>&1
			echo 'PASS'
			return 0
			;;
		SWPL)
			#Log activity.
			_commKey_interpreter_log_append
			# Delte all user files.
			[[ -e "$commfields_fileDir" ]] && [[ -d "$commfields_fileDir" ]] && _sweep "$commfields_fileDir"/* > /dev/null 2>&1
			echo 'PASS'
			return 0
			;;
	esac
	
	return 1
}



#"$1" == inFile
#"$2" == outFile
#"$3" == privilege indicator file (optional)
_commKey_interpreter_filter_sequence() {
	_start
	
	[[ $(head -c 1 "$internalFile_readiness") != '1' ]] && _stop 1
	
	local currentCommand
	currentCommand=$(head -c 4 "$1" | tr -dc 'a-zA-Z0-9')
	
	local currentCommandCharCount
	currentCommandCharCount=$(echo -n "$currentCommand" | wc -c | tr -dc '0-9')
	
	#Commands are always 4-letter words.
	[[ "$currentCommandCharCount" != "4" ]] && _messagePlain_bad 'fail: interpreter: command: length' && _stop 1
	
	#Data always follows after 4-letter command and underscore.
	#"CMND_DATADATADATA"
	tail -c +6 "$1" > "$safeTmp"/data
	
	[[ -e "$metaDir"/diag ]] && cp "$safeTmp"/data "$metaDir"/diag/data
	
	local currentOutFile
	currentOutFile="$2"
	
	! _commKey_interpreter_filter_reserved_procedure "$currentCommand" "$safeTmp"/data && _messagePlain_bad 'fail: interpreter: reserved or prohibited' && _stop 1
	
	# Privileged command, provides arbitrary command shell.
	if [[ "$currentCommand" == "BASH" ]]
	then
		_messagePlain_nominal 'interpreter: bash'
		[[ ! -e "$3" ]] && _messagePlain_bad 'fail: interpreter: privilege: missing' && _stop 1
		[[ $(head -c 1 "$3" | tr -dc '0-1') != "1" ]] && _messagePlain_bad 'fail: interpreter: privilege: reject' && _stop 1
		_messagePlain_good 'pass: interpreter: privilege'
		_timeout 3600 bash "$safeTmp"/data 2> /dev/null > "$currentOutFile" 2>&1
		_stop 0
	fi
	
	_commKey_interpreter_filter_storage_procedure "$currentCommand" "$safeTmp"/data 2> /dev/null > "$currentOutFile" && _messagePlain_good 'interpreter: accept: diagnostic' && _stop 0
	
	_commKey_interpreter_filter_diag_procedure "$currentCommand" "$safeTmp"/data 2> /dev/null > "$currentOutFile" && _messagePlain_good 'interpreter: accept: diagnostic' && _stop 0
	
	_commKey_interpreter_filter_record_procedure "$currentCommand" "$safeTmp"/data 2> /dev/null > "$currentOutFile" && _messagePlain_good 'interpreter: accept: record' && _stop 0
	
	_commKey_interpreter_filter_usermanager_procedure "$currentCommand" "$safeTmp"/data "$3" 2> /dev/null > "$currentOutFile" && _messagePlain_good 'interpreter: accept: usermanager' && _stop 0
	
	_commKey_interpreter_filter_getkey_procedure "$currentCommand" "$safeTmp"/data 2> /dev/null > "$currentOutFile" && _messagePlain_good 'interpreter: accept: usermanager' && _stop 0
	
	# DANGER: Privileged command set beyond this point. Privilege escalation capability expected.
	[[ ! -e "$3" ]] && _messagePlain_bad 'fail: interpreter: privilege: missing' && _stop 1
	[[ $(head -c 1 "$3" | tr -dc '0-1') != "1" ]] && _messagePlain_bad 'fail: interpreter: privilege: reject' && _stop 1
	_messagePlain_good 'pass: interpreter: privilege'
	
	
	_commKey_interpreter_filter_admin_procedure "$currentCommand" "$safeTmp"/data 2> /dev/null > "$currentOutFile" && _stop 0
	
	_stop
}

_commKey_interpreter_filter() {
	_messagePlain_nominal 'init: _commKey_interpreter_filter'
	"$scriptAbsoluteLocation" _commKey_interpreter_filter_sequence "$@"
}

_interpreter_filter() {
	_commKey_interpreter_filter "$@"
}

_interpreter() {
	_interpreter_filter "$@"
}


