# ATTENTION: Need not be UTC time. May be any permanently incrementing one-second-per-tick integer.
# DANGER: Any repetition of values may result in unexpected behavior.
# DANGER: Not intended for cryptographic counter, initialization vector, or replay detection.
#Placeholder.
_get_vectortime_local() {
	_tryExec "_get_vectortime_local_device" && return 0
	
	# DANGER: Use of any unprotected clock may allow interruptions, including denial-of-service. Recommend disable NTP.
	date +%s
	
	return 0
}



