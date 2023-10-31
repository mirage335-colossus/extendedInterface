
# NOTICE: Transmits relatively long symmetric key, assuming much stronger signal-to-noise ratio for the intended receiver. Can be a post-quantum technique to establish a separate, shared secret, though only through a longer protocol, not by itself, as it would be far more efficient to bidirectionally agree which small messages have or have not been received, than to rely on complete reception of a single large key. Additionally, automatic search would be necessary, as a squelch is fundamentally incompatible with such a technique.

# ATTENTION: May also be used as an 'all-or-nothing' proof of reception of the entire key (which is also plainly sent). For now, this is more or less the expected use case, if any.

# ATTENTION: Some benefits are possible from allowing single-bit corruption in the data. Integrity is still at least partially improved such that human readability of both the digital and analog domains may then suffice. However, if rejecting corruption is more important than exchanging at least some information, then set FORCE_AVALANCHE=true .

# ATTENTION: Data less than "$currentDataSize" may result in random garbage output. Pad if necessary.


_band-output() {
	if [[ "$FORCE_PURE" == "true" ]]
	then
		cat
		return
	else
		base64
		return
	fi
}

_band-input() {
	if [[ "$FORCE_PURE" == "true" ]]
	then
		cat
		return
	else
		base64 -d
		return
	fi
}

_band() {
	_start
	
	local currentMessageSimple
	currentMessageSimple=$(cat | base64)
	
	# Key size. Maybe think of bytes entropy (7B), redundancy (4s/B), minimum transmit power (10dB S/N == 10), relative gain (-10dB == 0.1), decibels (6dB == 2*2) .
	# 7 * 4 * 10 * 0.1 * 2*2
	# 112Bytes
	
	# 80Bytes or 17980Bytes key
	local currentKeySize
	currentKeySize="160"
	
	# DANGER: STRONGLY DISCOURAGED. Expected very detrimental in most situations. Please do not use this unless you can imagine exactly a good reason why you would want it.
	[[ "$FORCE_HUGE" == "true" ]] && currentKeySize="17980"
	
	local currentKeyTail
	let currentKeyTail="$currentKeySize"+1
	
	local currentDataSize
	currentDataSize=160
	[[ "$FORCE_AVALANCHE" == "true" ]] && currentDataSize=20
	
	if [[ "$currentKeySize" -lt "$currentDataSize" ]]
	then
		# DANGER: Absolutely must not reach here. Detrimental and also breaks the detection of whether to decode or encode .
		_stop 1
		return 1
	fi
	
	local currentMessageSize
	#currentMessageSize=100
	#[[ "$FORCE_HUGE" == "true" ]] && currentMessageSize=18000
	let currentMessageSize="$currentKeySize"+"$currentDataSize"
	
	
	if [[ $(echo "$currentMessageSimple" | base64 -d | wc -c | tr -dc '0-9') -ge "$currentKeySize" ]] || ( echo "$currentMessageSimple" | base64 -d 2>/dev/null | _band-input > /dev/null 2>&1 && [[ $(echo "$currentMessageSimple" | base64 -d 2>/dev/null | base64 -d 2>/dev/null | wc -c | tr -dc '0-9') -ge "$currentKeySize" ]] )
	then
		# decode
		echo "$currentMessageSimple" | base64 -d | _band-input | head -c "$currentKeySize" > "$safeTmp"/key
		if [[ "$FORCE_AVALANCHE" == "true" ]]
		then
			echo "$currentMessageSimple" | base64 -d | _band-input | head -c "$currentMessageSize" | tail -c+"$currentKeyTail" | openssl enc -d -aes-256-cfb -nosalt -iter 262144 -pass file:"$safeTmp"/key -out /dev/stdout -in /dev/stdin | head -c "$currentMessageSize"
		else
			echo "$currentMessageSimple" | base64 -d | _band-input | head -c "$currentMessageSize" | tail -c+"$currentKeyTail" | openssl enc -d -aes-128-cfb1 -nosalt -iter 262144 -pass file:"$safeTmp"/key -out /dev/stdout -in /dev/stdin | head -c "$currentMessageSize"
		fi
	else
		# encode
		_extractEntropyBin "$currentKeySize" > "$safeTmp"/key
		if [[ "$FORCE_AVALANCHE" == "true" ]]
		then
			echo "$currentMessageSimple" | base64 -d | head -c "$currentDataSize" | openssl enc -e -aes-256-cfb -nosalt -iter 262144 -pass file:"$safeTmp"/key -out /dev/stdout -in /dev/stdin | cat "$safeTmp"/key - | head -c "$currentMessageSize" | _band-output
		else
			echo "$currentMessageSimple" | base64 -d | head -c "$currentDataSize" | openssl enc -e -aes-128-cfb1 -nosalt -iter 262144 -pass file:"$safeTmp"/key -out /dev/stdout -in /dev/stdin | cat "$safeTmp"/key - | head -c "$currentMessageSize" | _band-output
		fi
	fi
	
	
	
	
	_sweep "$safeTmp"/key > /dev/null 2>&1
	
	_stop
}








_band_clipboard() {
	if _if_cygwin
	then
		cat /dev/clipboard | _band | cat > /dev/clipboard
		echo > /dev/tty
		return
	else
		xclip -out -selection clipboard | _band | xclip -in -selection clipboard
		echo > /dev/tty
		return
	fi
}







