Conventions, device/application input configuration files, device programming software, and hardware abstraction software for comprehensive physical and virtual reality user interface solutions.

# Param

Precomputed application startup parameters are documented under spreadsheet "param.ods" .

* Template checklist layout.
* Same order as application settings and/or procedures.
* Color warnings of expected quality or performance degration.
* Drop-down alternative selections.

* Alternative settings and peripherials included along with data and recommendations.

* Automatic load calculation as a fraction of previous maximum-resolution long-term test results.
* Angular resolution estimation.

Beware SteamVR by default imposes a 4096 '...upper bound on the calculated resolution' set under 'steamvr.vrsettings' file.

# Conventions

Layout and assignments documented under conventions tab of spreadsheet 'commonControlScheme.ods' . Sample implementations for some variants are also included.

## Delays

## Macro

* 0.020 - Key Press/Release

## Long/Short Press

* 0.120 - Menu/PTT
* 0.200 - Typical
* 0.500 - DANGEROUS

# Usage

## NIX

Start relevant scripts and programs as needed.

## MSW

Clone repository recursively to "C:\core\infrastructure\extendedInterface" . Ensure permissions are set appropriately. Copy configuration files to application directories as needed.

JoystickGremlin XML files may be loaded directly or placed in "%USERPROFILE%\joystick gremlin" .

VoiceAttack profiles may be imported through the program GUI.


# Recommended

* PanelBoard

* OpenHMD

* Arduino
* OpenBuilds


# Recommended - Vendor

Only hardware and software currently under evaluation or in production use may have an up-to-date configuration following the most modern conventions and matching application input configuration files.

* DCS World - FA18C
	* DCS Waypoint Editor
* Elite Dangerous

* JoystickGremlin v13.3
* WhiteKnight Auto-Whitelister for HidCerberus

* SimFFB
* ForceTest

* vJoy v2.1.9.1

* VoiceAttack v1.7.8

* VirtualDesktop
* OVRDrop

* SteamVR

* MS SideWinder Force Feedback 2 (SFB2)
* ThrustMaster TWCS Throttle (T16KTR_TH, T16KJG_TH)

* Atom 1.36.1

Other hardware and software is compatible with the conventions. Configuration files available may be correct, mostly correct, and/or adaptable by text editing. Occasional corrections may be provided as conventions are developed and tested.

* DCS World - F5E
* Descent Freespace
* EVE Valkyrie
* Descent (D2X)

* Thurstmaster T.A.R.G.E.T

* Thrustmaster T16000M FCS HOTAS (T16KTR_ST & T16KTR_TH, T16KJG_ST & T16KJG_TH)

Some hardware and software has not been found compatible.

* Universal Control Remapper

Some additional software and hardware is strongly recommended.

* 'DCS-to-GPS 1.3' - https://www.digitalcombatsimulator.com/en/files/3303310/
* 'com0com' - http://com0com.sourceforge.net/


# Backend - NIX

Shared memory file, double or triple buffered.


# Backend - MSW

```
*) VJoy
	*) Device 1, 2, 3, 4
		*) Axes - All
		*) Buttons - 32+/-, <128
			*) First device, 32buttons. Then, 31, 30, 29. 
			*) Only buttons 1-24 to be used by vehicle/tool.
			*) Always reserve last six buttons for comm/out-of-band control/signaling.
				*) Devices 3-4 last six buttons used for out-of-band.
		*) POV Hat Switch
			*) Continious
			*) POVs 1
		*) Force Feedback - All

*) Force Feedback
	Most likely, force feeback support will need to be native. VJoy and similar would only be used for button mapping, not axis mapping.
```

## Workarounds

SimFFB, and possibly other software, apparently depends on the ordering of 'controller' devices. To reorder these devices as needed, remove them with the 'Bluetooth and other devices settings' panel. Removing the Force Feedback joystick, followed by physical reconnection, may be sufficient.

Steam, SteamVR, and related apps, frequently are updated to versions which may break some use cases, particularly those relying on VR access to the physical desktop. Offline mode, and the related workaround to prevent a dialog box about offline mode, may be a solution.
https://gaming.stackexchange.com/questions/102867/remove-steam-is-currently-set-to-be-in-offline-mode-dialog/196778#196778


# Alternative

Modeling of existing systems as closely as possible may be accommodated by placing external functionality on dedicated wearable board(s).

Head/Chin/Chest/Arm/Knee Switch Boards
	Aux Comms
	VR/AR Align/Zoom
	Helmet Imaging (Goggles, Binoculars)
	Tactile Interface (North-Paw like Fail-Active IFR Backup providing some of Pitch/Roll/Heading Turn/Slip Climb RAlt/BAlt TAS/CAS/AOA Homing/ILS)
	Alarm (Indepdendent Lound Warning if AutoPilot Disengaged, Maneuver Drift, or Collision Risk)
	Panels (AR Desktop Computer Displays, Keyboard, Mouse)


# Included Works

See included LICENSE files.

Various short sound clips '_ref/sound_clips/_thirdparty/' .


# Copyright

All content in this folder not owned by other authors is intended to be public domain. Other copyright notices may be provided as templates. See license.txt for details.


# Reference

https://whitemagic.github.io/JoystickGremlin/

https://www.autohotkey.com/boards/viewtopic.php?t=34890



https://forums.eagle.ru/showpost.php?p=1628706&postcount=43

https://forums.eagle.ru/showpost.php?p=2419366&postcount=152

http://www.fs-force.com/support.php



https://voiceattack.com/

https://store.steampowered.com/app/586210/OVRdrop/

https://store.steampowered.com/app/382110/Virtual_Desktop/



http://vjoystick.sourceforge.net/site/index.php/download-a-install/download




https://steamcommunity.com/app/250820/discussions/0/1739980540117192912/




https://ntrs.nasa.gov/archive/nasa/casi.ntrs.nasa.gov/19980018292.pdf
	"Helmet-Mounted Display Design Guide" - Richard L. Newman and Kevin W. Greeley - '3 November 1997'

https://ntrs.nasa.gov/archive/nasa/casi.ntrs.nasa.gov/19960033220.pdf
	"Helmet-Mounted Display Symbology and Stabilization Concepts" - Richard L. Newman - 'June 1995'










https://www.youtube.com/watch?v=ywGhE1vnRVA




https://gaming.stackexchange.com/questions/102867/remove-steam-is-currently-set-to-be-in-offline-mode-dialog/196778#196778
