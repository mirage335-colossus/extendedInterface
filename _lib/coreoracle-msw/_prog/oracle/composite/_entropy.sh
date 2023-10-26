_gatherEntropy() {
	_if_cygwin && return 1
	
	local gatherEntropySuccess
	gatherEntropySuccess='false'
	
	
	if ! [[ -w "/dev/random" ]]
	then
		return 1
	fi
	
	local currentIteration
	currentIteration=1
	for currentIteration in $(seq 3)
	do
		date +%s%N > /dev/random
		date +%s%N > /dev/random
	done
	
	local arecordInstances
	arecordInstances=$(ps -eo args 2>/dev/null | grep arecord | grep '/dev/random' | wc -l | tr -dc '0-9')
	if [[ "$arecordInstances" -lt "4" ]] && type arecord > /dev/null 2>&1
	then
		( arecord -q -d 300 -fS32_LE /dev/random > /dev/random 2>&1 & )
		sleep 0.1
	fi
	
	_tryExec "_gatherEntropy_device" && gatherEntropySuccess='true' && return 0
	
	_tryExec "_gatherEntropy_servers"
	
	[[ "$gatherEntropySuccess" == "true" ]] && return 0
	return 1
}

_sourceEntropy_noblock_device() {
	! [[ -e /dev/"$ubiquitiousBashID"/entropy ]] && return 1
	
	local currentIteration
	for ((currentIteration=1; currentIteration <= "$1"; currentIteration++))
	do
		! _tryExec "_gatherEntropy_device" && sleep 0.2
		#sleep 0.1
		head -c 1 /dev/random
	done
	
	return 0
}

_sourceEntropy_noblock() {
	_tryExecFull "_sourceEntropy_noblock_device" "$1" && return 0
	
	local currentIteration
	for ((currentIteration=1; currentIteration <= "$1"; currentIteration++))
	do
		! _tryExec "_gatherEntropy_device" && sleep 0.2
		sleep 0.1
		head -c 1 /dev/urandom
	done
	
	return 0
}

_extractEntropyLow() {
	_openssl_rand "$1" | base64 | tr -dc 'a-z0-9' | head -c "$1"
}

_extractEntropyAlpha() {
	_openssl_rand "$1" | base64 | tr -dc 'a-zA-Z0-9' | head -c "$1"
}

_extractEntropyAlphaCapNum() {
	_openssl_rand "$1" | base64 | tr -dc 'A-Z0-9' | head -c "$1"
}

_extractEntropyBin() {
	_openssl_rand "$1" | head -c "$1"
}

_extractEntropy() {
	_extractEntropyAlpha "$@"
}

# example: dd if=$(./ubiquitous_bash.sh _cipherRand_fifo) of=/dev/null bs=1M count=10000 iflag=fullblock
_cipherRand_fifo() {
	_openssl_rand_fifo "$@"
}
_cipherRand() {
	_openssl_rand "$@"
}

_cipherRand_parallel() {
	_openssl_rand_parallel "$@"
}


_setup_entropy() {
	true
}
