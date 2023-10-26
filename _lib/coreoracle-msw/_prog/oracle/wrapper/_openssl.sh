_vectors_openssl_encrypt_procedure() {
	echo 'test' > "$safeTmp"/testPlaintext
	[[ $(head -c 48 "$safeTmp"/testPlaintext | xxd -p | tr -d '\n') != '746573740a' ]] && echo 'openssl: mismatch: testPlaintext' && _stop 1
	
	echo 'a' | xxd -p | tr -d '\n' > "$safeTmp"/keyFile1.hex
	echo 'b' | xxd -p | tr -d '\n' > "$safeTmp"/keyFile2.hex
	echo 'c' | xxd -p | tr -d '\n' > "$safeTmp"/keyFile3.hex
	echo 'd' | xxd -p | tr -d '\n' > "$safeTmp"/keyFile4.hex
	
	_openssl_e_enc "$safeTmp"/testPlaintext "$safeTmp"/testCiphertext "$safeTmp"/keyFile1 "$safeTmp"/keyFile2 "$safeTmp"/keyFile3 "$safeTmp"/keyFile4
	[[ $(head -c 48 "$safeTmp"/testCiphertext | xxd -p | tr -d '\n') != 'bea2aadfed28b088843c58c95591430a' ]] && echo 'openssl: mismatch: testCiphertext' && _stop 1
}


_vectors_openssl_sequence() {
	_start
	
	_vectors_openssl_encrypt_procedure
	
	_stop
}

_vectors_openssl() {
	if "$scriptAbsoluteLocation" _vectors_openssl_sequence "$@"
	then
		return 0
	fi
	_messageFAIL
	_stop 1
}

_test_openssl() {
	_getDep xxd
	_getDep openssl
	
	
	local currentCharCount
	
	local currentIteration
	for ((currentIteration=0; currentIteration < "10"; currentIteration++))
	do
		currentCharCount=$(_openssl_rand_parallel | base64 | tr -dc 'a-z0-9' | head -c 128 | wc -c | tr -dc '0-9')
		if [[ "$currentCharCount" != "128" ]]
		then
			echo 'fail: openssl: rand'
			_stop 1
		fi
	done
	
}

# "$1" == plaintext
# "$2" == ciphertext
# "$3" == keyFile1(.hex)
_openssl_e_enc() {
	openssl enc -e -aes-256-cbc -nosalt -md sha1 -pass file:"$3".hex -out "$2" -in "$1"
}

# "$1" == plaintext
# "$2" == ciphertext
# "$3" == keyFile1(.hex)
_openssl_d_enc() {
	openssl enc -d -aes-256-cbc -nosalt -md sha1 -pass file:"$3".hex -out "$1" -in "$2"
}


_openssl_fifo_rand_sequence() {
	[[ -e "$safeTmp" ]] && return 1
	_start
	
	local currentCipherDefault
	currentCipherDefault="-aes-256-cbc"
	local currentCipher
	currentCipher="$currentCipherDefault"
	
	if ! _if_cygwin
	then
		head -c 48 /dev/urandom | xxd -p | tr -d '\n' | openssl enc -e "$currentCipher" -pass stdin -nosalt -md sha1 -in /dev/zero 2>/dev/null
	else
		# https://stackoverflow.com/questions/3854692/generate-password-in-python
		python3 <<< '
import string
import os
from os import urandom
chars = string.ascii_letters + string.digits
print("".join(chars[c % len(chars)] for c in urandom(48)))
' | tr -dc 'a-zA-Z0-9' | xxd -p | tr -d '\n' | openssl enc -e "$currentCipher" -pass stdin -nosalt -md sha1 -in /dev/zero 2>/dev/null
	fi
	
	#sleep 0.1
	#rm -f "$safeTmp"/parallel_fifo > /dev/null 2>&1
	
	#while [[ -e "$safeTmp"/parallel_fifo ]]
	#do
	#	sleep 0.1
	#done
	
	_stop
}

_openssl_fifo_rand_parallel_sequence() {
	_start
	_self_background > /dev/null 2>&1
	
	mkfifo "$safeTmp"/parallel_fifo
	
	( "$scriptAbsoluteLocation" _openssl_fifo_rand_sequence > "$safeTmp"/parallel_fifo 2> /dev/null & )
	
	local hostThreadCount
	hostThreadCount=$(cat /proc/cpuinfo 2>/dev/null | grep MHz | wc -l | tr -dc '0-9')
	[[ "$hostThreadCount" -gt 48 ]] && hostThreadCount=48
	
	local opensslThreadCount
	if _if_cygwin
	then
		opensslThreadCount=$(ps | grep '/openssl' | wc -l | tr -dc '0-9')
	else
		opensslThreadCount=$(ps -eo args | grep '^openssl' | wc -l | tr -dc '0-9')
	fi
	
	let hostThreadCount="$hostThreadCount"-"$opensslThreadCount"
	
	# Nominally leaves at least 2 CPUs fully available to other tasks.
	let hostThreadCount="$hostThreadCount"-"3"
	
	# Nominally allows 100% CPU usage.
	let hostThreadCount="$hostThreadCount"/1
	
	[[ "$hostThreadCount" == 0 ]] && hostThreadCount=1
	
	#https://stackoverflow.com/questions/356100/how-to-wait-in-bash-for-several-subprocesses-to-finish-and-return-exit-code-0
	#local currentProcsArray
	
	local currentIteration
	for ((currentIteration=0; currentIteration < "$hostThreadCount"; currentIteration++))
	do
		( "$scriptAbsoluteLocation" _openssl_fifo_rand_sequence > "$safeTmp"/parallel_fifo 2> /dev/null & )
		#currentProcsArray["$currentIteration"]=$!
	done
	
	cat "$safeTmp"/parallel_fifo
	
	#sleep 0.1
	#rm -f "$safeTmp"/parallel_fifo > /dev/null 2>&1
	
	#for currentPID in ${currentProcsArray[*]}; do
	#	wait "$currentPID"
	#done
	#while [[ -e "$safeTmp"/parallel_fifo ]]
	#do
	#	sleep 0.1
	#done
	
	_stop
}


# example: dd if=$(./ubiquitous_bash.sh _openssl_rand_fifo) of=/dev/null bs=1M count=10000 iflag=fullblock
_openssl_rand_fifo() {
	_channel_host_fifo _openssl_fifo_rand_parallel_sequence "$@"
}
_openssl_rand() {
	"$scriptAbsoluteLocation" _openssl_fifo_rand_sequence "$@"
}
_openssl_rand_parallel() {
	"$scriptAbsoluteLocation" _openssl_fifo_rand_parallel_sequence "$@"
}

