
# NOTICE: Legacy. Configures and uses YubiKey OAUTH to generate matching time dependent passwords .





_pair-sharedSecret() {
	head -c 10 /dev/urandom | base32
}




_test_pairKey() {
	if ! type ykman > /dev/null 2>&1
	then
		echo 'missing: ykman'
		return 1
	fi
	
	return 0
}
 
