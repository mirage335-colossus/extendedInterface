
# NOTICE: Legacy . Emphasizes integrity by using only GPG . Beware any CVEs against GPG . 
















 
_test_planKey() {
	if ! type gpg > /dev/null 2>&1
	then
		echo 'missing: gpg'
		return 1
	fi
	
	return 0
}
 
