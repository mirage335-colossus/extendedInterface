
Directory '_drivers-controllers' is intended as temporary user storage for SteamVR Controller Hand Tracking (ie. Leap Motion) emulation drivers, and is excluded from git repository.

When Controller Emulation is not desired (ie. VR Application natively supports Leap Motion Hand Tracking), delete the relevant directory from 'SteamVR - Drivers' directory, leaving a copy under '_drivers-controllers' .

For best results, install all of the following.

* Leap Motion SteamVR Driver

https://github.com/cbuchner1/driver_leap


* Controller Emulation Driver, modified for DCS World (seems to have slightly more usable angles and such)

https://forums.eagle.ru/topic/236114-leapmotion-with-valve-index-vr-emulator-fixed-in-dcs-256
	https://forums.eagle.ru/applications/core/interface/file/attachment.php?id=172733


* Visual C++ 2015 Update 2 redistributables (32 and 64 bits)


* LeapDeveloperKit >4.1.0+52211


* Controller Emulation Driver, Upstream Version (alternative, optional, recommend saving to '_drivers-controllers')
https://github.com/SDraw/driver_leap


* Configuration entry under '<Steam_folder>/config/steamvr.vrsettings' .

```
"activateMultipleDrivers": true,
```


