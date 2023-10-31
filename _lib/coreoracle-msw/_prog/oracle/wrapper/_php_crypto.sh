_vectors_php_crypto_sequence() {
	_start
	
	echo 'a' > "$safeTmp"/testKey
	echo 'b' > "$safeTmp"/testMessage
	
	_php_hmac "$safeTmp"/testMessage "$safeTmp"/testAuthentication "$safeTmp"/testKey
	
	local currentTestVectorResult
	currentTestVectorResult=$(cat "$safeTmp"/testAuthentication | xxd -p | tr -d '\n')
	
	if [[ "$currentTestVectorResult" != "a4fb91caf36b551f97df899309c46fef866bf589a43b340dee6da3c824a91c88140b5e1f4f96370868411c90ad43e70f411b7447f291ed3fa5315a13709a261a" ]]
	then
		echo 'fail: vector: _php_hmac'
		_stop 1
	fi
	
	_php_pbkdf2 "$safeTmp"/testKey > "$safeTmp"/testExpansion
	
	currentTestVectorResult=$(cat "$safeTmp"/testExpansion | xxd -p | tr -d '\n')
	
	if [[ "$currentTestVectorResult" != "1a8116839767379552a90d999eed07a92fba96efbd9ff117cdbd36d2129ab15f2e3b690552f75632455bf15f89b26d9b8ce41bbf14ffaa7ab7f35660dc1d7534c3ba710148cd105c4b8def4f1ba655e3b89a1732fd845a0b361269dc8c9481c25b0747e4765d34d01b8a22f4fd28079e48874795ead371459e8db4e679ff2ea7b904ac74e784c021c1e8dbc19b0b2164259782d65e3ec19352b681a7f9b69ee52d6847908211306ba3c09bcefc5efcea8b6f33c87ee8f8585e7d7fa38f92d819fe45f238d7e20df71dcdd7e1a4399af40d0ea03fb44cc7b88d50559d7e1a2010f7d530cddee570553defbe471950c41e4963e577307bd4780cde1acedf892553c0b0cae27456002882c39991f4b2864e26a6cc62315444ad560671b00045e93d276b419ac7b7f216e9fe7ea48a8988373ca961b872ad8d65f7a97060468093bd34325f6327844c2eefc0857f57d339af2432ea9fc3fd1355c527823289f1880445021cb6b11f1c7b9c66da4a9b8a449b2fac6a513f03eff845f8b0c835e5c1c6093a3f9950cd6fdf5ff2946823ab748088b210a012ca469c6e8e7b216261a5c8831c65177c6ff37db766971ba453f7fe42019b157bcc276b2a42200eb341796d59fdc119d0fac43939212cfe9e2da4689d3c83e1fa3485ad6c5387282215887a675f41b2afb5aaf86741539e14f32549fb8e5affca8a311556d65b892fd0fbb3" ]]
	then
		echo 'fail: vector: _php_pbkdf2'
		_stop 1
	fi
	
	_stop
}

_vectors_php_crypto() {
	if "$scriptAbsoluteLocation" _vectors_php_crypto_sequence "$@"
	then
		return 0
	fi
	_messageFAIL
	_stop 1
}

_test_php_crypto() {
	_getDep php
	
	#https://www.a2hosting.com/kb/developer-corner/php/determine-if-a-php-function-is-available
	! cat << CZXWXcRMTo8EmM8i4d | php 2>/dev/null | grep 'present' > /dev/null 2>&1 && echo 'missing: php: hash_hmac_file' && _stop 1
<?php
    \$function_name = "hash_hmac_file";
    if ( function_exists(\$function_name) ) {
        echo "present";
    }
    else {
        echo "missing";
    }
?>
CZXWXcRMTo8EmM8i4d
	
	#https://www.a2hosting.com/kb/developer-corner/php/determine-if-a-php-function-is-available
	! cat << CZXWXcRMTo8EmM8i4d | php 2>/dev/null | grep 'present' > /dev/null 2>&1 && echo 'missing: php: hash_hmac_file' && _stop 1
<?php
    \$function_name = "hash_pbkdf2";
    if ( function_exists(\$function_name) ) {
        echo "present";
    }
    else {
        echo "missing";
    }
?>
CZXWXcRMTo8EmM8i4d

return 0
}

# WARNING: (PHP 5 >= 5.1.2, PHP 7, PECL hash >= 1.1)
#https://stackoverflow.com/questions/7285059/hmac-sha1-in-bash
#https://unix.stackexchange.com/questions/419826/generate-hmac-in-bash-without-revealing-the-secret
#https://unix.stackexchange.com/questions/152864/are-environment-variables-visible-to-unprivileged-users-on-linux
#https://www.linuxquestions.org/questions/linux-security-4/storing-a-password-in-an-environment-variable-894156/
#http://php.net/manual/en/function.hash-hmac.php
# https://github.com/crypto-browserify/hash-test-vectors/blob/master/hmac.json
# "$1" == "messageFile"
# "$2" == "authenticationFile" (default: stdout)
# "$3" == "keyFile" (eg. /dev/stdin)
_php_hmac_whirlpool() {
	local php_current_secretkey
	#read php_current_secretkey <"$1"
	#php_current_secretkey=$(cat "$1")
	#php_current_secretkey=$(cat "$1" | xxd -p | tr -d '\n')
	read php_current_secretkey < <(cat "$3" | xxd -p | tr -d '\n')
	
	local php_current_var
	php_current_var="<?= hash_hmac_file(\"whirlpool\", \"$1\", hex2bin(\"""$php_current_secretkey""\"), TRUE); ?>"
	
	[[ "$2" == "" ]] && php <<<"$php_current_var" 2>/dev/null && return 0
	[[ "$2" != "" ]] && php <<<"$php_current_var" 2>/dev/null | cat > "$2" && return 0
	return 1
}
_php_hmac() {
	_php_hmac_whirlpool "$@"
}

#Truncates last bytes (typically 64) from file, removing authentication tag.
_php_hmac_remove() {
	perl -e 'truncate $ARGV[0], ((-s $ARGV[0]) - 64)' "$1"
}

#Retrieves last bytes (typically 64) from file, providing authentication tag.
_php_hmac-extract() {
	tail -c 64 "$1"
}

# WARNING: Any changes to default behavior (ie. changing salt) will need to be reflected in vector test.
# WARNING: Slow, small number of iterations. Weak key strengthening. Key expansion only.
# WARNING: (PHP 5 >= 5.1.2, PHP 7, PECL hash >= 1.1)
#http://php.net/manual/en/function.hash-pbkdf2.php
#https://stackoverflow.com/questions/2746553/read-values-into-a-shell-variable-from-a-pipe
# "$1" == "keyFile" (eg. /dev/stdin)
# "$2" == "saltFile" (optional)
# "$3" == "iterationCount" (optional, default recommended, do not change without reason)
_php_pbkdf2() {
	local php_current_secretkey
	#read php_current_secretkey <"$1"
	#php_current_secretkey=$(cat "$1")
	#php_current_secretkey=$(cat "$1" | xxd -p | tr -d '\n')
	read php_current_secretkey < <(cat "$1" | xxd -p | tr -d '\n')
	
	local php_current_salt
	! [[ -e "$2" ]] && php_current_salt=$(echo -n L2Ie5xV3tZ4cr8VyUr7eC2KjSV5Edv6phTtC9Stkuj3O0PR2 | xxd -p | tr -d '\n')
	[[ -e "$2" ]] && read php_current_salt < <(cat "$2" | xxd -p | tr -d '\n')
	
	local php_current_iterationCount
	[[ "$3" == "" ]] && php_current_iterationCount="5509"
	[[ "$3" != "" ]] && php_current_iterationCount="$3"
	
	local php_current_var
	php_current_var="<?= hash_pbkdf2(\"whirlpool\", hex2bin(\"""$php_current_secretkey""\"), hex2bin(\"""$php_current_salt""\"), ""$php_current_iterationCount"", 512, TRUE); ?>"
	
	php <<<"$php_current_var" 2>/dev/null
}
 
_php_password_to_key() {
	_messagePlain_nominal '-----REQUEST: user password . Type password, then send '"'"'Ctrl+d'"'"' .'
	stty -echo > /dev/null 2>&1
	_php_pbkdf2 /dev/stdin
	stty echo > /dev/null 2>&1
}

