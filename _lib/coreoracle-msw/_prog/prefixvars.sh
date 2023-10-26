export oracleTmp="smoke"
export tmpPrefix=/"$oracleTmp"

export uidLengthPrefix="26"

# ATTENTION: Overload with "core.sh" or similar if appropriate.
# WARNING: Any "$tmpPrefix" will be reset before metaengine unless explicitly declared here.
_set_me_host_prefix() {
	export metaPrefix=/"$oracleTmp"
}
