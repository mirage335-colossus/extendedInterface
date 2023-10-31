_compile_bash_deps_prog() {
	if [[ "$1" == "planKey" ]]
	then
		_deps_fakehome
		#_deps_abstractfs
		
		_deps_planKey
		
		return 0
	fi
	
	if [[ "$1" == "pairKey" ]]
	then
		_deps_pairKey
		
		return 0
	fi
	
	if [[ "$1" == "bandKey" ]]
	then
		_deps_bandKey
		
		return 0
	fi
	
	if [[ "$1" == "oracle" ]]
	then
		_deps_commKey
		
		_deps_channel
		
		_deps_metaengine
		
		return 0
	fi
	
	if [[ "$1" == "commKey" ]]
	then
		_deps_commKey
		
		_deps_channel
		
		_deps_metaengine
		
		return 0
	fi
	
	if [[ "$1" == "fragKey" ]]
	then
		_deps_fragKey
		
		_deps_channel
		
		_deps_metaengine
		
		
		_deps_mount
		_deps_notLean
		_deps_image
		
		_deps_git
		_deps_bup
		
		
		return 0
	fi
}

#Default is to include all, or run a specified configuration. For this reason, it will be more typical to override this entire function, rather than append any additional code.
# WARNING Find current version of this function at "build/bash/compile_bash.sh"
# _compile_bash_deps() {
# 	[[ "$1" == "lean" ]] && return 0
# 	
# 	false
# }

_vars_compile_bash_prog() {
	#export configDir="$scriptAbsoluteFolder"/_config
	
	#export progDir="$scriptAbsoluteFolder"/_prog
	#export progScript="$scriptAbsoluteFolder"/ubiquitous_bash.sh
	#[[ "$1" != "" ]] && export progScript="$scriptAbsoluteFolder"/"$1"
	
	true
}

_compile_bash_header_prog() {	
	export includeScriptList
	true
	
	
	includeScriptList+=( "notices/"license.txt )
	
	includeScriptList+=( "notices/"WARNING_cryptography_willBeREPORTED_and_publicNOTICES.txt )
	
	includeScriptList+=( "notices/"gpl-3.0.txt )
}

_compile_bash_header_program_prog() {	
	export includeScriptList
	true
}

_compile_bash_essential_utilities_prog() {	
	export includeScriptList
	true
}

_compile_bash_utilities_virtualization_prog() {	
	export includeScriptList
	true
}

_compile_bash_utilities_prog() {	
	export includeScriptList
	true
}

_compile_bash_shortcuts_prog() {	
	export includeScriptList
	true
}

_compile_bash_shortcuts_setup_prog() {	
	export includeScriptList
	true
}

_compile_bash_bundled_prog() {	
	export includeScriptList
	true
}

_compile_bash_vars_basic_prog() {	
	export includeScriptList
	true
}

_compile_bash_vars_global_prog() {	
	export includeScriptList
	true
}

_compile_bash_vars_spec_prog() {	
	export includeScriptList
	true
}

_compile_bash_vars_shortcuts_prog() {	
	export includeScriptList
	true
}

_compile_bash_vars_virtualization_prog() {	
	export includeScriptList
	true
}

_compile_bash_vars_bundled_prog() {	
	export includeScriptList
	true
}

_compile_bash_buildin_prog() {	
	export includeScriptList
	true
}

_compile_bash_environment_prog() {	
	export includeScriptList
	true
}

_compile_bash_installation_prog() {	
	export includeScriptList
	true
}

_compile_bash_program_prog() {	
	export includeScriptList
	
	[[ "$enUb_oracle_commKey" == "true" ]] && includeScriptList+=( "oracle/composite/commKey/"_commKey_vars.sh )
	[[ "$enUb_oracle_commKey" == "true" ]] && includeScriptList+=( "oracle/composite/commKey/"_commKey_object.sh )
	[[ "$enUb_oracle_commKey" == "true" ]] && includeScriptList+=( "oracle/composite/commKey/"_commKey_chain.sh )
	[[ "$enUb_oracle_commKey" == "true" ]] && includeScriptList+=( "oracle/composite/commKey/"_commKey_counter.sh )
	[[ "$enUb_oracle_commKey" == "true" ]] && includeScriptList+=( "oracle/composite/commKey/"_commKey_client.sh )
	[[ "$enUb_oracle_commKey" == "true" ]] && includeScriptList+=( "oracle/composite/commKey/"_commKey.sh )
	[[ "$enUb_oracle_commKey" == "true" ]] && includeScriptList+=( "oracle/composite/commKey/diag/"_commKey_query.sh )
	
	[[ "$enUb_oracle_fragKey" == "true" ]] && includeScriptList+=( "oracle/composite/fragKey/"_fragKey_file_salts.sh )
	[[ "$enUb_oracle_fragKey" == "true" ]] && includeScriptList+=( "oracle/composite/fragKey/"_fragKey_file.sh )
	#[[ "$enUb_oracle_fragKey" == "true" ]] && includeScriptList+=( "oracle/composite/fragKey/"_fragKey_format.sh )
	#[[ "$enUb_oracle_fragKey" == "true" ]] && includeScriptList+=( "oracle/composite/fragKey/"_fragKey_safety.sh )
	[[ "$enUb_oracle_fragKey" == "true" ]] && includeScriptList+=( "oracle/composite/fragKey/"_fragKey_vars.sh )
	[[ "$enUb_oracle_fragKey" == "true" ]] && includeScriptList+=( "oracle/composite/fragKey/"_fragKey_volume.sh )
	[[ "$enUb_oracle_fragKey" == "true" ]] && includeScriptList+=( "oracle/composite/fragKey/"_fragKey_management_key.sh )
	[[ "$enUb_oracle_fragKey" == "true" ]] && includeScriptList+=( "oracle/composite/fragKey/"_fragKey_management_volume.sh )
	
	[[ "$enUb_oracle_fragKey" == "true" ]] && includeScriptList+=( "oracle/composite/fragKey/"_fragKey_swap.sh )
	
	[[ "$enUb_oracle_fragKey" == "true" ]] && includeScriptList+=( "oracle/composite/fragKey/_sub/"_fragKey_direct.sh )
	[[ "$enUb_oracle_fragKey" == "true" ]] && includeScriptList+=( "oracle/composite/fragKey/_sub/"_fragKey_special.sh )
	[[ "$enUb_oracle_fragKey" == "true" ]] && includeScriptList+=( "oracle/composite/fragKey/_sub/"_fragKey_distributed.sh )
	[[ "$enUb_oracle_fragKey" == "true" ]] && includeScriptList+=( "oracle/composite/fragKey/_sub/"_fragKey_flexible.sh )
	
	[[ "$enUb_oracle_fragKey" == "true" ]] && includeScriptList+=( "oracle/composite/fragKey/"_fragKey.sh )
	
	#includeScriptList+=( "oracle/composite/volumeKey" )
	
	includeScriptList+=( "oracle/composite/"_vectortime.sh )
	includeScriptList+=( "oracle/composite/"_reseed.sh )
	includeScriptList+=( "oracle/composite/"_entropy.sh )
	includeScriptList+=( "oracle/composite/"_sweep.sh )
	
	
	[[ "$enUb_oracle_commKey" == "true" ]] && includeScriptList+=( "oracle/interpreter/"_interpreter_filter.sh )
	[[ "$enUb_oracle_commKey" == "true" ]] && includeScriptList+=( "oracle/interpreter/"_interpreter_object.sh )
	[[ "$enUb_oracle_commKey" == "true" ]] && includeScriptList+=( "oracle/interpreter/"_interpreter_log.sh )
	
	
	includeScriptList+=( "oracle/diag/"_scope.sh )
	[[ "$enUb_oracle_commKey" == "true" ]] && includeScriptList+=( "oracle/diag/"_query.sh )
	
	
	includeScriptList+=( "oracle/wrapper/"_openssl.sh )
	includeScriptList+=( "oracle/wrapper/"_php_crypto.sh )
	
	
	
	[[ "$enUb_oracle_commKey" == "true" ]] && includeScriptList+=( "oracle/"override_commKey.sh )
	[[ "$enUb_oracle_fragKey" == "true" ]] && includeScriptList+=( "oracle/"override_fragKey.sh )
	
	
	
	
	
	[[ "$enUb_oracle_planKey" == "true" ]] && includeScriptList+=( "oracle/composite/planKey/"_planKey.sh )
	
	
	[[ "$enUb_oracle_pairKey" == "true" ]] && includeScriptList+=( "oracle/composite/pairKey/"_pairKey.sh )
	
	
	[[ "$enUb_oracle_bandKey" == "true" ]] && includeScriptList+=( "oracle/composite/bandKey/"_bandKey.sh )
}

_compile_bash_config_prog() {
	export includeScriptList
	
	includeScriptList+=( "_config/"cryptovars.sh )
	
	[[ "$enUb_oracle_fragKey" == "true" ]] && includeScriptList+=( "_config/fragKey/"cryptovars_fragKey.sh )
}

_compile_bash_selfHost_prog() {	
	export includeScriptList
	true
}

_compile_bash_overrides_prog() {	
	export includeScriptList
	true
}

_compile_bash_entry_prog() {	
	export includeScriptList
	true
}
