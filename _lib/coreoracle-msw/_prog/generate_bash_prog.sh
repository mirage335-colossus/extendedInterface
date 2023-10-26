_generate_compile_bash_prog() {
	rm "$scriptAbsoluteFolder"/ubiquitous_bash.sh
	
	#"$scriptAbsoluteLocation" _compile_bash cautossh cautossh
	#"$scriptAbsoluteLocation" _compile_bash lean lean.sh
	
	#"$scriptAbsoluteLocation" _compile_bash core ubiquitous_bash.sh
	
	#"$scriptAbsoluteLocation" _compile_bash "" ""
	#"$scriptAbsoluteLocation" _compile_bash ubiquitous_bash ubiquitous_bash.sh
	
	#"$scriptAbsoluteLocation" _package
	
	_generate_compile_bash_prog _compile_bash pairKey pairKey
	chmod 700 "$scriptAbsoluteFolder"pairKey
	
	_generate_compile_bash_prog _compile_bash planKey planKey
	chmod 700 "$scriptAbsoluteFolder"planKey
}
