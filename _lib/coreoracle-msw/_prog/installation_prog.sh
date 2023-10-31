#Especially crucial mathematical tests. Ensures correct operation of dependencies needed by especially critical functions.
_vectors_system_sequence() {
	_start
	
	! man echo | grep '\-n' > /dev/null 2>&1 && echo 'missing: echo -n' && _stop 1
	
	! [[ $(bc <<< "077545947298814593939168072244700493013430008196"" + ""1") == "77545947298814593939168072244700493013430008197" ]] && echo 'mismatch: arithmetic' && _stop 1
	! [[ $(bc <<< "999999999999999999999999999999999999999999999997"" + ""1") == "999999999999999999999999999999999999999999999998" ]] && echo 'mismatch: arithmetic' && _stop 1
	
	! [[ $(perl -e 'print sprintf "%048s\n","77545947298814593939168072244700493013430008197"') == "077545947298814593939168072244700493013430008197" ]] && echo 'mismatch: perl print sprintf' && _stop 1
	
	
	_stop
}

_vectors_system() {
	if "$scriptAbsoluteLocation" _vectors_system_sequence "$@"
	then
		return 0
	fi
	_messageFAIL
	_stop 1
}


_vectors_crypto() {
	_messageNormal "Vectors (system)..."
	
	_tryExec "_vectors_system"
	
	_messagePASS
	
	
	_messageNormal "Vectors (crypto)..."
	
	_tryExec "_vectors_openssl"
	_tryExec "_vectors_php_crypto"
	
	_messagePASS
	
	return 0
}

_test_prog() {
	_messageNormal "Sanity..."
	_getDep flock
	
	( flock 200; echo > "$safeTmp"/ready ; sleep 3 ) 200>"$safeTmp"/flock &
	sleep 1
	if ( flock 200; ! [[ -e "$safeTmp"/ready ]] ) 200>"$safeTmp"/flock
	then
		_messageFAIL
		_stop 1
	fi
	rm -f "$safeTmp"/flock > /dev/null 2>&1
	rm -f "$safeTmp"/ready > /dev/null 2>&1
	_messagePASS
	
	_messageNormal "Program..."
	
	_getDep bc
	
	_tryExec "_test_openssl"
	_tryExec "_test_php_crypto"
	
	_tryExec "_test_cryptsetup"
	
	
	_tryExec "_test_planKey"
	
	_tryExec "_test_pairKey"
	
	
	_messagePASS
	
	_tryExec "_vectors_crypto"
	
	_tryExec "_vector_cryptsetup"
}

_setup_prog() {
	if type _setup_entropy > /dev/null 2>&1
	then
		_setup_entropy
	fi
	
	if type _setup_commKey > /dev/null 2>&1
	then
		_setup_commKey
	fi
}



