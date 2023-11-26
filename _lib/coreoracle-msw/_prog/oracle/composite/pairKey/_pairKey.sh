
# NOTICE: Legacy. Configures and uses YubiKey OAUTH to generate matching time dependent passwords .
# DANGER: Safe (including some, but only some, post-quantum safety). Short-term integrity (ie.  SHA3-256 length extension resistance vs. HMAC, human readable Encrypt-and-MAC) was prioritized, confidentiality is only short-term (ie. AES-128-CFB1). Key reuse may result in some revealing patterns (eg. sending the same information multiple times).
#  DANGER: There are *very* good technical reasons for these tradeoffs. Do not tinker with such algorithms unless you really know what you are doing.
#   DANGER: Especially do not add predictable or unnecessary output (eg. do NOT salt, do NOT prepend predictable headers).
#   DANGER: Some aspects of software simplicity are a deliberate goal, appropriately prioritized (eg. no salt). Software issues are considered much more likely and much more catastrophic to integrity, than some loss of confidentiality.
#  Good use case is transfer of software packages, with credentials, for installation, to an offline computer. Malware installed to the offline computer would be devastating, whereas partial loss of confidentiality would only affect credentials that were completely compromised soon enough.
#  Another good use case is transfer of malware analysis out of or across separate network computers for public release or more analysis. Malware persisting with unanalyzed code on the separate network computer could reinfect the definitions, whereas loss of confidentiality may probably not be timely or complete enough for that to significantly reduce disinfection effectiveness.
# WARNING: Algorims here, even for the reference implementation, may change, as expected uses are ephemeral, invalidating old data.
# ATTENTION: All that said, this is safe. You have far more to worry about from malware, etc.


_pair-generate() {
	#_gatherEntropy
	_extractEntropyBin 10 | base32
}

_pair-create() {
	#local current_sharedSecret
	#current_sharedSecret=$(_pair-generate)
	#[[ "$1" != "" ]] && current_sharedSecret="$1"
	
	local current_sharedSecret1
	current_sharedSecret1=$(_pair-generate)
	[[ "$1" != "" ]] && current_sharedSecret1="$1"
	
	local current_sharedSecret2
	current_sharedSecret2=$(_pair-generate)
	[[ "$1" != "" ]] && current_sharedSecret2="$2"
	
	local current_sharedSecret3
	current_sharedSecret3=$(_pair-generate)
	[[ "$1" != "" ]] && current_sharedSecret3="$3"
	
	_messagePlain_request 'request: Ctrl+c or connect YubiKey and Enter .'
	while read
	do
		_messageNormal 'write: YubiKey'
		#ykman oath accounts delete 60/pair-oracle --force > /dev/null 2>&1
		#ykman oath accounts delete 3/pair-oracle --force > /dev/null 2>&1
		#ykman oath accounts delete pair-oracle --force > /dev/null 2>&1
		ykman oath accounts delete 60/pair-oracle-1 --force > /dev/null 2>&1
		#ykman oath accounts delete 3/pair-oracle-1 --force > /dev/null 2>&1
		#ykman oath accounts delete pair-oracle-1 --force > /dev/null 2>&1
		ykman oath accounts delete 60/pair-oracle-2 --force > /dev/null 2>&1
		#ykman oath accounts delete 3/pair-oracle-2 --force > /dev/null 2>&1
		#ykman oath accounts delete pair-oracle-2 --force > /dev/null 2>&1
		ykman oath accounts delete 60/pair-oracle-3 --force > /dev/null 2>&1
		#ykman oath accounts delete 3/pair-oracle-3 --force > /dev/null 2>&1
		#ykman oath accounts delete pair-oracle-3 --force > /dev/null 2>&1
		#echo "$current_sharedSecret" | ykman oath accounts add --digits 8 --oath-type TOTP --algorithm SHA512 --period 3 pair-oracle
		echo "$current_sharedSecret1" | ykman oath accounts add --digits 8 --oath-type TOTP --algorithm SHA512 --period 60 --touch pair-oracle-1
		echo "$current_sharedSecret2" | ykman oath accounts add --digits 8 --oath-type TOTP --algorithm SHA512 --period 60 --touch pair-oracle-2
		echo "$current_sharedSecret3" | ykman oath accounts add --digits 8 --oath-type TOTP --algorithm SHA512 --period 60 --touch pair-oracle-3
		[[ "$?" != "0" ]] && _messageFAIL
		_messagePlain_good 'done: write: YubiKey'
		_messagePlain_request 'request: Ctrl+c or connect YubiKey and Enter .'
	done
	
	return 0
}

_pair-grab-stdout() {
	#local currentPID
	
	# WARNING: May be untested .
	#_messagePlain_request 'request: Choose minute, close to the minute, press ENTER.'
	#( while date +%M:%S ; do sleep 1 ; done ) 2>/dev/null &
	#currentPID="$!"
	#read > /dev/null 2>&1
	#kill "$currentPID" > /dev/null 2>&1
	#kill -KILL "$currentPID" > /dev/null 2>&1
	
	#if [[ $(date +%S | sed 's/^0//') -lt 30 ]]
	#hen
		#echo 'wait: '$(bc <<< '60 + '$(date +%S))
		#while ! [[ $(date +%S | sed 's/^0//') -ge 59 ]] ; do sleep 0.3 ; done
		#while [[ $(date +%S | sed 's/^0//') -gt 14 ]] ; do sleep 7 ; done
		#while [[ $(date +%S | sed 's/^0//') -gt 0 ]] ; do sleep 0.3 ; done
	#else
		#echo 'wait: '$(bc <<< '60 - '$(date +%S))
		#while [[ $(date +%S | sed 's/^0//') -gt 14 ]] ; do sleep 7 ; done
		#while [[ $(date +%S | sed 's/^0//') -gt 0 ]] ; do sleep 0.3 ; done
	#fi
	#sleep 0.1
	
	
	
	
	_messagePlain_request 'request: Please confirm presence at YubiKey at the minute.' > /dev/tty
	while [[ $(date +%S | sed 's/^0//') -gt 25 ]]
	do
		date +%S > /dev/tty
		sleep 1 > /dev/tty
	done
	
	
	
	#ykman oath accounts code pair-oracle
	#sleep 3
	#sleep 0.1
	#ykman oath accounts code pair-oracle
	#sleep 3
	#sleep 0.1
	#ykman oath accounts code pair-oracle
	
	ykman oath accounts code pair-oracle-1 | tr -dc '0-9'
	ykman oath accounts code pair-oracle-2 | tr -dc '0-9'
	ykman oath accounts code pair-oracle-3 | tr -dc '0-9'
	
	echo -n 'Minute: ' > /dev/tty
	date +%M > /dev/tty
}

_pair-grab() {
	[[ -e "$HOME"/.pair ]] && _pair-purge
	
	echo -n > "$HOME"/.pair
	chmod 600 "$HOME"/.pair
	#_pair-grab-stdout > "$HOME"/.pair
	
	# ATTENTION: Since pair keys are expected ephemeral, algorithm may change, or may be disregarded, invalidating existing pair keys.
	_pair-grab-stdout | xxd -p | tr -d '\n' | openssl enc -e -aes-256-cbc -pass stdin -nosalt -pbkdf2 -in /dev/zero 2>/dev/null | xxd -p | tr -d '\n' | dd of="$HOME"/.pair bs=1M count=10 status=progress iflag=fullblock
	
	head -c 20 "$HOME"/.pair > "$HOME"/.pair-keyAuth
	
	tail -c 10 "$HOME"/.pair | openssl enc -e -aes-256-cbc -pass stdin -nosalt -pbkdf2 -in /dev/zero 2>/dev/null | tr -dc '0-9a-zA-Z' | head -c 20
	echo
}

_pair-purge() {
	! [[ -e "$HOME"/.pair ]] && ! [[ -e "$HOME"/.pair-keyAuth ]] && return 0
	
	_sweep "$HOME"/.pair
	_sweep "$HOME"/.pair-keyAuth
}

# ATTENTION: Since pair keys are expected ephemeral, algorithm may change, or may be disregarded, invalidating existing pair keys.
_pair-summary() {
	cat "$HOME"/.pair | xxd -p | tr -d '\n' | openssl enc -e -aes-256-cbc -pass stdin -nosalt -pbkdf2 -in /dev/zero 2>/dev/null | xxd -p | tr -d '\n' | head -c 20
}








_current_message-toSimple() {
	cat | base64 | base64 | cat
}

_current_message-toBin() {
	cat | base64 -d | base64 -d | cat
}



# https://en.wikipedia.org/wiki/HMAC
#  'The Keccak hash function, that was selected by NIST as the SHA-3 competition winner, doesn't need this nested approach and can be used to generate a MAC by simply prepending/appending the key to the message, as it is not susceptible to length-extension attacks.'
# https://en.wikipedia.org/wiki/Authenticated_encryption
#  'Encrypt-and-MAC' ... Same key is used.
_pair-mac() {
	cat "$HOME"/.pair-keyAuth - | openssl dgst -sha3-256 -binary | head -c32
}

# https://en.wikipedia.org/wiki/Block_cipher_mode_of_operation#Cipher_feedback_(CFB)
_pair-enc() {
	# Do NOT use 'ctr' , 'ofb' , etc - absolutely unsafe , much worse than ecb .
	#openssl enc -e -aes-128-ctr -nosalt -pbkdf2 -pass file:"$HOME"/.pair -out /dev/stdout -in /dev/stdin
	#openssl enc -e -aes-128-cfb -nosalt -pbkdf2 -pass file:"$HOME"/.pair -out /dev/stdout -in /dev/stdin
	
	openssl enc -e -aes-128-cfb1 -nosalt -pbkdf2 -pass file:"$HOME"/.pair -out /dev/stdout -in /dev/stdin
	
	#openssl enc -e -aes-128-cbc -nosalt -pbkdf2 -pass file:"$HOME"/.pair -out /dev/stdout -in /dev/stdin
}

_pair-encrypt() {
	# 128bit block size may reduce effect of corruption
	# ctr is symmetric (ie. same command to decrypt as to encrypt)
	# cfb may only be symmetric for first block
	_current_message-toBin | _pair-enc
}
_pair-decrypt() {
	#_current_message-toBin | _pair-enc
	#_current_message-toBin | openssl enc -d -aes-128-ctr -nosalt -pbkdf2 -pass file:"$HOME"/.pair -out /dev/stdout -in /dev/stdin
	
	_current_message-toBin | openssl enc -d -aes-128-cfb1 -nosalt -pbkdf2 -pass file:"$HOME"/.pair -out /dev/stdout -in /dev/stdin
}



_pair-mac_generated-bin() {
	_current_message-toBin | _pair-mac
}

_pair-mac_generated-hex() {
	_pair-mac_generated-bin | _binToHex | head -c64 | tr -dc 'a-zA-Z0-9'
}

_pair-mac_calculated-bin() {
	_current_message-toBin | head -c-32 | _current_message-toSimple | _pair-decrypt | _pair-mac
}

_pair-mac_calculated-hex() {
	_pair-mac_calculated-bin | _binToHex | head -c64 | tr -dc 'a-zA-Z0-9'
}

_pair-mac_received-bin() {
	_current_message-toBin | tail -c-32
}

_pair-mac_received-hex() {
	_pair-mac_received-bin | _binToHex | tail -c-64 | tr -dc 'a-zA-Z0-9'
}


_pair-mac_calculated_fromRH-bin() {
	_current_message-toBin | head -c-64 | _pair-mac
}

_pair-mac_calculated_fromRH-hex() {
	_pair-mac_calculated_fromRH-bin | _binToHex | head -c64 | tr -dc 'a-zA-Z0-9'
}

_pair-mac_received_fromRH-bin() {
	_current_message-toBin | tr -d '\n' | tail -c-64
}

_pair-mac_received_fromRH-hex() {
	_pair-mac_received_fromRH-bin | tail -c-64 | tr -dc 'a-zA-Z0-9'
}


_pair-mac_calculated_fromRHofB64ofE-bin() {
	_current_message-toBin | tr -d '\n' | head -c-64 | base64 -d 2>/dev/null | _current_message-toSimple | _pair-decrypt | _pair-mac
}

_pair-mac_calculated_fromRHofB64ofE-hex() {
	_pair-mac_calculated_fromRHofB64ofE-bin | _binToHex | head -c64 | tr -dc 'a-zA-Z0-9'
}

_pair-mac_received_fromRHofB64ofE-bin() {
	_current_message-toBin | tail -c-64
}

_pair-mac_received_fromRHofB64ofE-hex() {
	_pair-mac_received_fromRHofB64ofE-bin | tail -c-64 | tr -dc 'a-zA-Z0-9'
}


# ATTENTION: Override with 'ops.sh' .
_pair-logTTY() {
	false
	#cat > /dev/tty
}


_pair-emit_sequence() {
	_start
	
	local currentMessageSimple
	currentMessageSimple=$(_current_message-toSimple)
	
	_messageNormal '_pair-emit' | _pair-logTTY
	
	echo "$currentMessageSimple" | _pair-mac_received-hex > "$safeTmp"/hmac_received.hex
	
	_messagePlain_probe '"$safeTmp"/hmac_received.hex' | _pair-logTTY
	cat "$safeTmp"/hmac_received.hex | _pair-logTTY
	echo | _pair-logTTY
	
	echo "$currentMessageSimple" | _pair-mac_received_fromRH-hex > "$safeTmp"/hmac_received_fromRH.hex
	cat "$safeTmp"/hmac_received_fromRH.hex > "$safeTmp"/hmac_received_fromRHofB64ofE.hex
	
	_messagePlain_probe '"$safeTmp"/hmac_received_fromRH.hex' | _pair-logTTY
	cat "$safeTmp"/hmac_received_fromRH.hex | _pair-logTTY
	echo | _pair-logTTY
	
	
	
	echo "$currentMessageSimple" | _pair-mac_calculated-hex > "$safeTmp"/hmac_calculated.hex
	
	_messagePlain_probe '"$safeTmp"/hmac_calculated.hex' | _pair-logTTY
	cat "$safeTmp"/hmac_calculated.hex | _pair-logTTY
	echo | _pair-logTTY
	
	
	
	
	echo "$currentMessageSimple" | _pair-mac_calculated_fromRH-hex > "$safeTmp"/hmac_calculated_fromRH.hex
	echo "$currentMessageSimple" | _pair-mac_calculated_fromRH-bin > "$safeTmp"/hmac_calculated_fromRH.bin
	
	_messagePlain_probe '"$safeTmp"/hmac_calculated_fromRH.hex' | _pair-logTTY
	cat "$safeTmp"/hmac_calculated_fromRH.hex | _pair-logTTY
	echo | _pair-logTTY
	
	
	
	echo "$currentMessageSimple" | _pair-mac_calculated_fromRHofB64ofE-hex > "$safeTmp"/hmac_calculated_fromRHofB64ofE.hex
	echo "$currentMessageSimple" | _pair-mac_calculated_fromRHofB64ofE-bin > "$safeTmp"/hmac_calculated_fromRHofB64ofE.bin
	
	_messagePlain_probe '"$safeTmp"/hmac_calculated_fromRHofB64ofE.hex' | _pair-logTTY
	cat "$safeTmp"/hmac_calculated_fromRH.hex | _pair-logTTY
	echo | _pair-logTTY
	
	
	
	
	echo "$currentMessageSimple" | _pair-mac_generated-hex > "$safeTmp"/hmac_generated.hex
	echo "$currentMessageSimple" | _pair-mac_generated-bin > "$safeTmp"/hmac_generated.bin
	
	_messagePlain_probe '"$safeTmp"/hmac_generated.hex' | _pair-logTTY
	cat "$safeTmp"/hmac_generated.hex | _pair-logTTY
	echo | _pair-logTTY
	
	
	if [[ $(cat "$safeTmp"/hmac_received.hex) == $(cat "$safeTmp"/hmac_calculated.hex) ]]
	then
		_messagePlain_nominal 'decrypt' | _pair-logTTY
		_messagePlain_good 'good: decrypt: hmac: bin' | _pair-logTTY
		# decryption
		echo "$currentMessageSimple" | _current_message-toBin | head -c-32 | _current_message-toSimple | _pair-decrypt | cat - "$safeTmp"/hmac_calculated.hex
	elif [[ $(cat "$safeTmp"/hmac_received_fromRH.hex) == $(cat "$safeTmp"/hmac_calculated_fromRH.hex) ]]
	then
		#_messagePlain_nominal 'authenticate' | _pair-logTTY
		#_messagePlain_good 'good: authOnly: hmac: rawHex' | _pair-logTTY
		#echo "$currentMessageSimple" | _current_message-toBin | head -c-64 | cat - "$safeTmp"/hmac_calculated_fromRH.hex
		
		_messagePlain_nominal 'encrypt' | _pair-logTTY
		_messagePlain_good 'good: authOnly: hmac: rawHex' | _pair-logTTY
		if [[ "$FORCE_PURE" == "true" ]]
		then
			echo "$currentMessageSimple" | _current_message-toBin | head -c-64 | _current_message-toSimple | _pair-encrypt | cat - "$safeTmp"/hmac_calculated_fromRH.bin
		else
			echo "$currentMessageSimple" | _current_message-toBin | head -c-64 | _current_message-toSimple | _pair-encrypt | base64 | cat - "$safeTmp"/hmac_calculated_fromRH.hex
		fi
	elif [[ $(cat "$safeTmp"/hmac_received_fromRHofB64ofE.hex) == $(cat "$safeTmp"/hmac_calculated_fromRHofB64ofE.hex) ]]
	then
		_messagePlain_nominal 'decrypt' | _pair-logTTY
		_messagePlain_good 'good: hmac: rawHex: ofB64ofE' | _pair-logTTY
		#_current_message-toSimple | _pair-encrypt | base64
		echo "$currentMessageSimple" | _current_message-toBin | tr -d '\n' | head -c-64 | base64 -d | _current_message-toSimple | _pair-decrypt | cat - "$safeTmp"/hmac_calculated_fromRHofB64ofE.hex
	elif [[ "$FORCE_PURE" == "true" ]]
	then
		_messagePlain_nominal 'encrypt: FORCE_PURE' | _pair-logTTY
		# encryption
		
		echo "$currentMessageSimple" | _pair-encrypt | cat - "$safeTmp"/hmac_generated.bin
	else
		_messagePlain_nominal 'encrypt' | _pair-logTTY
		# encryption
		
		echo "$currentMessageSimple" | _pair-encrypt | base64 | cat - "$safeTmp"/hmac_generated.hex
	fi
	
	_stop
}
_pair-emit() {
	"$scriptAbsoluteLocation" _pair-emit_sequence "$@"
}

_pair_out() {
	if [[ "$1" == "" ]]
	then
		_messagePlain_bad 'bad: missing: file: '"$1" > /dev/tty
		return 1
	fi
	_messagePlain_nominal '_pair_out' > /dev/tty
	_messagePlain_request 'request: provide stream, Ctrl+D' > /dev/tty
	unset FORCE_PURE
	echo > /dev/tty
	cat | _pair-emit > "$1"
	echo > /dev/tty
	tail -c 64 "$1"
	echo > /dev/tty
	truncate --size=-64 "$1"
	echo > /dev/tty
}

_pair_in() {
	
	if [[ "$1" == "" ]]
	then
		_messagePlain_bad 'bad: missing: file: '"$1" > /dev/tty
		return 1
	fi
	clear > /dev/tty
	_messagePlain_nominal '_pair_in' > /dev/tty
	unset FORCE_PURE
	echo > /dev/tty
	cat "$1" | _pair-emit
	echo > /dev/tty
	_messagePlain_request 'request: transfer stream' > /dev/tty
}


_pair_copy() {
	if [[ "$1" == "" ]]
	then
		_messagePlain_bad 'bad: missing: file: '"$1" > /dev/tty
		return 1
	fi
	_messagePlain_nominal '_pair_copy' > /dev/tty
	
	cat "$1" | _pair-emit "$@" | tee >(tail -c 64 > /dev/tty) | xclip -in -selection clipboard
}

_pair_paste() {
	if [[ "$1" == "" ]]
	then
		_messagePlain_bad 'bad: missing: file: '"$1" > /dev/tty
		return 1
	fi
	_messagePlain_nominal '_pair_paste' > /dev/tty
	
	xclip -out -selection clipboard | _pair-emit > "$1"
	tail -c 64 "$1"
	truncate --size=-64 "$1"
}

_pair() {
	clear > /dev/tty
	_messagePlain_nominal '_pair' > /dev/tty
	_messagePlain_request 'request: provide stream, Ctrl+D' > /dev/tty
	echo > /dev/tty
	cat | _pair-emit "$@"
	echo > /dev/tty
}






_pair_clipboard() {
	if _if_cygwin
	then
		cat /dev/clipboard | _pair-emit | cat > /dev/clipboard
		echo > /dev/tty
	else
		xclip -out -selection clipboard | _pair-emit | xclip -in -selection clipboard
		echo > /dev/tty
	fi
}
















_vector_pairKey() {
	true
}

_test_pairKey() {
	if ! type ykman > /dev/null 2>&1
	then
		echo 'missing: ykman'
		return 1
	fi
	
	return 0
}
 
