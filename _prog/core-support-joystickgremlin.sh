
# NOTICE: Very rare. You probably do NOT want this. For the author's own present situation.
_rewrite_jg_present() {
	# stick
	#{7CE82F20-0DE0-11ED-801A-444553540000}
	
	# throttle
	#{7CE76BD0-0DE0-11ED-800F-444553540000}
	
	_rewrite_jg "{7CE82F20-0DE0-11ED-801A-444553540000}" "{7CE76BD0-0DE0-11ED-800F-444553540000}"
}



_rewrite_jg() {
	local functionEntryPWD
	functionEntryPWD="$PWD"
	
	
	mkdir -p "$scriptAbsoluteFolder"/support/joystickgremlin-ref
	
	#_safeRMR "$scriptAbsoluteFolder"/support/joystickgremlin
	mkdir -p "$scriptAbsoluteFolder"/support/joystickgremlin
	
	rsync -ax "$scriptAbsoluteFolder"/support/joystickgremlin-ref/. "$scriptAbsoluteFolder"/support/joystickgremlin/.
	
	
	"$scriptAbsoluteLocation" _rewrite_joystick "$1"
	cd "$functionEntryPWD"
	
	"$scriptAbsoluteLocation" _rewrite_throttle "$2"
	cd "$functionEntryPWD"
	
	
	cd "$functionEntryPWD"
}



_rewrite_throttle() {
	cd "$scriptAbsoluteFolder"/support
	
	mkdir -p "$scriptAbsoluteFolder"/support/joystickgremlin-ref
	
	#_safeRMR "$scriptAbsoluteFolder"/support/joystickgremlin
	mkdir -p "$scriptAbsoluteFolder"/support/joystickgremlin
	
	#rsync -ax "$scriptAbsoluteFolder"/support/joystickgremlin-ref/. "$scriptAbsoluteFolder"/support/joystickgremlin/.
	
	
	
	
	
	# ATTENTION: both OBSOLETE and PRESENT ids are used as placeholders for any NEEDED id
	
	
	cd "$scriptAbsoluteFolder"/support/joystickgremlin/.
	
	
	#{9FDEE5A0-E57C-11E7-8009-444553540000}
	#{7CE76BD0-0DE0-11ED-800F-444553540000}
	
	
	find . -iname '*.xml' -exec sed -i 's/{9FDEE5A0-E57C-11E7-8009-444553540000}/'"$1"'/g' {} \;
	find . -iname '*.xml' -exec sed -i 's/{7CE76BD0-0DE0-11ED-800F-444553540000}/'"$1"'/g' {} \;
}


_rewrite_joystick() {
	cd "$scriptAbsoluteFolder"/support
	
	mkdir -p "$scriptAbsoluteFolder"/support/joystickgremlin-ref
	
	#_safeRMR "$scriptAbsoluteFolder"/support/joystickgremlin
	mkdir -p "$scriptAbsoluteFolder"/support/joystickgremlin
	
	#rsync -ax "$scriptAbsoluteFolder"/support/joystickgremlin-ref/. "$scriptAbsoluteFolder"/support/joystickgremlin/.
	
	
	
	
	
	# ATTENTION: both OBSOLETE and PRESENT ids are used as placeholders for any NEEDED id
	
	
	cd "$scriptAbsoluteFolder"/support/joystickgremlin/.
	
	
	#{A4608390-E525-11E9-802D-444553540000}
	#{7CE82F20-0DE0-11ED-801A-444553540000}
	
	
	find . -iname '*.xml' -exec sed -i 's/{A4608390-E525-11E9-802D-444553540000}/'"$1"'/g' {} \;
	find . -iname '*.xml' -exec sed -i 's/{7CE82F20-0DE0-11ED-801A-444553540000}/'"$1"'/g' {} \;
}




