#!/usr/bin/env bash

[[ "$PATH" != *"/usr/local/bin"* ]] && [[ -e "/usr/local/bin" ]] && export PATH=/usr/local/bin:"$PATH"
[[ "$PATH" != *"/usr/bin"* ]] && [[ -e "/usr/bin" ]] && export PATH=/usr/bin:"$PATH"
[[ "$PATH" != *"/bin:"* ]] && [[ -e "/bin" ]] && export PATH=/bin:"$PATH"

# Rotten.
_test() { false; }
_setup() { false; }
_typeDep() { true; }
_getDep() { true; }
_wantGetDep() { true; }
_if_cygwin() { false; }
_user_log-ub() { false; }
_collect() { false; }
_enter() { false; }



#### from messaging.sh


_color_demo() {
	_messagePlain_request _color_demo
	_messagePlain_nominal _color_demo
	_messagePlain_probe _color_demo
	_messagePlain_probe_expr _color_demo
	_messagePlain_probe_var ubiquitousBashIDshort
	_messagePlain_good _color_demo
	_messagePlain_warn _color_demo
	_messagePlain_bad _color_demo
	_messagePlain_probe_cmd echo _color_demo
	_messagePlain_probe_quoteAddDouble echo _color_demo
	_messagePlain_probe_quoteAddSingle echo _color_demo
	_messageNormal _color_demo
	_messageError _color_demo
	_messageDELAYipc _color_demo
	_messageProcess _color_demo
}
_color_end() {
	( [[ "$current_scriptedIllustrator_markup" == "html" ]] || [[ "$current_scriptedIllustrator_markup" == "mediawiki" ]] ) && echo -e -n '</span>'
	[[ "$current_scriptedIllustrator_markup" == "" ]] && echo -e -n ' \E[0m'
}

_color_begin_request() {
	echo -e -n '\E[0;35m '
}
_color_begin_nominal() {
	echo -e -n '\E[0;36m '
}
_color_begin_probe() {
	echo -e -n '\E[0;34m '
}
_color_begin_probe_noindent() {
	echo -e -n '\E[0;34m'
}
_color_begin_good() {
	echo -e -n '\E[0;32m '
}
_color_begin_warn() {
	echo -e -n '\E[1;33m '
}
_color_begin_bad() {
	echo -e -n '\E[0;31m '
}
_color_begin_Normal() {
	echo -e -n '\E[1;32;46m '
}
_color_begin_Error() {
	echo -e -n '\E[1;33;41m '
}
_color_begin_DELAYipc() {
	echo -e -n '\E[1;33;47m '
}



#Purple. User must do something manually to proceed. NOT to be used for dependency installation requests - use probe, bad, and fail statements for that.
_messagePlain_request() {
	_color_begin_request
	echo -n "$@"
	_color_end
	echo
	return 0
}

#Cyan. Harmless status messages.
#"generic/ubiquitousheader.sh"
_messagePlain_nominal() {
	_color_begin_nominal
	echo -n "$@"
	_color_end
	echo
	return 0
}

#Blue. Diagnostic instrumentation.
#"generic/ubiquitousheader.sh"
_messagePlain_probe() {
	_color_begin_probe
	#_color_begin_probe_noindent
	echo -n "$@"
	_color_end
	echo
	return 0
}
_messagePlain_probe_noindent() {
	#_color_begin_probe
	_color_begin_probe_noindent
	echo -n "$@"
	_color_end
	echo
	return 0
}

#Blue. Diagnostic instrumentation.
#"generic/ubiquitousheader.sh"
_messagePlain_probe_expr() {
	_color_begin_probe
	echo -e -n "$@"
	_color_end
	echo
	return 0
}

#Blue. Diagnostic instrumentation.
#"generic/ubiquitousheader.sh"
_messagePlain_probe_var() {
	_color_begin_probe
	
	echo -n "$1"'= '
	
	eval echo -e -n \$"$1"
	
	_color_end
	echo
	return 0
}
_messageVar() {
	_messagePlain_probe_var "$@"
}

#Green. Working as expected.
#"generic/ubiquitousheader.sh"
_messagePlain_good() {
	_color_begin_good
	echo -n "$@"
	_color_end
	echo
	return 0
}

#Yellow. May or may not be a problem.
#"generic/ubiquitousheader.sh"
_messagePlain_warn() {
	_color_begin_warn
	echo -n "$@"
	_color_end
	echo
	return 0
}

#Red. Will result in missing functionality, reduced performance, etc, but not necessarily program failure overall.
_messagePlain_bad() {
	_color_begin_bad
	echo -n "$@"
	_color_end
	echo
	return 0
}

#Blue. Diagnostic instrumentation.
#Prints "$@" and runs "$@".
# WARNING: Use with care.
_messagePlain_probe_cmd() {
	_color_begin_probe
	
	_safeEcho "$@"
	
	_color_end
	echo
	
	"$@"
	
	return
}
_messageCMD() {
	_messagePlain_probe_cmd "$@"
}

#Blue. Diagnostic instrumentation.
#Prints "$@" with quotes around every parameter.
_messagePlain_probe_quoteAddDouble() {
	_color_begin_probe
	
	_safeEcho_quoteAddDouble "$@"
	
	_color_end
	echo
	
	return
}
_messagePlain_probe_quoteAdd() {
	_messagePlain_probe_quoteAddDouble "$@"
}

#Blue. Diagnostic instrumentation.
#Prints "$@" with single quotes around every parameter.
_messagePlain_probe_quoteAddSingle() {
	_color_begin_probe
	
	_safeEcho_quoteAddSingle "$@"
	
	_color_end
	echo
	
	return
}

#Blue. Diagnostic instrumentation.
#Prints "$@" and runs "$@".
# WARNING: Use with care.
_messagePlain_probe_cmd_quoteAdd() {
	
	_messagePlain_probe_quoteAdd "$@"
	
	"$@"
	
	return
}
_messageCMD_quoteAdd() {
	_messagePlain_probe_cmd_quoteAdd "$@"
}

#Demarcate major steps.
_messageNormal() {
	_color_begin_Normal
	echo -n "$@"
	_color_end
	echo
	return 0
}

#Demarcate major failures.
_messageError() {
	_color_begin_Error
	echo -n "$@"
	_color_end
	echo
	return 0
}

#Demarcate need to fetch/generate dependency automatically - not a failure condition.
_messageNEED() {
	_messageNormal "NEED"
	#echo " NEED "
}

#Demarcate have dependency already, no need to fetch/generate.
_messageHAVE() {
	_messageNormal "HAVE"
	#echo " HAVE "
}

_messageWANT() {
	_messageNormal "WANT"
	#echo " WANT "
}

#Demarcate where PASS/FAIL status cannot be absolutely proven. Rarely appropriate - usual best practice is to simply progress to the next major step.
_messageDONE() {
	_messageNormal "DONE"
	#echo " DONE "
}

_messagePASS() {
	_messageNormal "PASS"
	#echo " PASS "
}

#Major failure. Program stopped.
_messageFAIL() {
	_messageError "FAIL"
	#echo " FAIL "
	_stop 1
	return 0
}

_messageWARN() {
	echo
	echo "$@"
	return 0
}

# Demarcate *any* delay performed to allow 'InterProcess-Communication' connections (perhaps including at least some network or serial port servers).
_messageDELAYipc() {
	_color_begin_DELAYipc
	echo -e -n 'delay: InterProcess-Communication'
	_color_end
	echo
}


_messageProcess() {
	local processString
	processString="$1""..."
	
	local processStringLength
	processStringLength=${#processString}
	
	local currentIteration
	currentIteration=0
	
	local padLength
	let padLength=40-"$processStringLength"
	
	[[ "$processStringLength" -gt "38" ]] && _messageNormal "$processString" && return 0
	
	_color_begin_Normal
	
	echo -n "$processString"
	
	_color_end
	
	while [[ "$currentIteration" -lt "$padLength" ]]
	do
		echo -e -n ' '
		let currentIteration="$currentIteration"+1
	done
	
	return 0
}




#echo -n
_safeEcho() {
	printf '%s' "$1"
	shift
	
	[[ "$@" == "" ]] && return 0
	
	local currentArg
	for currentArg in "$@"
	do
		printf '%s' " "
		printf '%s' "$currentArg"
	done
	return 0
}

#echo
_safeEcho_newline() {
	_safeEcho "$@"
	printf '\n'
}

_safeEcho_quoteAddSingle() {
	# https://tldp.org/LDP/Bash-Beginners-Guide/html/sect_09_07.html
	while (( "$#" )); do
		_safeEcho ' '"'""$1""'"
		shift
	done
}
_safeEcho_quoteAddSingle_newline() {
	_safeEcho_quoteAddSingle "$@"
	printf '\n'
}

_safeEcho_quoteAddDouble() {
	#https://stackoverflow.com/questions/1668649/how-to-keep-quotes-in-bash-arguments
	
	local currentCommandStringPunctuated
	local currentCommandStringParameter
	for currentCommandStringParameter in "$@"; do
		currentCommandStringParameter="${currentCommandStringParameter//\\/\\\\}"
		currentCommandStringPunctuated="$currentCommandStringPunctuated \"${currentCommandStringParameter//\"/\\\"}\""
	done
	
	_safeEcho "$currentCommandStringPunctuated"
}
_safeEcho_quoteAddDouble_newline() {
	_safeEcho_quoteAddDouble "$@"
	printf '\n'
}






#### from messaging.sh





##Parameters
#"--shell", ""
#"--profile"
#"--parent", "--embed", "--return", "--devenv"
#"--call", "--script" "--bypass"
#if [[ "$ub_import" != "" ]]
#then
	#[[ "$ub_import" != "" ]] && export ub_import="" && unset ub_import
	
	#[[ "$importScriptLocation" != "" ]] && export importScriptLocation= && unset importScriptLocation
	#[[ "$importScriptFolder" != "" ]] && export importScriptFolder= && unset importScriptFolder
#fi
#[[ "$ub_import" != "" ]] && export ub_import="" && unset ub_import
#[[ "$ub_import_param" != "" ]] && export ub_import_param="" && unset ub_import_param
#[[ "$ub_import_script" != "" ]] && export ub_import_script="" && unset ub_import_script
#[[ "$ub_loginshell" != "" ]] && export ub_loginshell="" && unset ub_loginshell
ub_import=
ub_import_param=
ub_import_script=
ub_loginshell=


# ATTENTION: Apparently (Portable) Cygwin Bash interprets correctly.
[[ "${BASH_SOURCE[0]}" != "${0}" ]] && ub_import="true"

( [[ "$1" == '--profile' ]] || [[ "$1" == '--script' ]] || [[ "$1" == '--call' ]] || [[ "$1" == '--return' ]] || [[ "$1" == '--devenv' ]] || [[ "$1" == '--shell' ]] || [[ "$1" == '--bypass' ]] || [[ "$1" == '--parent' ]] || [[ "$1" == '--embed' ]] || [[ "$1" == '--compressed' ]] ) && ub_import_param="$1" && shift
( [[ "$0" == "/bin/bash" ]] || [[ "$0" == "-bash" ]] || [[ "$0" == "/usr/bin/bash" ]] || [[ "$0" == "bash" ]] ) && ub_loginshell="true"	#Importing ubiquitous bash into a login shell with "~/.bashrc" is the only known cause for "_getScriptAbsoluteLocation" to return a result such as "/bin/bash".
[[ "$ub_import" == "true" ]] && ! [[ "$ub_loginshell" == "true" ]] && ub_import_script="true"

_messagePlain_probe_expr '$0= '"$0"'\n ''$1= '"$1"'\n ''ub_import= '"$ub_import"'\n ''ub_import_param= '"$ub_import_param"'\n ''ub_import_script= '"$ub_import_script"'\n ''ub_loginshell= '"$ub_loginshell" | _user_log-ub

# DANGER Prohibited import from login shell. Use _setupUbiquitous, call from another script, or manually set importScriptLocation.
# WARNING Import from shell can be detected. Import from script cannot. Asserting that script has been imported is possible. Asserting that script has not been imported is not possible. Users may be protected from interactive mistakes. Script developers are NOT protected.
if [[ "$ub_import_param" == "--profile" ]]
then
	if ( [[ "$profileScriptLocation" == "" ]] ||  [[ "$profileScriptFolder" == "" ]] ) && _messagePlain_bad 'import: profile: missing: profileScriptLocation, missing: profileScriptFolder' | _user_log-ub
	then
		return 1 >/dev/null 2>&1
		exit 1
	fi
elif ( [[ "$ub_import_param" == "--parent" ]] || [[ "$ub_import_param" == "--embed" ]] || [[ "$ub_import_param" == "--return" ]] || [[ "$ub_import_param" == "--devenv" ]] )
then
	if ( [[ "$scriptAbsoluteLocation" == "" ]] || [[ "$scriptAbsoluteFolder" == "" ]] || [[ "$sessionid" == "" ]] ) && _messagePlain_bad 'import: parent: missing: scriptAbsoluteLocation, missing: scriptAbsoluteFolder, missing: sessionid' | _user_log-ub
	then
		return 1 >/dev/null 2>&1
		exit 1
	fi
elif [[ "$ub_import_param" == "--call" ]] || [[ "$ub_import_param" == "--script" ]] || [[ "$ub_import_param" == "--bypass" ]] || [[ "$ub_import_param" == "--shell" ]] || [[ "$ub_import_param" == "--compressed" ]] || ( [[ "$ub_import" == "true" ]] && [[ "$ub_import_param" == "" ]] )
then
	if ( [[ "$importScriptLocation" == "" ]] || [[ "$importScriptFolder" == "" ]] ) && _messagePlain_bad 'import: call: missing: importScriptLocation, missing: importScriptFolder' | _user_log-ub
	then
		return 1 >/dev/null 2>&1
		exit 1
	fi
elif [[ "$ub_import" != "true" ]]	#"--shell", ""
then
	_messagePlain_warn 'import: undetected: cannot determine if imported' | _user_log-ub
	true #no problem
else	#FAIL, implies [[ "$ub_import" == "true" ]]
	_messagePlain_bad 'import: fall: fail' | _user_log-ub
	return 1 >/dev/null 2>&1
	exit 1
fi

_sep() {
	echo '________________________________________'
}

#####Utilities

_test_getAbsoluteLocation_sequence() {
	_start scriptLocal_mkdir_disable
	
	local testScriptLocation_actual
	local testScriptLocation
	local testScriptFolder
	
	local testLocation_actual
	local testLocation
	local testFolder
	
	#script location/folder work directories
	mkdir -p "$safeTmp"/sAL_dir
	cp "$scriptAbsoluteLocation" "$safeTmp"/sAL_dir/script
	ln -s "$safeTmp"/sAL_dir/script "$safeTmp"/sAL_dir/lnk
	[[ ! -e "$safeTmp"/sAL_dir/script ]] && _stop 1
	[[ ! -e "$safeTmp"/sAL_dir/lnk ]] && _stop 1
	
	ln -s "$safeTmp"/sAL_dir "$safeTmp"/sAL_lnk
	[[ ! -e "$safeTmp"/sAL_lnk/script ]] && _stop 1
	[[ ! -e "$safeTmp"/sAL_lnk/lnk ]] && _stop 1
	
	#_getScriptAbsoluteLocation
	testScriptLocation_actual=$("$safeTmp"/sAL_dir/script _getScriptAbsoluteLocation)
	[[ "$safeTmp"/sAL_dir/script != "$testScriptLocation_actual" ]] && echo 'crit: "$safeTmp"/sAL_dir/script != "$testScriptLocation_actual"' && _stop 1
	
	testScriptLocation=$("$safeTmp"/sAL_dir/script _getScriptAbsoluteLocation)
	[[ "$testScriptLocation" != "$testScriptLocation_actual" ]] && echo 'crit: ! location "$safeTmp"/sAL_dir/script' && _stop 1
	testScriptLocation=$("$safeTmp"/sAL_dir/lnk _getScriptAbsoluteLocation)
	[[ "$testScriptLocation" != "$testScriptLocation_actual" ]] && echo 'crit: ! location "$safeTmp"/sAL_dir/lnk' && _stop 1
	
	testScriptLocation=$("$safeTmp"/sAL_lnk/script _getScriptAbsoluteLocation)
	[[ "$testScriptLocation" != "$testScriptLocation_actual" ]] && echo 'crit: ! location "$safeTmp"/sAL_lnk/script' && _stop 1
	testScriptLocation=$("$safeTmp"/sAL_lnk/lnk _getScriptAbsoluteLocation)
	[[ "$testScriptLocation" != "$testScriptLocation_actual" ]] && echo 'crit: ! location "$safeTmp"/sAL_lnk/lnk' && _stop 1
	
	#_getScriptAbsoluteFolder
	testScriptFolder_actual=$("$safeTmp"/sAL_dir/script _getScriptAbsoluteFolder)
	[[ "$safeTmp"/sAL_dir != "$testScriptFolder_actual" ]] && echo 'crit: "$safeTmp"/sAL_dir != "$testScriptFolder_actual"' && _stop 1
	
	testScriptFolder=$("$safeTmp"/sAL_dir/script _getScriptAbsoluteFolder)
	[[ "$testScriptFolder" != "$testScriptFolder_actual" ]] && echo 'crit: ! folder "$safeTmp"/sAL_dir/script' && _stop 1
	testScriptFolder=$("$safeTmp"/sAL_dir/lnk _getScriptAbsoluteFolder)
	[[ "$testScriptFolder" != "$testScriptFolder_actual" ]] && echo 'crit: ! folder "$safeTmp"/sAL_dir/lnk' && _stop 1
	
	testScriptFolder=$("$safeTmp"/sAL_lnk/script _getScriptAbsoluteFolder)
	[[ "$testScriptFolder" != "$testScriptFolder_actual" ]] && echo 'crit: ! folder "$safeTmp"/sAL_lnk/script' && _stop 1
	testScriptFolder=$("$safeTmp"/sAL_lnk/lnk _getScriptAbsoluteFolder)
	[[ "$testScriptFolder" != "$testScriptFolder_actual" ]] && echo 'crit: ! folder "$safeTmp"/sAL_lnk/lnk' && _stop 1
	
	
	#_getAbsoluteLocation
	testLocation_actual=$("$safeTmp"/sAL_dir/script _getAbsoluteLocation "$safeTmp"/sAL_dir/script)
	[[ "$safeTmp"/sAL_dir/script != "$testLocation_actual" ]] && echo 'crit: "$safeTmp"/sAL_dir/script != "$testLocation_actual"' && _stop 1
	
	testLocation=$("$safeTmp"/sAL_dir/script _getAbsoluteLocation "$safeTmp"/sAL_dir/script)
	[[ "$testLocation" != "$testLocation_actual" ]] && echo 'crit: ! location "$safeTmp"/sAL_dir/script' && _stop 1
	testLocation=$("$safeTmp"/sAL_dir/lnk _getAbsoluteLocation "$safeTmp"/sAL_dir/lnk)
	[[ "$testLocation" != "$testLocation_actual" ]] && echo 'crit: ! location "$safeTmp"/sAL_dir/lnk' && _stop 1
	
	testLocation=$("$safeTmp"/sAL_lnk/script _getAbsoluteLocation "$safeTmp"/sAL_lnk/script)
	[[ "$testLocation" != "$testLocation_actual" ]] && echo 'crit: ! location "$safeTmp"/sAL_lnk/script' && _stop 1
	testLocation=$("$safeTmp"/sAL_lnk/lnk _getAbsoluteLocation "$safeTmp"/sAL_lnk/lnk)
	[[ "$testLocation" != "$testLocation_actual" ]] && echo 'crit: ! location "$safeTmp"/sAL_lnk/lnk' && _stop 1
	
	#_getAbsoluteFolder
	testFolder_actual=$("$safeTmp"/sAL_dir/script _getAbsoluteFolder "$safeTmp"/sAL_dir/script)
	[[ "$safeTmp"/sAL_dir != "$testFolder_actual" ]] && echo 'crit: "$safeTmp"/sAL_dir != "$testFolder_actual"' && _stop 1
	
	testFolder=$("$safeTmp"/sAL_dir/script _getAbsoluteFolder "$safeTmp"/sAL_dir/script)
	[[ "$testFolder" != "$testFolder_actual" ]] && echo 'crit: ! folder "$safeTmp"/sAL_dir/script' && _stop 1
	testFolder=$("$safeTmp"/sAL_dir/lnk _getAbsoluteFolder "$safeTmp"/sAL_dir/script)
	[[ "$testFolder" != "$testFolder_actual" ]] && echo 'crit: ! folder "$safeTmp"/sAL_dir/lnk' && _stop 1
	
	testFolder=$("$safeTmp"/sAL_lnk/script _getAbsoluteFolder "$safeTmp"/sAL_lnk/script)
	[[ "$testFolder" != "$testFolder_actual" ]] && echo 'crit: ! folder "$safeTmp"/sAL_lnk/script' && _stop 1
	testFolder=$("$safeTmp"/sAL_lnk/lnk _getAbsoluteFolder "$safeTmp"/sAL_lnk/script)
	[[ "$testFolder" != "$testFolder_actual" ]] && echo 'crit: ! folder "$safeTmp"/sAL_lnk/lnk' && _stop 1
	
	_stop
}

_test_getAbsoluteLocation() {
	"$scriptAbsoluteLocation" _test_getAbsoluteLocation_sequence "$@"
	[[ "$?" != "0" ]] && _stop 1
	return 0
}

#https://unix.stackexchange.com/questions/293892/realpath-l-vs-p
_test_realpath_L_s_sequence() {
	_start scriptLocal_mkdir_disable
	local functionEntryPWD
	functionEntryPWD="$PWD"
	
	
	local testPath_actual
	local testPath
	
	mkdir -p "$safeTmp"/src
	mkdir -p "$safeTmp"/sub
	ln -s  "$safeTmp"/src "$safeTmp"/sub/lnk
	
	echo > "$safeTmp"/sub/point
	
	ln -s "$safeTmp"/sub/point "$safeTmp"/sub/lnk/ref
	
	#correct
	#"$safeTmp"/sub/ref
	#realpath -L "$safeTmp"/sub/lnk/../ref
	
	#default, wrong
	#"$safeTmp"/ref
	#realpath -P "$safeTmp"/sub/lnk/../ref
	#echo -n '>'
	#readlink -f "$safeTmp"/sub/lnk/../ref
	
	testPath_actual="$safeTmp"/sub/ref
	
	cd "$functionEntryPWD"
	testPath=$(_realpath_L "$safeTmp"/sub/lnk/../ref)
	[[ "$testPath" != "$testPath_actual" ]] && echo 'crit: ! _realpath_L' && _stop 1
	
	cd "$safeTmp"
	testPath=$(_realpath_L ./sub/lnk/../ref)
	[[ "$testPath" != "$testPath_actual" ]] && echo 'crit: ! _realpath_L' && _stop 1
	
	#correct
	#"$safeTmp"/sub/lnk/ref
	#realpath -L -s "$safeTmp"/sub/lnk/ref
	
	#default, wrong for some use cases
	#"$safeTmp"/sub/point
	#realpath -L "$safeTmp"/sub/lnk/ref
	#echo -n '>'
	#readlink -f "$safeTmp"/sub/lnk/ref
	
	testPath_actual="$safeTmp"/sub/lnk/ref
	
	cd "$functionEntryPWD"
	testPath=$(_realpath_L_s "$safeTmp"/sub/lnk/ref)
	[[ "$testPath" != "$testPath_actual" ]] && echo 'crit: ! _realpath_L_s' && _stop 1
	
	cd "$safeTmp"
	testPath=$(_realpath_L_s ./sub/lnk/ref)
	[[ "$testPath" != "$testPath_actual" ]] && echo 'crit: ! _realpath_L_s' && _stop 1
	
	
	cd "$functionEntryPWD"
	_stop
}

_test_realpath_L_s() {
	#Optional safety check. Nonconformant realpath solution should be caught by synthetic test cases.
	#_compat_realpath
	#  ! [[ -e "$compat_realpath_bin" ]] && [[ "$compat_realpath_bin" != "" ]] && echo 'crit: missing: realpath' && _stop 1
	
	"$scriptAbsoluteLocation" _test_realpath_L_s_sequence "$@"
	[[ "$?" != "0" ]] && _stop 1
	return 0
}

_test_realpath_L() {
	_test_realpath_L_s "$@"
}

_test_realpath() {
	_test_realpath_L_s "$@"
}

_test_readlink_f_sequence() {
	_start scriptLocal_mkdir_disable
	
	echo > "$safeTmp"/realFile
	ln -s "$safeTmp"/realFile "$safeTmp"/linkA
	ln -s "$safeTmp"/linkA "$safeTmp"/linkB
	
	local currentReadlinkResult
	currentReadlinkResult=$(readlink -f "$safeTmp"/linkB)
	
	local currentReadlinkResultBasename
	currentReadlinkResultBasename=$(basename "$currentReadlinkResult")
	
	if [[ "$currentReadlinkResultBasename" != "realFile" ]]
	then
		#echo 'fail: readlink -f'
		_stop 1
	fi
	
	_stop 0
}

_test_readlink_f() {
	if ! "$scriptAbsoluteLocation" _test_readlink_f_sequence
	then
		# May fail through MSW network drive provided by '_userVBox' .
		uname -a | grep -i cygwin > /dev/null 2>&1 && echo 'warn: broken (cygwin): readlink -f' && return 1
		echo 'fail: readlink -f'
		_stop 1
	fi
	
	return 0
}

_compat_realpath() {
	[[ -e "$compat_realpath_bin" ]] && [[ "$compat_realpath_bin" != "" ]] && return 0
	
	#Workaround, Mac. See https://github.com/mirage335/ubiquitous_bash/issues/1 .
	export compat_realpath_bin=/opt/local/libexec/gnubin/realpath
	[[ -e "$compat_realpath_bin" ]] && [[ "$compat_realpath_bin" != "" ]] && return 0
	
	export compat_realpath_bin=$(type -p realpath)
	[[ -e "$compat_realpath_bin" ]] && [[ "$compat_realpath_bin" != "" ]] && return 0
	
	export compat_realpath_bin=/bin/realpath
	[[ -e "$compat_realpath_bin" ]] && [[ "$compat_realpath_bin" != "" ]] && return 0
	
	export compat_realpath_bin=/usr/bin/realpath
	[[ -e "$compat_realpath_bin" ]] && [[ "$compat_realpath_bin" != "" ]] && return 0
	
	# ATTENTION
	# Command "readlink -f" or text processing can be used as fallbacks to obtain absolute path
	# https://stackoverflow.com/questions/3572030/bash-script-absolute-path-with-osx
	
	export compat_realpath_bin=""
	return 1
}

_compat_realpath_run() {
	! _compat_realpath && return 1
	
	"$compat_realpath_bin" "$@"
}

_realpath_L() {
	if ! _compat_realpath_run -L . > /dev/null 2>&1
	then
		readlink -f "$@"
		return
	fi
	
	realpath -L "$@"
}

_realpath_L_s() {
	if ! _compat_realpath_run -L . > /dev/null 2>&1
	then
		readlink -f "$@"
		return
	fi
	
	realpath -L -s "$@"
}


_cygwin_translation_rootFileParameter() {
	if ! uname -a | grep -i cygwin > /dev/null 2>&1
	then
		echo "$0"
		return 0
	fi
	
	
	local currentScriptLocation
	currentScriptLocation="$0"
	
	# CAUTION: Lookup table is used to avoid pulling in any additional dependencies. Additionally, Cygwin apparently may ignore letter case of path .
	
	[[ "$currentScriptLocation" == 'A:'* ]] && currentScriptLocation=${currentScriptLocation/A\://cygdrive/a} && echo "$currentScriptLocation" && return 0
	[[ "$currentScriptLocation" == 'B:'* ]] && currentScriptLocation=${currentScriptLocation/B\://cygdrive/b} && echo "$currentScriptLocation" && return 0
	[[ "$currentScriptLocation" == 'C:'* ]] && currentScriptLocation=${currentScriptLocation/C\://cygdrive/c} && echo "$currentScriptLocation" && return 0
	[[ "$currentScriptLocation" == 'D:'* ]] && currentScriptLocation=${currentScriptLocation/D\://cygdrive/d} && echo "$currentScriptLocation" && return 0
	[[ "$currentScriptLocation" == 'E:'* ]] && currentScriptLocation=${currentScriptLocation/E\://cygdrive/e} && echo "$currentScriptLocation" && return 0
	[[ "$currentScriptLocation" == 'F:'* ]] && currentScriptLocation=${currentScriptLocation/F\://cygdrive/f} && echo "$currentScriptLocation" && return 0
	[[ "$currentScriptLocation" == 'G:'* ]] && currentScriptLocation=${currentScriptLocation/G\://cygdrive/g} && echo "$currentScriptLocation" && return 0
	[[ "$currentScriptLocation" == 'H:'* ]] && currentScriptLocation=${currentScriptLocation/H\://cygdrive/h} && echo "$currentScriptLocation" && return 0
	[[ "$currentScriptLocation" == 'I:'* ]] && currentScriptLocation=${currentScriptLocation/I\://cygdrive/i} && echo "$currentScriptLocation" && return 0
	[[ "$currentScriptLocation" == 'J:'* ]] && currentScriptLocation=${currentScriptLocation/J\://cygdrive/j} && echo "$currentScriptLocation" && return 0
	[[ "$currentScriptLocation" == 'K:'* ]] && currentScriptLocation=${currentScriptLocation/K\://cygdrive/k} && echo "$currentScriptLocation" && return 0
	[[ "$currentScriptLocation" == 'L:'* ]] && currentScriptLocation=${currentScriptLocation/L\://cygdrive/l} && echo "$currentScriptLocation" && return 0
	[[ "$currentScriptLocation" == 'M:'* ]] && currentScriptLocation=${currentScriptLocation/M\://cygdrive/m} && echo "$currentScriptLocation" && return 0
	[[ "$currentScriptLocation" == 'N:'* ]] && currentScriptLocation=${currentScriptLocation/N\://cygdrive/n} && echo "$currentScriptLocation" && return 0
	[[ "$currentScriptLocation" == 'O:'* ]] && currentScriptLocation=${currentScriptLocation/O\://cygdrive/o} && echo "$currentScriptLocation" && return 0
	[[ "$currentScriptLocation" == 'P:'* ]] && currentScriptLocation=${currentScriptLocation/P\://cygdrive/p} && echo "$currentScriptLocation" && return 0
	[[ "$currentScriptLocation" == 'Q:'* ]] && currentScriptLocation=${currentScriptLocation/Q\://cygdrive/q} && echo "$currentScriptLocation" && return 0
	[[ "$currentScriptLocation" == 'R:'* ]] && currentScriptLocation=${currentScriptLocation/R\://cygdrive/r} && echo "$currentScriptLocation" && return 0
	[[ "$currentScriptLocation" == 'S:'* ]] && currentScriptLocation=${currentScriptLocation/S\://cygdrive/s} && echo "$currentScriptLocation" && return 0
	[[ "$currentScriptLocation" == 'T:'* ]] && currentScriptLocation=${currentScriptLocation/T\://cygdrive/t} && echo "$currentScriptLocation" && return 0
	[[ "$currentScriptLocation" == 'U:'* ]] && currentScriptLocation=${currentScriptLocation/U\://cygdrive/u} && echo "$currentScriptLocation" && return 0
	[[ "$currentScriptLocation" == 'V:'* ]] && currentScriptLocation=${currentScriptLocation/V\://cygdrive/v} && echo "$currentScriptLocation" && return 0
	[[ "$currentScriptLocation" == 'W:'* ]] && currentScriptLocation=${currentScriptLocation/W\://cygdrive/w} && echo "$currentScriptLocation" && return 0
	[[ "$currentScriptLocation" == 'X:'* ]] && currentScriptLocation=${currentScriptLocation/X\://cygdrive/x} && echo "$currentScriptLocation" && return 0
	[[ "$currentScriptLocation" == 'Y:'* ]] && currentScriptLocation=${currentScriptLocation/Y\://cygdrive/y} && echo "$currentScriptLocation" && return 0
	[[ "$currentScriptLocation" == 'Z:'* ]] && currentScriptLocation=${currentScriptLocation/Z\://cygdrive/z} && echo "$currentScriptLocation" && return 0
	
	[[ "$currentScriptLocation" == 'a:'* ]] && currentScriptLocation=${currentScriptLocation/a\://cygdrive/a} && echo "$currentScriptLocation" && return 0
	[[ "$currentScriptLocation" == 'b:'* ]] && currentScriptLocation=${currentScriptLocation/b\://cygdrive/b} && echo "$currentScriptLocation" && return 0
	[[ "$currentScriptLocation" == 'c:'* ]] && currentScriptLocation=${currentScriptLocation/c\://cygdrive/c} && echo "$currentScriptLocation" && return 0
	[[ "$currentScriptLocation" == 'd:'* ]] && currentScriptLocation=${currentScriptLocation/d\://cygdrive/d} && echo "$currentScriptLocation" && return 0
	[[ "$currentScriptLocation" == 'e:'* ]] && currentScriptLocation=${currentScriptLocation/e\://cygdrive/e} && echo "$currentScriptLocation" && return 0
	[[ "$currentScriptLocation" == 'f:'* ]] && currentScriptLocation=${currentScriptLocation/f\://cygdrive/f} && echo "$currentScriptLocation" && return 0
	[[ "$currentScriptLocation" == 'g:'* ]] && currentScriptLocation=${currentScriptLocation/g\://cygdrive/g} && echo "$currentScriptLocation" && return 0
	[[ "$currentScriptLocation" == 'h:'* ]] && currentScriptLocation=${currentScriptLocation/h\://cygdrive/h} && echo "$currentScriptLocation" && return 0
	[[ "$currentScriptLocation" == 'i:'* ]] && currentScriptLocation=${currentScriptLocation/i\://cygdrive/i} && echo "$currentScriptLocation" && return 0
	[[ "$currentScriptLocation" == 'j:'* ]] && currentScriptLocation=${currentScriptLocation/j\://cygdrive/j} && echo "$currentScriptLocation" && return 0
	[[ "$currentScriptLocation" == 'k:'* ]] && currentScriptLocation=${currentScriptLocation/k\://cygdrive/k} && echo "$currentScriptLocation" && return 0
	[[ "$currentScriptLocation" == 'l:'* ]] && currentScriptLocation=${currentScriptLocation/l\://cygdrive/l} && echo "$currentScriptLocation" && return 0
	[[ "$currentScriptLocation" == 'm:'* ]] && currentScriptLocation=${currentScriptLocation/m\://cygdrive/m} && echo "$currentScriptLocation" && return 0
	[[ "$currentScriptLocation" == 'n:'* ]] && currentScriptLocation=${currentScriptLocation/n\://cygdrive/n} && echo "$currentScriptLocation" && return 0
	[[ "$currentScriptLocation" == 'o:'* ]] && currentScriptLocation=${currentScriptLocation/o\://cygdrive/o} && echo "$currentScriptLocation" && return 0
	[[ "$currentScriptLocation" == 'p:'* ]] && currentScriptLocation=${currentScriptLocation/p\://cygdrive/p} && echo "$currentScriptLocation" && return 0
	[[ "$currentScriptLocation" == 'q:'* ]] && currentScriptLocation=${currentScriptLocation/q\://cygdrive/q} && echo "$currentScriptLocation" && return 0
	[[ "$currentScriptLocation" == 'r:'* ]] && currentScriptLocation=${currentScriptLocation/r\://cygdrive/r} && echo "$currentScriptLocation" && return 0
	[[ "$currentScriptLocation" == 's:'* ]] && currentScriptLocation=${currentScriptLocation/s\://cygdrive/s} && echo "$currentScriptLocation" && return 0
	[[ "$currentScriptLocation" == 't:'* ]] && currentScriptLocation=${currentScriptLocation/t\://cygdrive/t} && echo "$currentScriptLocation" && return 0
	[[ "$currentScriptLocation" == 'u:'* ]] && currentScriptLocation=${currentScriptLocation/u\://cygdrive/u} && echo "$currentScriptLocation" && return 0
	[[ "$currentScriptLocation" == 'v:'* ]] && currentScriptLocation=${currentScriptLocation/v\://cygdrive/v} && echo "$currentScriptLocation" && return 0
	[[ "$currentScriptLocation" == 'w:'* ]] && currentScriptLocation=${currentScriptLocation/w\://cygdrive/w} && echo "$currentScriptLocation" && return 0
	[[ "$currentScriptLocation" == 'x:'* ]] && currentScriptLocation=${currentScriptLocation/x\://cygdrive/x} && echo "$currentScriptLocation" && return 0
	[[ "$currentScriptLocation" == 'y:'* ]] && currentScriptLocation=${currentScriptLocation/y\://cygdrive/y} && echo "$currentScriptLocation" && return 0
	[[ "$currentScriptLocation" == 'z:'* ]] && currentScriptLocation=${currentScriptLocation/z\://cygdrive/z} && echo "$currentScriptLocation" && return 0
	
	
	echo "$currentScriptLocation" && return 0
}


#Critical prerequsites.
_getAbsolute_criticalDep() {
	#  ! type realpath > /dev/null 2>&1 && return 1
	! type readlink > /dev/null 2>&1 && return 1
	! type dirname > /dev/null 2>&1 && return 1
	! type basename > /dev/null 2>&1 && return 1
	
	#Known to succeed under BusyBox (OpenWRT), NetBSD, and common Linux variants. No known failure modes. Extra precaution.
	! readlink -f . > /dev/null 2>&1 && return 1
	
	! echo 'qwerty123.git' | grep '\.git$' > /dev/null 2>&1 && return 1
	echo 'qwerty1234git' | grep '\.git$' > /dev/null 2>&1 && return 1
	
	return 0
}
! _getAbsolute_criticalDep && exit 1

#Retrieves absolute path of current script, while maintaining symlinks, even when "./" would translate with "readlink -f" into something disregarding symlinked components in $PWD.
#However, will dereference symlinks IF the script location itself is a symlink. This is to allow symlinking to scripts to function normally.
#Suitable for allowing scripts to find other scripts they depend on. May look like an ugly hack, but it has proven reliable over the years.
_getScriptAbsoluteLocation() {
	if [[ "$0" == "-"* ]]
	then
		return 1
	fi
	
	local currentScriptLocation
	currentScriptLocation="$0"
	uname -a | grep -i cygwin > /dev/null 2>&1 && type _cygwin_translation_rootFileParameter > /dev/null 2>&1 && currentScriptLocation=$(_cygwin_translation_rootFileParameter)
	
	
	local absoluteLocation
	if [[ (-e $PWD\/$currentScriptLocation) && ($currentScriptLocation != "") ]] && [[ "$currentScriptLocation" != "/"* ]]
	then
		absoluteLocation="$PWD"\/"$currentScriptLocation"
		absoluteLocation=$(_realpath_L_s "$absoluteLocation")
	else
		absoluteLocation=$(_realpath_L "$currentScriptLocation")
	fi
	
	if [[ -h "$absoluteLocation" ]]
	then
		absoluteLocation=$(readlink -f "$absoluteLocation")
		absoluteLocation=$(_realpath_L "$absoluteLocation")
	fi
	echo $absoluteLocation
}
alias getScriptAbsoluteLocation=_getScriptAbsoluteLocation

#Retrieves absolute path of current script, while maintaining symlinks, even when "./" would translate with "readlink -f" into something disregarding symlinked components in $PWD.
#Suitable for allowing scripts to find other scripts they depend on.
_getScriptAbsoluteFolder() {
	if [[ "$0" == "-"* ]]
	then
		return 1
	fi
	
	dirname "$(_getScriptAbsoluteLocation)"
}
alias getScriptAbsoluteFolder=_getScriptAbsoluteFolder

#Retrieves absolute path of parameter, while maintaining symlinks, even when "./" would translate with "readlink -f" into something disregarding symlinked components in $PWD.
#Suitable for finding absolute paths, when it is desirable not to interfere with symlink specified folder structure.
_getAbsoluteLocation() {
	if [[ "$1" == "-"* ]]
	then
		return 1
	fi
	
	if [[ "$1" == "" ]]
	then
		echo
		return
	fi
	
	local absoluteLocation
	if [[ (-e $PWD\/$1) && ($1 != "") ]] && [[ "$1" != "/"* ]]
	then
		absoluteLocation="$PWD"\/"$1"
		absoluteLocation=$(_realpath_L_s "$absoluteLocation")
	else
		absoluteLocation=$(_realpath_L "$1")
	fi
	echo "$absoluteLocation"
}
alias getAbsoluteLocation=_getAbsoluteLocation

#Retrieves absolute path of parameter, while maintaining symlinks, even when "./" would translate with "readlink -f" into something disregarding symlinked components in $PWD.
#Suitable for finding absolute paths, when it is desirable not to interfere with symlink specified folder structure.
_getAbsoluteFolder() {
	if [[ "$1" == "-"* ]]
	then
		return 1
	fi
	
	local absoluteLocation=$(_getAbsoluteLocation "$1")
	dirname "$absoluteLocation"
}
alias getAbsoluteLocation=_getAbsoluteLocation

_getScriptLinkName() {
	! [[ -e "$0" ]] && return 1
	! [[ -L "$0" ]] && return 1
	
	! type basename > /dev/null 2>&1 && return 1
	
	local scriptLinkName
	scriptLinkName=$(basename "$0")
	
	[[ "$scriptLinkName" == "" ]] && return 1
	echo "$scriptLinkName"
}

#https://unix.stackexchange.com/questions/27021/how-to-name-a-file-in-the-deepest-level-of-a-directory-tree?answertab=active#tab-top
_filter_lowestPath() {
	awk -F'/' 'NF > depth {
depth = NF;
deepest = $0;
}
END {
print deepest;
}'
}

#https://stackoverflow.com/questions/1086907/can-find-or-any-other-tool-search-for-files-breadth-first
_filter_highestPath() {
	awk -F'/' '{print "", NF, $F}' | sort -n | awk '{print $2}' | head -n 1
}

_recursion_guard() {
	! [[ -e "$1" ]] && return 1
	
	! type "$1" >/dev/null 2>&1 && return 1
	
	local launchGuardScriptAbsoluteLocation
	launchGuardScriptAbsoluteLocation=$(_getScriptAbsoluteLocation)
	local launchGuardTestAbsoluteLocation
	launchGuardTestAbsoluteLocation=$(_getAbsoluteLocation "$1")
	[[ "$launchGuardScriptAbsoluteLocation" == "$launchGuardTestAbsoluteLocation" ]] && return 1
	
	return 0
}

#Checks whether command or function is available.
# DANGER Needed by safeRMR .
_checkDep() {
	if ! type "$1" >/dev/null 2>&1
	then
		echo "$1" missing
		_stop 1
	fi
}

_tryExec() {
	type "$1" >/dev/null 2>&1 && "$1"
}

_tryExecFull() {
	type "$1" >/dev/null 2>&1 && "$@"
}

#Fails if critical global variables point to nonexistant locations. Code may be duplicated elsewhere for extra safety.
_failExec() {
	[[ ! -e "$scriptAbsoluteLocation" ]] && return 1
	[[ ! -e "$scriptAbsoluteFolder" ]] && return 1
	return 0
}

#Portable sanity checked "rm -r" command.
# DANGER Last line of defense against catastrophic errors where "rm -r" or similar would be used!
# WARNING Not foolproof. Use to guard against systematic errors, not carelessness.
# WARNING Do NOT rely upon outside of internal programmatic usage inside script!
# WARNING Consider using this function even if program control flow can be proven safe. Redundant checks just might catch catastrophic memory errors.
#"$1" == directory to remove
_safeRMR() {
	! type _getAbsolute_criticalDep > /dev/null 2>&1 && return 1
	! _getAbsolute_criticalDep && return 1
	
	#Fail sooner, avoiding irrelevant error messages. Especially important to cases where an upstream process has already removed the "$safeTmp" directory of a downstream process which reaches "_stop" later.
	! [[ -e "$1" ]] && return 1
	
	[[ ! -e "$scriptAbsoluteLocation" ]] && return 1
	[[ ! -e "$scriptAbsoluteFolder" ]] && return 1
	_failExec || return 1
	
	#if [[ ! -e "$0" ]]
	#then
	#	return 1
	#fi
	
	if [[ "$1" == "" ]]
	then
		return 1
	fi
	
	if [[ "$1" == "/" ]]
	then
		return 1
	fi
	
	if [[ "$1" == "-"* ]]
	then
		return 1
	fi
	
	#Denylist.
	[[ "$1" == "/home" ]] && return 1
	[[ "$1" == "/home/" ]] && return 1
	[[ "$1" == "/home/$USER" ]] && return 1
	[[ "$1" == "/home/$USER/" ]] && return 1
	[[ "$1" == "/$USER" ]] && return 1
	[[ "$1" == "/$USER/" ]] && return 1
	
	[[ "$1" == "/tmp" ]] && return 1
	[[ "$1" == "/tmp/" ]] && return 1
	
	[[ "$1" == "$HOME" ]] && return 1
	[[ "$1" == "$HOME/" ]] && return 1
	
	#Allowlist.
	local safeToRM=false
	
	local safeScriptAbsoluteFolder
	#safeScriptAbsoluteFolder="$(_getScriptAbsoluteFolder)"
	safeScriptAbsoluteFolder="$scriptAbsoluteFolder"
	
	[[ "$1" == "./"* ]] && [[ "$PWD" == "$safeScriptAbsoluteFolder"* ]] && safeToRM="true"
	
	[[ "$1" == "$safeScriptAbsoluteFolder"* ]] && safeToRM="true"
	
	#[[ "$1" == "/home/$USER"* ]] && safeToRM="true"
	[[ "$1" == "/tmp/"* ]] && safeToRM="true"
	
	# WARNING: Allows removal of temporary folders created by current ubiquitous bash session only.
	[[ "$sessionid" != "" ]] && [[ "$1" == *"$sessionid"* ]] && safeToRM="true"
	[[ "$tmpSelf" != "$safeScriptAbsoluteFolder" ]] && [[ "$sessionid" != "" ]] && [[ "$1" == *$(echo "$sessionid" | head -c 16)* ]] && safeToRM="true"
	#[[ "$tmpSelf" != "$safeScriptAbsoluteFolder" ]] && [[ "$1" == "$tmpSelf"* ]] && safeToRM="true"
	
	# ATTENTION: CAUTION: Unusual Cygwin override to accommodate MSW network drive ( at least when provided by '_userVBox' ) !
	# ATTENTION: Search for verbatim warning to find related workarounds!
	if [[ "$scriptAbsoluteFolder" == '/cygdrive/'* ]] && [[ -e /cygdrive ]] && uname -a | grep -i cygwin > /dev/null 2>&1 && [[ "$scriptAbsoluteFolder" != '/cygdrive/c'* ]] && [[ "$scriptAbsoluteFolder" != '/cygdrive/C'* ]]
	then
		if [[ "$tmpSelf" != "$safeScriptAbsoluteFolder" ]] && [[ "$tmpSelf" != "" ]] && [[ "$tmpSelf" == "/cygdrive/"* ]] && [[ "$tmpSelf" == "$tmpMSW"* ]]
		then
			safeToRM="true"
		fi
	fi

	if [[ -e "$HOME"/.ubtmp ]] && uname -a | grep -i 'microsoft' > /dev/null 2>&1 && uname -a | grep -i 'WSL2' > /dev/null 2>&1
	then
		[[ "$1" == "$HOME"/.ubtmp/* ]] && safeToRM="true"
		[[ "$1" == "./"* ]] && [[ "$PWD" == "$HOME"/.ubtmp* ]] && safeToRM="true"
	fi
	
	
	[[ "$safeToRM" == "false" ]] && return 1
	
	#Safeguards/
	[[ "$safeToDeleteGit" != "true" ]] && [[ -d "$1" ]] && [[ -e "$1" ]] && find "$1" 2>/dev/null | grep -i '\.git$' >/dev/null 2>&1 && return 1
	
	#Validate necessary tools were available for path building and checks.
	#  ! type realpath > /dev/null 2>&1 && return 1
	! type readlink > /dev/null 2>&1 && return 1
	! type dirname > /dev/null 2>&1 && return 1
	! type basename > /dev/null 2>&1 && return 1
	
	if [[ -e "$1" ]]
	then
		#sleep 0
		#echo "$1"
		# WARNING Recommend against adding any non-portable flags.
		rm -rf "$1" > /dev/null 2>&1
	fi
}

#Portable sanity checking for less, but, dangerous, commands.
# WARNING Not foolproof. Use to guard against systematic errors, not carelessness.
# WARNING Do NOT rely upon outside of internal programmatic usage inside script!
#"$1" == file/directory path to sanity check
_safePath() {
	! type _getAbsolute_criticalDep > /dev/null 2>&1 && return 1
	! _getAbsolute_criticalDep && return 1
	
	[[ ! -e "$scriptAbsoluteLocation" ]] && return 1
	[[ ! -e "$scriptAbsoluteFolder" ]] && return 1
	_failExec || return 1
	
	#if [[ ! -e "$0" ]]
	#then
	#	return 1
	#fi
	
	if [[ "$1" == "" ]]
	then
		return 1
	fi
	
	if [[ "$1" == "/" ]]
	then
		return 1
	fi
	
	if [[ "$1" == "-"* ]]
	then
		return 1
	fi
	
	#Denylist.
	[[ "$1" == "/home" ]] && return 1
	[[ "$1" == "/home/" ]] && return 1
	[[ "$1" == "/home/$USER" ]] && return 1
	[[ "$1" == "/home/$USER/" ]] && return 1
	[[ "$1" == "/$USER" ]] && return 1
	[[ "$1" == "/$USER/" ]] && return 1
	
	[[ "$1" == "/tmp" ]] && return 1
	[[ "$1" == "/tmp/" ]] && return 1
	
	[[ "$1" == "$HOME" ]] && return 1
	[[ "$1" == "$HOME/" ]] && return 1
	
	#Allowlist.
	local safeToRM=false
	
	local safeScriptAbsoluteFolder
	#safeScriptAbsoluteFolder="$(_getScriptAbsoluteFolder)"
	safeScriptAbsoluteFolder="$scriptAbsoluteFolder"
	
	[[ "$1" == "./"* ]] && [[ "$PWD" == "$safeScriptAbsoluteFolder"* ]] && safeToRM="true"
	
	[[ "$1" == "$safeScriptAbsoluteFolder"* ]] && safeToRM="true"
	
	#[[ "$1" == "/home/$USER"* ]] && safeToRM="true"
	[[ "$1" == "/tmp/"* ]] && safeToRM="true"
	
	# WARNING: Allows removal of temporary folders created by current ubiquitous bash session only.
	[[ "$sessionid" != "" ]] && [[ "$1" == *"$sessionid"* ]] && safeToRM="true"
	[[ "$tmpSelf" != "$safeScriptAbsoluteFolder" ]] && [[ "$sessionid" != "" ]] && [[ "$1" == *$(echo "$sessionid" | head -c 16)* ]] && safeToRM="true"
	#[[ "$tmpSelf" != "$safeScriptAbsoluteFolder" ]] && [[ "$1" == "$tmpSelf"* ]] && safeToRM="true"
	
	
	# ATTENTION: CAUTION: Unusual Cygwin override to accommodate MSW network drive ( at least when provided by '_userVBox' ) !
	# ATTENTION: Search for verbatim warning to find related workarounds!
	if [[ "$scriptAbsoluteFolder" == '/cygdrive/'* ]] && [[ -e /cygdrive ]] && uname -a | grep -i cygwin > /dev/null 2>&1 && [[ "$scriptAbsoluteFolder" != '/cygdrive/c'* ]] && [[ "$scriptAbsoluteFolder" != '/cygdrive/C'* ]]
	then
		if [[ "$tmpSelf" != "$safeScriptAbsoluteFolder" ]] && [[ "$tmpSelf" != "" ]] && [[ "$tmpSelf" == "/cygdrive/"* ]] && [[ "$tmpSelf" == "$tmpMSW"* ]]
		then
			safeToRM="true"
		fi
	fi

	if [[ -e "$HOME"/.ubtmp ]] && uname -a | grep -i 'microsoft' > /dev/null 2>&1 && uname -a | grep -i 'WSL2' > /dev/null 2>&1
	then
		[[ "$1" == "$HOME"/.ubtmp/* ]] && safeToRM="true"
		[[ "$1" == "./"* ]] && [[ "$PWD" == "$HOME"/.ubtmp* ]] && safeToRM="true"
	fi
	
	
	[[ "$safeToRM" == "false" ]] && return 1
	
	#Safeguards/
	[[ "$safeToDeleteGit" != "true" ]] && [[ -d "$1" ]] && [[ -e "$1" ]] && find "$1" 2>/dev/null | grep -i '\.git$' >/dev/null 2>&1 && return 1
	
	#Validate necessary tools were available for path building and checks.
	#  ! type realpath > /dev/null 2>&1 && return 1
	! type readlink > /dev/null 2>&1 && return 1
	! type dirname > /dev/null 2>&1 && return 1
	! type basename > /dev/null 2>&1 && return 1
	
	if [[ -e "$1" ]]
	then
		#sleep 0
		#echo "$1"
		# WARNING Recommend against adding any non-portable flags.
		return 0
	fi
}

# DANGER Last line of defense against catastrophic errors when using "delete" flag with rsync or similar!
_safeBackup() {
	! type _getAbsolute_criticalDep > /dev/null 2>&1 && return 1
	! _getAbsolute_criticalDep && return 1
	
	[[ ! -e "$scriptAbsoluteLocation" ]] && return 1
	[[ ! -e "$scriptAbsoluteFolder" ]] && return 1
	
	#Fail sooner, avoiding irrelevant error messages. Especially important to cases where an upstream process has already removed the "$safeTmp" directory of a downstream process which reaches "_stop" later.
	! [[ -e "$1" ]] && return 1
	
	[[ "$1" == "" ]] && return 1
	[[ "$1" == "/" ]] && return 1
	[[ "$1" == "-"* ]] && return 1
	
	[[ "$1" == "/home" ]] && return 1
	[[ "$1" == "/home/" ]] && return 1
	[[ "$1" == "/home/$USER" ]] && return 1
	[[ "$1" == "/home/$USER/" ]] && return 1
	[[ "$1" == "/$USER" ]] && return 1
	[[ "$1" == "/$USER/" ]] && return 1
	
	[[ "$1" == "/root" ]] && return 1
	[[ "$1" == "/root/" ]] && return 1
	[[ "$1" == "/root/$USER" ]] && return 1
	[[ "$1" == "/root/$USER/" ]] && return 1
	[[ "$1" == "/$USER" ]] && return 1
	[[ "$1" == "/$USER/" ]] && return 1
	
	[[ "$1" == "/tmp" ]] && return 1
	[[ "$1" == "/tmp/" ]] && return 1
	
	[[ "$1" == "$HOME" ]] && return 1
	[[ "$1" == "$HOME/" ]] && return 1
	
	! type realpath > /dev/null 2>&1 && return 1
	! type readlink > /dev/null 2>&1 && return 1
	! type dirname > /dev/null 2>&1 && return 1
	! type basename > /dev/null 2>&1 && return 1
	
	return 0
}

# DANGER Last line of defense against catastrophic errors when using "delete" flag with rsync or similar!
# WARNING Intended for direct copy/paste inclusion into independent launch wrapper scripts. Kept here for redundancy as well as example and maintenance.
_command_safeBackup() {
	! type _command_getAbsolute_criticalDep > /dev/null 2>&1 && return 1
	! _command_getAbsolute_criticalDep && return 1
	
	[[ ! -e "$commandScriptAbsoluteLocation" ]] && return 1
	[[ ! -e "$commandScriptAbsoluteFolder" ]] && return 1
	
	#Fail sooner, avoiding irrelevant error messages. Especially important to cases where an upstream process has already removed the "$safeTmp" directory of a downstream process which reaches "_stop" later.
	! [[ -e "$1" ]] && return 1
	
	[[ "$1" == "" ]] && return 1
	[[ "$1" == "/" ]] && return 1
	[[ "$1" == "-"* ]] && return 1
	
	[[ "$1" == "/home" ]] && return 1
	[[ "$1" == "/home/" ]] && return 1
	[[ "$1" == "/home/$USER" ]] && return 1
	[[ "$1" == "/home/$USER/" ]] && return 1
	[[ "$1" == "/$USER" ]] && return 1
	[[ "$1" == "/$USER/" ]] && return 1
	
	[[ "$1" == "/root" ]] && return 1
	[[ "$1" == "/root/" ]] && return 1
	[[ "$1" == "/root/$USER" ]] && return 1
	[[ "$1" == "/root/$USER/" ]] && return 1
	[[ "$1" == "/$USER" ]] && return 1
	[[ "$1" == "/$USER/" ]] && return 1
	
	[[ "$1" == "/tmp" ]] && return 1
	[[ "$1" == "/tmp/" ]] && return 1
	
	[[ "$1" == "$HOME" ]] && return 1
	[[ "$1" == "$HOME/" ]] && return 1
	
	#  ! type realpath > /dev/null 2>&1 && return 1
	! type readlink > /dev/null 2>&1 && return 1
	! type dirname > /dev/null 2>&1 && return 1
	! type basename > /dev/null 2>&1 && return 1
	
	return 0
}




# Equivalent to 'mv -n' with an error exit status if file cannot be overwritten.
# https://unix.stackexchange.com/questions/248544/mv-move-file-only-if-destination-does-not-exist
_moveconfirm() {
	local currentExitStatusText
	currentExitStatusText=$(mv -vn "$1" "$2" 2>/dev/null)
	[[ "$currentExitStatusText" == "" ]] && return 1
	return 0
}


_test_moveconfirm_procedure() {
	echo > "$safeTmp"/mv_src
	echo > "$safeTmp"/mv_dst
	
	_moveconfirm "$safeTmp"/mv_src "$safeTmp"/mv_dst && return 1
	
	rm -f "$safeTmp"/mv_dst
	! _moveconfirm "$safeTmp"/mv_src "$safeTmp"/mv_dst && return 1
	
	rm -f "$safeTmp"/mv_dst
	
	return 0
}

_test_moveconfirm_sequence() {
	_start
	
	if ! _test_moveconfirm_procedure "$@"
	then
		_stop 1
	fi
	
	_stop
}

_test_moveconfirm() {
	"$scriptAbsoluteLocation" _test_moveconfirm_sequence "$@"
}


_all_exist() {
	local currentArg
	for currentArg in "$@"
	do
		! [[ -e "$currentArg" ]] && return 1
	done
	
	return 0
}

_wait_not_all_exist() {
	while ! _all_exist "$@"
	do
		sleep 0.1
	done
}

#http://stackoverflow.com/questions/687948/timeout-a-command-in-bash-without-unnecessary-delay
_timeout() { ( set +b; sleep "$1" & "${@:2}" & wait -n; r=$?; kill -9 `jobs -p`; exit $r; ) } 

_condition_lines_zero() {
	local currentLineCount
	currentLineCount=$(wc -l)
	
	[[ "$currentLineCount" == 0 ]] && return 0
	return 1
}


_safe_declare_uid() {
	unset _uid
	_uid() {
		local currentLengthUID
		currentLengthUID="$1"
		[[ "$currentLengthUID" == "" ]] && currentLengthUID=18
		cat /dev/random 2> /dev/null | base64 2> /dev/null | tr -dc 'a-zA-Z0-9' 2> /dev/null | tr -d 'acdefhilmnopqrsuvACDEFHILMNOPQRSU14580' | head -c "$currentLengthUID" 2> /dev/null
		return
	}
	export -f _uid
}

#Generates semi-random alphanumeric characters, default length 18.
_uid() {
	local curentLengthUID
	local currentIteration
	currentIteration=0
	
	currentLengthUID="18"
	! [[ -z "$uidLengthPrefix" ]] && ! [[ "$uidLengthPrefix" -lt "18" ]] && currentLengthUID="$uidLengthPrefix"
	! [[ -z "$1" ]] && currentLengthUID="$1"
	
	if [[ -z "$uidLengthPrefix" ]] && [[ -z "$1" ]]
	then
		# https://stackoverflow.com/questions/32484504/using-random-to-generate-a-random-string-in-bash
		# https://www.cyberciti.biz/faq/unix-linux-iterate-over-a-variable-range-of-numbers-in-bash/
		#chars=abcdefghijklmnopqrstuvwxyz0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ
		chars=bgjktwxyz23679BGJKTVWXYZ
		#for currentIteration in {1..$currentLengthUID} ; do
		for (( currentIteration=1; currentIteration<="$currentLengthUID"; currentIteration++ )) ; do
		echo -n "${chars:RANDOM%${#chars}:1}"
		done
		echo
	else
		cat /dev/urandom 2> /dev/null | base64 2> /dev/null | tr -dc 'a-zA-Z0-9' 2> /dev/null | tr -d 'acdefhilmnopqrsuvACDEFHILMNOPQRSU14580' | head -c "$currentLengthUID" 2> /dev/null
	fi
	return 0
}

# WARNING: Reduces uniqueness, irreversible. Multiple input characters result in same output character.
_filter_random() {
	tr 'a-z' 'bgjktwxyz''bgjktwxyz''bgjktwxyz' | tr 'A-Z' 'BGJKTVWXYZ''BGJKTVWXYZ''BGJKTVWXYZ' | tr '0-9' '23679''23679''23679' | tr -dc 'bgjktwxyz23679BGJKTVWXYZ'
}

# WARNING: Reduces uniqueness, irreversible. Multiple input characters result in same output character.
# WARNING: Not recommended for short strings (ie. not recommended for '8.3' compatibility ).
_filter_hex() {
	tr 'a-z' 'bcdf''bcdf''bcdf''bcdf''bcdf''bcdf''bcdf''bcdf' | tr 'A-Z' 'BCDF''BCDF''BCDF''BCDF''BCDF''BCDF''BCDF''BCDF' | tr '0-9' '23679''23679''23679' | tr -dc 'bcdf23679BCDF'
}

_compat_stat_c_run() {
	local functionOutput
	
	functionOutput=$(stat -c "$@" 2> /dev/null)
	[[ "$?" == "0" ]] && echo "$functionOutput" && return 0
	
	#BSD
	if stat --help 2>&1 | grep '\-f ' > /dev/null 2>&1
	then
		functionOutput=$(stat -f "$@" 2> /dev/null)
		[[ "$?" == "0" ]] && echo "$functionOutput" && return 0
	fi
	
	return 1
}

_permissions_directory_checkForPath() {
	local parameterAbsoluteLocation
	parameterAbsoluteLocation=$(_getAbsoluteLocation "$1")
	
	local checkScriptAbsoluteFolder="$(_getScriptAbsoluteFolder)"
	
	[[ "$parameterAbsoluteLocation" == "$PWD" ]] && ! [[ "$parameterAbsoluteLocation" == "$checkScriptAbsoluteFolder" ]] && return 1
	
	
	
	local currentParameter
	currentParameter="$1"
	
	[[ "$scriptAbsoluteFolder" == /media/"$USER"* ]] && [[ -e /media/"$USER" ]] && currentParameter=/media/"$USER"
	[[ "$scriptAbsoluteFolder" == /mnt/"$USER"* ]] && [[ -e /mnt/"$USER" ]] && currentParameter=/mnt/"$USER"
	[[ "$scriptAbsoluteFolder" == /var/run/media/"$USER"* ]] && [[ -e /var/run/media/"$USER" ]] && currentParameter=/var/run/media/"$USER"
	[[ "$scriptAbsoluteFolder" == /run/"$USER"* ]] && [[ -e /run/"$USER" ]] && currentParameter=/run/"$USER"
	
	local permissions_readout=$(_compat_stat_c_run "%a" "$currentParameter")
	
	local permissions_user
	local permissions_group
	local permissions_other
	
	permissions_user=$(echo "$permissions_readout" | cut -c 1)
	permissions_group=$(echo "$permissions_readout" | cut -c 2)
	permissions_other=$(echo "$permissions_readout" | cut -c 3)
	
	[[ "$permissions_user" -gt "7" ]] && return 1
	[[ "$permissions_group" -gt "7" ]] && return 1
	[[ "$permissions_other" -gt "5" ]] && return 1
	
	#Above checks considered sufficient in typical cases, remainder for sake of example. Return true (safe).
	return 0
	
	local permissions_uid
	local permissions_gid
	
	permissions_uid=$(_compat_stat_c_run "%u" "$currentParameter")
	permissions_gid=$(_compat_stat_c_run "%g" "$currentParameter")
	
	#Normally these variables are available through ubiqutious bash, but this permissions check may be needed earlier in that global variables setting process.
	local permissions_host_uid
	local permissions_host_gid
	
	permissions_host_uid=$(id -u)
	permissions_host_gid=$(id -g)
	
	[[ "$permissions_uid" != "$permissions_host_uid" ]] && return 1
	[[ "$permissions_uid" != "$permissions_host_gid" ]] && return 1
	
	return 0
}

#Checks whether the repository has unsafe permissions for adding binary files to path. Used as an extra safety check by "_setupUbiquitous" before adding a hook to the user's default shell environment.
_permissions_ubiquitous_repo() {
	local parameterAbsoluteLocation
	parameterAbsoluteLocation=$(_getAbsoluteLocation "$1")
	
	[[ ! -e "$parameterAbsoluteLocation" ]] && return 0
	
	! _permissions_directory_checkForPath "$parameterAbsoluteLocation" && return 1
	
	[[ -e "$parameterAbsoluteLocation"/_bin ]] && ! _permissions_directory_checkForPath "$parameterAbsoluteLocation"/_bin && return 1
	[[ -e "$parameterAbsoluteLocation"/_bundle ]] && ! _permissions_directory_checkForPath "$parameterAbsoluteLocation"/_bundle && return 1
	
	return 0
}

_test_permissions_ubiquitous-cygwin() {
	! _if_cygwin && _stop 1
	#  ! _if_cygwin && _stop "$1"
	
	_if_cygwin && echo 'warn: accepted: cygwin: permissions' && return 0
}

#Checks whether currently set "$scriptBin" and similar locations are actually safe.
# WARNING Keep in mind this is necessarily run only after PATH would already have been modified, and does not guard against threats already present on the local machine.
_test_permissions_ubiquitous() {
	[[ ! -e "$scriptAbsoluteFolder" ]] && _stop 1
	
	! _permissions_directory_checkForPath "$scriptAbsoluteFolder" && _test_permissions_ubiquitous-cygwin 1
	
	[[ -e "$scriptBin" ]] && ! _permissions_directory_checkForPath "$scriptBin" && _test_permissions_ubiquitous-cygwin 1
	[[ -e "$scriptBundle" ]] && ! _permissions_directory_checkForPath "$scriptBundle" && _test_permissions_ubiquitous-cygwin 1
	
	return 0
}

#Takes "$@". Places in global array variable "globalArgs".
# WARNING Adding this globalvariable to the "structure/globalvars.sh" declaration or similar to be overridden at script launch is not recommended.
#"${globalArgs[@]}"
_gather_params() {
	export globalArgs=("${@}")
}

_mustcarry() {
	grep "$1" "$2" > /dev/null 2>&1 && return 0
	
	echo "$1" >> "$2"
	return
}

#Determines if user is root. If yes, then continue. If not, exits after printing error message.
_mustBeRoot() {
if [[ $(id -u) != 0 ]]; then 
	echo "This must be run as root!"
	exit
fi
}
alias mustBeRoot=_mustBeRoot

#Determines if sudo is usable by scripts.
_mustGetSudo() {
	# WARNING: What is otherwise considered bad practice may be accepted to reduce substantial MSW/Cygwin inconvenience .
	_if_cygwin && return 0
	
	local rootAvailable
	rootAvailable=false
	
	rootAvailable=$(sudo -n echo true)
	
	#[[ $(id -u) == 0 ]] && rootAvailable=true
	
	! [[ "$rootAvailable" == "true" ]] && exit 1
	
	return 0
}

#Determines if sudo is usable by scripts. Will not exit on failure.
_wantSudo() {
	# WARNING: What is otherwise considered bad practice may be accepted to reduce substantial MSW/Cygwin inconvenience .
	_if_cygwin && return 0
	
	local rootAvailable
	rootAvailable=false
	
	rootAvailable=$(sudo -n echo true 2> /dev/null)
	
	#[[ $(id -u) == 0 ]] && rootAvailable=true
	
	! [[ "$rootAvailable" == "true" ]] && return 1
	
	return 0
}

#Returns a UUID in the form of xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
_getUUID() {
	if [[ -e /proc/sys/kernel/random/uuid ]]
	then
		cat /proc/sys/kernel/random/uuid
		return 0
	fi
	
	
	if type -p uuidgen > /dev/null 2>&1
	then
		uuidgen
		return 0
	fi
	
	# Failure. Intentionally adds extra characters to cause any tests of uuid output to fail.
	_uid 40
	return 1
}
alias getUUID=_getUUID

_embed_here() {
	cat << CZXWXcRMTo8EmM8i4d
#!/usr/bin/env bash

export scriptAbsoluteLocation="$scriptAbsoluteLocation"
export scriptAbsoluteFolder="$scriptAbsoluteFolder"
export sessionid="$sessionid"
. "$scriptAbsoluteLocation" --embed "\$@"
CZXWXcRMTo8EmM8i4d
}

_embed() {
	export sessionid="$1"
	"$scriptAbsoluteLocation" --embed "$@"
}

#"$@" == URL
_fetch() {
	if type axel > /dev/null 2>&1
	then
		axel "$@"
		return 0
	fi
	
	wget "$@"
	
	return 0
}

#Run command and output to terminal with colorful formatting. Controlled variant of "bash -v".
_showCommand() {
	echo -e '\E[1;32;46m $ '"$1"' \E[0m'
	"$@"
}

#Validates non-empty request.
_validateRequest() {
	echo -e -n '\E[1;32;46m Validating request '"$1"'...	\E[0m'
	[[ "$1" == "" ]] && echo -e '\E[1;33;41m BLANK \E[0m' && return 1
	echo "PASS"
	return
}

#http://www.commandlinefu.com/commands/view/3584/remove-color-codes-special-characters-with-sed
_nocolor() {
	sed -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[m|K]//g"
}

_noFireJail() {
	if ( [[ -L /usr/local/bin/"$1" ]] && ls -l /usr/local/bin/"$1" | grep firejail > /dev/null 2>&1 ) || ( [[ -L /usr/bin/"$1" ]] && ls -l /usr/bin/"$1" | grep firejail > /dev/null 2>&1 )
	then
		 _messagePlain_bad 'conflict: firejail: '"$1"
		 return 1
	fi
	
	return 0
}

#Copy log files to "$permaLog" or current directory (default) for analysis.
_preserveLog() {
	if [[ ! -d "$permaLog" ]]
	then
		permaLog="$PWD"
	fi
	
	cp "$logTmp"/* "$permaLog"/ > /dev/null 2>&1
}

_stopwatch() {
	local measureDateA
	local measureDateB
	
	measureDateA=$(date +%s%N | cut -b1-13)

	"$@"

	measureDateB=$(date +%s%N | cut -b1-13)

	bc <<< "$measureDateB - $measureDateA"
}

#####Shortcuts

_importShortcuts() {
	_tryExec "_resetFakeHomeEnv"
	
	if ! [[ "$PATH" == *":""$HOME""/bin"* ]] && ! [[ "$PATH" == "$HOME""/bin"* ]] && [[ -e "$HOME"/bin ]] && [[ -d "$HOME"/bin ]]
	then
		#export PATH="$PATH":"$HOME"/bin
		
		# CAUTION: Dubious workaround to prevent '/usr/local/bin/ubiquitous_bash.sh' , or '/usr/local/bin' , from overriding later program versions in '~/bin' .
		if [[ $( ( export PATH="$PATH":"$HOME"/bin ; type -p ubiquitous_bash.sh ) ) == "/usr/local/bin/ubiquitous_bash.sh" ]]
		then
			export PATH="$HOME"/bin:"$PATH"
		else
			export PATH="$PATH":"$HOME"/bin
		fi
	fi
	
	_tryExec "_visualPrompt"
	
	_tryExec "_scopePrompt"
	
	return 0
}

# https://unix.stackexchange.com/questions/434409/make-a-bash-ps1-that-counts-streak-of-correct-commands
_visualPrompt_promptCommand() {
	[[ "$PS1_lineNumber" == "" ]] && PS1_lineNumber='0'
	#echo "$PS1_lineNumber"
	let PS1_lineNumber="$PS1_lineNumber"+1
	#export PS1_lineNumber

	PS1_lineNumberText="$PS1_lineNumber"
	if [[ "$PS1_lineNumber" == '1' ]]
	then
		# https://unix.stackexchange.com/questions/266921/is-it-possible-to-use-ansi-color-escape-codes-in-bash-here-documents
		PS1_lineNumberText=$(echo -e -n '\E[1;36m'1)
		#PS1_lineNumberText=$(echo -e -n '\E[1;36m'1)
		#PS1_lineNumberText=$(echo -e -n '\[\033[01;36m\]'1)
		#PS1_lineNumberText=$(echo -e -n '\033[01;36m'1)
	fi
}

_visualPrompt() {
	local currentHostname
	currentHostname="$HOSTNAME"
	
	[[ -e /etc/hostname ]] && export currentHostname=$(cat /etc/hostname)
	
	
	export currentChroot=
	[[ "$chrootName" != "" ]] && export currentChroot="$chrootName"
	
	
	#+%H:%M:%S\ %Y-%m-%d\ Q%q
	#+%H:%M:%S\ %b\ %d,\ %y

	#Long.
	#export PS1='\[\033[01;40m\]\[\033[01;36m\]+\[\033[01;34m\]-|\[\033[01;31m\]${?}:${debian_chroot:+($debian_chroot)}\[\033[01;33m\]\u\[\033[01;32m\]@\h\[\033[01;36m\]\[\033[01;34m\])-\[\033[01;36m\]--\[\033[01;34m\]-(\[\033[01;35m\]$(date +%H:%M:%S\ .%d)\[\033[01;34m\])-\[\033[01;36m\]-|\[\033[00m\]\n\[\033[01;40m\]\[\033[01;36m\]+\[\033[01;34m\]-|\[\033[37m\][\w]\[\033[00m\]\n\[\033[01;36m\]+\[\033[01;34m\]-|\#) \[\033[36m\]>\[\033[00m\] '

	#Short.
	#export PS1='\[\033[01;40m\]\[\033[01;36m\]+\[\033[01;34m\]|\[\033[01;31m\]${?}:${debian_chroot:+($debian_chroot)}\[\033[01;33m\]\u\[\033[01;32m\]@\h\[\033[01;36m\]\[\033[01;34m\])-\[\033[01;36m\]-\[\033[01;34m\]-(\[\033[01;35m\]$(date +%H:%M:%S\ .%d)\[\033[01;34m\])\[\033[01;36m\]|\[\033[00m\]\n\[\033[01;40m\]\[\033[01;36m\]+\[\033[01;34m\]|\[\033[37m\][\w]\[\033[00m\]\n\[\033[01;36m\]+\[\033[01;34m\]|\#) \[\033[36m\]>\[\033[00m\] '
	
	#Truncated, 40 columns.
	#export PS1='\[\033[01;40m\]\[\033[01;36m\]\[\033[01;34m\]|\[\033[01;31m\]${?}:${debian_chroot:+($debian_chroot)}\[\033[01;33m\]\u\[\033[01;32m\]@\h\[\033[01;36m\]\[\033[01;34m\])\[\033[01;36m\]\[\033[01;34m\]-(\[\033[01;35m\]$(date +%H:%M:%S\.%d)\[\033[01;34m\])\[\033[01;36m\]|\[\033[00m\]\n\[\033[01;40m\]\[\033[01;36m\]\[\033[01;34m\]|\[\033[37m\][\w]\[\033[00m\]\n\[\033[01;36m\]\[\033[01;34m\]|\#) \[\033[36m\]>\[\033[00m\] '
	
	
	# https://unix.stackexchange.com/questions/434409/make-a-bash-ps1-that-counts-streak-of-correct-commands
	
	#export PROMPT_COMMAND=$(declare -f _visualPrompt_promptCommand)' ; _visualPrompt_promptCommand'
	#export PROMPT_COMMAND='_visualPrompt_promptCommand () { [[ "$PS1_lineNumber" == "" ]] && PS1_lineNumber="0"; let PS1_lineNumber="$PS1_lineNumber"+1; PS1_lineNumberText="$PS1_lineNumber"; if [[ "$PS1_lineNumber" == "1" ]]; then PS1_lineNumberText=$(echo -e -n "'"\E[1;36m"'"1"'"\E[0m"'"); fi } ; _visualPrompt_promptCommand'
	
	export -f _visualPrompt_promptCommand
	export PROMPT_COMMAND=_visualPrompt_promptCommand
	
	#export PS1='\[\033[01;40m\]\[\033[01;36m\]\[\033[01;34m\]|\[\033[01;31m\]${?}:${debian_chroot:+($debian_chroot)}\[\033[01;33m\]\u\[\033[01;32m\]@\h\[\033[01;36m\]\[\033[01;34m\])\[\033[01;36m\]\[\033[01;34m\]-(\[\033[01;35m\]$(date +%H:%M:%S\.%d)\[\033[01;34m\])\[\033[01;36m\]|\[\033[00m\]\n\[\033[01;40m\]\[\033[01;36m\]\[\033[01;34m\]|\[\033[37m\][\w]\[\033[00m\]\n\[\033[01;36m\]\[\033[01;34m\]|$PS1_lineNumberText\[\033[01;34m\]) \[\033[36m\]>\[\033[00m\] '
	
	
	#export PS1='\[\033[01;40m\]\[\033[01;36m\]\[\033[01;34m\]|\[\033[01;31m\]${?}:${debian_chroot:+($debian_chroot)}\[\033[01;33m\]\u\[\033[01;32m\]@\h\[\033[01;36m\]\[\033[01;34m\])\[\033[01;36m\]\[\033[01;34m\]-'"$prompt_cloudNetName"'(\[\033[01;35m\]$(date +%H:%M:%S\.%d)\[\033[01;34m\])\[\033[01;36m\]|\[\033[00m\]\n\[\033[01;40m\]\[\033[01;36m\]\[\033[01;34m\]|\[\033[37m\][\w]\[\033[00m\]\n\[\033[01;36m\]\[\033[01;34m\]|$PS1_lineNumberText\[\033[01;34m\]) \[\033[36m\]'""'>\[\033[00m\] '
	
	
	if [[ "$SHELL" == *"/nix/store/"*"/bin/bash"* ]]
	then
		export prompt_nixShell="nixShell"
	else
		export prompt_nixShell=""
	fi
	
	#export PS1='\[\033[01;40m\]\[\033[01;36m\]\[\033[01;34m\]|\[\033[01;31m\]${?}:${debian_chroot:+($debian_chroot)}\[\033[01;33m\]\u\[\033[01;32m\]@\h\[\033[01;36m\]\[\033[01;34m\])\[\033[01;36m\]\[\033[01;34m\]-'"$prompt_cloudNetName"'(\[\033[01;35m\]$(date +%H:%M:%S\.%d)\[\033[01;34m\])\[\033[01;36m\]|\[\033[00m\]'"$prompt_nixShell"'\n\[\033[01;40m\]\[\033[01;36m\]\[\033[01;34m\]|\[\033[37m\][\w]\[\033[00m\]\n\[\033[01;36m\]\[\033[01;34m\]|$([[ "$PS1_lineNumber" == "1" ]] && echo -e -n '"'"'\[\033[01;36m\]'"'"'$PS1_lineNumber || echo -e -n $PS1_lineNumber)\[\033[01;34m\]) \[\033[36m\]'""'>\[\033[00m\] '
	
	
	
	if _if_cygwin
	then
		export PS1='\[\033[01;40m\]\[\033[01;36m\]\[\033[01;34m\]|\[\033[01;31m\]${?}:${currentChroot:+($currentChroot)}\[\033[01;33m\]\u\[\033[01;32m\]@'"$currentHostname"'\[\033[01;36m\]\[\033[01;34m\])\[\033[01;36m\]\[\033[01;34m\]-'"$prompt_cloudNetName"'(\[\033[01;35m\]$(date +%H:%M:%S\.%d)\[\033[01;34m\])\[\033[01;36m\]|\[\033[00m\]'"$prompt_nixShell"'\n\[\033[01;40m\]\[\033[01;36m\]\[\033[01;34m\]\[\033[37m\]\w\[\033[00m\]\n\[\033[01;36m\]\[\033[01;34m\]|$([[ "$PS1_lineNumber" == "1" ]] && echo -e -n '"'"'\[\033[01;36m\]'"'"'$PS1_lineNumber || echo -e -n $PS1_lineNumber)\[\033[01;34m\]) \[\033[36m\]'""'>\[\033[00m\] '
	elif ( uname -a | grep -i 'microsoft' > /dev/null 2>&1 || uname -a | grep -i 'WSL2' > /dev/null 2>&1 )
	then
		export PS1='\[\033[01;40m\]\[\033[01;36m\]\[\033[01;34m\]|\[\033[01;31m\]${?}:${currentChroot:+($currentChroot)}\[\033[01;33m\]\u\[\033[01;32m\]@'"$currentHostname"-wsl2'\[\033[01;36m\]\[\033[01;34m\])\[\033[01;36m\]\[\033[01;34m\]-'"$prompt_cloudNetName"'(\[\033[01;35m\]$(date +%H:%M:%S\.%d)\[\033[01;34m\])\[\033[01;36m\]|\[\033[00m\]'"$prompt_nixShell"'\n\[\033[01;40m\]\[\033[01;36m\]\[\033[01;34m\]\[\033[37m\]\w\[\033[00m\]\n\[\033[01;36m\]\[\033[01;34m\]|$([[ "$PS1_lineNumber" == "1" ]] && echo -e -n '"'"'\[\033[01;36m\]'"'"'$PS1_lineNumber || echo -e -n $PS1_lineNumber)\[\033[01;34m\]) \[\033[36m\]'""'>\[\033[00m\] '
	else
		export PS1='\[\033[01;40m\]\[\033[01;36m\]\[\033[01;34m\]|\[\033[01;31m\]${?}:${currentChroot:+($currentChroot)}\[\033[01;33m\]\u\[\033[01;32m\]@'"$currentHostname"'\[\033[01;36m\]\[\033[01;34m\])\[\033[01;36m\]\[\033[01;34m\]-'"$prompt_cloudNetName"'(\[\033[01;35m\]$(date +%H:%M:%S\.%d)\[\033[01;34m\])\[\033[01;36m\]|\[\033[00m\]'"$prompt_nixShell"'\n\[\033[01;40m\]\[\033[01;36m\]\[\033[01;34m\]|\[\033[37m\][\w]\[\033[00m\]\n\[\033[01;36m\]\[\033[01;34m\]|$([[ "$PS1_lineNumber" == "1" ]] && echo -e -n '"'"'\[\033[01;36m\]'"'"'$PS1_lineNumber || echo -e -n $PS1_lineNumber)\[\033[01;34m\]) \[\033[36m\]'""'>\[\033[00m\] '	
	fi
	
	#export PS1="$prompt_nixShell""$PS1"
}


_request_visualPrompt() {
	_messagePlain_request 'export profileScriptLocation="'"$scriptAbsoluteLocation"'"'
	_messagePlain_request 'export profileScriptFolder="'"$scriptAbsoluteFolder"'"'
	_messagePlain_request ". "'"'"$scriptAbsoluteLocation"'"' --profile _importShortcuts
}


# Requires "$GH_TOKEN" .
_gh_downloadURL() {
	local current_url
	local current_repo
	local current_tagName
	local current_file
	
	
	# ATTRIBUTION: ChatGPT GPT-4 2023-11-04 .
	
	# The provided URL
	current_url="$1"
	shift
	
	# Use `sed` to extract the parts of the URL
	current_repo=$(echo "$current_url" | sed -n 's|https://github.com/\([^/]*\)/\([^/]*\)/.*|\1/\2|p')
	current_tagName=$(echo "$current_url" | sed -n 's|https://github.com/[^/]*/[^/]*/releases/download/\([^/]*\)/.*|\1|p')
	current_file=$(echo "$current_url" | sed -n 's|https://github.com/[^/]*/[^/]*/releases/download/[^/]*/\(.*\)|\1|p')
	
	local current_fileOut
	current_fileOut="$current_file"
	if [[ "$1" == "-O" ]]
	then
		#_gh_downloadURL "${currentURL_array_reversed[$currentIterationNext1]}" -O "$currentAxelTmpFileRelative".tmp2
		current_fileOut="$2"
	fi
	
	# Use variables to construct the gh release download command
	local currentIteration
	currentIteration=0
	while ! [[ -e "$current_fileOut" ]] && [[ "$currentIteration" -lt 3 ]]
	do
		gh release download "$current_tagName" -R "$current_repo" -p "$current_file" "$@"
		! [[ -e "$current_fileOut" ]] && sleep 7
		let currentIteration=currentIteration+1
	done
	[[ -e "$current_fileOut" ]]
	return "$?"
}



_wget_githubRelease-URL() {
	local currentURL
	if [[ "$2" != "" ]]
	then
		if [[ "$GH_TOKEN" == "" ]]
		then
			currentURL=$(curl -6 -s "https://api.github.com/repos/""$1""/releases" | jq -r ".[] | select(.name == \"""$2""\") | .assets[] | select(.name == \"""$3""\") | .browser_download_url" | sort -n -r | head -n 1)
			[[ "$currentURL" == "" ]] && currentURL=$(curl -4 -s "https://api.github.com/repos/""$1""/releases" | jq -r ".[] | select(.name == \"""$2""\") | .assets[] | select(.name == \"""$3""\") | .browser_download_url" | sort -n -r | head -n 1)
			echo "$currentURL"
			return
		else
			currentURL=$(curl -6 -H "Authorization: Bearer $GH_TOKEN" -s "https://api.github.com/repos/""$1""/releases" | jq -r ".[] | select(.name == \"""$2""\") | .assets[] | select(.name == \"""$3""\") | .browser_download_url" | sort -n -r | head -n 1)
			[[ "$currentURL" == "" ]] && currentURL=$(curl -4 -H "Authorization: Bearer $GH_TOKEN" -s "https://api.github.com/repos/""$1""/releases" | jq -r ".[] | select(.name == \"""$2""\") | .assets[] | select(.name == \"""$3""\") | .browser_download_url" | sort -n -r | head -n 1)
			echo "$currentURL"
			return
		fi
	else
		if [[ "$GH_TOKEN" == "" ]]
		then
			currentURL=$(curl -6 -s "https://api.github.com/repos/""$1""/releases/latest" | jq -r ".assets[] | select(.name == \"""$3""\") | .browser_download_url" | sort -n -r | head -n 1)
			[[ "$currentURL" == "" ]] && currentURL=$(curl -4 -s "https://api.github.com/repos/""$1""/releases/latest" | jq -r ".assets[] | select(.name == \"""$3""\") | .browser_download_url" | sort -n -r | head -n 1)
			echo "$currentURL"
			return
		else
			currentURL=$(curl -6 -H "Authorization: Bearer $GH_TOKEN" -s "https://api.github.com/repos/""$1""/releases/latest" | jq -r ".assets[] | select(.name == \"""$3""\") | .browser_download_url" | sort -n -r | head -n 1)
			[[ "$currentURL" == "" ]] && currentURL=$(curl -4 -H "Authorization: Bearer $GH_TOKEN" -s "https://api.github.com/repos/""$1""/releases/latest" | jq -r ".assets[] | select(.name == \"""$3""\") | .browser_download_url" | sort -n -r | head -n 1)
			echo "$currentURL"
			return
		fi
	fi
}

_wget_githubRelease() {
	local currentURL=$(_wget_githubRelease-URL "$@")
	if [[ "$GH_TOKEN" == "" ]]
	then
		_messagePlain_probe curl -L -o "$3" "$currentURL" >&2
		curl -L -o "$3" "$currentURL"
	else
		if type -p gh > /dev/null 2>&1 && [[ "$GH_TOKEN" != "" ]] && [[ "$FORCE_WGET" != "true" ]]
		then
			_messagePlain_probe _gh_downloadURL "$currentURL" -O "$3" >&2
			_gh_downloadURL "$currentURL" -O "$3"
		else
			# Broken. Must use 'gh' instead.
			_messagePlain_probe curl -H "Authorization: Bearer "'$GH_TOKEN' -L -o "$3" "$currentURL" >&2
			curl -H "Authorization: Bearer $GH_TOKEN" -L -o "$3" "$currentURL"
		fi
	fi
	[[ ! -e "$3" ]] && _messagePlain_bad 'missing: '"$1"' '"$2"' '"$3" && return 1
	return 0
}

_wget_githubRelease-stdout() {
	local currentURL=$(_wget_githubRelease-URL "$@")
	if type -p gh > /dev/null 2>&1 && [[ "$GH_TOKEN" != "" ]] && [[ "$FORCE_WGET" != "true" ]]
	then
		_messagePlain_probe _gh_downloadURL "$currentURL" -O - >&2
		_gh_downloadURL "$currentURL" -O -
		return
	else
		if [[ "$GH_TOKEN" == "" ]]
		then
			_messagePlain_probe curl -L -o - "$currentURL" >&2
			curl -L -o - "$currentURL"
		else
			# Broken. Must use 'gh' instead.
			_messagePlain_probe curl -H "Authorization: Bearer "'$GH_TOKEN' -L -o - "$currentURL" >&2
			curl -H "Authorization: Bearer $GH_TOKEN" -L -o - "$currentURL"
		fi
		return
	fi
}


_wget_githubRelease_join-stdout() {
	local functionEntryPWD
	functionEntryPWD="$PWD"
	cd "$scriptAbsoluteFolder"
	
	local currentURL
	local currentURL_array

	local currentIteration
	currentIteration=0
	for currentIteration in $(seq -f "%02g" 0 50)
	do
		currentURL=$(_wget_githubRelease-URL "$1" "$2" "$3"".part""$currentIteration")
		[[ "$currentURL" == "" ]] && break
		[[ "$currentURL" != "" ]] && currentURL_array+=( "$currentURL" )
	done

	# https://unix.stackexchange.com/questions/412868/bash-reverse-an-array
	local currentValue
	for currentValue in "${currentURL_array[@]}"
	do
		currentURL_array_reversed=("$currentValue" "${currentURL_array_reversed[@]}")
	done
	
	# DANGER: Requires   ' "$MANDATORY_HASH" == true '   to indicate use of a hash obtained more securely to check download integrity. Do NOT set 'MANDATORY_HASH' explicitly, safe functions which already include appropriate checks for integrity will set this safety flag automatically.
	# CAUTION: Do NOT use unless reasonable to degrade network traffic collision backoff algorithms. Unusual defaults, very aggressive, intended for load-balanced multi-WAN with at least 3 WANs .
	if [[ "$FORCE_AXEL" != "" ]] && ( [[ "$MANDATORY_HASH" == "true" ]] )
	then
		#local currentAxelTmpFile
		#currentAxelTmpFile="$scriptAbsoluteFolder"/.m_axelTmp_$(_uid 14)
		export currentAxelTmpFileRelative=.m_axelTmp_$(_uid 14)
		export currentAxelTmpFile="$scriptAbsoluteFolder"/"$currentAxelTmpFileRelative"

		#local currentAxelPID

		local currentForceAxel
		currentForceAxel="$FORCE_AXEL"

		( [[ "$currentForceAxel" == "true" ]] || [[ "$currentForceAxel" == "" ]] ) && currentForceAxel="48"
		[[ "$currentForceAxel" -lt 2 ]] && currentForceAxel="2"

		currentForceAxel=$(bc <<< "$currentForceAxel""*0.5" | cut -f1 -d\. )
		[[ "$currentForceAxel" -lt 2 ]] && currentForceAxel="2"

		#_messagePlain_probe axel -a -n "$FORCE_AXEL" -o "$currentAxelTmpFile" "${currentURL_array_reversed[@]}" >&2
		#axel -a -n "$FORCE_AXEL" -o "$currentAxelTmpFile" "${currentURL_array_reversed[@]}" >&2 &
		#currentAxelPID="$!"


		local current_usable_ipv4
		current_usable_ipv4="false"
		#if _timeout 8 aria2c --async-dns=false -o "$currentAxelTmpFile" --disable-ipv6 --allow-overwrite=true --auto-file-renaming=false --file-allocation=none --timeout=6 "${currentURL_array_reversed[0]}" >&2
		#then
			#current_usable_ipv4="true"
		#fi
		if [[ "$GH_TOKEN" == "" ]]
		then
			if _timeout 5 wget -4 -O - "${currentURL_array_reversed[0]}" > /dev/null
			then
				current_usable_ipv4="true"
			fi
		else
			if _timeout 5 wget -4 -O - --header="Authorization: Bearer $GH_TOKEN" "${currentURL_array_reversed[0]}" > /dev/null
			then
				current_usable_ipv4="true"
			fi
		fi

		local current_usable_ipv6
		current_usable_ipv6="false"
		if [[ "$GH_TOKEN" == "" ]]
		then
			if _timeout 5 wget -6 -O - "${currentURL_array_reversed[0]}" > /dev/null
			then
				current_usable_ipv6="true"
			fi
		else
			if _timeout 5 wget -6 -O - --header="Authorization: Bearer $GH_TOKEN" "${currentURL_array_reversed[0]}" > /dev/null
			then
				current_usable_ipv6="true"
			fi
		fi

		local currentPID_1
		local currentPID_2
		currentIteration=0
		local currentIterationNext1
		let currentIterationNext1=currentIteration+1
		rm -f "$currentAxelTmpFile"
		rm -f "$currentAxelTmpFile".* > /dev/null 2>&1
		while [[ "${currentURL_array_reversed[$currentIteration]}" != "" ]] || [[ "${currentURL_array_reversed[$currentIterationNext1]}" != "" ]] || [[ -e "$currentAxelTmpFile".tmp2 ]]
		do
			#rm -f "$currentAxelTmpFile"
			rm -f "$currentAxelTmpFile".aria2
			rm -f "$currentAxelTmpFile".tmp
			rm -f "$currentAxelTmpFile".tmp.st
			rm -f "$currentAxelTmpFile".tmp.aria2
			rm -f "$currentAxelTmpFile".tmp1
			rm -f "$currentAxelTmpFile".tmp1.st
			rm -f "$currentAxelTmpFile".tmp1.aria2
			#rm -f "$currentAxelTmpFile".tmp2
			#rm -f "$currentAxelTmpFile".tmp2.st
			#rm -f "$currentAxelTmpFile".tmp2.aria2
			#rm -f "$currentAxelTmpFile".* > /dev/null 2>&1
			
			#rm -f "$currentAxelTmpFile".* > /dev/null 2>&1

			# https://github.com/aria2/aria2/issues/1108

			if [[ "${currentURL_array_reversed[$currentIteration]}" != "" ]]
			then
				# Download preferring from IPv6 address .
				if [[ "$current_usable_ipv6" == "true" ]]
				then
					if [[ "$GH_TOKEN" == "" ]]
					then
						#--file-allocation=falloc
						_messagePlain_probe aria2c -x "$currentForceAxel" --async-dns=false -o "$currentAxelTmpFileRelative".tmp1 --disable-ipv6=false "${currentURL_array_reversed[$currentIteration]}" >&2
						aria2c --log=- --log-level=info -x "$currentForceAxel" --async-dns=false -o "$currentAxelTmpFileRelative".tmp1 --disable-ipv6=false "${currentURL_array_reversed[$currentIteration]}" | grep --color -i -E "Name resolution|$" >&2 &
						currentPID_1="$!"
					else
						_messagePlain_probe aria2c -x "$currentForceAxel" --async-dns=false -o "$currentAxelTmpFileRelative".tmp1 --disable-ipv6=false --header="Authorization: Bearer "'$GH_TOKEN'"" "${currentURL_array_reversed[$currentIteration]}" >&2
						aria2c --log=- --log-level=info -x "$currentForceAxel" --async-dns=false -o "$currentAxelTmpFileRelative".tmp1 --disable-ipv6=false --header="Authorization: Bearer $GH_TOKEN" "${currentURL_array_reversed[$currentIteration]}" | grep --color -i -E "Name resolution|$" >&2 &
						currentPID_1="$!"
					fi
				else
					if [[ "$GH_TOKEN" == "" ]]
					then
						_messagePlain_probe aria2c -x "$currentForceAxel" --async-dns=false -o "$currentAxelTmpFileRelative".tmp1 --disable-ipv6=true "${currentURL_array_reversed[$currentIteration]}" >&2
						aria2c --log=- --log-level=info -x "$currentForceAxel" --async-dns=false -o "$currentAxelTmpFileRelative".tmp1 --disable-ipv6=true "${currentURL_array_reversed[$currentIteration]}" | grep --color -i -E "Name resolution|$" >&2 &
						currentPID_1="$!"
					else
						_messagePlain_probe aria2c -x "$currentForceAxel" --async-dns=false -o "$currentAxelTmpFileRelative".tmp1 --disable-ipv6=true --header="Authorization: Bearer "'$GH_TOKEN'"" "${currentURL_array_reversed[$currentIteration]}" >&2
						aria2c --log=- --log-level=info -x "$currentForceAxel" --async-dns=false -o "$currentAxelTmpFileRelative".tmp1 --disable-ipv6=true --header="Authorization: Bearer $GH_TOKEN" "${currentURL_array_reversed[$currentIteration]}" | grep --color -i -E "Name resolution|$" >&2 &
						currentPID_1="$!"
					fi
				fi
			fi
			
			
			# CAUTION: ATTENTION: Very important. Simultaneous reading and writing is *very* important for writing directly to slow media (ie. BD-R) .
			#  NOTICE: Wirting directly to slow BD-R is essential for burning a Live disc from having booted a Live disc.
			#   DANGER: Critical for rapid recovery back to recent upstream 'ubdist/OS' ! Do NOT unnecessarily degrade this capability!
			#  Also theoretically helpful with especially fast network connections.
			#if [[ "$currentIteration" != "0" ]]
			if [[ -e "$currentAxelTmpFile".tmp2 ]]
			then
				# ATTENTION: Staggered.
				#sleep 10 > /dev/null 2>&1
				wait "$currentPID_2" >&2
				#wait >&2

				sleep 0.2 > /dev/null 2>&1
				if [[ -e "$currentAxelTmpFile".tmp2 ]]
				then
					_messagePlain_probe dd if="$currentAxelTmpFile".tmp2 bs=1M status=progress' >> '"$currentAxelTmpFile" >&2
					
					# ### dd if="$currentAxelTmpFile".tmp2 bs=5M status=progress >> "$currentAxelTmpFile"
					dd if="$currentAxelTmpFile".tmp2 bs=1M status=progress
					#cat "$currentAxelTmpFile".tmp2
					
					du -sh "$currentAxelTmpFile".tmp2 >> "$currentAxelTmpFile"
					
					#cat "$currentAxelTmpFile".tmp2 >> "$currentAxelTmpFile"
				fi
			else
				if [[ "$currentIteration" == "0" ]]
				then
					# ATTENTION: Staggered.
					#sleep 6 > /dev/null 2>&1
					true
				fi
			fi
			rm -f "$currentAxelTmpFile".tmp2
			rm -f "$currentAxelTmpFile".tmp2.st
			rm -f "$currentAxelTmpFile".tmp2.aria2
			#rm -f "$currentAxelTmpFile".* > /dev/null 2>&1
			
			


			if [[ "${currentURL_array_reversed[$currentIterationNext1]}" != "" ]]
			then
				# Download preferring from IPv4 address.
				#--disable-ipv6
				if [[ "$current_usable_ipv4" == "true" ]]
				then
					if [[ "$GH_TOKEN" == "" ]]
					then
						_messagePlain_probe aria2c -x "$currentForceAxel" --async-dns=false -o "$currentAxelTmpFileRelative".tmp2 --disable-ipv6=true "${currentURL_array_reversed[$currentIterationNext1]}" >&2
						aria2c --log=- --log-level=info -x "$currentForceAxel" --async-dns=false -o "$currentAxelTmpFileRelative".tmp2 --disable-ipv6=true "${currentURL_array_reversed[$currentIterationNext1]}" | grep --color -i -E "Name resolution|$" >&2 &
						currentPID_2="$!"
					else
						_messagePlain_probe aria2c -x "$currentForceAxel" --async-dns=false -o "$currentAxelTmpFileRelative".tmp2 --disable-ipv6=true --header="Authorization: Bearer "'$GH_TOKEN'"" "${currentURL_array_reversed[$currentIterationNext1]}" >&2
						aria2c --log=- --log-level=info -x "$currentForceAxel" --async-dns=false -o "$currentAxelTmpFileRelative".tmp2 --disable-ipv6=true --header="Authorization: Bearer $GH_TOKEN" "${currentURL_array_reversed[$currentIterationNext1]}" | grep --color -i -E "Name resolution|$" >&2 &
						currentPID_2="$!"
					fi
				else
					if [[ "$GH_TOKEN" == "" ]]
					then
						_messagePlain_probe aria2c -x "$currentForceAxel" --async-dns=false -o "$currentAxelTmpFileRelative".tmp2 --disable-ipv6=false "${currentURL_array_reversed[$currentIterationNext1]}" >&2
						aria2c --log=- --log-level=info -x "$currentForceAxel" --async-dns=false -o "$currentAxelTmpFileRelative".tmp2 --disable-ipv6=false "${currentURL_array_reversed[$currentIterationNext1]}" | grep --color -i -E "Name resolution|$" >&2 &
						currentPID_2="$!"
					else
						_messagePlain_probe aria2c -x "$currentForceAxel" --async-dns=false -o "$currentAxelTmpFileRelative".tmp2 --disable-ipv6=false --header="Authorization: Bearer "'$GH_TOKEN'"" "${currentURL_array_reversed[$currentIterationNext1]}" >&2
						aria2c --log=- --log-level=info -x "$currentForceAxel" --async-dns=false -o "$currentAxelTmpFileRelative".tmp2 --disable-ipv6=false --header="Authorization: Bearer $GH_TOKEN" "${currentURL_array_reversed[$currentIterationNext1]}" | grep --color -i -E "Name resolution|$" >&2 &
						currentPID_2="$!"
					fi
				fi
			fi
			

			# ATTENTION: NOT staggered.
			#wait "$currentPID_1" >&2
			#wait "$currentPID_2" >&2
			#wait >&2
			
			if [[ "$currentIteration" == "0" ]]
			then
				wait "$currentPID_1" >&2
				sleep 6 > /dev/null 2>&1
				[[ "$currentPID_2" == "" ]] && sleep 35 > /dev/null 2>&1
				[[ "$currentPID_2" != "" ]] && wait "$currentPID_2" >&2
				wait >&2
			fi

			wait "$currentPID_1" >&2
			sleep 0.2 > /dev/null 2>&1
			if [[ -e "$currentAxelTmpFile".tmp1 ]]
			then
				_messagePlain_probe dd if="$currentAxelTmpFile".tmp1 bs=1M status=progress' >> '"$currentAxelTmpFile" >&2
				
				if [[ ! -e "$currentAxelTmpFile" ]]
				then
					# ### mv -f "$currentAxelTmpFile".tmp1 "$currentAxelTmpFile"
					dd if="$currentAxelTmpFile".tmp1 bs=1M status=progress
					
					du -sh "$currentAxelTmpFile".tmp1 >> "$currentAxelTmpFile"
				else
					# ATTENTION: Staggered.
					#dd if="$currentAxelTmpFile".tmp1 bs=1M status=progress >> "$currentAxelTmpFile" &
				
					# ATTENTION: NOT staggered.
					# ### dd if="$currentAxelTmpFile".tmp1 bs=5M status=progress >> "$currentAxelTmpFile"
					dd if="$currentAxelTmpFile".tmp1 bs=1M status=progress
					#cat "$currentAxelTmpFile".tmp1
					
					du -sh "$currentAxelTmpFile".tmp1 >> "$currentAxelTmpFile"
					
					#cat "$currentAxelTmpFile".tmp1 >> "$currentAxelTmpFile"
				fi
			fi

			let currentIteration=currentIteration+2
			let currentIterationNext1=currentIteration+1
		done
		

		#for currentValue in "${currentURL_array_reversed[@]}"
		#do
			#rm -f "$currentAxelTmpFile".tmp
			
			
			##_messagePlain_probe axel -a -n "$currentForceAxel" -o "$currentAxelTmpFile".tmp "$currentValue" >&2
			##axel -a -n "$currentForceAxel" -o "$currentAxelTmpFile".tmp "$currentValue" >&2
			#if [[ "$GH_TOKEN" == "" ]]
			#then
				#_messagePlain_probe axel -a -n "$currentForceAxel" -o "$currentAxelTmpFile".tmp "$currentValue" >&2
				#axel -a -n "$currentForceAxel" -o "$currentAxelTmpFile".tmp "$currentValue" >&2
			#else
				#_messagePlain_probe axel -a -n "$currentForceAxel" -H '"Authorization: Bearer $GH_TOKEN"' -o "$currentAxelTmpFile".tmp "$currentValue" >&2
				#axel -a -n "$currentForceAxel" -H "Authorization: Bearer $GH_TOKEN" -o "$currentAxelTmpFile".tmp "$currentValue" >&2
			#fi
			
			
			#_messagePlain_probe dd if="$currentAxelTmpFile".tmp bs=1M status=progress' >> '"$currentAxelTmpFile" >&2
			#dd if="$currentAxelTmpFile".tmp bs=1M status=progress >> "$currentAxelTmpFile"
			#let currentIteration=currentIteration+1
		#done

		#while [[ "$currentIteration" -le 16 ]] && [[ ! -e "$currentAxelTmpFile" ]]
		#do
			#sleep 2 > /dev/null 2>&1
			#let currentIteration="$currentIteration"+1
		#done

		#if [[ -e "$currentAxelTmpFile" ]]
		#then
			#tail --pid="$currentAxelPID" -c 100000000000 -f "$currentAxelTmpFile"
			#wait "$currentAxelPID"
		#else
			#_messagePlain_bad 'missing: "$currentAxelTmpFile"' >&2
			#kill -TERM "$currentAxelPID" > /dev/null 2>&1
			#kill -TERM "$currentAxelPID" > /dev/null 2>&1
			#sleep 3
			#kill -TERM "$currentAxelPID" > /dev/null 2>&1
			#sleep 3
			#kill -TERM "$currentAxelPID" > /dev/null 2>&1
			#kill -KILL "$currentAxelPID" > /dev/null 2>&1
			#return 1
		#fi

		if ! [[ -e "$currentAxelTmpFile" ]]
		then
			true
			# ### return 1
		fi

		# ### cat "$currentAxelTmpFile"

		rm -f "$currentAxelTmpFile"
		rm -f "$currentAxelTmpFile".aria2
		rm -f "$currentAxelTmpFile".tmp
		rm -f "$currentAxelTmpFile".tmp.st
		rm -f "$currentAxelTmpFile".tmp.aria2
		rm -f "$currentAxelTmpFile".tmp1
		rm -f "$currentAxelTmpFile".tmp1.st
		rm -f "$currentAxelTmpFile".tmp1.aria2
		rm -f "$currentAxelTmpFile".tmp2
		rm -f "$currentAxelTmpFile".tmp2.st
		rm -f "$currentAxelTmpFile".tmp2.aria2
		rm -f "$currentAxelTmpFile".tmp3
		rm -f "$currentAxelTmpFile".tmp3.st
		rm -f "$currentAxelTmpFile".tmp3.aria2
		rm -f "$currentAxelTmpFile".tmp4
		rm -f "$currentAxelTmpFile".tmp4.st
		rm -f "$currentAxelTmpFile".tmp4.aria2
			
		rm -f "$currentAxelTmpFile".* > /dev/null 2>&1
		
		return 0
	else
		if [[ "$GH_TOKEN" == "" ]]
		then
			_messagePlain_probe curl -L "${currentURL_array_reversed[@]}" >&2
			curl -L "${currentURL_array_reversed[@]}"
		elif type -p gh > /dev/null 2>&1 && [[ "$GH_TOKEN" != "" ]] && [[ "$FORCE_WGET" != "true" ]]
		then
			
			if [[ $(cat /proc/meminfo | grep MemTotal | tr -cd '[[:digit:]]') -gt 16379210 ]] && [[ "$FORCE_LOWTMP" != "true" ]]
			then
				
				
				
				
				# ATTENTION: Follows structure based on functionality for 'aria2c' .
				
				#local currentAxelTmpFile
				#currentAxelTmpFile="$scriptAbsoluteFolder"/.m_axelTmp_$(_uid 14)
				export currentAxelTmpFileRelative=.m_axelTmp_$(_uid 14)
				export currentAxelTmpFile="$scriptAbsoluteFolder"/"$currentAxelTmpFileRelative"
				
				local currentPID_1
				local currentPID_2
				local currentPID_3
				local currentPID_4
				local currentIteration
				currentIteration=0
				local currentIterationNext1
				let currentIterationNext1=currentIteration+1
				local currentIterationNext2
				let currentIterationNext2=currentIteration+2
				local currentIterationNext3
				let currentIterationNext3=currentIteration+3
				rm -f "$currentAxelTmpFile"
				rm -f "$currentAxelTmpFile".* > /dev/null 2>&1
				while [[ "${currentURL_array_reversed[$currentIteration]}" != "" ]] || [[ "${currentURL_array_reversed[$currentIterationNext1]}" != "" ]] || [[ -e "$currentAxelTmpFile".tmp2 ]] || [[ "${currentURL_array_reversed[$currentIterationNext2]}" != "" ]] || [[ -e "$currentAxelTmpFile".tmp3 ]] || [[ "${currentURL_array_reversed[$currentIterationNext3]}" != "" ]] || [[ -e "$currentAxelTmpFile".tmp4 ]]
				do
					#rm -f "$currentAxelTmpFile"
					rm -f "$currentAxelTmpFile".aria2 > /dev/null 2>&1
					rm -f "$currentAxelTmpFile".tmp > /dev/null 2>&1
					rm -f "$currentAxelTmpFile".tmp.st > /dev/null 2>&1
					rm -f "$currentAxelTmpFile".tmp.aria2 > /dev/null 2>&1
					rm -f "$currentAxelTmpFile".tmp1 > /dev/null 2>&1
					rm -f "$currentAxelTmpFile".tmp1.st > /dev/null 2>&1
					rm -f "$currentAxelTmpFile".tmp1.aria2 > /dev/null 2>&1
					#rm -f "$currentAxelTmpFile".tmp2 > /dev/null 2>&1
					#rm -f "$currentAxelTmpFile".tmp2.st > /dev/null 2>&1
					#rm -f "$currentAxelTmpFile".tmp2.aria2 > /dev/null 2>&1
					#rm -f "$currentAxelTmpFile".* > /dev/null 2>&1
					
					#rm -f "$currentAxelTmpFile".* > /dev/null 2>&1

					# https://github.com/aria2/aria2/issues/1108

					if [[ "${currentURL_array_reversed[$currentIteration]}" != "" ]]
					then
						_messagePlain_probe _gh_downloadURL "${currentURL_array_reversed[$currentIteration]}" -O "$currentAxelTmpFileRelative".tmp1 >&2
						#"$scriptAbsoluteLocation"
						_gh_downloadURL "${currentURL_array_reversed[$currentIteration]}" -O "$currentAxelTmpFileRelative".tmp1 >&2 &
						currentPID_1="$!"
					fi
					
					
					# CAUTION: ATTENTION: Very important. Simultaneous reading and writing is *very* important for writing directly to slow media (ie. BD-R) .
					#  NOTICE: Wirting directly to slow BD-R is essential for burning a Live disc from having booted a Live disc.
					#   DANGER: Critical for rapid recovery back to recent upstream 'ubdist/OS' ! Do NOT unnecessarily degrade this capability!
					#  Also theoretically helpful with especially fast network connections.
					#if [[ "$currentIteration" != "0" ]]
					if [[ -e "$currentAxelTmpFile".tmp2 ]]
					then
						# ATTENTION: Staggered.
						#sleep 10 > /dev/null 2>&1
						wait "$currentPID_2" >&2
						[[ "$currentPID_2" != "" ]] && _pauseForProcess "$currentPID_2" >&2
						#wait >&2

						sleep 0.2 > /dev/null 2>&1
						if [[ -e "$currentAxelTmpFile".tmp2 ]]
						then
							_messagePlain_probe dd if="$currentAxelTmpFile".tmp2 bs=1M status=progress' >> '"$currentAxelTmpFile" >&2
							
							# ### dd if="$currentAxelTmpFile".tmp2 bs=5M status=progress >> "$currentAxelTmpFile"
							dd if="$currentAxelTmpFile".tmp2 bs=1M status=progress
							#cat "$currentAxelTmpFile".tmp2
							
							du -sh "$currentAxelTmpFile".tmp2 >> "$currentAxelTmpFile"
							
							#cat "$currentAxelTmpFile".tmp2 >> "$currentAxelTmpFile"
						fi
					else
						if [[ "$currentIteration" == "0" ]]
						then
							# ATTENTION: Staggered.
							#sleep 6 > /dev/null 2>&1
							true
						fi
					fi
					rm -f "$currentAxelTmpFile".tmp2 > /dev/null 2>&1
					rm -f "$currentAxelTmpFile".tmp2.st > /dev/null 2>&1
					rm -f "$currentAxelTmpFile".tmp2.aria2 > /dev/null 2>&1
					#rm -f "$currentAxelTmpFile".* > /dev/null 2>&1
					
					if [[ "${currentURL_array_reversed[$currentIterationNext1]}" != "" ]]
					then
						_messagePlain_probe _gh_downloadURL "${currentURL_array_reversed[$currentIterationNext1]}" -O "$currentAxelTmpFileRelative".tmp2 >&2
						#"$scriptAbsoluteLocation" 
						_gh_downloadURL "${currentURL_array_reversed[$currentIterationNext1]}" -O "$currentAxelTmpFileRelative".tmp2 >&2 &
						currentPID_2="$!"
					fi
					
					
					
					if [[ -e "$currentAxelTmpFile".tmp3 ]]
					then
						# ATTENTION: Staggered.
						#sleep 10 > /dev/null 2>&1
						wait "$currentPID_3" >&2
						[[ "$currentPID_3" != "" ]] && _pauseForProcess "$currentPID_3" >&2
						#wait >&2

						sleep 0.2 > /dev/null 2>&1
						if [[ -e "$currentAxelTmpFile".tmp3 ]]
						then
							_messagePlain_probe dd if="$currentAxelTmpFile".tmp3 bs=1M status=progress' >> '"$currentAxelTmpFile" >&2
							
							# ### dd if="$currentAxelTmpFile".tmp3 bs=5M status=progress >> "$currentAxelTmpFile"
							dd if="$currentAxelTmpFile".tmp3 bs=1M status=progress
							#cat "$currentAxelTmpFile".tmp3
							
							du -sh "$currentAxelTmpFile".tmp3 >> "$currentAxelTmpFile"
							
							#cat "$currentAxelTmpFile".tmp3 >> "$currentAxelTmpFile"
						fi
					else
						if [[ "$currentIteration" == "0" ]]
						then
							# ATTENTION: Staggered.
							#sleep 6 > /dev/null 2>&1
							true
						fi
					fi
					rm -f "$currentAxelTmpFile".tmp3 > /dev/null 2>&1
					rm -f "$currentAxelTmpFile".tmp3.st > /dev/null 2>&1
					rm -f "$currentAxelTmpFile".tmp3.aria2 > /dev/null 2>&1
					#rm -f "$currentAxelTmpFile".* > /dev/null 2>&1
					
					if [[ "${currentURL_array_reversed[$currentIterationNext2]}" != "" ]]
					then
						_messagePlain_probe _gh_downloadURL "${currentURL_array_reversed[$currentIterationNext2]}" -O "$currentAxelTmpFileRelative".tmp3 >&2
						#"$scriptAbsoluteLocation" 
						_gh_downloadURL "${currentURL_array_reversed[$currentIterationNext2]}" -O "$currentAxelTmpFileRelative".tmp3 >&2 &
						currentPID_3="$!"
					fi
					
					
					
					if [[ -e "$currentAxelTmpFile".tmp4 ]]
					then
						# ATTENTION: Staggered.
						#sleep 10 > /dev/null 2>&1
						wait "$currentPID_4" >&2
						[[ "$currentPID_4" != "" ]] && _pauseForProcess "$currentPID_4" >&2
						#wait >&2

						sleep 0.2 > /dev/null 2>&1
						if [[ -e "$currentAxelTmpFile".tmp4 ]]
						then
							_messagePlain_probe dd if="$currentAxelTmpFile".tmp4 bs=1M status=progress' >> '"$currentAxelTmpFile" >&2
							
							# ### dd if="$currentAxelTmpFile".tmp4 bs=5M status=progress >> "$currentAxelTmpFile"
							dd if="$currentAxelTmpFile".tmp4 bs=1M status=progress
							#cat "$currentAxelTmpFile".tmp4
							
							du -sh "$currentAxelTmpFile".tmp4 >> "$currentAxelTmpFile"
							
							#cat "$currentAxelTmpFile".tmp4 >> "$currentAxelTmpFile"
						fi
					else
						if [[ "$currentIteration" == "0" ]]
						then
							# ATTENTION: Staggered.
							#sleep 6 > /dev/null 2>&1
							true
						fi
					fi
					rm -f "$currentAxelTmpFile".tmp4 > /dev/null 2>&1
					rm -f "$currentAxelTmpFile".tmp4.st > /dev/null 2>&1
					rm -f "$currentAxelTmpFile".tmp4.aria2 > /dev/null 2>&1
					#rm -f "$currentAxelTmpFile".* > /dev/null 2>&1
					
					if [[ "${currentURL_array_reversed[$currentIterationNext3]}" != "" ]]
					then
						_messagePlain_probe _gh_downloadURL "${currentURL_array_reversed[$currentIterationNext3]}" -O "$currentAxelTmpFileRelative".tmp4 >&2
						#"$scriptAbsoluteLocation" 
						_gh_downloadURL "${currentURL_array_reversed[$currentIterationNext3]}" -O "$currentAxelTmpFileRelative".tmp4 >&2 &
						currentPID_4="$!"
					fi
					
					

					# ATTENTION: NOT staggered.
					#wait "$currentPID_1" >&2
					#[[ "$currentPID_1" != "" ]] && _pauseForProcess "$currentPID_1" >&2
					#wait "$currentPID_2" >&2
					#[[ "$currentPID_2" != "" ]] && _pauseForProcess "$currentPID_2" >&2
					#wait "$currentPID_3" >&2
					#[[ "$currentPID_3" != "" ]] && _pauseForProcess "$currentPID_3" >&2
					#wait "$currentPID_4" >&2
					#[[ "$currentPID_4" != "" ]] && _pauseForProcess "$currentPID_4" >&2
					#wait >&2
					
					if [[ "$currentIteration" == "0" ]]
					then
						# CAUTION: Workaround for DUMMY , ONLY . Will NOT, by design, accept files that are both >1part and <4parts .
						#  This is to confidently reject failures to acquire part4 during the initial multiple connections.
						#sleep 7
						sleep 90
						if ( [[ ! -e "$currentAxelTmpFileRelative".tmp1 ]] || [[ ! -e "$currentAxelTmpFileRelative".tmp2 ]] || [[ ! -e "$currentAxelTmpFileRelative".tmp3 ]] || [[ ! -e "$currentAxelTmpFileRelative".tmp4 ]] ) && ! ( [[ -e "$currentAxelTmpFileRelative".tmp1 ]] && ( [[ ! -e "$currentAxelTmpFileRelative".tmp2 ]] || [[ ! -e "$currentAxelTmpFileRelative".tmp3 ]] || [[ ! -e "$currentAxelTmpFileRelative".tmp4 ]] ) )
						then
							_messageFAIL >&2
							_messageFAIL
							_stop 1
							return 1
						fi
						wait "$currentPID_1" >&2
						[[ "$currentPID_1" != "" ]] && _pauseForProcess "$currentPID_1" >&2
						sleep 6 > /dev/null 2>&1
						[[ "$currentPID_2" == "" ]] && sleep 35 > /dev/null 2>&1
						[[ "$currentPID_2" != "" ]] && wait "$currentPID_2" >&2
						[[ "$currentPID_2" != "" ]] && _pauseForProcess "$currentPID_2" >&2
						[[ "$currentPID_3" != "" ]] && wait "$currentPID_3" >&2
						[[ "$currentPID_3" != "" ]] && _pauseForProcess "$currentPID_3" >&2
						[[ "$currentPID_4" != "" ]] && wait "$currentPID_4" >&2
						[[ "$currentPID_4" != "" ]] && _pauseForProcess "$currentPID_4" >&2
						wait >&2
					fi

					wait "$currentPID_1" >&2
					[[ "$currentPID_1" != "" ]] && _pauseForProcess "$currentPID_1" >&2
					sleep 0.2 > /dev/null 2>&1
					if [[ -e "$currentAxelTmpFile".tmp1 ]]
					then
						_messagePlain_probe dd if="$currentAxelTmpFile".tmp1 bs=1M status=progress' >> '"$currentAxelTmpFile" >&2
						
						if [[ ! -e "$currentAxelTmpFile" ]]
						then
							# ### mv -f "$currentAxelTmpFile".tmp1 "$currentAxelTmpFile"
							dd if="$currentAxelTmpFile".tmp1 bs=1M status=progress
							
							du -sh "$currentAxelTmpFile".tmp1 >> "$currentAxelTmpFile"
						else
							# ATTENTION: Staggered.
							#dd if="$currentAxelTmpFile".tmp1 bs=1M status=progress >> "$currentAxelTmpFile" &
						
							# ATTENTION: NOT staggered.
							# ### dd if="$currentAxelTmpFile".tmp1 bs=5M status=progress >> "$currentAxelTmpFile"
							dd if="$currentAxelTmpFile".tmp1 bs=1M status=progress
							#cat "$currentAxelTmpFile".tmp1
							
							du -sh "$currentAxelTmpFile".tmp1 >> "$currentAxelTmpFile"
							
							#cat "$currentAxelTmpFile".tmp1 >> "$currentAxelTmpFile"
						fi
					fi

					let currentIteration=currentIteration+4
					let currentIterationNext1=currentIteration+1
					let currentIterationNext2=currentIteration+2
					let currentIterationNext3=currentIteration+3
				done

				if ! [[ -e "$currentAxelTmpFile" ]]
				then
					true
					# ### return 1
				fi

				# ### cat "$currentAxelTmpFile"

				rm -f "$currentAxelTmpFile"
				rm -f "$currentAxelTmpFile".aria2
				rm -f "$currentAxelTmpFile".tmp
				rm -f "$currentAxelTmpFile".tmp.st
				rm -f "$currentAxelTmpFile".tmp.aria2
				rm -f "$currentAxelTmpFile".tmp1
				rm -f "$currentAxelTmpFile".tmp1.st
				rm -f "$currentAxelTmpFile".tmp1.aria2
				rm -f "$currentAxelTmpFile".tmp2
				rm -f "$currentAxelTmpFile".tmp2.st
				rm -f "$currentAxelTmpFile".tmp2.aria2
				rm -f "$currentAxelTmpFile".tmp3
				rm -f "$currentAxelTmpFile".tmp3.st
				rm -f "$currentAxelTmpFile".tmp3.aria2
				rm -f "$currentAxelTmpFile".tmp4
				rm -f "$currentAxelTmpFile".tmp4.st
				rm -f "$currentAxelTmpFile".tmp4.aria2
				
				rm -f "$currentAxelTmpFile".* > /dev/null 2>&1
				
				
				
			else
				#local currentAxelTmpFile
				#currentAxelTmpFile="$scriptAbsoluteFolder"/.m_axelTmp_$(_uid 14)
				export currentAxelTmpFileRelative=.m_axelTmp_$(_uid 14)
				export currentAxelTmpFile="$scriptAbsoluteFolder"/"$currentAxelTmpFileRelative"
				
				local currentPID_1
				
				local currentIteration
				currentIteration=0
				
				while [[ "${currentURL_array_reversed[$currentIteration]}" != "" ]]
				do
					#_messagePlain_probe _gh_downloadURL "${currentURL_array_reversed[$currentIteration]}" -O - >&2
					##"$scriptAbsoluteLocation"
					#_gh_downloadURL "${currentURL_array_reversed[$currentIteration]}" -O - | dd bs=1M status=progress
					
					
					
					_messagePlain_probe _gh_downloadURL "${currentURL_array_reversed[$currentIteration]}" -O "$currentAxelTmpFile".tmp1 >&2
					#"$scriptAbsoluteLocation"
					_gh_downloadURL "${currentURL_array_reversed[$currentIteration]}" -O "$currentAxelTmpFile".tmp1 >&2 &
					currentPID_1="$!"
					
					sleep 6 > /dev/null 2>&1
					
					wait "$currentPID_1" >&2
					[[ "$currentPID_1" != "" ]] && wait "$currentPID_1" >&2
					[[ "$currentPID_1" != "" ]] && _pauseForProcess "$currentPID_1" >&2
					wait >&2
					
					
					
					dd if="$currentAxelTmpFile".tmp1 bs=1M status=progress
					rm -f "$currentAxelTmpFile".tmp1
					
					
					let currentIteration=currentIteration+1
				done
				
				
				rm -f "$currentAxelTmpFile"
				rm -f "$currentAxelTmpFile".aria2
				rm -f "$currentAxelTmpFile".tmp1
				rm -f "$currentAxelTmpFile".* > /dev/null 2>&1
			fi
			
			
			
			
		else
			_messagePlain_probe curl -H '"Authorization: Bearer $GH_TOKEN"' -L "${currentURL_array_reversed[@]}" >&2
			curl -H "Authorization: Bearer $GH_TOKEN" -L "${currentURL_array_reversed[@]}"
		fi
		return
	fi


	cd "$functionEntryPWD"
}

_wget_githubRelease_join() {
	local functionEntryPWD
	functionEntryPWD="$PWD"

	_messagePlain_probe _wget_githubRelease_join-stdout "$@" '>' "$3" >&2
	if [[ "$FORCE_AXEL" != "" ]]
	then
		_wget_githubRelease_join-stdout "$@" > "$3"
	else
		_wget_githubRelease_join-stdout "$@" > "$3"
	fi

	cd "$functionEntryPWD"
	[[ ! -e "$3" ]] && _messagePlain_bad 'missing: '"$1"' '"$2"' '"$3" && return 1

	cd "$functionEntryPWD"
	return 0
}


_wget_githubRelease_internal-URL() {
	_wget_githubRelease-URL "$1" "internal" "$2"
}

_wget_githubRelease_internal() {
	_wget_githubRelease "$1" "internal" "$2"
}





#####Basic Variable Management

#Reset prefixes.
export tmpPrefix=""
export tmpSelf=""

# ATTENTION: CAUTION: Should only be used by a single unusual Cygwin override. Must be reset if used for any other purpose.
#export descriptiveSelf=""

#####Global variables.
#Fixed unique identifier for ubiquitous bash created global resources, such as bootdisc images to be automaticaly mounted by guests. Should NEVER be changed.
export ubiquitiousBashIDnano=uk4u
export ubiquitiousBashIDshort="$ubiquitiousBashIDnano"PhB6
export ubiquitiousBashID="$ubiquitiousBashIDshort"63kVcygT0q
export ubiquitousBashIDnano=uk4u
export ubiquitousBashIDshort="$ubiquitousBashIDnano"PhB6
export ubiquitousBashID="$ubiquitousBashIDshort"63kVcygT0q

##Parameters
#"--shell", ""
#"--profile"
#"--parent", "--return", "--devenv"
#"--call", "--script" "--bypass"
if [[ "$ub_import_param" == "--profile" ]]
then
	ub_import=true
	export scriptAbsoluteLocation="$profileScriptLocation"
	export scriptAbsoluteFolder="$profileScriptFolder"
	export sessionid=$(_uid)
	_messagePlain_probe_expr 'profile: scriptAbsoluteLocation= '"$scriptAbsoluteLocation"'\n ''profile: scriptAbsoluteFolder= '"$scriptAbsoluteFolder"'\n ''profile: sessionid= '"$sessionid" | _user_log-ub
elif ( [[ "$ub_import_param" == "--parent" ]] || [[ "$ub_import_param" == "--embed" ]] || [[ "$ub_import_param" == "--return" ]] || [[ "$ub_import_param" == "--devenv" ]] ) && [[ "$scriptAbsoluteLocation" != "" ]] && [[ "$scriptAbsoluteFolder" != "" ]] && [[ "$sessionid" != "" ]]
then
	ub_import=true
	true #Do not override.
	_messagePlain_probe_expr 'parent: scriptAbsoluteLocation= '"$scriptAbsoluteLocation"'\n ''parent: scriptAbsoluteFolder= '"$scriptAbsoluteFolder"'\n ''parent: sessionid= '"$sessionid" | _user_log-ub
elif [[ "$ub_import_param" == "--call" ]] || [[ "$ub_import_param" == "--script" ]] || [[ "$ub_import_param" == "--bypass" ]] || [[ "$ub_import_param" == "--shell" ]] || [[ "$ub_import_param" == "--compressed" ]] || ( [[ "$ub_import" == "true" ]] && [[ "$ub_import_param" == "" ]] )
then
	ub_import=true
	export scriptAbsoluteLocation="$importScriptLocation"
	export scriptAbsoluteFolder="$importScriptFolder"
	export sessionid=$(_uid)
	_messagePlain_probe_expr 'call: scriptAbsoluteLocation= '"$scriptAbsoluteLocation"'\n ''call: scriptAbsoluteFolder= '"$scriptAbsoluteFolder"'\n ''call: sessionid= '"$sessionid" | _user_log-ub
elif [[ "$ub_import" != "true" ]]	#"--shell", ""
then
	export scriptAbsoluteLocation=$(_getScriptAbsoluteLocation)
	export scriptAbsoluteFolder=$(_getScriptAbsoluteFolder)
	export sessionid=$(_uid)
	_messagePlain_probe_expr 'default: scriptAbsoluteLocation= '"$scriptAbsoluteLocation"'\n ''default: scriptAbsoluteFolder= '"$scriptAbsoluteFolder"'\n ''default: sessionid= '"$sessionid" | _user_log-ub
else	#FAIL, implies [[ "$ub_import" == "true" ]]
	_messagePlain_bad 'import: fall: fail' | _user_log-ub
	return 1 >/dev/null 2>&1
	exit 1
fi
[[ "$importScriptLocation" != "" ]] && export importScriptLocation=
[[ "$importScriptFolder" != "" ]] && export importScriptFolder=

[[ ! -e "$scriptAbsoluteLocation" ]] && _messagePlain_bad 'missing: scriptAbsoluteLocation= '"$scriptAbsoluteLocation" | _user_log-ub && exit 1
[[ "$sessionid" == "" ]] && _messagePlain_bad 'missing: sessionid' | _user_log-ub && exit 1

#Current directory for preservation.
export outerPWD=$(_getAbsoluteLocation "$PWD")

export initPWD="$PWD"
intInitPWD="$PWD"


# DANGER: CAUTION: Undefined removal of (at least temporary) directories may be possible. Do NOT use without thorough consideration!
# Only known use is setting the temporary directory of a subsequent background process through "$scriptAbsoluteLocation" .
# EXAMPLE: _interactive_pipe() { ... }
if [[ "$ub_force_sessionid" != "" ]]
then
	sessionid="$ub_force_sessionid"
	[[ "$ub_force_sessionid_repeat" != 'true' ]] && export ub_force_sessionid=""
fi


_get_ub_globalVars_sessionDerived() {

export lowsessionid=$(echo -n "$sessionid" | tr A-Z a-z )

# ATTENTION: CAUTION: Unusual Cygwin override to accommodate MSW network drive ( at least when provided by '_userVBox' ) !
if [[ "$scriptAbsoluteFolder" == '/cygdrive/'* ]] && [[ -e /cygdrive ]] && uname -a | grep -i cygwin > /dev/null 2>&1 && [[ "$scriptAbsoluteFolder" != '/cygdrive/c'* ]] && [[ "$scriptAbsoluteFolder" != '/cygdrive/C'* ]]
then
	if [[ "$tmpSelf" == "" ]]
	then
		
		export tmpMSW=$( cd "$LOCALAPPDATA" 2>/dev/null ; pwd )"/Temp"
		[[ ! -e "$tmpMSW" ]] && export tmpMSW=$( cd "$LOCALAPPDATA" 2>/dev/null ; pwd )"/faketemp"
		
		if [[ "$tmpMSW" != "" ]]
		then
			export descriptiveSelf="$sessionid"
			type md5sum > /dev/null 2>&1 && [[ "$scriptAbsoluteLocation" != '/bin/'* ]] && [[ "$scriptAbsoluteLocation" != '/usr/'* ]] && export descriptiveSelf=$(_getScriptAbsoluteLocation | md5sum | head -c 2)$(echo "$sessionid" | head -c 16)
			export tmpSelf="$tmpMSW"/"$descriptiveSelf"
			
			[[ "$descriptiveSelf" == "" ]] && export tmpSelf="$tmpMSW"/"$sessionid"
			true
		fi
		
		( [[ "$tmpSelf" == "" ]] || [[ "$tmpMSW" == "" ]] ) && export tmpSelf=/tmp/"$sessionid"
		true
		
	fi
elif uname -a | grep -i 'microsoft' > /dev/null 2>&1 && uname -a | grep -i 'WSL2' > /dev/null 2>&1
then
	if [[ "$tmpSelf" == "" ]]
	then
		export tmpWSL="$HOME"/.ubtmp
		[[ "$realHome" != "" ]] && export tmpWSL="$realHome"/.ubtmp
		[[ ! -e "$tmpWSL" ]] && mkdir -p "$tmpWSL"
		
		if [[ "$tmpWSL" != "" ]]
		then
			export descriptiveSelf="$sessionid"
			type md5sum > /dev/null 2>&1 && [[ "$scriptAbsoluteLocation" != '/bin/'* ]] && [[ "$scriptAbsoluteLocation" != '/usr/'* ]] && export descriptiveSelf=$(_getScriptAbsoluteLocation | md5sum | head -c 2)$(echo "$sessionid" | head -c 16)
			export tmpSelf="$tmpWSL"/"$descriptiveSelf"

			[[ "$descriptiveSelf" == "" ]] && export tmpSelf="$tmpWSL"/"$sessionid"
			true
		fi

		( [[ "$tmpSelf" == "" ]] || [[ "$tmpWSL" == "" ]] ) && export tmpSelf=/tmp/"$sessionid"
		true
	fi
fi


# CAUTION: 'Proper' UNIX platforms are expected to use "$scriptAbsoluteFolder" as "$tmpSelf" . Only by necessity may these variables be different.
# CAUTION: If not blank, '$tmpSelf' must include first 16 digits of "$sessionid". Failure to do so may cause 'rmdir' collisions and prevent '_safeRMR' from allowing appropriate removal.
# Virtualization and OS image modification functions in particular are not guaranteed to have been otherwise tested.
[[ "$tmpSelf" == "" ]] && export tmpSelf="$scriptAbsoluteFolder"

#Temporary directories.
export safeTmp="$tmpSelf""$tmpPrefix"/w_"$sessionid"
export scopeTmp="$tmpSelf""$tmpPrefix"/s_"$sessionid"
export queryTmp="$tmpSelf""$tmpPrefix"/q_"$sessionid"
export logTmp="$safeTmp"/log
#Solely for misbehaved applications called upon.
export shortTmp=/tmp/w_"$sessionid"
[[ "$tmpMSW" != "" ]] && export shortTmp="$tmpMSW"/w_"$sessionid"

}
_get_ub_globalVars_sessionDerived "$@"






export scriptBin="$scriptAbsoluteFolder"/_bin
export scriptBundle="$scriptAbsoluteFolder"/_bundle
export scriptLib="$scriptAbsoluteFolder"/_lib
#For trivial installations and virtualized guests. Exclusively intended to support _setupUbiquitous and _drop* hooks.
[[ ! -e "$scriptBin" ]] && export scriptBin="$scriptAbsoluteFolder"
[[ ! -e "$scriptBundle" ]] && export scriptBundle="$scriptAbsoluteFolder"
[[ ! -e "$scriptLib" ]] && export scriptLib="$scriptAbsoluteFolder"


# WARNING: Standard relied upon by other standalone scripts (eg. MSW compatible _anchor.bat )
export scriptLocal="$scriptAbsoluteFolder"/_local

#For system installations (exclusively intended to support _setupUbiquitous and _drop* hooks).
if [[ "$scriptAbsoluteLocation" == "/usr/local/bin"* ]] || [[ "$scriptAbsoluteLocation" == "/usr/bin"* ]]
then
	[[ "$scriptAbsoluteLocation" == "/usr/bin"* ]] && export scriptBin="/usr/share/ubcore/bin"
	[[ "$scriptAbsoluteLocation" == "/usr/local/bin"* ]] && export scriptBin="/usr/local/share/ubcore/bin"
	
	if [[ -d "$HOME" ]]
	then
		export scriptLocal="$HOME"/".ubcore"/_sys
	fi
fi

#Essentially temporary tokens which may need to be reused. 
export scriptTokens="$scriptLocal"/.tokens

#Reboot Detection Token Storage
# WARNING WIP. Not tested on all platforms. Requires a directory to be tmp/ram fs mounted. Worst case result is to preserve tokens across reboots.
# WARNING: Does NOT work on Cygwin, files written to either '/tmp' or '/dev/shm' are persistent.
#Fail-Safe
export bootTmp="$scriptLocal"
#Typical BSD
[[ -d /tmp ]] && export bootTmp='/tmp'
#Typical Linux
[[ -d /dev/shm ]] && export bootTmp='/dev/shm'
#Typical MSW - WARNING: Persistent!
[[ "$tmpMSW" != "" ]] && export bootTmp="$tmpMSW"

#Specialized temporary directories.

#MetaEngine/Engine Tmp Defaults (example, no production use)
#export metaTmp="$tmpSelf""$tmpPrefix"/.m_"$sessionid"
#export engineTmp="$tmpSelf""$tmpPrefix"/.e_"$sessionid"

# WARNING: Only one user per (virtual) machine. Requires _prepare_abstract . Not default.
# DANGER: Mandatory strict directory 8.3 compliance for this variable! Long subdirectory/filenames permitted thereafter.
# DANGER: Permitting multi-user access to this directory may cause unexpected behavior, including inconsitent file ownership.
#Consistent absolute path abstraction.
export abstractfs_root=/tmp/"$ubiquitousBashIDnano"
( [[ "$bootTmp" == '/dev/shm' ]] || [[ "$bootTmp" == '/tmp' ]] || [[ "$tmpMSW" != "" ]] ) && export abstractfs_root="$bootTmp"/"$ubiquitousBashIDnano"
export abstractfs_lock="$bootTmp"/"$ubiquitousBashID"/afslock

# Unusually, safeTmpSSH must not be interpreted by client, and therefore is single quoted.
# TODO Test safeTmpSSH variants including spaces in path.
export safeTmpSSH='~/.sshtmp/.s_'"$sessionid"

#Process control.
export pidFile="$safeTmp"/.pid
#Invalid do-not-match default.
export uPID="cwrxuk6wqzbzV6p8kPS8J4APYGX"

export daemonPidFile="$scriptLocal"/.bgpid

#export varStore="$scriptAbsoluteFolder"/var

export vncPasswdFile="$safeTmp"/.vncpasswd

#Network Defaults
[[ "$netTimeout" == "" ]] && export netTimeout=18

export AUTOSSH_FIRST_POLL=45
export AUTOSSH_POLL=45
#export AUTOSSH_GATETIME=0
export AUTOSSH_GATETIME=15

#export AUTOSSH_PORT=0

#export AUTOSSH_DEBUG=1
#export AUTOSSH_LOGLEVEL=7

#Monolithic shared files.
export lock_pathlock="$scriptLocal"/l_path
#Used to make locking operations atomic as possible.
export lock_quicktmp="$scriptLocal"/l_qt
export lock_emergency="$scriptLocal"/l_em
export lock_open="$scriptLocal"/l_o
export lock_opening="$scriptLocal"/l_opening
export lock_closed="$scriptLocal"/l_closed
export lock_closing="$scriptLocal"/l_closing
export lock_instance="$scriptLocal"/l_instance
export lock_instancing="$scriptLocal"/l_instancing

#Specialized lock files. Recommend five character or less suffix. Not all of these may yet be implemented.
export specialLocks
specialLocks=""

export lock_open_image="$lock_open"-img
specialLocks+=("$lock_open_image")

export lock_loop_image="$lock_open"-loop
specialLocks+=("$lock_loop_image")

export lock_open_chroot="$lock_open"-chrt
specialLocks+=("$lock_open_chroot")
export lock_open_docker="$lock_open"-dock
specialLocks+=("$lock_open_docker")
export lock_open_vbox="$lock_open"-vbox
specialLocks+=("$lock_open_vbox")
export lock_open_qemu="$lock_open"-qemu
specialLocks+=("$lock_open_qemu")

export specialLock=""
export specialLocks

export ubVirtImageLocal="true"

#Monolithic shared log files.
export importLog="$scriptLocal"/import.log

#Resource directories.
#export guidanceDir="$scriptAbsoluteFolder"/guidance

#Object Dir
export objectDir="$scriptAbsoluteFolder"

#Object Name
export objectName=$(basename "$objectDir")

#Modify PATH to include own directories.
if ! [[ "$PATH" == *":""$scriptAbsoluteFolder"* ]] && ! [[ "$PATH" == "$scriptAbsoluteFolder"* ]]
then
	export PATH="$PATH":"$scriptAbsoluteFolder":"$scriptBin":"$scriptBundle"
fi

export permaLog="$scriptLocal"

export HOST_USER_ID=$(id -u)
export HOST_GROUP_ID=$(id -g)

export globalArcDir="$scriptLocal"/a
export globalArcFS="$globalArcDir"/fs
export globalArcTmp="$globalArcDir"/tmp

export globalBuildDir="$scriptLocal"/b
export globalBuildFS="$globalBuildDir"/fs
export globalBuildTmp="$globalBuildDir"/tmp


export ub_anchor_specificSoftwareName=""
export ub_anchor_specificSoftwareName

export ub_anchor_user=""
export ub_anchor_user

export ub_anchor_autoupgrade=""
export ub_anchor_autoupgrade





#_set_GH_TOKEN() {
	#[[ "$GH_TOKEN" != "" ]] && export GH_TOKEN=$(_safeEcho "$GH_TOKEN" | tr -dc 'a-zA-Z0-9_')
	#[[ "$INPUT_GITHUB_TOKEN" != "" ]] && export INPUT_GITHUB_TOKEN=$(_safeEcho "$INPUT_GITHUB_TOKEN" | tr -dc 'a-zA-Z0-9_')
#}
#_set_GH_TOKEN


#####Local Environment Management (Resources)

#_prepare_prog() {
#	true
#}

_extra() {
	true
}

_prepare_abstract() {
	! mkdir -p "$abstractfs_root" && exit 1
	chmod 0700 "$abstractfs_root" > /dev/null 2>&1
	! chmod 700 "$abstractfs_root" && exit 1
	
	if [[ "$CI" != "" ]] && ! type chown > /dev/null 2>&1
	then
		chown() {
			true
		}
	fi
	
	if _if_cygwin
	then
		if ! chown "$USER":None "$abstractfs_root" > /dev/null 2>&1
		then
			! chown "$USER" "$abstractfs_root" && exit 1
		fi
	else
		if ! chown "$USER":"$USER" "$abstractfs_root" > /dev/null 2>&1
		then
			if [[ -e /sbin/chown ]]
			then
				! /sbin/chown "$USER" "$abstractfs_root" && exit 1
			else
				! /usr/bin/chown "$USER" "$abstractfs_root" && exit 1
			fi
		fi
	fi
	
	
	
	
	! mkdir -p "$abstractfs_lock" && exit 1
	chmod 0700 "$abstractfs_lock" > /dev/null 2>&1
	! chmod 700 "$abstractfs_lock" && exit 1
	
	if _if_cygwin
	then
		if ! chown "$USER":None "$abstractfs_lock" > /dev/null 2>&1
		then
			! chown "$USER" "$abstractfs_lock" && exit 1
		fi
	else
		if ! chown "$USER":"$USER" "$abstractfs_lock" > /dev/null 2>&1
		then
			if [[ -e /sbin/chown ]]
			then
				! /sbin/chown "$USER" "$abstractfs_lock" && exit 1
			else
				! /usr/bin/chown "$USER" "$abstractfs_lock" && exit 1
			fi
		fi
	fi
}

_prepare() {
	
	! mkdir -p "$safeTmp" && exit 1
	
	! mkdir -p "$shortTmp" && exit 1
	
	! mkdir -p "$logTmp" && exit 1
	
	[[ "$*" != *scriptLocal_mkdir_disable* ]] && ! mkdir -p "$scriptLocal" && exit 1
	
	! mkdir -p "$bootTmp" && exit 1
	
	# WARNING: No production use. Not guaranteed to be machine readable.
	[[ "$tmpSelf" != "$scriptAbsoluteFolder" ]] && echo "$tmpSelf" 2> /dev/null > "$scriptAbsoluteFolder"/__d_$(echo "$sessionid" | head -c 16)
	
	#_prepare_abstract
	
	_extra
	_tryExec "_prepare_prog"
}

#####Local Environment Management (Instancing)

#_start_prog() {
#	true
#}

# ATTENTION: Consider carefully, override with "ops".
# WARNING: Unfortunate, but apparently necessary, workaround for script termintaing while "sleep" or similar run under background.
_start_stty_echo() {
	#true
	
	#stty echo --file=/dev/tty > /dev/null 2>&1
	
	export ubFoundEchoStatus=$(stty --file=/dev/tty -g 2>/dev/null)
}

_start() {
	_start_stty_echo
	
	_prepare "$@"
	
	#touch "$varStore"
	#. "$varStore"
	
	echo $$ > "$safeTmp"/.pid
	echo "$sessionid" > "$safeTmp"/.sessionid
	_embed_here > "$safeTmp"/.embed.sh
	chmod 755 "$safeTmp"/.embed.sh
	
	_tryExec "_start_prog"
}

#_saveVar_prog() {
#	true
#}

_saveVar() {
	true
	#declare -p varName > "$varStore"
	
	_tryExec "_saveVar_prog"
}

#_stop_prog() {
#	true
#}

# ATTENTION: Consider carefully, override with "ops".
# WARNING: Unfortunate, but apparently necessary, workaround for script termintaing while "sleep" or similar run under background.
_stop_stty_echo() {
	#true
	
	#stty echo --file=/dev/tty > /dev/null 2>&1
	
	[[ "$ubFoundEchoStatus" != "" ]] && stty --file=/dev/tty "$ubFoundEchoStatus" 2> /dev/null
}

# DANGER: Use of "_stop" must NOT require successful "_start". Do NOT include actions which would not be safe if "_start" was not used or unsuccessful.
_stop() {
	_stop_stty_echo
	
	_tryExec "_stop_prog"
	
	_tryExec "_stop_queue_page"
	_tryExec "_stop_queue_aggregatorStatic"
	
	_preserveLog
	
	#Kill process responsible for initiating session. Not expected to be used normally, but an important fallback.
	local ub_stop_pid
	if [[ -e "$safeTmp"/.pid ]]
	then
		ub_stop_pid=$(cat "$safeTmp"/.pid 2> /dev/null)
		if [[ $$ != "$ub_stop_pid" ]]
		then
			pkill -P "$ub_stop_pid" > /dev/null 2>&1
			kill "$ub_stop_pid" > /dev/null 2>&1
		fi
	fi
	#Redundant, as this usually resides in "$safeTmp".
	rm -f "$pidFile" > /dev/null 2>&1
	
	
	# https://stackoverflow.com/questions/25906020/are-pid-files-still-flawed-when-doing-it-right/25933330
	# https://stackoverflow.com/questions/360201/how-do-i-kill-background-processes-jobs-when-my-shell-script-exits
	local currentStopJobs
	currentStopJobs=$(jobs -p -r 2> /dev/null)
	# WARNING: Although usually bad practice, it is useful for the spaces between PIDs to be interpreted in this case.
	# DANGER: Apparently, it is possible for some not running background jobs to be included in the PID list.
	[[ "$currentStopJobs" != "" ]] && kill $currentStopJobs > /dev/null 2>&1
	
	
	if [[ -e "$scopeTmp" ]] && [[ -e "$scopeTmp"/.pid ]] && [[ "$$" == $(cat "$scopeTmp"/.pid 2>/dev/null) ]]
	then
		#Symlink, or nonexistent.
		rm -f "$ub_scope" > /dev/null 2>&1
		#Only created if needed by scope.
		[[ -e "$scopeTmp" ]] && _safeRMR "$scopeTmp"
	fi
	
	#Only created if needed by query.
	[[ -e "$queryTmp" ]] && _safeRMR "$queryTmp"
	
	#Only created if needed by engine.
	[[ -e "$engineTmp" ]] && _safeRMR "$engineTmp"
	
	_tryExec _rm_instance_metaengine
	_tryExec _rm_instance_channel
	
	_safeRMR "$shortTmp"
	_safeRMR "$safeTmp"
	
	[[ -e "$safeTmp" ]] && sleep 0.1 && _safeRMR "$safeTmp"
	[[ -e "$safeTmp" ]] && sleep 0.3 && _safeRMR "$safeTmp"
	[[ -e "$safeTmp" ]] && sleep 1 && _safeRMR "$safeTmp"
	[[ -e "$safeTmp" ]] && sleep 3 && _safeRMR "$safeTmp"
	[[ -e "$safeTmp" ]] && sleep 3 && _safeRMR "$safeTmp"
	[[ -e "$safeTmp" ]] && sleep 3 && _safeRMR "$safeTmp"
	
	_tryExec _rm_instance_fakeHome
	
	#Optionally always try to remove any systemd shutdown hook.
	#_tryExec _unhook_systemd_shutdown
	
	[[ "$tmpSelf" != "$scriptAbsoluteFolder" ]] && [[ "$tmpSelf" != "/" ]] && [[ -e "$tmpSelf" ]] && rmdir "$tmpSelf" > /dev/null 2>&1
	rm -f "$scriptAbsoluteFolder"/__d_$(echo "$sessionid" | head -c 16) > /dev/null 2>&1

	#currentAxelTmpFile="$scriptAbsoluteFolder"/.m_axelTmp_$(_uid 14)
	if [[ "$currentAxelTmpFile" != "" ]]
	then
		rm -f "$currentAxelTmpFile" > /dev/null 2>&1
		rm -f "$currentAxelTmpFile".st > /dev/null 2>&1
		rm -f "$currentAxelTmpFile".tmp > /dev/null 2>&1
		rm -f "$currentAxelTmpFile".tmp.st > /dev/null 2>&1
		rm -f "$currentAxelTmpFile".tmp.aria2 > /dev/null 2>&1
		rm -f "$currentAxelTmpFile".tmp1 > /dev/null 2>&1
		rm -f "$currentAxelTmpFile".tmp1.st > /dev/null 2>&1
		rm -f "$currentAxelTmpFile".tmp1.aria2 > /dev/null 2>&1
		rm -f "$currentAxelTmpFile".tmp2 > /dev/null 2>&1
		rm -f "$currentAxelTmpFile".tmp2.st > /dev/null 2>&1
		rm -f "$currentAxelTmpFile".tmp2.aria2 > /dev/null 2>&1
		rm -f "$currentAxelTmpFile".tmp3 > /dev/null 2>&1
		rm -f "$currentAxelTmpFile".tmp3.st > /dev/null 2>&1
		rm -f "$currentAxelTmpFile".tmp3.aria2 > /dev/null 2>&1
		rm -f "$currentAxelTmpFile".tmp4 > /dev/null 2>&1
		rm -f "$currentAxelTmpFile".tmp4.st > /dev/null 2>&1
		rm -f "$currentAxelTmpFile".tmp4.aria2 > /dev/null 2>&1
			
		rm -f "$currentAxelTmpFile"* > /dev/null 2>&1
	fi
	
	_stop_stty_echo
	if [[ "$1" != "" ]]
	then
		exit "$1"
	else
		exit 0
	fi
}

#Do not overload this unless you know why you need it instead of _stop_prog.
#_stop_emergency_prog() {
#	true
#}

#Called upon SIGTERM or similar signal.
_stop_emergency() {
	[[ "$noEmergency" == true ]] && _stop "$1"
	
	export EMERGENCYSHUTDOWN=true
	
	#Not yet using _tryExec since this function would typically result from user intervention, or system shutdown, both emergency situations in which an error message would be ignored if not useful. Higher priority is guaranteeing execution if needed and available.
	_tryExec "_closeChRoot_emergency"
	
	#Daemon uses a separate instance, and will not be affected by previous actions, possibly even if running in the foreground.
	#jobs -p >> "$daemonPidFile" #Could derrange the correct order of descendent job termination.
	_tryExec _killDaemon
	
	_tryExec _stop_virtLocal
	
	_tryExec "_stop_emergency_prog"
	
	_stop "$1"
	
}

_waitFile() {
	
	[[ -e "$1" ]] && sleep 1
	[[ -e "$1" ]] && sleep 9
	[[ -e "$1" ]] && sleep 27
	[[ -e "$1" ]] && sleep 81
	[[ -e "$1" ]] && _return 1
	
	return 0
}

#Wrapper. If lock file is present, waits for unlocking operation to complete successfully, then reports status.
#"$1" == checkFile
#"$@" == wait command and parameters
_waitFileCommands() {
	local waitCheckFile
	waitCheckFile="$1"
	shift
	
	if [[ -e "$waitCheckFile" ]]
	then
		local waitFileCommandStatus
		
		"$@"
		
		waitFileCommandStatus="$?"
		
		if [[ "$waitFileCommandStatus" != "0" ]]
		then
			return "$waitFileCommandStatus"
		fi
		
		[[ -e "$waitCheckFile" ]] && return 1
		
	fi
	
	return 0
}

#$1 == command to execute if scriptLocal path has changed, typically remove another lock file
_pathLocked() {
	[[ ! -e "$lock_pathlock" ]] && echo "k3riC28hQRLnjgkwjI" > "$lock_pathlock"
	[[ ! -e "$lock_pathlock" ]] && return 1
	
	local lockedPath
	lockedPath=$(cat "$lock_pathlock")
	
	if [[ "$lockedPath" != "$scriptLocal" ]]
	then
		rm -f "$lock_pathlock" > /dev/null 2>&1
		[[ -e "$lock_pathlock" ]] && return 1
		
		echo "$scriptLocal" > "$lock_pathlock"
		[[ ! -e "$lock_pathlock" ]] && return 1
		
		if [[ "$1" != "" ]]
		then
			"$@"
			[[ "$?" != "0" ]] && return 1
		fi
		
	fi
	
	return 0
}

_readLocked() {
	mkdir -p "$bootTmp"
	
	local rebootToken
	rebootToken=$(cat "$1" 2> /dev/null)
	
	#Remove miscellaneous files if appropriate.
	if [[ -d "$bootTmp" ]] && ! [[ -e "$bootTmp"/"$rebootToken" ]]
	then
		rm -f "$scriptLocal"/*.log && rm -f "$scriptLocal"/imagedev && rm -f "$scriptLocal"/WARNING
		
		[[ -e "$lock_quicktmp" ]] && sleep 0.1 && [[ -e "$lock_quicktmp" ]] && rm -f "$lock_quicktmp"
	fi
	
	! [[ -e "$1" ]] && return 1
	##Lock file exists.
	
	if [[ -d "$bootTmp" ]]
	then
		if ! [[ -e "$bootTmp"/"$rebootToken" ]]
		then
			##Lock file obsolete.
			
			#Remove old lock.
			rm -f "$1" > /dev/null 2>&1
			return 1
		fi
		
		##Lock file and token exists.
		return 0
	fi
	
	##Lock file exists, token cannot be found.
	return 0
	
	
	
}

#Using _readLocked before any _createLocked operation is strongly recommended to remove any lock from prior UNIX session (ie. before latest reboot).
_createLocked() {
	[[ "$uDEBUG" == true ]] && caller 0 >> "$scriptLocal"/lock.log
	[[ "$uDEBUG" == true ]] && echo -e '\t'"$sessionid"'\t'"$1" >> "$scriptLocal"/lock.log
	
	mkdir -p "$bootTmp"
	
	! [[ -e "$bootTmp"/"$sessionid" ]] && echo > "$bootTmp"/"$sessionid"
	
	# WARNING Recommend setting this to a permanent value when testing critical subsystems, such as with _userChRoot related operations.
	local lockUID="$(_uid)"
	
	echo "$sessionid" > "$lock_quicktmp"_"$lockUID"
	
	mv -n "$lock_quicktmp"_"$lockUID" "$1" > /dev/null 2>&1
	
	if [[ -e "$lock_quicktmp"_"$lockUID" ]]
	then
		[[ "$uDEBUG" == true ]] && echo -e '\t'FAIL >> "$scriptLocal"/lock.log
		rm -f "$lock_quicktmp"_"$lockUID" > /dev/null 2>&1
		return 1
	fi
	
	rm -f "$lock_quicktmp"_"$lockUID" > /dev/null 2>&1
	return 0
}

_resetLocks() {
	
	_readLocked "$lock_open"
	_readLocked "$lock_opening"
	_readLocked "$lock_closed"
	_readLocked "$lock_closing"
	_readLocked "$lock_instance"
	_readLocked "$lock_instancing"
	
}

_checkSpecialLocks() {
	local localSpecialLock
	
	localSpecialLock="$specialLock"
	[[ "$1" != "" ]] && localSpecialLock="$1"
	
	local currentLock
	
	for currentLock in "${specialLocks[@]}"
	do
		[[ "$currentLock" == "$localSpecialLock" ]] && continue
		_readLocked "$currentLock" && return 0
	done
	
	return 1
}

#Wrapper. Operates lock file for mounting shared resources (eg. persistent virtual machine image). Avoid if possible.
#"$1" == waitOpen function && shift
#"$@" == wrapped function and parameters
#"$specialLock" == additional lockfile to write
_open_sequence() {
	if _readLocked "$lock_open"
	then
		_checkSpecialLocks && return 1
		return 0
	fi
	
	_readLocked "$lock_closing" && return 1
	
	if _readLocked "$lock_opening"
	then
		if _waitFileCommands "$lock_opening" "$1"
		then
			_readLocked "$lock_open" || return 1
			return 0
		else
			return 1
		fi
	fi
	
	_createLocked "$lock_opening" || return 1
	
	shift
	
	echo "LOCKED" > "$scriptLocal"/WARNING
	
	"$@"
	
	if [[ "$?" == "0" ]]
	then
		_createLocked "$lock_open" || return 1
		
		if [[ "$specialLock" != "" ]]
		then
			_createLocked "$specialLock" || return 1
		fi
		
		rm -f "$lock_opening"
		return 0
	fi
	
	return 1
}

_open() {
	local returnStatus
	
	_open_sequence "$@"
	returnStatus="$?"
	
	export specialLock
	specialLock=""
	export specialLock
	
	return "$returnStatus"
}

#Wrapper. Operates lock file for shared resources (eg. persistent virtual machine image). Avoid if possible.
#"$1" == <"--force"> && shift
#"$1" == waitClose function && shift
#"$@" == wrapped function and parameters
#"$specialLock" == additional lockfile to remove
_close_sequence() {
	local closeForceEnable
	closeForceEnable=false
	
	if [[ "$1" == "--force" ]]
	then
		closeForceEnable=true
		shift
	fi
	
	if ! _readLocked "$lock_open" && [[ "$closeForceEnable" != "true" ]]
	then
		return 0
	fi
	
	if [[ "$specialLock" != "" ]] && [[ -e "$specialLock" ]] && ! _readLocked "$specialLock" && [[ "$closeForceEnable" != "true" ]]
	then
		return 1
	fi
	
	_checkSpecialLocks && return 1
	
	if _readLocked "$lock_closing" && [[ "$closeForceEnable" != "true" ]]
	then
		if _waitFileCommands "$lock_closing" "$1"
		then
			return 0
		else
			return 1
		fi
	fi
	
	if [[ "$closeForceEnable" != "true" ]]
	then
		_createLocked "$lock_closing" || return 1
	fi
	! _readLocked "$lock_closing" && _createLocked "$lock_closing"
	
	shift
	
	"$@"
	
	if [[ "$?" == "0" ]]
	then
		#rm -f "$lock_open" || return 1
		rm -f "$lock_open"
		[[ -e "$lock_open" ]] && return 1
		
		if [[ "$specialLock" != "" ]] && [[ -e "$specialLock" ]]
		then
			#rm -f "$specialLock" || return 1
			rm -f "$specialLock"
			[[ -e "$specialLock" ]] && return 1
		fi
		
		rm -f "$lock_closing"
		rm -f "$scriptLocal"/WARNING
		return 0
	fi
	
	return 1
}

_close() {
	local returnStatus
	
	_close_sequence "$@"
	returnStatus="$?"
	
	export specialLock
	specialLock=""
	export specialLock
	
	return "$returnStatus"
}

#"$1" == variable name to preserve
#shift
#"$1" == variable data to preserve
#shift
#"$@" == function to prepare other variables
_preserveVar() {
	local varNameToPreserve
	varNameToPreserve="$1"
	shift
	
	local varDataToPreserve
	varDataToPreserve="$1"
	shift
	
	"$@"
	
	[[ "$varNameToPreserve" == "" ]] && return
	[[ "$varDataToPreserve" == "" ]] && return
	
	export "$varNameToPreserve"="$varDataToPreserve"
	
	return
}


#####Installation

_installation_nonet_default() {
	if [[ "$nonet" != 'false' ]]
	then
		[[ "$scriptAbsoluteFolder" == /media/"$USER"* ]] && [[ -e /media/"$USER" ]] && export nonet='true'
		[[ "$scriptAbsoluteFolder" == /mnt/"$USER"* ]] && [[ -e /mnt/"$USER" ]] && export nonet='true'
		[[ "$scriptAbsoluteFolder" == /var/run/media/"$USER"* ]] && [[ -e /var/run/media/"$USER" ]] && export nonet='true'
		[[ "$scriptAbsoluteFolder" == /run/"$USER"* ]] && [[ -e /run/"$USER" ]] && currentParameter=/run/"$USER" && export nonet='true'
		[[ "$scriptAbsoluteFolder" == "/cygdrive"* ]] && [[ -e /cygdrive ]] && export nonet='true'
	fi
	
	return 0
}

_vector_line_cksum() {
	[[ $(echo test | env CMD_ENV=xpg4 cksum | cut -f1 -d\  | tr -dc '0-9') != '935282863' ]] && echo 'broken cksum' && _messageFAIL && _stop 1
	
	[[ $(echo -e '1\n2\n3\n4\n5\n6\n7\n8\n9\n0' | tail -n +2 | env CMD_ENV=xpg4 cksum | cut -f1 -d\  | tr -dc '0-9') != '2409981071' ]] && _messageFAIL && _stop 1
	[[ $(echo -e '1\n2\n3\n4\n5\n6\n7\n8\n9\n0' | tail -n +2 | wc -l | cut -f1 -d\  | tr -dc '0-9') != '9' ]] && _messageFAIL && _stop 1
	
	[[ $(echo -e '1\n2\n3\n4\n5\n6\n7\n8\n9\n0' | tail -n 2 | env CMD_ENV=xpg4 cksum | cut -f1 -d\  | tr -dc '0-9') != '763220757' ]] && _messageFAIL && _stop 1
	[[ $(echo -e '1\n2\n3\n4\n5\n6\n7\n8\n9\n0' | tail -n 2 | wc -l | cut -f1 -d\  | tr -dc '0-9') != '2' ]] && _messageFAIL && _stop 1
	
	[[ $(echo -e '1\n2\n3\n4\n5\n6\n7\n8\n9\n0' | head -n 2 | env CMD_ENV=xpg4 cksum | cut -f1 -d\  | tr -dc '0-9') != '1864731933' ]] && _messageFAIL && _stop 1
	[[ $(echo -e '1\n2\n3\n4\n5\n6\n7\n8\n9\n0' | head -n 2 | wc -l | cut -f1 -d\  | tr -dc '0-9') != '2' ]] && _messageFAIL && _stop 1
	
	[[ $(echo -e '1\n2\n3\n4\n5\n6\n7\n8\n9\n0' | head -n -2 | env CMD_ENV=xpg4 cksum | cut -f1 -d\  | tr -dc '0-9') != '3336706933' ]] && _messageFAIL && _stop 1
	[[ $(echo -e '1\n2\n3\n4\n5\n6\n7\n8\n9\n0' | head -n -2 | wc -l | cut -f1 -d\  | tr -dc '0-9') != '8' ]] && _messageFAIL && _stop 1
	
	return 0
}

_vector() {
	_tryExec "_vector_line_cksum"
	
	
	_tryExec "_vector_virtUser"
	
	
	_tryExec "_vector_ollama"
}




#Verifies the timeout and sleep commands work properly, with subsecond specifications.
_timetest() {
	local iterations
	local dateA
	local dateB
	local dateDelta
	
	local nsDateA
	local nsDateB
	local nsDateDelta
	
	iterations=0
	#while false && [[ "$iterations" -lt 3 ]]
	while [[ "$iterations" -lt 3 ]]
	do
		dateA=$(date +%s)
		nsDateA=$(date +%s%N)
		
		sleep 0.1
		sleep 0.1
		sleep 0.1
		sleep 0.1
		sleep 0.1
		sleep 0.1
		
		_timeout 0.1 sleep 10
		_timeout 0.1 sleep 10
		_timeout 0.1 sleep 10
		_timeout 0.1 sleep 10
		_timeout 0.1 sleep 10
		_timeout 0.1 sleep 10
		
		dateB=$(date +%s)
		nsDateB=$(date +%s%N)
		
		dateDelta=$(bc <<< "$dateB - $dateA")
		nsDateDelta=$(bc <<< "$nsDateB - $nsDateA")
		
		if [[ "$dateDelta" -lt "1" ]]
		then
			_messageFAIL
			_stop 1
		fi
		
		if [[ "$dateDelta" -gt "5" ]]
		then
			_messageFAIL
			_stop 1
		fi
		
		if [[ $(echo -e -n "$nsDateDelta" | wc -c) != '10' ]]
		then
			_messageFAIL
			_stop 1
		fi
		
		if [[ "$nsDateDelta" -lt '1000000000' ]]
		then
			_messageFAIL
			_stop 1
		fi
		
		if [[ $(echo -e -n "$nsDateDelta" | cut -b1-4) -lt 1000 ]]
		then
			_messageFAIL
			_stop 1
		fi
		
		if [[ $(echo -e -n "$nsDateDelta" | cut -b1-8) -gt '50000000' ]]
		then
			_messageFAIL
			_stop 1
		fi
		
		if [[ $(echo -e -n "$nsDateDelta" | cut -b1-4) -gt 5000 ]]
		then
			_messageFAIL
			_stop 1
		fi
		
		
		
		
		
		dateA=$(date +%s)
		nsDateA=$(date +%s%N)
		
		sleep 0.123
		sleep 0.123
		sleep 0.123
		sleep 0.123
		sleep 0.123
		sleep 0.123
		
		_timeout 0.123 sleep 10
		_timeout 0.123 sleep 10
		_timeout 0.123 sleep 10
		_timeout 0.123 sleep 10
		_timeout 0.123 sleep 10
		_timeout 0.123 sleep 10
		
		dateB=$(date +%s)
		nsDateB=$(date +%s%N)
		
		dateDelta=$(bc <<< "$dateB - $dateA")
		nsDateDelta=$(bc <<< "$nsDateB - $nsDateA")
		
		if [[ "$dateDelta" -lt "1" ]]
		then
			_messageFAIL
			_stop 1
		fi
		
		if [[ "$dateDelta" -gt "5" ]]
		then
			_messageFAIL
			_stop 1
		fi
		
		if [[ $(echo -e -n "$nsDateDelta" | wc -c) != '10' ]]
		then
			_messageFAIL
			_stop 1
		fi
		
		if [[ "$nsDateDelta" -lt '1000000000' ]]
		then
			_messageFAIL
			_stop 1
		fi
		
		if [[ $(echo -e -n "$nsDateDelta" | cut -b1-4) -lt 1000 ]]
		then
			_messageFAIL
			_stop 1
		fi
		
		if [[ $(echo -e -n "$nsDateDelta" | cut -b1-8) -gt '50000000' ]]
		then
			_messageFAIL
			_stop 1
		fi
		
		if [[ $(echo -e -n "$nsDateDelta" | cut -b1-4) -gt 5000 ]]
		then
			_messageFAIL
			_stop 1
		fi
		
		
		
		
		dateA=$(date +%s)
		nsDateA=$(date +%s%N)
		
		sleep .123
		sleep .123
		sleep .123
		sleep .123
		sleep .123
		sleep .123
		
		_timeout .123 sleep 10
		_timeout .123 sleep 10
		_timeout .123 sleep 10
		_timeout .123 sleep 10
		_timeout .123 sleep 10
		_timeout .123 sleep 10
		
		dateB=$(date +%s)
		nsDateB=$(date +%s%N)
		
		dateDelta=$(bc <<< "$dateB - $dateA")
		nsDateDelta=$(bc <<< "$nsDateB - $nsDateA")
		
		if [[ "$dateDelta" -lt "1" ]]
		then
			_messageFAIL
			_stop 1
		fi
		
		if [[ "$dateDelta" -gt "5" ]]
		then
			_messageFAIL
			_stop 1
		fi
		
		if [[ $(echo -e -n "$nsDateDelta" | wc -c) != '10' ]]
		then
			_messageFAIL
			_stop 1
		fi
		
		if [[ "$nsDateDelta" -lt '1000000000' ]]
		then
			_messageFAIL
			_stop 1
		fi
		
		if [[ $(echo -e -n "$nsDateDelta" | cut -b1-4) -lt 1000 ]]
		then
			_messageFAIL
			_stop 1
		fi
		
		if [[ $(echo -e -n "$nsDateDelta" | cut -b1-8) -gt '50000000' ]]
		then
			_messageFAIL
			_stop 1
		fi
		
		if [[ $(echo -e -n "$nsDateDelta" | cut -b1-4) -gt 5000 ]]
		then
			_messageFAIL
			_stop 1
		fi
		
		
		
		
		let iterations="$iterations + 1"
	done
	
	
	local nsDateC
	local nsDateD
	local nsDateDeltaA
	local nsDateDeltaB
	local msIterations
	
	if uname -a | grep -i 'cygwin' > /dev/null 2>&1
	then
		nsDateA=$(date +%s%N)
		for msIterations in {1..100}
		do
			sleep 0.011
		done
		nsDateB=$(date +%s%N)
		
		#nsDateC=$(date +%s%N)
		nsDateC="$nsDateB"
		for msIterations in {1..100}
		do
			sleep 0.091
		done
		nsDateD=$(date +%s%N)
		
		nsDateDeltaA=$(bc <<< "$nsDateB - $nsDateA")
		nsDateDeltaB=$(bc <<< "$nsDateD - $nsDateC")
		nsDateDelta=$(bc <<< "$nsDateDeltaB - $nsDateDeltaA")
		
		#echo "$nsDateDelta"
		
		
		
		if [[ $(echo -e -n "$nsDateDelta" | cut -b1-8) -lt '10000000' ]]
		then
			_messageFAIL
			_stop 1
		fi
		if [[ $(echo -e -n "$nsDateDelta" | cut -b1-8) -gt '640000000' ]]
		then
			_messageFAIL
			_stop 1
		fi
		
		if [[ $(echo -e -n "$nsDateDelta" | cut -b1-4) -lt '1000' ]]
		then
			_messageFAIL
			_stop 1
		fi
		if [[ $(echo -e -n "$nsDateDelta" | cut -b1-4) -gt '64000' ]]
		then
			_messageFAIL
			_stop 1
		fi
	else
		nsDateA=$(date +%s%N)
		for msIterations in {1..100}
		do
			sleep 0.001
		done
		nsDateB=$(date +%s%N)
		
		#nsDateC=$(date +%s%N)
		nsDateC="$nsDateB"
		for msIterations in {1..100}
		do
			sleep 0.009
		done
		nsDateD=$(date +%s%N)
		
		nsDateDeltaA=$(bc <<< "$nsDateB - $nsDateA")
		nsDateDeltaB=$(bc <<< "$nsDateD - $nsDateC")
		nsDateDelta=$(bc <<< "$nsDateDeltaB - $nsDateDeltaA")
		
		#echo "$nsDateDelta"
		
		
		
		if [[ $(echo -e -n "$nsDateDelta" | cut -b1-8) -lt '10000000' ]]
		then
			_messageFAIL
			_stop 1
		fi
		if [[ $(echo -e -n "$nsDateDelta" | cut -b1-8) -gt '640000000' ]]
		then
			_messageFAIL
			_stop 1
		fi
		
		if [[ $(echo -e -n "$nsDateDelta" | cut -b1-4) -lt '1000' ]]
		then
			_messageFAIL
			_stop 1
		fi
		if [[ $(echo -e -n "$nsDateDelta" | cut -b1-4) -gt '64000' ]]
		then
			_messageFAIL
			_stop 1
		fi
	fi
	
	
	
	
	_messagePASS
	return 0
}


_testarglength() {
	local testArgLength
	
	! testArgLength=$(getconf ARG_MAX) && _messageFAIL && _stop 1
	
	
	# Typical UNIX.
	# && [[ "$testArgLength" != "" ]]
	if [[ "$testArgLength" -lt 131071 ]] && [[ "$testArgLength" != "-1" ]] && [[ "$testArgLength" != "undefined" ]]
	then

		# Typical Cygwin. Marginal result at best.
		[[ "$testArgLength" -ge 32000 ]] && uname -a | grep -i 'cygwin' > /dev/null 2>&1 && _messagePASS && return 0
		if _if_cygwin
		then
			# Fortunately, as of 2023-09-08 , from questions to the Cygwin mailing list, reportedly the undefined 'ARG_MAX' is a standards compliant delimiter of no limit except system resource limit.
			# Unfortunately, as of 2023-09-07 , apparently Cygwin has removed the 'ARG_MAX' definition from the provided 'getconf' .
			# Due to the narrower use case of Cygwin/MSW (as opposed to GNU/Linux) - not expecting to compile gEDA for Cygwin anytime soon - it will be more of a concern if other binaries in 'ubcp' cease to exist because newer versions of Cygwin packages upstream were failing to compile as a result. Hopefully, Cygwin itself has adequate testing to prevent release of such breakage.
			#echo "$testArgLength"
			return 0
		fi
		
		_messageFAIL && _stop 1
	fi
	
	_messagePASS
}



_variableLocalTestA_procedure() {
	local currentLocalA
	currentLocalA='false'
	[[ "$currentGlobalA" != 'true' ]] && _stop 1
	[[ "$currentLocalA" == '' ]] && _stop 1
	[[ "$currentLocalA" != 'false' ]] && _stop 1
	
	local currentLocalB
	currentLocalB='true'
	
	currentNotLocalA='true'
	
	
	return 0
}

_variableLocalTestB_procedure() {
	[[ "$currentGlobalA" != 'true' ]] && return 1
	[[ "$currentLocalA" != '' ]] && return 1
	[[ "$currentLocalA" == 'true' ]] && return 1
	
	return 0
}

_variableLocalTestC_procedure() {
	[[ "$currentGlobalA" != '' ]] && _stop 1
	[[ "$currentGlobalA" == 'true' ]] && _stop 1
	
	return 0
}

_variableLocalTest_sequence() {
	_start scriptLocal_mkdir_disable
	
	variableLocalTest_currentSubFunction() {
		if ! [[ "$currentSubFunctionTest" == "true" ]] || ! [[ $(echo "$currentSubFunctionTest") == "true" ]]
		then
			_stop 1
			return 1
		fi
		return 0
	}
	local currentSubFunctionTest
	currentSubFunctionTest='true'
	! variableLocalTest_currentSubFunction && _stop 1
	
	
	local currentSubshellTest1=$(
		echo x
	)
	[[ "$currentSubshellTest1" != 'x' ]] && _stop 1
	
	local currentSubshellTest2
	currentSubshellTest2=$(
		echo x
	)
	[[ "$currentSubshellTest2" != 'x' ]] && _stop 1
	
	
	echo $(
		echo 1
		echo 2
	) | grep '1 2' > /dev/null || _stop 1
	
	! echo $(
		echo 1
		echo 2
	) | grep '1 2' > /dev/null && _stop 1
	
	
	export currentGlobalA='true'
	
	local currentLocalA
	currentLocalA='true'
	
	( export currentSubshellTestA='true' )
	[[ ! -z "$currentSubshellTestA" ]] && _stop 1
	[[ "$currentSubshellTestA" != "" ]] && _stop 1
	[[ "$currentSubshellTestA" != '' ]] && _stop 1
	[[ "$currentSubshellTestA" == 'true' ]] && _stop 1
	
	( currentSubshellTestB='true' )
	[[ "$currentSubshellTestB" != "" ]] && _stop 1
	[[ "$currentSubshellTestB" == 'true' ]] && _stop 1
	
	( local currentSubshellTestC='true' )
	[[ "$currentSubshellTestC" != "" ]] && _stop 1
	[[ "$currentSubshellTestC" == 'true' ]] && _stop 1
	
	
	export currentGlobalSubshellTest="true"
	if [[ $( ( echo "$currentGlobalSubshellTest" ) ) != "true" ]]
	then
		_stop 1
	fi
	if [[ $( ( export currentGlobalSubshellTest="false" ; echo "$currentGlobalSubshellTest" ) ) != "false" ]]
	then
		_stop 1
	else
		true
	fi
	if [[ $( ( echo "$currentGlobalSubshellTest" ) ) != "true" ]]
	then
		_stop 1
	fi
	if [[ "$currentGlobalSubshellTest" != "true" ]]
	then
		_stop 1
	fi
	
	
	! ( echo true ) | grep 'true' > /dev/null && _stop 1
	! ( echo "$currentGlobalA" ) | grep 'true' > /dev/null && _stop 1
	! ( echo "$currentLocalA" ) | grep 'true' > /dev/null && _stop 1
	( echo "$currentLocalB" ) | grep 'true' > /dev/null && _stop 1
	
	[[ "$currentLocalA" != 'true' ]] && _stop 1
	! _variableLocalTestA_procedure && _stop 1
	[[ "$currentLocalA" != 'true' ]] && _stop 1
	[[ "$currentLocalB" != '' ]] && _stop 1
	[[ "$currentLocalB" == 'true' ]] && _stop 1
	[[ "$currentNotLocalA" != 'true' ]] && _stop 1
	
	_variableLocalTestB_procedure && _stop 1
	! "$scriptAbsoluteLocation" _variableLocalTestB_procedure && _stop 1
	
	local currentGlobalA
	! _variableLocalTestC_procedure && _stop 1
	
	export currentGlobalB='false'
	local currentGlobalB='true'
	[[ "$currentGlobalB" != 'true' ]] && _stop 1
	
	local currentLocalB='true'
	! ( echo "$currentLocalB" ) | grep 'true' > /dev/null && _stop 1
	[[ "$currentLocalB" != 'true' ]] && _stop 1
	
	local currentLocalC='true'
	[[ "$currentLocalC" != 'true' ]] && _stop 1
	
	! env -i  HOME="$HOME" TERM="${TERM}" SHELL="${SHELL}" PATH="${PATH}" PWD="$PWD" scriptAbsoluteLocation="$scriptAbsoluteLocation" scriptAbsoluteFolder="$scriptAbsoluteFolder" sessionid="$sessionid" LD_PRELOAD="$LD_PRELOAD" USER="$USER" "bash" -c '[[ "$sessionid" != "" ]]' && _stop 1
	env -i  HOME="$HOME" TERM="${TERM}" SHELL="${SHELL}" PATH="${PATH}" PWD="$PWD" scriptAbsoluteLocation="$scriptAbsoluteLocation" scriptAbsoluteFolder="$scriptAbsoluteFolder" sessionid="" LD_PRELOAD="$LD_PRELOAD" USER="$USER" "bash" -c '[[ "$sessionid" != "" ]]' && _stop 1
	env -i HOME="$HOME" TERM="${TERM}" SHELL="${SHELL}" PATH="${PATH}" PWD="$PWD" scriptAbsoluteLocation="$scriptAbsoluteLocation" scriptAbsoluteFolder="$scriptAbsoluteFolder" LD_PRELOAD="$LD_PRELOAD" USER="$USER" "bash" -c '[[ "$sessionid" != "" ]]' && _stop 1
	
	local currentBashBinLocation
	currentBashBinLocation=$(type -p bash)
	[[ "$sessionid" == '' ]] &&  _stop 1
	! env -i sessionid="$sessionid" "$currentBashBinLocation" -c '[[ "$sessionid" != "" ]]' && _stop 1
	env -i sessionid="" "$currentBashBinLocation" --norc -c '[[ "$sessionid" != "" ]]' && _stop 1
	env -i "$currentBashBinLocation" --norc -c '[[ "$sessionid" != "" ]]' && _stop 1
	
	
	
	local currentVariableFunctionText
	
	export UB_TEST_VARIABLE_FUNCTION_COMMAND='_variableFunction_variableLocalTest() { echo true; }'' ; _variableFunction_variableLocalTest'
	currentVariableFunctionText=$(bash -c "$UB_TEST_VARIABLE_FUNCTION_COMMAND")
	#currentVariableFunctionText=$($UB_TEST_VARIABLE_FUNCTION_COMMAND)
	[[ "$currentVariableFunctionText" != "true" ]] && _messageFAIL && _stop 1
	export UB_TEST_VARIABLE_FUNCTION_COMMAND=
	unset UB_TEST_VARIABLE_FUNCTION_COMMAND
	
	_exportFunction_variableLocalTest() {
		echo true
	}
	currentVariableFunctionText=$(bash -c '_exportFunction_variableLocalTest' 2>/dev/null)
	[[ "$currentVariableFunctionText" != "" ]] && _messageFAIL && _stop 1
	export -f _exportFunction_variableLocalTest
	currentVariableFunctionText=$(bash -c '_exportFunction_variableLocalTest' 2>/dev/null)
	[[ "$currentVariableFunctionText" != "true" ]] && _messageFAIL && _stop 1
	unset _exportFunction_variableLocalTest
	
	
	_currentFunctionDefinitionTest() { echo false; }
	true && _currentFunctionDefinitionTest() { echo true; }
	false && _currentFunctionDefinitionTest() { echo false; }
	[[ $(_currentFunctionDefinitionTest) != "true" ]] && _messageFAIL && _stop 1
	unset _currentFunctionDefinitionTest
	
	
	local doubleLocalDefinitionA
	doubleLocalDefinitionA=1
	local doubleLocalDefinitionA
	doubleLocalDefinitionA=2
	[[ "$doubleLocalDefinitionA" != "2" ]] && _messageFAIL && _stop 1
	local doubleLocalDefinitionA=3
	[[ "$doubleLocalDefinitionA" != "3" ]] && _messageFAIL && _stop 1
	local doubleLocalDefinitionA
	doubleLocalDefinitionA=4
	[[ "$doubleLocalDefinitionA" != "4" ]] && _messageFAIL && _stop 1
	export doubleLocalDefinitionA=5
	[[ "$doubleLocalDefinitionA" != "5" ]] && _messageFAIL && _stop 1
	local doubleLocalDefinitionA=6
	[[ "$doubleLocalDefinitionA" != "6" ]] && _messageFAIL && _stop 1
	doubleLocalDefinitionA=7
	[[ "$doubleLocalDefinitionA" != "7" ]] && _messageFAIL && _stop 1
	local doubleLocalDefinitionA=8
	[[ "$doubleLocalDefinitionA" != "8" ]] && _messageFAIL && _stop 1
	unset doubleLocalDefinitionA
	[[ "$doubleLocalDefinitionA" != "" ]] && _messageFAIL && _stop 1
	
	
	_stop
}


_variableLocalTest() {
	if "$scriptAbsoluteLocation" _variableLocalTest_sequence "$@"
	then
		return 0
	fi
	return 1
}


_uid_test() {
	local current_uid_1
	local current_uid_2
	local current_uid_3
	
	current_uid_1=$(_uid)
	current_uid_2=$(_uid)
	current_uid_3_char=$(_uid 8 | wc -c)
	
	if [[ "$current_uid_1" == "" ]]
	then
		_messageFAIL
		_stop 1
	fi
	
	if [[ "$current_uid_2" == "" ]]
	then
		_messageFAIL
		_stop 1
	fi
	
	if [[ "$current_uid_1" == "$current_uid_2" ]]
	then
		_messageFAIL
		_stop 1
	fi
	
	if [[ "$current_uid_3_char" != "8" ]]
	then
		_messageFAIL
		_stop 1
	fi
	
	return 0
}


# Creating a function from within a function may be relied upon for some overrides.
# Enumerating a function's text with 'declare -f' may be relied upon by some 'here document' functions.
_define_function_test() {
	local current_uid_1
	current_uid_1=$(_uid)
	
	local current_uid_2
	current_uid_2=$(_uid)
	
	# https://stackoverflow.com/questions/7145337/bash-how-do-i-create-function-from-variable
	eval "__$current_uid_1() { __$current_uid_2() { echo $ubiquitousBashID; }; }"
	
	if [[ $(declare -f __$current_uid_1 | wc -c) -lt 50 ]]
	then
		_messageFAIL
		_stop 1
	fi
	
	if [[ $(declare -f __$current_uid_2 | wc -c) -gt 0 ]]
	then
		_messageFAIL
		_stop 1
	fi
	
	__$current_uid_1
	
	if [[ $(declare -f __$current_uid_2 | wc -c) -lt 15 ]]
	then
		_messageFAIL
		_stop 1
	fi
	
	# https://superuser.com/questions/154332/how-do-i-unset-or-get-rid-of-a-bash-function
	unset -f __$current_uid_2
	
	if [[ $(declare -f __$current_uid_2 | wc -c) -gt 0 ]]
	then
		_messageFAIL
		_stop 1
	fi
	
	if [[ $(declare -f __$current_uid_1 | wc -c) -lt 50 ]]
	then
		_messageFAIL
		_stop 1
	fi
	
	unset -f __$current_uid_1
	
	if [[ $(declare -f __$current_uid_1 | wc -c) -gt 0 ]]
	then
		_messageFAIL
		_stop 1
	fi
	
	
	return 0
}

#_test_prog() {
#	true
#}

_test_embed_procedure-embed() {
	#echo $ub_import
	#echo $ub_import_param
	
	[[ "$ub_import" != 'true' ]] && return 1
	[[ "$ub_import" == '' ]] && return 1
	[[ "$ub_import_param" != '--embed' ]] && return 1
	
	#_stop 0
	#return 0
	true
}

_test_embed_sequence() {
	_start scriptLocal_mkdir_disable
	
	#echo $ub_import
	#echo $ub_import_param
	
	# CAUTION: Profoundly unexpected to have called '_test' or similar functions after importing into a current shell in any way.
	if ( [[ "$current_internal_CompressedScript" == "" ]] && [[ "$current_internal_CompressedScript_cksum" == "" ]] && [[ "$current_internal_CompressedScript_bytes" == "" ]] ) || ( ( [[ "$ub_import_param" != "--embed" ]] ) && [[ "$ub_import_param" != "--bypass" ]] && [[ "$ub_import_param" != "--call" ]] && [[ "$ub_import_param" != "--script" ]] && [[ "$ub_import_param" != "--compressed" ]] )
	then
		[[ "$ub_import" == 'true' ]] && _messageFAIL && _stop 1
		[[ "$ub_import" != '' ]] && _messageFAIL && _stop 1
		[[ "$ub_import_param" != '' ]] && _messageFAIL && _stop 1
	fi
	
	! "$safeTmp"/.embed.sh _true && _stop 1
	
	"$safeTmp"/.embed.sh _false && _stop 1
	
	! "$safeTmp"/.embed.sh _test_embed_procedure-embed && _stop 1
	
	! . "$safeTmp"/.embed.sh _test_embed_procedure-embed && _stop 1
	
	_stop
}

_test_embed() {
	"$scriptAbsoluteLocation" _test_embed_sequence "$@"
}

_test_parallelFifo_procedure() {
	mkfifo "$safeTmp"/parallel_fifo
	cat "$safeTmp"/parallel_fifo > "$safeTmp"/parallel_fifo_out &
	
	local currentIterationsA
	currentIterationsA=0
	local currentIterationsB
	currentIterationsB=0
	
	while [[ "$currentIterationsA" -lt "2" ]]
	do
		echo a
		sleep 1
		let currentIterationsA="$currentIterationsA"" + 1"
	done | cat > "$safeTmp"/parallel_fifo &
	
	sleep 0.4
	
	while [[ "$currentIterationsB" -lt "2" ]]
	do
		echo b
		sleep 1
		let currentIterationsB="$currentIterationsB"" + 1"
	done | cat > "$safeTmp"/parallel_fifo
	
	sleep 1
	sleep 7
	
	
	#echo $(cat "$safeTmp"/parallel_fifo_out | tr -dc 'a-zA-Z0-9' 2> /dev/null)
	
	# WARNING: Strongly discouraged! Strict test highly dependent on unpredictable InterProcess-Communication timing requiring >7s latency margins at each 'step'!
	if _if_cygwin
	then
		[[ $(cat "$safeTmp"/parallel_fifo_out | tr -dc 'a-zA-Z0-9' 2> /dev/null) != "abab" ]] && _messageFAIL && return 1
	fi
	
	[[ $(cat "$safeTmp"/parallel_fifo_out | tr -dc 'a-zA-Z0-9' | wc -c) != "4" ]] && _messageFAIL && return 1
	
	
	rm -f "$safeTmp"/parallel_fifo
	rm -f "$safeTmp"/parallel_fifo_out
}

# No production use.
_test_parallelFifo_sequence() {
	_start scriptLocal_mkdir_disable
	
	_test_parallelFifo_procedure "$@"
	
	_stop
}

_test_pipe_true() {
	true | tee /dev/null 2>&1
}

# Apparently, shell script functions and conditions default to pipefail or pipestatus, although "$scriptAbsoluteLocation" is able to use the exit status instead.
_test_pipe_false() {
	false | tee /dev/null 2>&1
}
_test_pipe_false_condition() {
	#false | tee /dev/null 2>&1 && return 0
	false | echo stuff | grep stuff > /dev/null 2>&1 && return 0
	return 1
}
_test_pipe_false_condition_special() {
	false | tee /dev/null
	[[ "$?" == "0" ]] && return 0
	return 1
}

# Expect return true (ie. 0).
_test_pipefail_forcePlus_true_sequence() {
	set +o pipefail
	true | tee /dev/null 2>&1
}
_test_pipefail_forcePlus_true() {
	"$scriptAbsoluteLocation" _test_pipefail_forcePlus_true_sequence "$@"
}

# Expect return true (ie. 0).
_test_pipefail_forcePlus_false_sequence() {
	set +o pipefail
	false | tee /dev/null 2>&1
}
_test_pipefail_forcePlus_false() {
	"$scriptAbsoluteLocation" _test_pipefail_forcePlus_false_sequence "$@"
}

# Expect return true (ie. 0).
_test_pipefail_forceMinus_true_sequence() {
	set -o pipefail
	true | tee /dev/null 2>&1
}
_test_pipefail_forceMinus_true() {
	"$scriptAbsoluteLocation" _test_pipefail_forceMinus_true_sequence "$@"
}

# Expect return false (ie. 1).
_test_pipefail_forceMinus_false_sequence() {
	set -o pipefail
	false | tee /dev/null 2>&1
}
_test_pipefail_forceMinus_false() {
	"$scriptAbsoluteLocation" _test_pipefail_forceMinus_false_sequence "$@"
}

# https://stackoverflow.com/questions/6871859/piping-command-output-to-tee-but-also-save-exit-code-of-command
_test_pipestatus_true() {
	true | tee /dev/null 2>&1
	return ${PIPESTATUS[0]}
}

_test_pipestatus_false() {
	false | tee /dev/null 2>&1
	return ${PIPESTATUS[0]}
}

# ATTENTION: NOTICE: Regard this as a relatively definitive specification of known bash pipe 'exit status', 'pipestatus', 'pipefail', defaults and inheritance.
# WARNING: If 'bash' software interpreter uses same code paths (eg. for shell functions and subshells) do not assume this will always remain the case. Test and consider specifically and explicitly.
_test_pipefail_sequence_sequence() {
	if ! _test_pipefail_forcePlus_true || ! _test_pipefail_forcePlus_false || ! _test_pipefail_forceMinus_true_sequence || _test_pipefail_forceMinus_false_sequence
	then
		echo 'fail: pipefail'
		_stop 1
		return 1
	fi
	
	# NOTICE: Will FAIL if 'set -o pipefail' applies to script commands !
	if ! _test_pipestatus_true || _test_pipestatus_false || ! "$scriptAbsoluteLocation" _test_pipestatus_true || "$scriptAbsoluteLocation" _test_pipestatus_false
	then
		echo 'fail: pipestatus'
		_stop 1
		return 1
	fi
	
	
	
	# ATTENTION: Apparently, "$scriptAbsoluteLocation" is able to correctly retrieve the expected (ie. 0, true) exit status of both '_test_pipe_true' and '_test_pipe_false', although calling these functions directly results in the unexpected use of pipestatus, pipefail, or similar, etc.
	# CAUTION: While such defaults may seem slightly undesirable for shell scripts, there may be some benefit to command prompt use (especailly when functions are called from an interactive shell through such as ubiquitous_bash.sh _true , etc), UNIX pipe input programs (eg. cat /file) rarely if ever fail when a grep match would occur, and best practice of using a condition (ie. [[ -e /file ]]) before such pipes already avoids severe issues in shell script usage.
	# CAUTION: Ensure all pipe exit status, pipe status, and pipe fail, default behavior remains *strictly* as-is.
	
	
	
	# ATTENTION: ! _test_pipe_false ... would return true if consistent with behavior when called by "$scriptAbsoluteLocation"
	_test_pipe_false
	[[ "$?" == "0" ]] && echo 'fail: _test_pipe_false' && _stop 1 && return 1
	if _test_pipe_false
	then
		echo 'fail: _test_pipe_false'
		_stop 1
		return 1
	fi
	
	# ATTENTION: ! _test_pipe_false ... does return true if called by "$scriptAbsoluteLocation"
	! "$scriptAbsoluteLocation" _test_pipe_false
	[[ "$?" == "0" ]] && echo 'fail: ! "$scriptAbsoluteLocation" _test_pipe_false' && _stop 1 && return 1
	if ! "$scriptAbsoluteLocation" _test_pipe_false
	then
		echo 'fail: if: ! "$scriptAbsoluteLocation" _test_pipe_false'
		_stop 1
		return 1
	fi
	
	_test_pipe_false_condition
	[[ "$?" == "0" ]] && echo 'fail: _test_pipe_false_condition' && _stop 1 && return 1
	if _test_pipe_false_condition
	then
		echo 'fail: if: _test_pipe_false_condition'
		_stop 1
		return 1
	fi
	
	! "$scriptAbsoluteLocation" _test_pipe_false_condition
	[[ "$?" == "0" ]] && echo 'fail: ! "$scriptAbsoluteLocation" _test_pipe_false_condition' && _stop 1 && return 1
	if _test_pipe_false_condition
	then
		echo 'fail: if: ! "$scriptAbsoluteLocation" _test_pipe_false_condition'
		_stop 1
		return 1
	fi
	
	
	_test_pipe_false_condition_special
	[[ "$?" == "0" ]] && echo 'fail: _test_pipe_false_condition_special' && _stop 1 && return 1
	if _test_pipe_false_condition_special
	then
		echo 'fail: if: _test_pipe_false_condition_special'
		_stop 1
		return 1
	fi
	
	! "$scriptAbsoluteLocation" _test_pipe_false_condition_special
	[[ "$?" == "0" ]] && echo 'fail: ! "$scriptAbsoluteLocation" _test_pipe_false_condition_special' && _stop 1 && return 1
	if ! "$scriptAbsoluteLocation" _test_pipe_false_condition_special
	then
		echo 'fail: if: ! "$scriptAbsoluteLocation" _test_pipe_false_condition_special'
		_stop 1
		return 1
	fi
	
	"$scriptAbsoluteLocation" _test_pipe_false_condition_special
	[[ "$?" != "0" ]] && echo 'fail: "$scriptAbsoluteLocation" _test_pipe_false_condition_special' && _stop 1 && return 1
	if "$scriptAbsoluteLocation" _test_pipe_false_condition_special
	then
		true
	else
		echo 'fail: if: "$scriptAbsoluteLocation" _test_pipe_false_condition_special'
		_stop 1
		return 1
	fi
	
	
	#! _test_pipe_true || ! _test_pipe_false || ! "$scriptAbsoluteLocation" _test_pipe_true || ! "$scriptAbsoluteLocation" _test_pipe_false
	#! _test_pipe_false
	if ! _test_pipe_true || ! "$scriptAbsoluteLocation" _test_pipe_true || ! "$scriptAbsoluteLocation" _test_pipe_false
	then
		echo 'fail: if: pipe: value'
		_stop 1
		return 1
	fi
	
	set +o pipefail
	# NOTICE: Will FAIL if 'set -o pipefail' applies to script commands !
	if ! _test_pipestatus_true || _test_pipestatus_false || ! "$scriptAbsoluteLocation" _test_pipestatus_true || "$scriptAbsoluteLocation" _test_pipestatus_false
	then
		echo 'fail: pipestatus'
		_stop 1
		return 1
	fi
	if ( true | tee /dev/null 2>&1 )
	then
		true
	else
		echo 'fail: if: pipe: pipefail: plus: subshell: true'
		_stop 1
		return 1
	fi
	if ( false | tee /dev/null 2>&1 )
	then
		true
	else
		echo 'fail: if: pipe: pipefail: plus: subshell: false'
		_stop 1
		return 1
	fi
	if ! "$scriptAbsoluteLocation" _test_pipe_true || ! "$scriptAbsoluteLocation" _test_pipe_false
	then
		echo 'fail: if: pipe: pipefail: plus'
		_stop 1
		return 1
	fi
	
	set -o pipefail
	# NOTICE: Will FAIL if 'set -o pipefail' applies to script commands !
	if ! _test_pipestatus_true || _test_pipestatus_false || ! "$scriptAbsoluteLocation" _test_pipestatus_true || "$scriptAbsoluteLocation" _test_pipestatus_false
	then
		echo 'fail: pipestatus'
		_stop 1
		return 1
	fi
	if ( true | tee /dev/null 2>&1 )
	then
		true
	else
		echo 'fail: if: pipe: pipefail: minus: subshell: true'
		_stop 1
		return 1
	fi
	# ATTENTION: Seems this actually is sensitive to 'set -o pipefail' .
	if ( false | tee /dev/null 2>&1 )
	then
		echo 'fail: if: pipe: pipefail: minus: subshell: false'
		_stop 1
		return 1
	else
		true
	fi
	if ! "$scriptAbsoluteLocation" _test_pipe_true || ! "$scriptAbsoluteLocation" _test_pipe_false
	then
		echo 'fail: if: pipe: pipefail: minus'
		_stop 1
		return 1
	fi
	return 0
}
_test_pipefail_sequence() {
	! "$scriptAbsoluteLocation" _test_pipefail_sequence_sequence "$@" && return 1
	
	set +o pipefail
	! "$scriptAbsoluteLocation" _test_pipefail_sequence_sequence "$@" && return 1
	
	set -o pipefail
	! "$scriptAbsoluteLocation" _test_pipefail_sequence_sequence "$@" && return 1
	
	return 0
}
_test_pipefail() {
	if ! "$scriptAbsoluteLocation" _test_pipefail_sequence "$@"
	then
		_messageFAIL
		_stop 1
		return 1
	fi
	"$scriptAbsoluteLocation" _test_pipefail_sequence "$@"
	if [[ "$?" != "0" ]]
	then
		_messageFAIL
		_stop 1
		return 1
	fi
}

# WARNING: Not necessarily tested by default, due to lack of use except where faults are tolerable, and slim possibility of useful embedded systems not able to pass.
_test_grep() {
	# If not known distribution/OS, do NOT test. Some embedded systems not able to pass may be nevertheless useful.
	! ( [[ -e /etc/issue ]] && cat /etc/issue | grep 'Debian\|Raspbian\|Ubuntu' > /dev/null 2>&1 ) && ! _if_cygwin && return 0
	
	
	
	! echo \$123 | grep -E '^\$[0-9]|^\.[0-9]' > /dev/null 2>&1 && _messageFAIL && return 1
	! echo \.123 | grep -E '^\$[0-9]|^\.[0-9]' > /dev/null 2>&1 && _messageFAIL && return 1
	echo 123 | grep -E '^\$[0-9]|^\.[0-9]' > /dev/null 2>&1 && _messageFAIL && return 1
	
	
	
	! echo 'qwerty.*123' | grep -xF 'qwerty.*123' > /dev/null 2>&1 && _messageFAIL && return 1
	! echo 'qwerty.*123' | grep -F 'qwerty.*123' > /dev/null 2>&1 && _messageFAIL && return 1
	! echo 'qwerty123' | grep -x 'q.*3' > /dev/null 2>&1 && _messageFAIL && return 1
	
	echo 'qwerty123' | grep -xF 'qwerty.*123' > /dev/null 2>&1 && _messageFAIL && return 1
	echo 'qwerty.*123' | grep -xF 'qwerty123' > /dev/null 2>&1 && _messageFAIL && return 1
	
	echo 'qwerty123' | grep -xF 'qwerty' > /dev/null 2>&1 && _messageFAIL && return 1
	echo 'qwerty123' | grep -xF '123' > /dev/null 2>&1 && _messageFAIL && return 1
	echo 'qwerty123' | grep -xF 'werty12' > /dev/null 2>&1 && _messageFAIL && return 1
	
	
	! echo 'qwerty123' | grep -x 'qwerty.*123' > /dev/null 2>&1 && _messageFAIL && return 1
	echo 'qwerty.*123' | grep -x 'qwerty123' > /dev/null 2>&1 && _messageFAIL && return 1
	
	echo 'qwerty123' | grep -x 'qwerty' > /dev/null 2>&1 && _messageFAIL && return 1
	echo 'qwerty123' | grep -x '123' > /dev/null 2>&1 && _messageFAIL && return 1
	echo 'qwerty123' | grep -x 'werty12' > /dev/null 2>&1 && _messageFAIL && return 1
	
	
	echo 'qwerty123' | grep -F 'qwerty.*123' > /dev/null 2>&1 && _messageFAIL && return 1
	echo 'qwerty.*123' | grep -F 'qwerty123' > /dev/null 2>&1 && _messageFAIL && return 1
	
	! echo 'qwerty123' | grep -F 'qwerty' > /dev/null 2>&1 && _messageFAIL && return 1
	! echo 'qwerty123' | grep -F '123' > /dev/null 2>&1 && _messageFAIL && return 1
	! echo 'qwerty123' | grep -F 'werty12' > /dev/null 2>&1 && _messageFAIL && return 1
	
	
	
	return 0
}

_test_sanity() {
	if (exit 0)
	then
		true
	else
		_messageFAIL && return 1
	fi
	if ! (exit 0)
	then
		_messageFAIL && return 1
	fi
	if (exit 1)
	then
		_messageFAIL && return 1
	fi
	if (exit 2)
	then
		_messageFAIL && return 1
	fi
	if (exit 3)
	then
		_messageFAIL && return 1
	fi
	if (exit 126)
	then
		_messageFAIL && return 1
	fi
	if (exit 127)
	then
		_messageFAIL && return 1
	fi
	if (exit 128)
	then
		_messageFAIL && return 1
	fi
	if (exit 129)
	then
		_messageFAIL && return 1
	fi
	if (exit 130)
	then
		_messageFAIL && return 1
	fi
	if (exit 131)
	then
		_messageFAIL && return 1
	fi
	if (exit 132)
	then
		_messageFAIL && return 1
	fi
	if (exit 255)
	then
		_messageFAIL && return 1
	fi
	
	local currentSubReturnStatus
	(exit 0)
	currentSubReturnStatus="$?"
	[[ "$currentSubReturnStatus" != '0' ]] && _messageFAIL && return 1
	(exit 1)
	currentSubReturnStatus="$?"
	[[ "$currentSubReturnStatus" != '1' ]] && _messageFAIL && return 1
	(exit 2)
	currentSubReturnStatus="$?"
	[[ "$currentSubReturnStatus" != '2' ]] && _messageFAIL && return 1
	(exit 3)
	currentSubReturnStatus="$?"
	[[ "$currentSubReturnStatus" != '3' ]] && _messageFAIL && return 1
	
	
	# Do NOT allow 'rm' to be a shell function alias to 'rm -i' or similar.
	[[ $(type -p rm) == "" ]] && _messageFAIL && return 1
	
	
	! _test_pipefail && _messageFAIL && return 1
	
	
	
	
	#! [[ -2147483648 -lt 2147483647 ]] && _messageFAIL && return 1
	#! [[ -2000000000 -lt 2000000000 ]] && _messageFAIL && return 1
	
	! [[ -1234567890 -le -1234567890 ]] && _messageFAIL && return 1
	! [[ 1234567890 -le 1234567890 ]] && _messageFAIL && return 1
	! [[ -1234567890 -lt 1234567890 ]] && _messageFAIL && return 1
	! [[ -1234567890 -ge -1234567890 ]] && _messageFAIL && return 1
	! [[ 1234567890 -ge 1234567890 ]] && _messageFAIL && return 1
	! [[ 1234567890 -gt -1234567890 ]] && _messageFAIL && return 1
	! [[ -1234567890 -lt -0 ]] && _messageFAIL && return 1
	! [[ -1234567890 -lt 0 ]] && _messageFAIL && return 1
	! [[ 0 -lt 1234567890 ]] && _messageFAIL && return 1
	! [[ -0 -gt -1234567890 ]] && _messageFAIL && return 1
	! [[ 0 -gt -1234567890 ]] && _messageFAIL && return 1
	! [[ 0 -gt -1234567890 ]] && _messageFAIL && return 1
	
	! [[ -900000000 -le -900000000 ]] && _messageFAIL && return 1
	! [[ 900000000 -le 900000000 ]] && _messageFAIL && return 1
	! [[ -900000000 -lt 900000000 ]] && _messageFAIL && return 1
	! [[ -900000000 -ge -900000000 ]] && _messageFAIL && return 1
	! [[ 900000000 -ge 900000000 ]] && _messageFAIL && return 1
	! [[ 900000000 -gt -900000000 ]] && _messageFAIL && return 1
	! [[ -900000000 -lt -0 ]] && _messageFAIL && return 1
	! [[ -900000000 -lt 0 ]] && _messageFAIL && return 1
	! [[ 0 -lt 900000000 ]] && _messageFAIL && return 1
	! [[ -0 -gt -900000000 ]] && _messageFAIL && return 1
	! [[ 0 -gt -900000000 ]] && _messageFAIL && return 1
	! [[ 0 -gt -900000000 ]] && _messageFAIL && return 1
	! [[ 0 -le -0 ]] && _messageFAIL && return 1
	! [[ -0 -le 0 ]] && _messageFAIL && return 1
	! [[ 0 -ge -0 ]] && _messageFAIL && return 1
	! [[ -0 -ge 0 ]] && _messageFAIL && return 1
	
	
	
	! "$scriptAbsoluteLocation" _true && _messageFAIL && return 1
	"$scriptAbsoluteLocation" _false && _messageFAIL && return 1
	
	# CAUTION: Profoundly unexpected to have called '_test' or similar functions after importing into a current shell in any way.
	if ( [[ "$current_internal_CompressedScript" == "" ]] && [[ "$current_internal_CompressedScript_cksum" == "" ]] && [[ "$current_internal_CompressedScript_bytes" == "" ]] ) || ( ( [[ "$ub_import_param" != "--embed" ]] ) && [[ "$ub_import_param" != "--bypass" ]] && [[ "$ub_import_param" != "--call" ]] && [[ "$ub_import_param" != "--script" ]] && [[ "$ub_import_param" != "--compressed" ]] )
	then
		[[ "$ub_import" == 'true' ]] && _messageFAIL && _stop 1
		[[ "$ub_import" != '' ]] && _messageFAIL && _stop 1
		[[ "$ub_import_param" != '' ]] && _messageFAIL && _stop 1
	fi
	
	local santiySessionID_length
	santiySessionID_length=$(echo -n "$sessionid" | wc -c | tr -dc '0-9')
	
	[[ "$santiySessionID_length" -lt "18" ]] && _messageFAIL && return 1
	[[ "$uidLengthPrefix" != "" ]] && [[ "$santiySessionID_length" -lt "$uidLengthPrefix" ]] && _messageFAIL && return 1
	
	[[ -e "$safeTmp" ]] && _messageFAIL && return 1
	
	_start scriptLocal_mkdir_disable
	
	
	[[ ! -e "$safeTmp" ]] && _messageFAIL && return 1
	
	[[ $( cd "$safeTmp" 2>/dev/null ; ls *doNotMatch* 2>/dev/null | wc -c) != "0" ]] && _messageFAIL && return 1
	[[ $( cd "$safeTmp" 2>/dev/null ; ls -A *doNotMatch* 2>/dev/null | wc -c) != "0" ]] && _messageFAIL && return 1
	
	echo -e -n >> "$safeTmp"/empty
	[[ ! -e "$safeTmp"/empty ]] && _messageFAIL && return 1
	[[ $(cat "$safeTmp"/empty | wc -c) != '0' ]] && _messageFAIL && return 1
	
	[[ $( cd "$safeTmp" 2>/dev/null ; ls *empty* 2>/dev/null | wc -c) == "0" ]] && _messageFAIL && return 1
	[[ $( cd "$safeTmp" 2>/dev/null ; ls -A *empty* 2>/dev/null | wc -c) == "0" ]] && _messageFAIL && return 1
	
	rm -f "$safeTmp"/empty > /dev/null 2>&1
	
	
	! _test_moveconfirm_procedure && _messageFAIL && return 1
	
	
	local currentTestUID=$(_uid 245)
	mkdir -p "$safeTmp"/"$currentTestUID"
	echo > "$safeTmp"/"$currentTestUID"/"$currentTestUID"
	
	[[ ! -e "$safeTmp"/"$currentTestUID"/"$currentTestUID" ]] && _messageFAIL && return 1
	
	rm -f "$safeTmp"/"$currentTestUID"/"$currentTestUID"
	rmdir "$safeTmp"/"$currentTestUID"
	
	[[ -e "$safeTmp"/"$currentTestUID" ]] && _messageFAIL && return 1
	
	echo 'true' > "$safeTmp"/shouldNotOverwrite
	mv "$safeTmp"/doesNotExist "$safeTmp"/shouldNotOverwrite > /dev/null 2>&1 && _messageFAIL && return 1
	echo > "$safeTmp"/replacement
	mv -n "$safeTmp"/replacement "$safeTmp"/shouldNotOverwrite > /dev/null 2>&1
	[[ $(cat "$safeTmp"/shouldNotOverwrite) != "true" ]] && _messageFAIL && return 1
	rm -f "$safeTmp"/replacement > /dev/null 2>&1
	rm -f "$safeTmp"/shouldNotOverwrite > /dev/null 2>&1
	
	
	_uid_test
	
	[[ $(_getUUID | wc -c) != '37' ]] && _messageFAIL && return 1
	
	[[ $(_getUUID | cut -f1 -d\- | wc -c) != '9' ]] &&  _messageFAIL && return 1
	
	
	! env | grep 'PATH' > /dev/null 2>&1 && _messageFAIL && return 1
	! printenv | grep 'PATH' > /dev/null 2>&1 && _messageFAIL && return 1
	
	
	_define_function_test
	
	! _variableLocalTest && _messageFAIL && return 1
	
	
	
	mkdir -p "$safeTmp"/maydeletethisfolder
	[[ ! -d "$safeTmp"/maydeletethisfolder ]] && return 1
	echo > "$safeTmp"/maydeletethisfolder/maydeletethisfile
	[[ ! -e "$safeTmp"/maydeletethisfolder/maydeletethisfile ]] && return 1
	_safeRMR "$safeTmp"/maydeletethisfolder
	[[ -e "$safeTmp"/maydeletethisfolder/maydeletethisfile ]] && return 1
	[[ -e "$safeTmp"/maydeletethisfolder ]] && return 1
	
	
	
	_test_grep
	
	
	local currentJobsList
	currentJobsList=$(jobs -p -r)
	
	[[ "$currentJobsList" != "" ]] && return 1
	
	sleep 7 &
	currentJobsList=$(jobs -p -r)
	[[ "$currentJobsList" == "" ]] && return 1
	
	wait
	currentJobsList=$(jobs -p -r)
	[[ "$currentJobsList" != "" ]] && return 1
	
	
	echo -e -n "b" > "$safeTmp"/a
	[[ $(echo -e -n "c" | cat "$safeTmp"/a -) != "bc" ]] && _messageFAIL && _stop 1
	#[[ $(echo -e -n "c" | cat "$safeTmp"/a /dev/stdin) != "bc" ]] && _messageFAIL && _stop 1
	[[ $(echo -e -n "c" | cat "$safeTmp"/a /proc/self/fd/0) != "bc" ]] && _messageFAIL && _stop 1
	[[ $(echo -e -n "c" | cat - "$safeTmp"/a) != "cb" ]] && _messageFAIL && _stop 1
	#[[ $(echo -e -n "c" | cat /dev/stdin "$safeTmp"/a) != "cb" ]] && _messageFAIL && _stop 1
	[[ $(echo -e -n "c" | cat /proc/self/fd/0 "$safeTmp"/a) != "cb" ]] && _messageFAIL && _stop 1
	rm -f "$safeTmp"/a
	
	
	echo -e -n "b" > "$safeTmp"/a
	[[ $(echo -e -n "c" | _messagePlain_probe_cmd cat "$safeTmp"/a - | tail -c 2) != "bc" ]] && _messageFAIL && _stop 1
	#[[ $(echo -e -n "c" | _messagePlain_probe_cmd cat "$safeTmp"/a /dev/stdin | tail -c 2) != "bc" ]] && _messageFAIL && _stop 1
	[[ $(echo -e -n "c" | _messagePlain_probe_cmd cat "$safeTmp"/a /proc/self/fd/0 | tail -c 2) != "bc" ]] && _messageFAIL && _stop 1
	[[ $(echo -e -n "c" | _messagePlain_probe_cmd cat - "$safeTmp"/a | tail -c 2) != "cb" ]] && _messageFAIL && _stop 1
	#[[ $(echo -e -n "c" | _messagePlain_probe_cmd cat /dev/stdin "$safeTmp"/a | tail -c 2) != "cb" ]] && _messageFAIL && _stop 1
	[[ $(echo -e -n "c" | _messagePlain_probe_cmd cat /proc/self/fd/0 "$safeTmp"/a | tail -c 2) != "cb" ]] && _messageFAIL && _stop 1
	rm -f "$safeTmp"/a
	
	
	
	
	if ! _test_embed
	then
		_messageFAIL && _stop 1
		#! uname -a | grep -i cygwin > /dev/null 2>&1 && _messageFAIL && _stop 1
		#echo 'warn: broken (cygwin): _test_embed - cygwin detected'
	fi
	
	
	
	
	_getDep flock
	
	( flock 200; echo > "$safeTmp"/ready ; sleep 3 ) 200>"$safeTmp"/flock &
	sleep 1
	if ( flock 200; ! [[ -e "$safeTmp"/ready ]] ) 200>"$safeTmp"/flock
	then
		! uname -a | grep -i cygwin > /dev/null 2>&1 && _messageFAIL && _stop 1
		echo 'warn: broken (cygwin): flock - cygwin may not be able to use flock through MSW network drive'
		return 1
	fi
	rm -f "$safeTmp"/flock > /dev/null 2>&1
	rm -f "$safeTmp"/ready > /dev/null 2>&1
	
	ln -s /dev/null "$safeTmp"/working
	ln -s /dev/null/broken "$safeTmp"/broken
	if ! [[ -h "$safeTmp"/broken ]] || ! [[ -h "$safeTmp"/working ]] || [[ -e "$safeTmp"/broken ]] || ! [[ -e "$safeTmp"/working ]]
	then
		! uname -a | grep -i cygwin > /dev/null 2>&1 && _messageFAIL && _stop 1
		echo 'warn: broken (cygwin): flock - cygwin may not be able to use flock through MSW network drive'
		return 1
	fi
	rm -f "$safeTmp"/working
	rm -f "$safeTmp"/broken
	
	
	
	_tryExec _test_parallelFifo_procedure
	
	
	return 0
}



_test-shell-cygwin() {
	_messageNormal "Cygwin detected... MSW configuration issues..."
	
	
	local currentScriptTime
	if type _stopwatch > /dev/null 2>&1
	then
		if [[ -e "$scriptAbsoluteFolder"/ubiquitous_bash.sh ]]
		then
			currentScriptTime=$(_timeout 45 _stopwatch "$scriptAbsoluteFolder"/ubiquitous_bash.sh _true 2>/dev/null | tr -dc '0-9')
		else
			currentScriptTime=$(_timeout 45 _stopwatch "$scriptAbsoluteLocation" _true 2>/dev/null | tr -dc '0-9')
		fi
	else
		# If '_stopwatch' is not available, assume this is not an issue.
		currentScriptTime="2000"
	fi
	
	# Unusual, broken, non-desktop, etc user/login/account/etc configuration in MSW, might cause prohibitively long Cygwin delays.
	# MSW has a fragile track record, and cannot be used for combining complex applications (eg. flight sim) with 'enterprise' user/login/account/etc and/or deployment. Unless extensive testing conclusively shows a long track record otherwise, or unless MS has a direct commitment under a valuable contract to specifically ensure compatibility with such a use case, it would be obviously gross negligence to put a business at risk of unacceptable downtime from such a fragile stack. Any 'bonus' compensation so earned should incur liability for the disproportionate risk.
	# Enterprise must either use GNU/Linux, or similar, or maybe swap single-user preinstalled physical laptops/desktops.
	if [[ "$currentScriptTime" == "" ]]
	then
		echo 'fail: blank: currentScriptTime'
		_messageFAIL
	fi
	if ( [[ "$currentScriptTime" -gt '9500' ]] && [[ "$CI" == "" ]] ) || [[ "$currentScriptTime" -gt '20000' ]]
	then
		echo 'fail: slow: currentScriptTime: '"$currentScriptTime"
		_messageFAIL
	fi
	if [[ "$currentScriptTime" -gt '4500' ]]
	then
		echo 'warn: slow: currentScriptTime: '"$currentScriptTime"
		_messagePlain_request 'request: obtain a CPU with better single-thread performance, disable HyperThreading, disable EfficiencyCores, and/or reduce MSW OS installed functionality'
	fi
	
	
	local currentPathCount
	currentPathCount=$(echo "$PATH" | grep -o ':' | wc -l | tr -dc '0-9')
	if [[ "$currentPathCount" -gt 50 ]]
	then
		echo 'fail: count: PATH: '"$currentPathCount"
		_messageFAIL
	fi
	if [[ "$currentPathCount" -gt 44 ]]
	then
		echo 'warn: count: PATH: '"$currentPathCount"
		echo 'warn: MSWEXTPATH may be ignored'
		_messagePlain_request 'request: reduce the length of PATH variable'
	fi
	
	if [[ "$currentPathCount" -gt 32 ]]
	then
		echo 'warn: count: PATH: '"$currentPathCount"
		echo 'warn: MSWEXTPATH exceeds preferred 32'
		_messagePlain_request 'request: reduce the length of PATH variable'
	fi
	if [[ "$currentPathCount" -gt 34 ]]
	then
		echo 'warn: count: PATH: '"$currentPathCount"
		echo 'warn: MSWEXTPATH exceeds preferred 34'
		_messagePlain_request 'request: reduce the length of PATH variable'
	fi
	
	
	
	local currentPathCount
	currentPathCount=$(echo "$MSWEXTPATH" | grep -o ';\|:' | wc -l | tr -dc '0-9')
	if [[ "$currentPathCount" -gt 50 ]] && [[ "$CI" == "" ]]
	then
		echo 'fail: count: MSWEXTPATH: '"$currentPathCount"
		_messageFAIL
	fi
	if [[ "$currentPathCount" -gt 44 ]]
	then
		echo 'warn: count: MSWEXTPATH: '"$currentPathCount"
		echo 'warn: MSWEXTPATH may be ignored by default'
		_messagePlain_request 'request: reduce the length of PATH variable'
	fi
	
	
	if [[ "$currentPathCount" -gt 32 ]]
	then
		echo 'warn: count: MSWEXTPATH: '"$currentPathCount"
		echo 'warn: MSWEXTPATH exceeds preferred 32'
		_messagePlain_request 'request: reduce the length of PATH variable'
	fi
	if [[ "$currentPathCount" -gt 34 ]]
	then
		echo 'warn: count: MSWEXTPATH: '"$currentPathCount"
		echo 'warn: MSWEXTPATH exceeds preferred 34'
		_messagePlain_request 'request: reduce the length of PATH variable'
	fi
	
	
	
	# Although use case specific (eg. flight sim with usual desktop applications installed) test cases may be necessary for MSW, to avoid ambiguity in expectations that every test includes an explicit PASS statement, a call to '_messagePASS' is still given.
	# Self-hosted 'runners' may be able to implement these test cases, with the resulting fragility reduced somewhat by another computer pulling frequent backups and artifacts.
	# Unusually, MSW may have use case specific issues due to a track record for configuration changes to the MSW OS causing prohibitive performance issues (eg. Cygwin being delayed more than tens of seconds possibly due to a program adding some kind of user account, some programs known to drastically increase frame dropping in intense applications, etc).
	_messagePASS
	
	
	return 0
}
_test-shell() {
	_installation_nonet_default
	
	# ATTENTION: As part of sanity test, "$safeTmp" must not exist until '_start scriptLocal_mkdir_disable' is called from within '_test_sanity' .
	#_start scriptLocal_mkdir_disable
	_messageNormal "Sanity..."
	_test_sanity && _messagePASS
	
	
	
	_messageNormal "Permissions..."
	! _test_permissions_ubiquitous && _messageFAIL
	_messagePASS
	
	#Environment generated by ubiquitous bash is typically 10000 characters.
	#echo -n -e '\E[1;32;46m Argument length...	\E[0m'
	_messageNormal 'Argument length...'
	_testarglength
	
	_messageNormal "Absolute pathfinding..."
	#if ! uname -a | grep -i cygwin > /dev/null 2>&1
	#then
		_tryExec "_test_getAbsoluteLocation"
	#fi
	_messagePASS
	
	
	if _if_cygwin
	then
		! _test-shell-cygwin && _messageFAIL
	fi
	
	
	return 0
}

_test() {
	_test-shell "$@"
	_installation_nonet_default
	
	if ! _typeDep sudo && [[ "$UID" == "0" ]]
	then
		if _typeDep 'apt-get'
		then
			apt-get -y install sudo
		fi
	fi
	#! _typeDep sudo && _stop 1
	
	if ! _typeDep bc
	then
		if _typeDep 'apt-get'
		then
			sudo -n apt-get -y install bc
		fi
	fi
	! _typeDep bc && _stop 1
	
	if type _timetest > /dev/null 2>&1 && [[ "$devfast" != 'true' ]]
	then
		echo -n -e '\E[1;32;46m Timing...		\E[0m'
		echo
		
		# DANGER: Even under MSW/Cygwin, should ONLY fail IF extremely slow storage is attached.
		if type _test_selfTime > /dev/null 2>&1
		then
			echo -e '\E[0;36m Timing: _test_selfTime \E[0m'
			if ! _test_selfTime
			then
				if _if_cygwin
				then
					echo 'warn: accepted: cygwin: _test_selfTime broken'
				else
					echo '_test_selfTime broken'
					_stop 1
				fi
			fi
		fi
		
		if type _test_bashTime > /dev/null 2>&1
		then
			echo -e '\E[0;36m Timing: _test_bashTime \E[0m'
			! _test_bashTime && echo '_test_selfTime broken' && _stop 1
		fi
		
		if type _test_filemtime > /dev/null 2>&1
		then
			echo -e '\E[0;36m Timing: _test_filemtime \E[0m'
			! _test_filemtime && echo '_test_selfTime broken' && _stop 1
		fi
		
		if type _test_timeoutRead > /dev/null 2>&1
		then
			echo -e '\E[0;36m Timing: _test_timeoutRead \E[0m'
			! _test_timeoutRead && echo '_test_timeoutRead broken' && _stop 1
		fi
		
		echo -e '\E[0;36m Timing: _timetest \E[0m'
		! _timetest && echo '_timetest broken' && _stop 1
	fi
	
	
	_messageNormal "Dependency checking..."
	
	## Check dependencies
	
	# WARNING: Although '#!/usr/bin/env bash' is used as header when possible, some high-speed 'heredoc' scripts may instead rely on '#!/bin/bash' or '#!/bin/dash' to ensure performance. For these important use cases, the typical '/bin/bash' and '/bin/dash' binary locations are required.
	_getDep /bin/bash
	! [[ -e /bin/bash ]] && echo '/bin/bash missing' && _stop 1
	! [[ -x /bin/bash ]] && echo '/bin/bash nonexecutable' && _stop 1
	_getDep /bin/dash
	! [[ -e /bin/dash ]] && echo '/bin/dash missing' && _stop 1
	! [[ -x /bin/dash ]] && echo '/bin/dash nonexecutable' && _stop 1
	
	#"generic/filesystem"/permissions.sh
	_checkDep stat
	
	_getDep cksum
	
	_getDep wget
	_getDep grep
	_getDep fgrep
	_getDep sed
	_getDep awk
	_getDep cut
	_getDep head
	_getDep tail
	
	_getDep seq
	
	_getDep wc
	
	_getDep fold
	
	
	! _compat_realpath && ! _wantGetDep realpath && echo 'realpath missing'
	_getDep readlink
	_getDep dirname
	_getDep basename
	
	_getDep sleep
	_getDep wait
	_getDep kill
	_getDep jobs
	_getDep ps
	_getDep exit
	
	_getDep env
	_getDep printenv
	_getDep bash
	_getDep echo
	_getDep cat
	_getDep tac
	_getDep type
	_getDep mkdir
	_getDep trap
	_getDep return
	_getDep set
	
	# WARNING: Deprecated. Migrate to 'type -p' instead when possible.
	# WARNING: No known production use.
	#https://unix.stackexchange.com/questions/85249/why-not-use-which-what-to-use-then
	_getDep which
	
	_getDep printf
	
	_getDep stat
	_getDep touch
	
	_getDep dd
	_wantGetDep blockdev
	_wantGetDep lsblk
	
	_getDep rm
	
	_getDep find
	_getDep ln
	_getDep ls
	
	_getDep id
	
	_getDep test
	
	_getDep true
	_getDep false
	
	_getDep diff
	
	_getDep uuidgen
	
	_getDep bc
	_getDep xxd
	_getDep od
	
	_getDep yes
	
	
	_getDep xargs
	
	
	
	_getDep perl
	
	
	# WARNING: Avoid if possible.
	# Not needed by 'ubiquitous_bash' itself up to at least commit 51ba42ed50b24a0e6eca749e8db7bee5c52cce47 .
	_wantGetDep expect
	
	
	_tryExec "_test_python"
	_tryExec "_test_haskell"
	
	
	
	_test_readlink_f
	
	_tryExec "_test_package"
	
	_tryExec "_test_daemon"
	
	_tryExec "_testFindPort"
	_tryExec "_test_waitport"
	
	
	_tryExec "_test_gitBest"
	
	_tryExec "_test_fw"
	_tryExec "_test_hosts"
	
	_tryExec "_testProxySSH"
	
	_tryExec "_testAutoSSH"
	
	_tryExec "_testTor"
	
	_tryExec "_testProxyRouter"
	
	#_tryExec "_test_build"
	
	_tryExec "_testGosu"
	
	_tryExec "_testMountChecks"
	_tryExec "_testBindMountManager"
	_tryExec "_testDistro"
	_tryExec "_test_fetchDebian"
	
	_tryExec "_test_image"
	_tryExec "_test_transferimage"
	
	_tryExec "_testCreatePartition"
	_tryExec "_testCreateFS"
	
	_tryExec "_test_mkboot"
	
	_tryExec "_test_abstractfs"
	_tryExec "_test_fakehome"
	_tryExec "_testChRoot"
	_tryExec "_testQEMU"
	_tryExec "_testQEMU_x64-x64"
	_tryExec "_testQEMU_x64-raspi"
	_tryExec "_testQEMU_raspi-raspi"
	_tryExec "_testVBox"
	
	_tryExec "_test_vboxconvert"
	
	_tryExec "_test_dosbox"
	
	_tryExec "_testWINE"
	
	_tryExec "_test_docker"
	
	_tryExec "_test_docker_mkimage"
	
	_tryExec "_testVirtBootdisc"
	
	_tryExec "_test_live"
	
	_tryExec "_testExtra"
	
	_tryExec "_testGit"
	
	_tryExec "_test_bup"
	
	_tryExec "_testX11"
	
	_tryExec "_test_virtLocal_X11"
	
	_tryExec "_test_search"
	
	_tryExec "_test_packetDriveDevice"
	_tryExec "_test_gparted"


	_tryExec "_test_wsl2_internal"

	
	# WARNING: Disabled by default. Newer FLOSS (ie. 'barrier'), seems to have displaced the older 'synergy' software.
	# ATTENTION: Override with 'ops' or similar.
	# More portable computing (ie. better laptops) and hardware (eg. mechanical) USB switches are also displacing the usefulness of such keyboard/mouse sharing software.
	#_tryExec "_test_synergy"
	
	
	
	_tryExec "_test_ollama"
	
	
	
	_tryExec "_test_devqalculate"
	_tryExec "_test_devgnuoctave"
	
	
	
	_tryExec "_test_devatom"
	_tryExec "_test_devemacs"
	_tryExec "_test_deveclipse"
	
	
	_tryExec "_test_h1060p"
	
	
	_tryExec "_test_ethereum"
	_tryExec "_test_ethereum_parity"
	
	
	
	_tryExec "_test_mktorrent"
	
	
	_tryExec "_test_cloud"
	
	_tryExec "_test_rclone"
	_tryExec "_test_croc"
	
	_tryExec "_test_terraform"
	
	
	_tryExec "_test_vagrant_build"
	
	
	
	_tryExec "_test_rclone_limited"
	
	
	
	_tryExec "_test_kernelConfig"
	
	
	_tryExec "_test_clog"
	
	_tryExec "_test_metaengine"
	
	_tryExec "_test_channel"
	
	_tryExec "_test_nix-env"
	
	
	! [[ -e /dev/urandom ]] && echo /dev/urandom missing && _stop 1
	[[ $(_timeout 3 cat /dev/urandom 2> /dev/null | _timeout 3 base64 2> /dev/null | _timeout 3 tr -dc 'a-zA-Z0-9' 2> /dev/null | _timeout 3 head -c 18 2> /dev/null) == "" ]] && echo /dev/urandom fail && _stop 1
	
	_messagePASS
	
	if type _test_queue > /dev/null 2>&1 && [[ "$devfast" != 'true' ]]
	then
		_messageNormal "Queue..."
		
		_tryExec '_test_queue'
		
		# DANGER: Even under MSW/Cygwin, should ONLY fail IF extremely slow storage is attached.
		echo -e '\E[0;36m Queue: _test_broadcastPipe_page \E[0m'
		if ! _test_broadcastPipe_page
		then
			if _if_cygwin
			then
				echo 'warn: accepted: cygwin: _test_broadcastPipe_page broken'
			else
				echo '_test_broadcastPipe_page broken'
				_stop 1
			fi
		fi
		
		# DANGER: Even under MSW/Cygwin, should ONLY fail IF extremely slow storage is attached.
		echo -e '\E[0;36m Queue: _test_broadcastPipe_aggregatorStatic \E[0m'
		if ! _test_broadcastPipe_aggregatorStatic
		then
			if _if_cygwin
			then
				#echo 'warn: accepted: cygwin: _test_broadcastPipe_aggregatorStatic broken'
				echo '_test_broadcastPipe_aggregatorStatic broken'
				_stop 1
			else
				echo '_test_broadcastPipe_aggregatorStatic broken'
				_stop 1
			fi
		fi
		
		_messagePASS
	fi
	
	_messageNormal 'Vector...'
	_vector
	_messagePASS
	
	_tryExec "_test_prog"
	
	
	_stop
}

#_testBuilt_prog() {
#	true
#}

_testBuilt() {
	_start scriptLocal_mkdir_disable
	
	_messageProcess "Binary checking"
	
	_tryExec "_testBuiltIdle"
	_tryExec "_testBuiltGosu"	#Note, requires sudo, not necessary for docker .
	
	_tryExec "_test_ethereum_built"
	_tryExec "_test_ethereum_parity_built"
	
	_tryExec "_testBuiltChRoot"
	_tryExec "_testBuiltQEMU"
	
	_tryExec "_testBuiltExtra"
	
	_tryExec "_testBuilt_prog"
	
	_messagePASS
	
	_stop
}

#Creates symlink in "$HOME"/bin, to the executable at "$1", named according to its residing directory and file name.
_setupCommand() {
	mkdir -p "$HOME"/bin
	! [[ -e "$HOME"/bin ]] && return 1
	
	local clientScriptLocation
	clientScriptLocation=$(_getAbsoluteLocation "$1")
	
	local clientScriptFolder
	clientScriptFolder=$(_getAbsoluteFolder "$1")
	
	local commandName
	commandName=$(basename "$1")
	
	local clientName
	clientName=$(basename "$clientScriptFolder")
	
	_relink_relative "$clientScriptLocation" "$HOME"/bin/"$commandName""-""$clientName"
	
	
}

_setupCommand_meta() {
	mkdir -p "$HOME"/bin
	! [[ -e "$HOME"/bin ]] && return 1
	
	local clientScriptLocation
	clientScriptLocation=$(_getAbsoluteLocation "$1")
	
	local clientScriptFolder
	clientScriptFolder=$(_getAbsoluteFolder "$1")
	
	local clientScriptFolderResidence
	clientScriptFolderResidence=$(_getAbsoluteFolder "$clientScriptFolder")
	
	local commandName
	commandName=$(basename "$1")
	
	local clientName
	clientName=$(basename "$clientScriptFolderResidence")
	
	_relink_relative "$clientScriptLocation" "$HOME"/bin/"$commandName""-""$clientName"
	
	
}

_find_setupCommands() {
	find -L "$scriptAbsoluteFolder" -not \( -path \*_arc\* -prune \) -not \( -path \*__disk\* -prune \) -not \( -path \*/_local/h/\* -prune \) -not \( -path \*/_local/fs/\* -prune \) -not \( -path \*/_local/ubcp/\* -prune \) "$@"
}

#Consider placing files like ' _vnc-machine-"$netName" ' in an "_index" folder for automatic installation.
_setupCommands() {
	#_find_setupCommands -name '_command' -exec "$scriptAbsoluteLocation" _setupCommand '{}' \;
	
	_tryExec "_setup_ssh_commands"
	_tryExec "_setup_command_commands"
}

#_setup_pre() {
#	true
#}

#_setup_prog() {
#	true
#}


_setup_anchor() {
	if ! _if_cygwin && [[ "$objectName" == "ubiquitous_bash" ]]
	then
		# WARNING: End user file association. Do NOT call within scripts.
		# WARNING: Necessarily relies on a 'deprecated' 'field code' with the 'Exec key' of a 'Desktop Entry' file association.
		# https://specifications.freedesktop.org/desktop-entry-spec/desktop-entry-spec-latest.html
		_messagePlain_request 'association: *.bat'
		echo 'konsole --workdir %d -e /bin/bash %f (open in graphical terminal emulator from file manager)'
		echo 'bash'
	fi
	
	if type "_associate_anchors_request" > /dev/null 2>&1
	then
		_tryExec "_associate_anchors_request"
		return
	fi
}

_setup() {
	_installation_nonet_default
	
	_start scriptLocal_mkdir_disable
	
	"$scriptAbsoluteLocation" _test || _stop 1
	
	#Only attempt build procedures if their functions have been defined from "build.sh" . Pure shell script projects (eg. CoreAutoSSH), and projects using only statically compiled binaries, need NOT include such procedures.
	local buildSupported
	type _build > /dev/null 2>&1 && type _test_build > /dev/null 2>&1 && buildSupported="true"
	
	[[ "$buildSupported" == "true" ]] && ! "$scriptAbsoluteLocation" _test_build && _stop 1
	
	if ! "$scriptAbsoluteLocation" _testBuilt
	then
		! [[ "$buildSupported" == "true" ]] && _stop 1
		[[ "$buildSupported" == "true" ]] && ! "$scriptAbsoluteLocation" _build "$@" && _stop 1
		! "$scriptAbsoluteLocation" _testBuilt && _stop 1
	fi
	
	_setupCommands
	
	_tryExec "_setup_pre"
	
	_tryExec "_setup_ssh"
	
	_tryExec "_setup_prog"
	
	_setup_anchor
	
	_stop
}

# DANGER: Especially not expected to modify system program behavior (eg. not to modify "$HOME"/.ssh ).
# WARNING: Strictly expected to not modify anyting outside the script directory.
_setup_local() {
	export ub_setup_local='true'
	
	_setup
}

_test_package() {
	_getDep tar
	_getDep gzip
	
	_getDep xz
}

_package_prog() {
	true
}


_package_ubcp_copy_copy() {
	#cp -a "$1" "$2"
	if [[ "$ubPackage_enable_ubcp" != 'true' ]]
	then
		if [[ "$skimfast" != "true" ]]
		then
			rsync -av --progress --exclude "/ubcp/conemu" --exclude "/ubcp/cygwin" --exclude "/ubcp/package_ubcp-cygwinOnly.tar.gz" --exclude "/ubcp/package_ubcp-cygwinOnly.tar.xz" --exclude "/ubcp/package_ubcp-cygwinOnly.tar.flx" "$1" "$2"
		else
			rsync -a --exclude "/ubcp/conemu" --exclude "/ubcp/cygwin" --exclude "/ubcp/package_ubcp-cygwinOnly.tar.gz" --exclude "/ubcp/package_ubcp-cygwinOnly.tar.xz" --exclude "/ubcp/package_ubcp-cygwinOnly.tar.flx" "$1" "$2"
		fi
	else
		if [[ "$skimfast" != "true" ]]
		then
			rsync -av --progress --exclude "/ubcp/package_ubcp-cygwinOnly.tar.gz" --exclude "/ubcp/package_ubcp-cygwinOnly.tar.xz" --exclude "/ubcp/package_ubcp-cygwinOnly.tar.flx" "$1" "$2"
		else
			rsync -a --exclude "/ubcp/package_ubcp-cygwinOnly.tar.gz" --exclude "/ubcp/package_ubcp-cygwinOnly.tar.xz" --exclude "/ubcp/package_ubcp-cygwinOnly.tar.flx" "$1" "$2"
		fi
	fi
	
	
	rm -f "$safeTmp"/package/_local/package_ubcp-cygwinOnly.tar.gz
	rm -f "$safeTmp"/package/_local/package_ubcp-cygwinOnly.tar.xz
	rm -f "$safeTmp"/package/_local/package_ubcp-cygwinOnly.tar.flx
	rm -f "$safeTmp"/package/_local/ubcp/package_ubcp-cygwinOnly.tar.gz
	rm -f "$safeTmp"/package/_local/ubcp/package_ubcp-cygwinOnly.tar.xz
	rm -f "$safeTmp"/package/_local/ubcp/package_ubcp-cygwinOnly.tar.flx
	
	return 0
}

# ATTENTION: Override with 'installation_prog.sh' or similar.
_package_ubcp_copy_prog() {
	false
	
	cd "$outerPWD"
	return 1
	_stop 1
}

_package_ubcp_copy() {
	mkdir -p "$safeTmp"/package/_local
	
	if [[ -e "$scriptLocal"/ubcp ]]
	then
		_package_ubcp_copy_copy "$scriptLocal"/ubcp "$safeTmp"/package/_local/
		return 0
	fi
	if [[ -e "$scriptLib"/ubcp ]]
	then
		_package_ubcp_copy_copy "$scriptLib"/ubcp "$safeTmp"/package/_local/
		rm -f "$safeTmp"/package/_local/ubcp/package_ubcp-cygwinOnly.tar.gz
		return 0
	fi
	if [[ -e "$scriptAbsoluteFolder"/ubcp ]]
	then
		_package_ubcp_copy_copy "$scriptAbsoluteFolder"/ubcp "$safeTmp"/package/_local/
		rm -f "$safeTmp"/package/_local/ubcp/package_ubcp-cygwinOnly.tar.gz
		return 0
	fi
	
	
	if [[ -e "$scriptLib"/ubiquitous_bash/_local/ubcp ]]
	then
		_package_ubcp_copy_copy "$scriptLib"/ubiquitous_bash/_local/ubcp "$safeTmp"/package/_local/
		rm -f "$safeTmp"/package/_local/ubcp/package_ubcp-cygwinOnly.tar.gz
		return 0
	fi
	if [[ -e "$scriptLib"/ubiquitous_bash/_lib/ubcp ]]
	then
		_package_ubcp_copy_copy "$scriptLib"/ubiquitous_bash/_lib/ubcp "$safeTmp"/package/_local/
		rm -f "$safeTmp"/package/_local/ubcp/package_ubcp-cygwinOnly.tar.gz
		return 0
	fi
	if [[ -e "$scriptLib"/ubiquitous_bash/ubcp ]]
	then
		_package_ubcp_copy_copy "$scriptLib"/ubiquitous_bash/ubcp "$safeTmp"/package/_local/
		rm -f "$safeTmp"/package/_local/ubcp/package_ubcp-cygwinOnly.tar.gz
		return 0
	fi
	
	# ATTENTION: Override with 'installation_prog.sh' or similar.
	if _package_ubcp_copy_prog
	then
		return 0
	fi
	
	
	cd "$outerPWD"
	_stop 1
}

# ATTENTION: Override with 'ops' or similar ONLY if necessary.
_package_subdir() {
	#return 0
	
	# ATTENTION: Error message about 'cannot move' ... 'subdirectory of itself' ... is normal .
	mkdir -p "$safeTmp"/package/"$objectName"_tmp/
	( shopt -s dotglob ; mv "$safeTmp"/package/* "$safeTmp"/package/"$objectName"_tmp/ )
	mv "$safeTmp"/package/"$objectName"_tmp "$safeTmp"/package/"$objectName"
}

# WARNING Must define "_package_license" function in ops to include license files in package!
_package_procedure() {
	_start scriptLocal_mkdir_disable
	mkdir -p "$safeTmp"/package
	
	# May not have any effect - Cygwin symlinks should be transparent to 'tar' and similar.
	_force_cygwin_symlinks
	
	# WARNING: Largely due to presence of '.gitignore' files in 'ubcp' .
	export safeToDeleteGit="true"
	
	_package_prog
	
	_tryExec "_package_license"
	
	_tryExec "_package_cautossh"
	
	#cp -a "$scriptAbsoluteFolder"/.git "$safeTmp"/package/ > /dev/null 2>&1
	cp "$scriptAbsoluteFolder"/.gitignore "$safeTmp"/package/ > /dev/null 2>&1
	cp "$scriptAbsoluteFolder"/.gitmodules "$safeTmp"/package/ > /dev/null 2>&1
	
	cp "$scriptAbsoluteFolder"/COPYING "$safeTmp"/package/ > /dev/null 2>&1
	cp "$scriptAbsoluteFolder"/COPYING* "$safeTmp"/package/ > /dev/null 2>&1
	
	cp "$scriptAbsoluteFolder"/gpl.txt "$safeTmp"/package/ > /dev/null 2>&1
	cp "$scriptAbsoluteFolder"/gpl-*.txt "$safeTmp"/package/ > /dev/null 2>&1
	cp "$scriptAbsoluteFolder"/gpl-3.0.txt "$safeTmp"/package/ > /dev/null 2>&1
	
	cp "$scriptAbsoluteFolder"/agpl.txt "$safeTmp"/package/ > /dev/null 2>&1
	cp "$scriptAbsoluteFolder"/agpl-*.txt "$safeTmp"/package/ > /dev/null 2>&1
	cp "$scriptAbsoluteFolder"/agpl-3.0.txt "$safeTmp"/package/ > /dev/null 2>&1
	
	cp "$scriptAbsoluteFolder"/license.txt "$safeTmp"/package/ > /dev/null 2>&1
	cp "$scriptAbsoluteFolder"/license*.txt "$safeTmp"/package/ > /dev/null 2>&1
	
	#scriptBasename=$(basename "$scriptAbsoluteLocation")
	#cp -a "$scriptAbsoluteLocation" "$safeTmp"/package/"$scriptBasename"
	cp -a "$scriptAbsoluteLocation" "$safeTmp"/package/
	cp -a "$scriptAbsoluteFolder"/ops "$safeTmp"/package/
	cp -a "$scriptAbsoluteFolder"/ops.sh "$safeTmp"/package/
	
	cp "$scriptAbsoluteFolder"/_* "$safeTmp"/package/
	cp "$scriptAbsoluteFolder"/*.sh "$safeTmp"/package/
	cp "$scriptAbsoluteFolder"/*.py "$safeTmp"/package/
	
	cp -a "$scriptLocal"/ops "$safeTmp"/package/
	cp -a "$scriptLocal"/ops.sh "$safeTmp"/package/
	
	#cp -a "$scriptAbsoluteFolder"/_bin "$safeTmp"
	#cp -a "$scriptAbsoluteFolder"/_config "$safeTmp"
	#cp -a "$scriptAbsoluteFolder"/_prog "$safeTmp"
	
	#cp -a "$scriptAbsoluteFolder"/_local "$safeTmp"/package/
	
	cp -a "$scriptAbsoluteFolder"/README.md "$safeTmp"/package/
	cp -a "$scriptAbsoluteFolder"/USAGE.html "$safeTmp"/package/
	
	cp -a "$scriptAbsoluteFolder"/README.sh "$safeTmp"/package/
	cp -a "$scriptAbsoluteFolder"/README.html "$safeTmp"/package/
	cp -a "$scriptAbsoluteFolder"/README.pdf "$safeTmp"/package/
	cp -a "$scriptAbsoluteFolder"/README.md "$safeTmp"/package/
	
	
	cp -a "$scriptAbsoluteFolder"/_config "$safeTmp"/package/
	
	
	cp -a "$scriptAbsoluteFolder"/_bin "$safeTmp"/package/
	
	
	cp "$scriptAbsoluteFolder"/fork "$safeTmp"/package/
	
	
	rm -f "$safeTmp"/package/devtask* > /dev/null 2>&1
	rm -f "$safeTmp"/package/__d_* > /dev/null 2>&1
	rm -f "$safeTmp"/package/_d_* > /dev/null 2>&1
	
	
	#if [[ "$ubPackage_enable_ubcp" == 'true' ]]
	#then
		#_package_ubcp_copy "$@"
	#fi
	
	_package_ubcp_copy "$@"
	if [[ "$ubPackage_enable_ubcp" != 'true' ]]
	then
		_safeRMR "$safeTmp"/package/_local/ubcp/conemu
		_safeRMR "$safeTmp"/package/_local/ubcp/cygwin
	fi
	
	cd "$safeTmp"/package/
	_package_subdir
	
	#! [[ "$ubPackage_enable_ubcp" == 'true' ]] && env GZIP=-9 tar -czvf "$scriptAbsoluteFolder"/package.tar.gz .
	! [[ "$ubPackage_enable_ubcp" == 'true' ]] && env XZ_OPT=-e9 tar -cJvf "$scriptAbsoluteFolder"/package.tar.xz .
	#[[ "$ubPackage_enable_ubcp" == 'true' ]] && env GZIP=-9 tar -czvf "$scriptAbsoluteFolder"/package_ubcp.tar.gz .
	#[[ "$ubPackage_enable_ubcp" == 'true' ]] && env XZ_OPT=-e9 tar -cJvf "$scriptAbsoluteFolder"/package_ubcp.tar.xz .
	[[ "$ubPackage_enable_ubcp" == 'true' ]] && env XZ_OPT="-5 -T0" tar -cJvf "$scriptAbsoluteFolder"/package_ubcp.tar.xz .
	
	if [[ "$ubPackage_enable_ubcp" == 'true' ]]
	then
		_messagePlain_request 'request: review contents of _local/ubcp/cygwin/home and similar directories'
	fi
	
	cd "$outerPWD"
	_stop
}

_package() {
	export ubPackage_enable_ubcp='false'
	"$scriptAbsoluteLocation" _package_procedure "$@"
	
	export ubPackage_enable_ubcp='true'
	"$scriptAbsoluteLocation" _package_procedure "$@"
}








_install_special() {
    echo test
}





_configureLocal() {
	_configureFile "$1" "_local"
}

_configureFile() {
	cp "$scriptAbsoluteFolder"/"$1" "$scriptAbsoluteFolder"/"$2"
}

_configureOps() {
	echo "$@" >> "$scriptAbsoluteFolder"/ops
}

_resetOps() {
	rm "$scriptAbsoluteFolder"/ops
}

_gitPull_ubiquitous() {
	#git pull
	_gitBest pull
}

_gitClone_ubiquitous() {
	#git clone --depth 1 git@github.com:mirage335/ubiquitous_bash.git
	_gitBest clone --recursive --depth 1 git@github.com:mirage335/ubiquitous_bash.git
}

_selfCloneUbiquitous() {
	"$scriptBin"/.ubrgbin.sh _ubrgbin_cpA "$scriptBin" "$ubcoreUBdir"/ > /dev/null 2>&1
	cp -a "$scriptAbsoluteLocation" "$ubcoreUBdir"/lean.sh
	cp -a "$scriptAbsoluteLocation" "$ubcoreUBdir"/ubcore.sh
	cp -a "$scriptAbsoluteFolder"/lean.sh "$ubcoreUBdir"/lean.sh > /dev/null 2>&1
	cp -a "$scriptAbsoluteFolder"/lean.sh "$ubcoreUBdir"/ubcore.sh > /dev/null 2>&1
	cp -a "$scriptAbsoluteFolder"/ubcore.sh "$ubcoreUBdir"/ubcore.sh > /dev/null 2>&1
	cp -a "$scriptAbsoluteLocation" "$ubcoreUBdir"/ubiquitous_bash.sh
	
	cp -a "$scriptAbsoluteFolder"/lean.py "$ubcoreUBdir"/lean.py > /dev/null 2>&1
}

_installUbiquitous() {
	local localFunctionEntryPWD
	localFunctionEntryPWD="$PWD"
	
	cd "$ubcoreDir"
	
	cd "$ubcoreUBdir"
	_messagePlain_nominal 'attempt: git pull'
	if [[ "$nonet" != "true" ]] && type git > /dev/null 2>&1
	then
		_gitBest_detect
		
		local ub_gitPullStatus
		#git pull
		_gitBest pull
		ub_gitPullStatus="$?"
		#[[ "$ub_gitPullStatus" != 0 ]] && git pull && ub_gitPullStatus="$?"
		[[ "$ub_gitPullStatus" != 0 ]] && _gitBest pull && ub_gitPullStatus="$?"
		! cd "$localFunctionEntryPWD" && return 1
		
		[[ "$ub_gitPullStatus" == "0" ]] && _messagePlain_good 'pass: git pull' && cd "$localFunctionEntryPWD" && return 0
	fi
	_messagePlain_warn 'fail: git pull'
	
	cd "$ubcoreDir"
	_messagePlain_nominal 'attempt: git clone'
	[[ "$nonet" != "true" ]] && type git > /dev/null 2>&1 && [[ ! -e ".git" ]] && [[ ! -e "$ubcoreUBdir"/.git ]] && _gitClone_ubiquitous && _messagePlain_good 'pass: git clone' && return 0
	[[ "$nonet" != "true" ]] && type git > /dev/null 2>&1 && [[ ! -e ".git" ]] && [[ ! -e "$ubcoreUBdir"/.git ]] && _gitClone_ubiquitous && _messagePlain_good 'pass: git clone' && return 0
	_messagePlain_warn 'fail: git clone'
	
	cd "$ubcoreUBdir"
	_messagePlain_nominal 'attempt: self git pull'
	# WARNING: Not attempted if 'nonet' has been set 'true', due to possible conflicts with scripts intending only to copy one file (ie. by SSH transfer).
	if [[ "$nonet" != "true" ]] && type git > /dev/null 2>&1 && [[ -e "$scriptAbsoluteFolder"/.git ]] && [[ -e "$scriptAbsoluteFolder"/.git ]]
	then
		
		local ub_gitPullStatus
		#git reset --hard
		[[ -e "$scriptAbsoluteFolder"/lean.sh ]] && rm -f "$ubcoreUBdir"/lean.sh > /dev/null 2>&1
		[[ -e "$scriptAbsoluteFolder"/ubcore.sh ]] && rm -f "$ubcoreUBdir"/ubcore.sh > /dev/null 2>&1
		[[ -e "$scriptAbsoluteFolder"/ubiquitous_bash.sh ]] && rm -f "$ubcoreUBdir"/ubiquitous_bash.sh > /dev/null 2>&1
		[[ -e "$scriptAbsoluteFolder"/lean_compressed.sh ]] && rm -f "$ubcoreUBdir"/lean_compressed.sh > /dev/null 2>&1
		[[ -e "$scriptAbsoluteFolder"/core_compressed.sh ]] && rm -f "$ubcoreUBdir"/core_compressed.sh > /dev/null 2>&1
		[[ -e "$scriptAbsoluteFolder"/ubcore_compressed.sh ]] && rm -f "$ubcoreUBdir"/ubcore_compressed.sh > /dev/null 2>&1
		[[ -e "$scriptAbsoluteFolder"/ubiquitous_bash_compressed.sh ]] && rm -f "$ubcoreUBdir"/ubiquitous_bash_compressed.sh > /dev/null 2>&1
		[[ -e "$scriptAbsoluteFolder"/lean.py ]] && rm -f "$ubcoreUBdir"/lean.py > /dev/null 2>&1
		#git reset --hard
		#git pull "$scriptAbsoluteFolder"
		_gitBest pull "$scriptAbsoluteFolder"
		_gitBest reset --hard
		ub_gitPullStatus="$?"
		! cd "$localFunctionEntryPWD" && return 1
		
		[[ "$ub_gitPullStatus" == "0" ]] && _messagePlain_good 'pass: self git pull' && cd "$localFunctionEntryPWD" && return 0
	fi
	_messagePlain_warn 'fail: self git pull'
	
	cd "$ubcoreDir"
	_messagePlain_nominal 'attempt: self clone'
	[[ -e ".git" ]] && _messagePlain_bad 'fail: self clone' && return 1
	_selfCloneUbiquitous && return 0
	_messagePlain_bad 'fail: self clone' && return 1
	
	return 0
	
	cd "$localFunctionEntryPWD"
}




_setupUbiquitous() {
	_messageNormal "init: setupUbiquitous"
	
	if _if_cygwin
	then
		echo 'detected: cygwin'
		_messagePlain_probe_cmd _setupUbiquitous_accessories-git
	fi
	
	_force_cygwin_symlinks
	_if_cygwin && _setup_ubiquitousBash_cygwin_procedure
	
	
	local ubHome
	ubHome="$HOME"
	[[ "$1" != "" ]] && ubHome="$1"
	
	export ubcoreDir="$ubHome"/.ubcore
	export ubcoreFile="$ubcoreDir"/.ubcorerc
	
	export ubcoreDir_accessories="$ubHome"/.ubcore/accessories
	
	
	# WARNING: Despite the name, do NOT point this to 'ubcore.sh' or similar. Full set of functions are expected from this file by some use cases!
	export ubcoreUBdir="$ubcoreDir"/ubiquitous_bash
	export ubcoreUBfile="$ubcoreDir"/ubiquitous_bash/ubiquitous_bash.sh
	
	_messagePlain_probe 'ubHome= '"$ubHome"
	_messagePlain_probe 'ubcoreDir= '"$ubcoreDir"
	_messagePlain_probe 'ubcoreFile= '"$ubcoreFile"
	
	_messagePlain_probe 'ubcoreUBdir= '"$ubcoreUBdir"
	_messagePlain_probe 'ubcoreUBfile= '"$ubcoreUBfile"
	
	mkdir -p "$ubcoreUBdir"
	! [[ -e "$ubcoreUBdir" ]] && _messagePlain_bad 'missing: ubcoreUBdir= '"$ubcoreUBdir" && _messageFAIL && return 1
	
	mkdir -p "$ubcoreDir_accessories"
	! [[ -e "$ubcoreDir_accessories" ]] && _messagePlain_bad 'missing: ubcoreUBdir_accessories= '"$ubcoreDir_accessories" && _messageFAIL && return 1
	
	
	_messageNormal "install: setupUbiquitous"
	! _installUbiquitous && _messageFAIL && return 1
	! [[ -e "$ubcoreUBfile" ]] && _messagePlain_bad 'missing: ubcoreUBfile= '"$ubcoreUBfile" && _messageFAIL && return 1
	
	
	_messageNormal "hook: setupUbiquitous"
	if ! _permissions_ubiquitous_repo "$ubcoreUBdir" && _messagePlain_bad 'permissions: ubcoreUBdir = '"$ubcoreUBdir"
	then
		if ! _if_cygwin
		then
			_messageFAIL
			return 1
		else
			echo 'warn: accepted: cygwin: permissions'
		fi
	fi
	
	mkdir -p "$ubHome"/bin/
	ln -sf "$ubcoreUBfile" "$ubHome"/bin/ubiquitous_bash.sh
	ln -sf "$ubcoreUBfile" "$ubHome"/bin/_winehere
	ln -sf "$ubcoreUBfile" "$ubHome"/bin/_winecfghere
	
	echo '#!/bin/bash
"$HOME"/bin/ubiquitous_bash.sh _vncf "$@"' > "$ubHome"/bin/vncf
	chmod u+x "$ubHome"/bin/vncf
	
	echo '#!/bin/bash
"$HOME"/bin/ubiquitous_bash.sh _sshf "$@"' > "$ubHome"/bin/sshf
	chmod u+x "$ubHome"/bin/vncf
	
	
	
	_setupUbiquitous_here > "$ubcoreFile"
	_setupUbiquitous_accessories_bashrc >> "$ubcoreFile"
	_setupUbiquitous_safe_bashrc >> "$ubcoreFile"
	! [[ -e "$ubcoreFile" ]] && _messagePlain_bad 'missing: ubcoreFile= '"$ubcoreFile" && _messageFAIL && return 1
	
	
	! grep ubcore "$ubHome"/.bashrc > /dev/null 2>&1 && _messagePlain_probe "$ubcoreFile"' >> '"$ubHome"/.bashrc && echo ". ""$ubcoreFile" >> "$ubHome"/.bashrc
	! grep ubcore "$ubHome"/.bashrc > /dev/null 2>&1 && _messagePlain_bad 'missing: bashrc hook' && _messageFAIL && return 1
	
	
	if [[ ! -e "$HOME"/.bash_profile ]] || ! grep '\.bashrc' "$HOME"/.bash_profile > /dev/null 2>&1
	then
		_setupUbiquitous_bashProfile_here >> "$HOME"/.bash_profile
	fi
	
	_setupUbiquitous_resize >> "$ubcoreFile"
	
	
	_messageNormal "install: setupUbiquitous_accessories"
	
	_setupUbiquitous_accessories "$@"
	
	
	_messageNormal "request: setupUbiquitous_accessories , setupUbiquitous"
	
	_setupUbiquitous_accessories_requests "$@"
	
	if ! _if_cygwin
	then
		# WARNING: End user file association. Do NOT call within scripts.
		# WARNING: Necessarily relies on a 'deprecated' 'field code' with the 'Exec key' of a 'Desktop Entry' file association.
		# https://specifications.freedesktop.org/desktop-entry-spec/desktop-entry-spec-latest.html
		_messagePlain_request 'association: *.bat'
		echo 'konsole --workdir %d -e /bin/bash %f (open in graphical terminal emulator from file manager) (preferred)'
		echo "bash ('Advanced Options -> Run in terminal')"
	fi
	
	_messagePlain_request "Now import new functionality into current shell if not in current shell."
	if [[ "$profileScriptLocation" != "" ]] && [[ "$profileScriptFolder" != "" ]]
	then
		_messagePlain_request ". "'"'"$scriptAbsoluteLocation"'"' --profile _importShortcuts
	else
		_request_visualPrompt
	fi
	
	sleep 3
	return 0
}

_setupUbiquitous_nonet() {
	local oldNoNet
	oldNoNet="$nonet"
	export nonet="true"
	_setupUbiquitous "$@"
	[[ "$oldNoNet" != "true" ]] && export nonet="$oldNoNet"
}

_upgradeUbiquitous() {
	_setupUbiquitous
}

_resetUbiquitous_sequence() {
	_start scriptLocal_mkdir_disable
	
	[[ ! -e "$HOME"/.bashrc ]] && return 0
	cp "$HOME"/.bashrc "$HOME"/.bashrc.bak
	cp "$HOME"/.bashrc "$safeTmp"/.bashrc
	grep -v 'ubcore' "$safeTmp"/.bashrc > "$safeTmp"/.bashrc.tmp
	mv "$safeTmp"/.bashrc.tmp "$HOME"/.bashrc
	
	[[ ! -e "$HOME"/.ubcore ]] && return 0
	rm "$HOME"/.ubcorerc
	
	_stop
}

_resetUbiquitous() {
	"$scriptAbsoluteLocation" _resetUbiquitous_sequence
}

_refresh_anchors_ubiquitous() {
	#cp -a "$scriptAbsoluteFolder"/_anchor "$scriptAbsoluteFolder"/_ubide
	
	cp -a "$scriptAbsoluteFolder"/_anchor "$scriptAbsoluteFolder"/_ubdb
	
	cp -a "$scriptAbsoluteFolder"/_anchor "$scriptAbsoluteFolder"/_test
	cp -a "$scriptAbsoluteFolder"/_anchor "$scriptAbsoluteFolder"/_true
	cp -a "$scriptAbsoluteFolder"/_anchor "$scriptAbsoluteFolder"/_false
	
	cp -a "$scriptAbsoluteFolder"/_anchor.bat "$scriptAbsoluteFolder"/_test.bat
	cp -a "$scriptAbsoluteFolder"/_anchor.bat "$scriptAbsoluteFolder"/_true.bat
	cp -a "$scriptAbsoluteFolder"/_anchor.bat "$scriptAbsoluteFolder"/_false.bat
	
	cp -a "$scriptAbsoluteFolder"/_anchor.bat "$scriptAbsoluteFolder"/_bin.bat
	cp -a "$scriptAbsoluteFolder"/_anchor.bat "$scriptAbsoluteFolder"/_bash.bat
	
	cp -a "$scriptAbsoluteFolder"/_anchor.bat "$scriptAbsoluteFolder"/_setup_ubcp.bat
	cp -a "$scriptAbsoluteFolder"/_anchor.bat "$scriptAbsoluteFolder"/_setup_ubiquitousBash_cygwin.bat
	
	cp -a "$scriptAbsoluteFolder"/_anchor.bat "$scriptAbsoluteFolder"/_setupUbiquitous.bat
	cp -a "$scriptAbsoluteFolder"/_anchor.bat "$scriptAbsoluteFolder"/_setupUbiquitous_nonet.bat
	
	cp -a "$scriptAbsoluteFolder"/_anchor.bat "$scriptAbsoluteFolder"/_demand_broadcastPipe_page.bat
	cp -a "$scriptAbsoluteFolder"/_anchor.bat "$scriptAbsoluteFolder"/_terminate_broadcastPipe_page.bat
	
	
	cp -a "$scriptAbsoluteFolder"/_anchor.bat "$scriptAbsoluteFolder"/_packetDriveDevice.bat
	cp -a "$scriptAbsoluteFolder"/_anchor.bat "$scriptAbsoluteFolder"/_packetDriveDevice_remove.bat
}


_refresh_anchors_cautossh() {
	cp -a "$scriptAbsoluteFolder"/_anchor "$scriptAbsoluteFolder"/_test
	cp -a "$scriptAbsoluteFolder"/_anchor "$scriptAbsoluteFolder"/_setup
	cp -a "$scriptAbsoluteFolder"/_anchor "$scriptAbsoluteFolder"/_bash
	cp -a "$scriptAbsoluteFolder"/_anchor "$scriptAbsoluteFolder"/_bin
	cp -a "$scriptAbsoluteFolder"/_anchor "$scriptAbsoluteFolder"/_grsync
	
	cp -a "$scriptAbsoluteFolder"/_anchor.bat "$scriptAbsoluteFolder"/_test.bat
	cp -a "$scriptAbsoluteFolder"/_anchor.bat "$scriptAbsoluteFolder"/_setup.bat
	cp -a "$scriptAbsoluteFolder"/_anchor.bat "$scriptAbsoluteFolder"/_bash.bat
	cp -a "$scriptAbsoluteFolder"/_anchor.bat "$scriptAbsoluteFolder"/_bin.bat
	cp -a "$scriptAbsoluteFolder"/_anchor.bat "$scriptAbsoluteFolder"/_grsync.bat
}


# EXAMPLE ONLY.
# _refresh_anchors() {
# 	cp -a "$scriptAbsoluteFolder"/_anchor "$scriptAbsoluteFolder"/_true
# }


# CAUTION: Anchor scripts MUST include code to ignore '--' suffix specific software name convention!
# CAUTION: ONLY intended to be used either with generic software, or anchors following '--' suffix specific software name convention!
# WARNING: DO NOT enable in "core.sh". Intended to be enabled by "_local/ops.sh".
# ATTENTION: Set "$ub_anchor_specificSoftwareName" or similar in "ops.sh".
# ATTENTION: Set ub_anchor_user='true' or similar in "ops.sh".
#export ub_anchor_specificSoftwareName='experimental'
#export ub_anchor_user="true"
_set_refresh_anchors_specific() {
	export ub_anchor_suffix=
	export ub_anchor_suffix
	
	[[ "$ub_anchor_specificSoftwareName" == "" ]] && return 0
	
	export ub_anchor_suffix='--'"$ub_anchor_specificSoftwareName"
	
	return 0
}

_refresh_anchors_specific_single_procedure() {
	[[ "$ub_anchor_specificSoftwareName" == "" ]] && return 1
	
	_set_refresh_anchors_specific
	
	cp -a "$scriptAbsoluteFolder"/_anchor "$scriptAbsoluteFolder"/"$1""$ub_anchor_suffix"
	
	return 0
}
# Assumes user has included "$HOME"/bin in their "$PATH".
_refresh_anchors_user_single_procedure() {
	[[ "$ub_anchor_user" != 'true' ]] && return 1
	
	_set_refresh_anchors_specific
	! mkdir -p "$HOME"/bin && return 1
	
	
	# WARNING: Default to replacement. Rare case considered acceptable for several reasons.
	# Negligible damage potential - all replaced files are symlinks or anchors.
	# Limited to specifically named anchor symlinks, defined in "_associate_anchors_request", typically overloaded with 'core.sh' or similar.
	# Usually requested 'manually' through "_setup" or "_anchor", even if called through a multi-installation request.
	# Incorrectly calling a moved, uninstalled, or otherwise incorrect previous version, of linked software, is anticipated to be a more commonly impose greater risk.
	#ln -s "$scriptAbsoluteFolder"/"$1""$ub_anchor_suffix" "$HOME"/bin/ > /dev/null 2>&1
	ln -sf "$scriptAbsoluteFolder"/"$1""$ub_anchor_suffix" "$HOME"/bin/
	
	return 0
}

# ATTENTION: Overload with 'core.sh' or similar.
# # EXAMPLE ONLY.
# _refresh_anchors_specific() {
# 	_refresh_anchors_specific_single_procedure _true
# }
# # EXAMPLE ONLY.
# _refresh_anchors_user() {
# 	_refresh_anchors_user_single_procedure _true
# }


# ATTENTION: Overload with 'core'sh' or similar.
# _associate_anchors_request() {
# 	if type "_refresh_anchors_user" > /dev/null 2>&1
# 	then
# 		_tryExec "_refresh_anchors_user"
# 		#return
# 	fi
# 	
# 	_messagePlain_request 'association: dir'
# 	echo _scope_konsole"$ub_anchor_suffix"
# 	
# 	_messagePlain_request 'association: dir'
# 	echo _scope_designer_designeride"$ub_anchor_suffix"
# 	
# 	_messagePlain_request 'association: dir, *.ino'
# 	echo _designer_generate"$ub_anchor_suffix"
# }



# ATTENTION: Overload with 'core.sh' or similar.
# WARNING: May become default behavior.
_anchor_autoupgrade() {
	local currentScriptBaseName
	currentScriptBaseName=$(basename $scriptAbsoluteLocation)
	[[ "$currentScriptBaseName" != "ubiquitous_bash.sh" ]] && return 1
	
	[[ "$ub_anchor_autoupgrade" != 'true' ]] && return 0
	
	_findUbiquitous
	
	[[ -e "$ubiquitousLibDir"/_anchor ]] && cp -a "$ubiquitousLibDir"/_anchor "$scriptAbsoluteFolder"/_anchor
}

_anchor_configure() {
	export ubAnchorTemplateCurrent="$scriptAbsoluteFolder"/_anchor
	[[ "$1" != "" ]] && export ubAnchorTemplateCurrent="$1"
	
	! [[ -e "$ubAnchorTemplateCurrent" ]] && return 1
	
	#https://superuser.com/questions/450868/what-is-the-simplest-scriptable-way-to-check-whether-a-shell-variable-is-exporte
	! [ "$(bash -c 'echo ${objectName}')" ] && return 1
	
	
	rm -f "$scriptAbsoluteFolder"/_anchor.tmp "$scriptAbsoluteFolder"/_anchor.tmp1 "$scriptAbsoluteFolder"/_anchor.tmp2 > /dev/null 2>&1
	cp "$ubAnchorTemplateCurrent" "$scriptAbsoluteFolder"/_anchor.tmp
	cp "$ubAnchorTemplateCurrent" "$scriptAbsoluteFolder"/_anchor.tmp1
	cp "$ubAnchorTemplateCurrent" "$scriptAbsoluteFolder"/_anchor.tmp2
	
	cat "$scriptAbsoluteFolder"/_anchor.tmp  | sed 's/^export anchorSourceDir\=.*$/export anchorSourceDir\=\"'"$objectName"'\"/g' > "$scriptAbsoluteFolder"/_anchor.tmp1
	#perl -p -e 's/export anchorSourceDir=.*/export anchorSourceDir="$ENV{objectName}"/g' "$scriptAbsoluteFolder"/_anchor.tmp > "$scriptAbsoluteFolder"/_anchor.tmp1
	
	cat "$scriptAbsoluteFolder"/_anchor.tmp1 | sed 's/^SET \"MSWanchorSourceDir\=.*$/SET \"MSWanchorSourceDir\='"$objectName"'\"/g' > "$scriptAbsoluteFolder"/_anchor.tmp2
	#perl -p -e 's/SET "MSWanchorSourceDir=.*/SET "MSWanchorSourceDir=$ENV{objectName}"/g' "$scriptAbsoluteFolder"/_anchor.tmp1 > "$scriptAbsoluteFolder"/_anchor.tmp2
	
	local currentScriptBaseName
	currentScriptBaseName=$(basename $scriptAbsoluteLocation)
	
	# ATTENTION: Configure with 'ops.sh' , 'core.sh' , or similar.
	if [[ "$scriptAbsoluteLocation" == *"cautossh" ]] || [[ "$scriptAbsoluteLocation" != *"ubiquitous_bash.sh" ]]
	then
		cat "$scriptAbsoluteFolder"/_anchor.tmp2  | sed 's/^export anchorSource\=.*$/export anchorSource\=\"'"$currentScriptBaseName"'\"/g' > "$scriptAbsoluteFolder"/_anchor.tmp3
		#perl -p -e 's/export anchorSource=.*/export anchorSource="cautossh"/g' "$scriptAbsoluteFolder"/_anchor.tmp2 > "$scriptAbsoluteFolder"/_anchor.tmp3
		
		cat "$scriptAbsoluteFolder"/_anchor.tmp3 | sed 's/^SET \"MSWanchorSource\=.*$/SET \"MSWanchorSource\='"$currentScriptBaseName"'\"/g' > "$scriptAbsoluteFolder"/_anchor.tmp4
		#perl -p -e 's/SET "MSWanchorSource=.*/SET "MSWanchorSource=cautossh"/g' "$scriptAbsoluteFolder"/_anchor.tmp3 > "$scriptAbsoluteFolder"/_anchor.tmp4
	else
		cat "$scriptAbsoluteFolder"/_anchor.tmp2 > "$scriptAbsoluteFolder"/_anchor.tmp4
	fi
	
	mv "$scriptAbsoluteFolder"/_anchor.tmp4 "$ubAnchorTemplateCurrent"
	chmod u+x "$ubAnchorTemplateCurrent"
	rm -f "$scriptAbsoluteFolder"/_anchor.tmp "$scriptAbsoluteFolder"/_anchor.tmp1 "$scriptAbsoluteFolder"/_anchor.tmp2 "$scriptAbsoluteFolder"/_anchor.tmp3 "$scriptAbsoluteFolder"/_anchor.tmp4 > /dev/null 2>&1
}


_anchor() {
	_anchor_autoupgrade
	
	_anchor_configure
	_anchor_configure "$scriptAbsoluteFolder"/_anchor.bat

	_tryExec "_anchor_special"
	
	! [[ -e "$scriptAbsoluteFolder"/_anchor ]] && ! [[ -e "$scriptAbsoluteFolder"/_anchor.bat ]] && return 1
	
	[[ "$scriptAbsoluteFolder" == *"ubiquitous_bash" ]] && _refresh_anchors_ubiquitous
	
	if type "_refresh_anchors_cautossh" > /dev/null 2>&1 && [[ "$scriptAbsoluteLocation" == *"cautossh" ]]
	then
		_tryExec "_refresh_anchors_cautossh"
		#return
	fi
	
	
	if type "_refresh_anchors" > /dev/null 2>&1
	then
		_tryExec "_refresh_anchors"
		#return
	fi
	
	# CAUTION: Anchor scripts MUST include code to ignore '--' suffix specific software name convention!
	# WARNING: DO NOT enable in "core.sh". Intended to be enabled by "_local/ops.sh".
	if type "_refresh_anchors_specific" > /dev/null 2>&1
	then
		_tryExec "_refresh_anchors_specific"
		#return
	fi
	
	# CAUTION: ONLY intended to be used either with generic software, or anchors following '--' suffix specific software name convention!
	# WARNING: DO NOT enable in "core.sh". Intended to be enabled by "_local/ops.sh".
	if type "_refresh_anchors_user" > /dev/null 2>&1
	then
		_tryExec "_refresh_anchors_user"
		#return
	fi
	
	# WARNING: Calls _refresh_anchors_user . Same variables required to enable, intended to be set by "_local/ops.sh".
	#if type "_associate_anchors_request" > /dev/null 2>&1
	#then
		#_tryExec "_associate_anchors_request"
		##return
	#fi
	
	
	
	return 0
}


#####Program

#Typically launches an application - ie. through virtualized container.
_launch() {
	false
	#"$@"
}

#Typically gathers command/variable scripts from other (ie. yaml) file types (ie. AppImage recipes).
_collect() {
	false
}

#Typical program entry point, absent any instancing support.
_enter() {
	_launch "$@"
}

#Typical program entry point.
_main() {
	_start
	
	_collect
	
	_enter "$@"
	
	_stop
}

##### Core


_experiment() {
	echo test
}

_gitMad_neighbors_procedure() {
	local functionEntryPWD
	functionEntryPWD="$PWD"

	[[ ! -e '/cygdrive/c/core/infrastructure/iconArt' ]] && _messageFAIL

	cd '/cygdrive/c/core/infrastructure/iconArt'
	_gitMad
	
	cd "$functionEntryPWD"
}
_gitMad_neighbors() {
	"$scriptAbsoluteLocation" _gitMad_neighbors_procedure "$@"
}


_setup_install-permissions() {
	local functionEntryPWD
	functionEntryPWD="$PWD"
	
	_messagePlain_probe_cmd chmod 755 /home/root/.ssh/id_*.pub
	_messagePlain_probe_cmd chmod 600 /home/root/.ssh/id_*

	cd /home/root/.ubcore/ubiquitous_bash
	git config --global --add safe.directory /home/root/.ubcore/ubiquitous_bash
	_gitMad


	cd "$functionEntryPWD"
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
	#--exclude ".gitconfig"
	#--exclude "_bashrc"
	_messagePlain_probe_cmd rsync -ax --delete --exclude ".bash_profile" --exclude ".bashrc" --exclude ".config" --exclude ".inputrc" --exclude ".lesshst" --exclude ".octave_hist" --exclude ".octaverc" --exclude ".profile" --exclude ".ubcore" --exclude ".ubcorerc_pythonrc.py" --exclude ".ubcorerc-gnuoctave.m" --exclude ".viminfo" --exclude ".wget-hsts" --exclude "bin" "$currentSource" "$currentDestination"
	#_setup_install-permissions "$@"
}
_setup_install_procedure() {
	_messageNormal 'init: _setup_install'
	_messagePlain_probe "$@"
	
	
	_messagePlain_nominal 'begin: _setup_install'
	
	
	
	# Some such commands may need to run at least twice. Doing so multiple different ways substantially reduces risk of future breakage.
	# https://pureinfotech.com/uninstall-widgets-powershell-windows-11/
	# https://nerdschalk.com/how-to-hide-disable-or-uninstall-widgets-on-windows-11-and-disable-windowsw-shortcut/
	
	# WARNING: CAUTION: WinGet may halt installer.
	# https://github.com/microsoft/winget-cli/discussions/1536
	#--accept-package-agreements --accept-source-agreements
	#cmd /c winget uninstall "Windows web experience pack"
	#winget uninstall "Windows web experience pack"
	
	# WARNING: CAUTION: PowerShell may cause failure, due to increasingly limited availablility for 'security' reasons.
	powershell -Command "Get-AppxPackage WebExperience | Remove-AppxPackage"
	
	
	
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
	#_setup_install-permissions "$@"

	_messagePlain_probe_cmd unzip -o "$scriptAbsoluteFolder"/support/000-OS/MSW/root_extra.zip -d /cygdrive/c

	mkdir -p /cygdrive/c/core
	mkdir -p /cygdrive/c/core/_buried
	mkdir -p /cygdrive/c/core/backup/zSpecial/FanControl
	mkdir -p /cygdrive/c/core/infrastructure
	mkdir -p /cygdrive/c/core/installations
	mkdir -p /cygdrive/c/core/investigation
	mkdir -p /cygdrive/c/core/info

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
	# "_pgnd" playground
	# "_release" release (eg. public websites)
	# "cr" corporate (must be very short, others projects especially may have long paths)
	# "og" org (must be very short, others projects especially may have long paths)
	# z_mirage335-gizmos
	# zSpecial
	mkdir -p /cygdrive/c/q/p
	mkdir -p /cygdrive/c/q/p/_cur
	mkdir -p /cygdrive/c/q/p/_def
	mkdir -p /cygdrive/c/q/p/_perm
	mkdir -p /cygdrive/c/q/p/_pgnd
	mkdir -p /cygdrive/c/q/p/_release
	mkdir -p /cygdrive/c/q/p/cr
	mkdir -p /cygdrive/c/q/p/og
	mkdir -p /cygdrive/c/q/p/z_mirage335-gizmos
	mkdir -p /cygdrive/c/q/p/zSpecial


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
	mkdir -p "/cygdrive/c/core/webCache/named/DCS World OpenBeta"
	mkdir -p "/cygdrive/c/core/webCache/named/Frontier_Developments"
	mkdir -p "/cygdrive/c/core/webCache/named/Microsoft Flight Simulator - Steam"

	_messagePlain_probe_cmd unzip -o "$scriptAbsoluteFolder"/support/000-OS/MSW/webCache_index.zip -d /cygdrive/c/core/webCache/_index




	reg add "HKEY_CLASSES_ROOT\Directory\shell\OpenWith_ubcp-bash" /v "" /d "Open with ubcp-bash" /f
	reg add "HKEY_CLASSES_ROOT\Directory\shell\OpenWith_ubcp-bash\command" /v "" /d "C:\_bash.bat" /f

	reg add "HKEY_CLASSES_ROOT\Directory\Background\shell\OpenWith_ubcp-bash" /v "" /d "Open with ubcp-bash" /f
	reg add "HKEY_CLASSES_ROOT\Directory\Background\shell\OpenWith_ubcp-bash\command" /v "" /d "C:\_bash.bat" /f

	reg add "HKEY_CLASSES_ROOT\Directory\shell\OpenWith_ubcp-bash-admin" /v "" /d "Open with ubcp-bash-admin" /f
	reg add "HKEY_CLASSES_ROOT\Directory\shell\OpenWith_ubcp-bash-admin\command" /v "" /d "nircmdc elevate cmd /c \"cd \"%V\" && C:\_bash.bat\"" /f

	reg add "HKEY_CLASSES_ROOT\Directory\Background\shell\OpenWith_ubcp-bash-admin" /v "" /d "Open with ubcp-bash-admin" /f
	reg add "HKEY_CLASSES_ROOT\Directory\Background\shell\OpenWith_ubcp-bash-admin\command" /v "" /d "nircmdc elevate cmd /c \"cd \"%V\" && C:\_bash.bat\"" /f



	_messagePlain_probe_cmd _self_gitMad
	#_setup_install-permissions "$@"

	_messagePlain_probe_cmd _gitMad_neighbors
	

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
	
	
	cp -a "$scriptAbsoluteFolder"/_anchor "$scriptAbsoluteFolder"/rewrite_jg
}




# NOTICE: Very rare. You probably do NOT want this. For the author's own present situation.
_rewrite_jg_present() {
	# stick
	#{7CE82F20-0DE0-11ED-801A-444553540000}
	
	# throttle
	#{7CE76BD0-0DE0-11ED-800F-444553540000}
	
	_rewrite_jg "{7CE82F20-0DE0-11ED-801A-444553540000}" "{7CE76BD0-0DE0-11ED-800F-444553540000}"
}



_rewrite_jg() {
	local functionEntryPWD
	functionEntryPWD="$PWD"
	
	
	mkdir -p "$scriptAbsoluteFolder"/support/joystickgremlin-ref
	
	#_safeRMR "$scriptAbsoluteFolder"/support/joystickgremlin
	mkdir -p "$scriptAbsoluteFolder"/support/joystickgremlin
	
	rsync -ax "$scriptAbsoluteFolder"/support/joystickgremlin-ref/. "$scriptAbsoluteFolder"/support/joystickgremlin/.
	
	
	"$scriptAbsoluteLocation" _rewrite_joystick "$1"
	cd "$functionEntryPWD"
	
	"$scriptAbsoluteLocation" _rewrite_throttle "$2"
	cd "$functionEntryPWD"
	
	
	cd "$functionEntryPWD"
}



_rewrite_throttle() {
	cd "$scriptAbsoluteFolder"/support
	
	mkdir -p "$scriptAbsoluteFolder"/support/joystickgremlin-ref
	
	#_safeRMR "$scriptAbsoluteFolder"/support/joystickgremlin
	mkdir -p "$scriptAbsoluteFolder"/support/joystickgremlin
	
	#rsync -ax "$scriptAbsoluteFolder"/support/joystickgremlin-ref/. "$scriptAbsoluteFolder"/support/joystickgremlin/.
	
	
	
	
	
	# ATTENTION: both OBSOLETE and PRESENT ids are used as placeholders for any NEEDED id
	
	
	cd "$scriptAbsoluteFolder"/support/joystickgremlin/.
	
	
	#{9FDEE5A0-E57C-11E7-8009-444553540000}
	#{7CE76BD0-0DE0-11ED-800F-444553540000}
	
	
	find . -iname '*.xml' -exec sed -i 's/{9FDEE5A0-E57C-11E7-8009-444553540000}/'"$1"'/g' {} \;
	find . -iname '*.xml' -exec sed -i 's/{7CE76BD0-0DE0-11ED-800F-444553540000}/'"$1"'/g' {} \;
}


_rewrite_joystick() {
	cd "$scriptAbsoluteFolder"/support
	
	mkdir -p "$scriptAbsoluteFolder"/support/joystickgremlin-ref
	
	#_safeRMR "$scriptAbsoluteFolder"/support/joystickgremlin
	mkdir -p "$scriptAbsoluteFolder"/support/joystickgremlin
	
	#rsync -ax "$scriptAbsoluteFolder"/support/joystickgremlin-ref/. "$scriptAbsoluteFolder"/support/joystickgremlin/.
	
	
	
	
	
	# ATTENTION: both OBSOLETE and PRESENT ids are used as placeholders for any NEEDED id
	
	
	cd "$scriptAbsoluteFolder"/support/joystickgremlin/.
	
	
	#{A4608390-E525-11E9-802D-444553540000}
	#{7CE82F20-0DE0-11ED-801A-444553540000}
	
	
	find . -iname '*.xml' -exec sed -i 's/{A4608390-E525-11E9-802D-444553540000}/'"$1"'/g' {} \;
	find . -iname '*.xml' -exec sed -i 's/{7CE82F20-0DE0-11ED-801A-444553540000}/'"$1"'/g' {} \;
}





#####Overrides

[[ "$isDaemon" == "true" ]] && echo "$$" | _prependDaemonPID

#May allow traps to work properly in simple scripts which do not include more comprehensive "_stop" or "_stop_emergency" implementations.
if ! type _stop > /dev/null 2>&1
then
	# ATTENTION: Consider carefully, override with "ops".
	# WARNING: Unfortunate, but apparently necessary, workaround for script termintaing while "sleep" or similar run under background.
	_stop_stty_echo() {
		#true
		
		stty echo --file=/dev/tty > /dev/null 2>&1
		
		#[[ "$ubFoundEchoStatus" != "" ]] && stty --file=/dev/tty "$ubFoundEchoStatus" 2> /dev/null
	}
	_stop() {
		_stop_stty_echo
		
		if [[ "$1" != "" ]]
		then
			exit "$1"
		else
			exit 0
		fi
	}
fi
if ! type _stop_emergency > /dev/null 2>&1
then
	_stop_emergency() {
		_stop "$1"
	}
fi

#Traps, if script is not imported into existing shell, or bypass requested.
# WARNING Exact behavior of this system is critical to some use cases.
if [[ "$ub_import" != "true" ]] || [[ "$ub_import_param" == "--bypass" ]]
then
	trap 'excode=$?; _stop $excode; trap - EXIT; echo $excode' EXIT HUP QUIT PIPE 	# reset
	trap 'excode=$?; trap "" EXIT; _stop $excode; echo $excode' EXIT HUP QUIT PIPE 	# ignore
	
	# DANGER: Mechanism of workaround 'ub_trapSet_stop_emergency' is not fully understood, and was added undesirably late in development, with unknown effects. Nevertheless, a need for such functionality is expected to be encountered only rarely.
	# At least '_closeChRoot' , '_userChRoot' , '_userVBox' do not seem to have lost functionality.
	# DANGER: Any shell command matching ' _timeout.*&$ ' (backgrounding of _timeout) will probably be unable to reach '_stop' correctly, and may not remove temporary directories, etc.
	if [[ "$ub_trapSet_stop_emergency" != 'true' ]]
	then
		trap 'excode=$?; _stop_emergency $excode; trap - EXIT; echo $excode' INT TERM	# reset
		trap 'excode=$?; trap "" EXIT; _stop_emergency $excode; echo $excode' INT TERM	# ignore
		export ub_trapSet_stop_emergency='true'
	fi
fi

# DANGER: NEVER intended to be set in an end user shell for ANY reason.
# DANGER: Implemented to prevent 'compile.sh' from attempting to run functions from 'ops.sh'. No other valid use currently known or anticipated!
if [[ "$ub_ops_disable" != 'true' ]]
then
	#Override functions with external definitions from a separate file if available.
	#if [[ -e "./ops" ]]
	#then
	#	. ./ops
	#fi

	#Override functions with external definitions from a separate file if available.
	# CAUTION: Recommend only "ops" or "ops.sh" . Using both can cause confusion.
	# ATTENTION: Recommend "ops.sh" only when unusually long. Specifically intended for "CoreAutoSSH" .
	if [[ -e "$objectDir"/ops ]]
	then
		. "$objectDir"/ops
	fi
	if [[ -e "$objectDir"/ops.sh ]]
	then
		. "$objectDir"/ops.sh
	fi
	if [[ -e "$scriptLocal"/ops ]]
	then
		. "$scriptLocal"/ops
	fi
	if [[ -e "$scriptLocal"/ops.sh ]]
	then
		. "$scriptLocal"/ops.sh
	fi
	if [[ -e "$scriptLocal"/ssh/ops ]]
	then
		. "$scriptLocal"/ssh/ops
	fi
	if [[ -e "$scriptLocal"/ssh/ops.sh ]]
	then
		. "$scriptLocal"/ssh/ops.sh
	fi

	#WILL BE OVERWRITTEN FREQUENTLY.
	#Intended for automatically generated shell code identifying usable resources, such as unused network ports. Do NOT use for serialization of internal variables (use $varStore for that).
	if [[ -e "$objectDir"/opsauto ]]
	then
		. "$objectDir"/opsauto
	fi
	if [[ -e "$scriptLocal"/opsauto ]]
	then
		. "$scriptLocal"/opsauto
	fi
	if [[ -e "$scriptLocal"/ssh/opsauto ]]
	then
		. "$scriptLocal"/ssh/opsauto
	fi
fi

#wsl '~/.ubcore/ubiquitous_bash/ubiquitous_bash.sh' '_wrap' kwrite './gpl-3.0.txt'
#wsl '~/.ubcore/ubiquitous_bash/ubiquitous_bash.sh' '_wrap' ldesk
_wrap() {
	[[ "$LANG" != "C" ]] && export LANG=C
	. "$HOME"/.ubcore/.ubcorerc
	
	_safe_declare_uid
	
	if uname -a | grep -i 'microsoft' > /dev/null 2>&1 && uname -a | grep -i 'WSL2' > /dev/null 2>&1
	then
		local currentArg
		local currentResult
		processedArgs=()
		for currentArg in "$@"
		do
			currentResult=$(wslpath -u "$currentArg")
			if [[ -e "$currentResult" ]]
			then
				true
			else
				currentResult="$currentArg"
			fi
			
			processedArgs+=("$currentResult")
		done
		
		
		"${processedArgs[@]}"
		return
	fi
	
	"$@"
}

#Wrapper function to launch arbitrary commands within the ubiquitous_bash environment, including its PATH with scriptBin.
_bin() {
	_safe_declare_uid
	
	"$@"
}
#Mostly intended to launch bash prompt for MSW/Cygwin users.
_bash() {
	_safe_declare_uid
	
	local currentIsCygwin
	currentIsCygwin='false'
	[[ -e '/cygdrive' ]] && uname -a | grep -i cygwin > /dev/null 2>&1 && _if_cygwin && currentIsCygwin='true'
	
	# WARNING: What is otherwise considered bad practice may be accepted to reduce substantial MSW/Cygwin inconvenience .
	[[ "$currentIsCygwin" == 'true' ]] && echo -n '.'
	
	
	_visualPrompt
	[[ "$ub_scope_name" != "" ]] && _scopePrompt
	
	_safe_declare_uid
	
	
	[[ "$1" == '-i' ]] && shift
	
	
	_safe_declare_uid
	
	if [[ "$currentIsCygwin" == 'true' ]] && grep ubcore "$HOME"/.bashrc > /dev/null 2>&1 && [[ "$scriptAbsoluteLocation" == *"lean.sh" ]]
	then
		export sessionid=""
		export scriptAbsoluteFolder=""
		export scriptAbsoluteLocation=""
		bash -i "$@"
		return
	elif  [[ "$currentIsCygwin" == 'true' ]] && grep ubcore "$HOME"/.bashrc > /dev/null 2>&1 && [[ "$scriptAbsoluteLocation" != *"lean.sh" ]]
	then
		bash -i "$@"
		return
	elif [[ "$currentIsCygwin" == 'true' ]] && ! grep ubcore "$HOME"/.bashrc > /dev/null 2>&1
	then
		bash --norc -i "$@"
		return
	else
		bash -i "$@"
		return
	fi
	
	bash -i "$@"
	return
	
	return 1
}

#Mostly if not entirely intended for end user convenience.
_python() {
	_safe_declare_uid
	
	if [[ -e "$safeTmp"/lean.py ]]
	then
		"$safeTmp"/lean.py '_python()'
		return
	fi
	if [[ -e "$scriptAbsoluteFolder"/lean.py ]]
	then
		"$scriptAbsoluteFolder"/lean.py '_python()'
		return
	fi
	if type -p 'lean.py' > /dev/null 2>&1
	then
		lean.py '_python()'
		return
	fi
	return 1
}

#Launch internal functions as commands, and other commands, as root.
_sudo() {
	_safe_declare_uid
	
	sudo -n "$scriptAbsoluteLocation" _bin "$@"
}

_true() {
	_safe_declare_uid
	
	#"$scriptAbsoluteLocation" _false && return 1
	#  ! "$scriptAbsoluteLocation" _bin true && return 1
	#"$scriptAbsoluteLocation" _bin false && return 1
	true
}
_false() {
	_safe_declare_uid
	
	false
}
_echo() {
	_safe_declare_uid
	
	echo "$@"
}

_diag() {
	_safe_declare_uid
	
	echo "$sessionid"
}

#Stop if script is imported, parameter not specified, and command not given.
if [[ "$ub_import" == "true" ]] && [[ "$ub_import_param" == "" ]] && [[ "$1" != '_'* ]]
then
	_messagePlain_warn 'import: missing: parameter, missing: command' | _user_log-ub
	ub_import=""
	return 1 > /dev/null 2>&1
	exit 1
fi

#Set "ubOnlyMain" in "ops" overrides as necessary.
if [[ "$ubOnlyMain" != "true" ]]
then
	
	#Launch command named by link name.
	if scriptLinkCommand=$(_getScriptLinkName)
	then
		if [[ "$scriptLinkCommand" == '_'* ]]
		then
			"$scriptLinkCommand" "$@"
			internalFunctionExitStatus="$?"
			
			#Exit if not imported into existing shell, or bypass requested, else fall through to subsequent return.
			if [[ "$ub_import" != "true" ]] || [[ "$ub_import_param" == "--bypass" ]] || [[ "$ub_import_param" == "--compressed" ]]
			then
				#export noEmergency=true
				exit "$internalFunctionExitStatus"
			fi
			ub_import=""
			return "$internalFunctionExitStatus" > /dev/null 2>&1
			exit "$internalFunctionExitStatus"
		fi
	fi
	
	# NOTICE Launch internal functions as commands.
	#if [[ "$1" != "" ]] && [[ "$1" != "-"* ]] && [[ ! -e "$1" ]]
	#if [[ "$1" == '_'* ]] || [[ "$1" == "true" ]] || [[ "$1" == "false" ]]
	# && [[ "$1" != "_test" ]] && [[ "$1" != "_setup" ]] && [[ "$1" != "_build" ]] && [[ "$1" != "_vector" ]] && [[ "$1" != "_setupCommand" ]] && [[ "$1" != "_setupCommand_meta" ]] && [[ "$1" != "_setupCommands" ]] && [[ "$1" != "_find_setupCommands" ]] && [[ "$1" != "_setup_anchor" ]] && [[ "$1" != "_anchor" ]] && [[ "$1" != "_package" ]] && [[ "$1" != *"_prog" ]] && [[ "$1" != "_main" ]] && [[ "$1" != "_collect" ]] && [[ "$1" != "_enter" ]] && [[ "$1" != "_launch" ]] && [[ "$1" != "_default" ]] && [[ "$1" != "_experiment" ]]
	if [[ "$1" == '_'* ]] && type "$1" > /dev/null 2>&1 && [[ "$1" != "_test" ]] && [[ "$1" != "_setup" ]] && [[ "$1" != "_build" ]] && [[ "$1" != "_vector" ]] && [[ "$1" != "_setupCommand" ]] && [[ "$1" != "_setupCommand_meta" ]] && [[ "$1" != "_setupCommands" ]] && [[ "$1" != "_find_setupCommands" ]] && [[ "$1" != "_setup_anchor" ]] && [[ "$1" != "_anchor" ]] && [[ "$1" != "_package" ]] && [[ "$1" != *"_prog" ]] && [[ "$1" != "_main" ]] && [[ "$1" != "_collect" ]] && [[ "$1" != "_enter" ]] && [[ "$1" != "_launch" ]] && [[ "$1" != "_default" ]] && [[ "$1" != "_experiment" ]]
	then
		"$@"
		internalFunctionExitStatus="$?"
		
		#Exit if not imported into existing shell, or bypass requested, else fall through to subsequent return.
		if [[ "$ub_import" != "true" ]] || [[ "$ub_import_param" == "--bypass" ]] || [[ "$ub_import_param" == "--compressed" ]]
		then
			#export noEmergency=true
			exit "$internalFunctionExitStatus"
		fi
		ub_import=""
		return "$internalFunctionExitStatus" > /dev/null 2>&1
		exit "$internalFunctionExitStatus"
		#_stop "$?"
	fi
fi

[[ "$ubOnlyMain" == "true" ]] && export ubOnlyMain="false"

#Do not continue script execution through program code if critical global variables are not sane.
[[ ! -e "$scriptAbsoluteLocation" ]] && exit 1
[[ ! -e "$scriptAbsoluteFolder" ]] && exit 1
_failExec || exit 1

#Return if script is under import mode, and bypass is not requested.
# || [[ "$current_internal_CompressedScript" != "" ]] || [[ "$current_internal_CompressedScript_cksum" != "" ]] || [[ "$current_internal_CompressedScript_bytes" != "" ]]
if [[ "$ub_import" == "true" ]] && ! ( [[ "$ub_import_param" == "--bypass" ]] ) || [[ "$ub_import_param" == "--compressed" ]] || [[ "$ub_import_param" == "--parent" ]] || [[ "$ub_import_param" == "--profile" ]]
then
	return 0 > /dev/null 2>&1
	exit 0
fi


#####Overrides DISABLE

# DANGER: NEVER intended to be set in an end user shell for ANY reason.
# DANGER: Implemented to prevent 'compile.sh' from attempting to run functions from 'ops.sh'. No other valid use currently known or anticipated!
export ub_ops_disable='true'


#####Entry

# WARNING: Do not add code directly here without disabling checksum!
# WARNING: Checksum may only be disabled either by override of 'generic/minimalheader.sh' or by adding appropriate '.nck' file !

#"$scriptAbsoluteLocation" _setup




if [[ "$1" == '_'* ]] && type "$1" > /dev/null 2>&1
then
	"$@"
	internalFunctionExitStatus="$?"
	return "$internalFunctionExitStatus" > /dev/null 2>&1
	exit "$internalFunctionExitStatus"
fi
if [[ "$1" != '_'* ]]
then
	_main "$@"
fi

