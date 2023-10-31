
_deps_planKey() {
	_deps_generic
	
	_deps_fakehome
	#_deps_abstractfs
	
	export enUb_oracle_planKey="true"
}

_deps_pairKey() {
	_deps_generic
	
	export enUb_oracle_pairKey="true"
}

_deps_bandKey() {
	_deps_generic
	
	export enUb_oracle_bandKey="true"
}

_deps_commKey() {
	_deps_channel
		
	_deps_metaengine
	
	export enUb_oracle_commKey="true"
}

_deps_fragKey() {
	_deps_channel
	
	_deps_metaengine
	
	
	_deps_mount
	_deps_notLean
	_deps_image
	
	_deps_git
	_deps_bup
	
	export enUb_oracle_fragKey="true"
}

