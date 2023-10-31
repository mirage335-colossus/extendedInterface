
# NOTICE: Legacy . Emphasizes integrity by using only GPG . Beware any CVEs against GPG . 

# Private LAN (PLAN)




_plan() {
	mkdir -p "$HOME"/.plan
	gpg --homedir "$HOME"/.plan "$@"
}







 
_test_planKey() {
	if ! type ykman > /dev/null 2>&1
	then
		echo 'missing: ykman'
		return 1
	fi
	
	if ! type gpg > /dev/null 2>&1
	then
		echo 'missing: gpg'
		return 1
	fi
	
	return 0
}
 
