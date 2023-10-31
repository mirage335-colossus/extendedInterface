#IN
	#"$metaDir"/ai/plaintext
	#"$metaDir"/ai/privilege
	#"$metaDir"/bi/commKey (optional)
	#"$metaDir"/bi/samplenumber
#OUT
	#"$metaDir"/ao/plaintext
	#"$metaDir"/bo/commKey
	#"$metaDir"/bo/samplenumber
	#"$metaDir"/bo/confidence ("0" || "1")
# "$commFields_key"
# "$commFields_keyConfig"
# "$commFields_keyLog"
_me_processor_commKey_interpreter() {
	_messageNormal 'launch: '"$metaObjName"
	
	! _wait_metaengine && ! _me_internal_fail_confidence && return 1
	_start_metaengine
	_relink_metaengine_in
	! _me_internal_wait_confidence && ! _me_internal_fail_confidence && return 1
	mkdir -p "$metaDir"/diag
	
	if [[ -e "$metaDir"/bi/commKey ]]
	then
		_reset_commFields
		local currentCommKeyPath
		currentCommKeyPath=$(readlink -f "$metaDir"/bi/commKey)
		_set_commFields "$currentCommKeyPath"
	fi
	
	cp -r "$commFields_key" "$metaDir"/diag/kd_in
	
	
	[[ ! -d "$commFields_key" ]] && _messageError 'fail: commFields: not dir' && ! _me_internal_fail_confidence && return 1
	! _me_internal_commKey_checkReady && ! _me_internal_fail_confidence && return 1
	
	#cp "$metaDir"/ai/plaintext "$metaDir"/ao/plaintext
	_commKey_interpreter_filter "$metaDir"/ai/plaintext "$metaDir"/ao/plaintext "$metaDir"/ai/privilege
	
	#! [[ -e "$metaDir"/ao/plaintext ]] && echo -n > "$metaDir"/ao/plaintext
	! [[ -e "$metaDir"/ao/plaintext ]] && ! _me_internal_fail_confidence && return 1
	
	cp "$metaDir"/bi/samplenumber "$metaDir"/bo/samplenumber > /dev/null 2>&1
	
	_relink_relative "$commFields_absolute" "$metaDir"/bo/commKey
	
	
	
	echo -n '1' > "$metaDir"/bo/confidence
	
	cp -r "$commFields_key" "$metaDir"/diag/kd_out
	
	_relink_metaengine_out
	
	#optional, closes host upon completion
	#_stop
}
