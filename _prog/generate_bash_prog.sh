_generate_compile_bash_prog() {
	"$scriptAbsoluteLocation" _true
	
	#return
	
	rm "$scriptAbsoluteFolder"/ubiquitous_bash.sh
	
	#"$scriptAbsoluteLocation" _compile_bash cautossh cautossh
	"$scriptAbsoluteLocation" _compile_bash lean extendedInterface-lean.sh
	
	#"$scriptAbsoluteLocation" _compile_bash lean extendedInterface.sh
	"$scriptAbsoluteLocation" _compile_bash rotten_test-extendedInterface extendedInterface.sh
	
	"$scriptAbsoluteLocation" _compile_bash complete ubiquitous_bash.sh
	
	#"$scriptAbsoluteLocation" _compile_bash "" ""
	#"$scriptAbsoluteLocation" _compile_bash ubiquitous_bash ubiquitous_bash.sh
	
	#"$scriptAbsoluteLocation" _package
}
