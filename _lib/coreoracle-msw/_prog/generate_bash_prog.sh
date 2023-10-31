_generate_compile_bash_prog() {
	rm "$scriptAbsoluteFolder"/ubiquitous_bash.sh
	
	#"$scriptAbsoluteLocation" _compile_bash cautossh cautossh
	#"$scriptAbsoluteLocation" _compile_bash lean lean.sh
	
	#"$scriptAbsoluteLocation" _compile_bash core ubiquitous_bash.sh
	
	#"$scriptAbsoluteLocation" _compile_bash "" ""
	#"$scriptAbsoluteLocation" _compile_bash ubiquitous_bash ubiquitous_bash.sh
	
	#"$scriptAbsoluteLocation" _package
	
	#"$scriptAbsoluteLocation" _compile_bash oracle oracle
	#chmod 700 "$scriptAbsoluteFolder"/oracle
	
	"$scriptAbsoluteLocation" _compile_bash commKey commKey
	chmod 700 "$scriptAbsoluteFolder"/commKey
	
	"$scriptAbsoluteLocation" _compile_bash fragKey fragKey
	chmod 700 "$scriptAbsoluteFolder"/fragKey
	
	"$scriptAbsoluteLocation" _compile_bash bandKey bandKey
	chmod 700 "$scriptAbsoluteFolder"/bandKey
	
	"$scriptAbsoluteLocation" _compile_bash pairKey pairKey
	chmod 700 "$scriptAbsoluteFolder"/pairKey
	
	"$scriptAbsoluteLocation" _compile_bash planKey planKey
	chmod 700 "$scriptAbsoluteFolder"/planKey
}
