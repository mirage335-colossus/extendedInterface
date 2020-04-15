REM Prohibits Oculus service from running and interfering with use of SteamVR (which supports OVRDrop) if desired.
REM Typically called from "rapid" sequences."


REM Thus far, apparently, stopping the service is sufficient.
CALL C:\core\infrastructure\extendedInterface\support\oculus\oculus_stop.bat

REM If necessary, stop and disable service.
REM CALL C:\core\infrastructure\extendedInterface\support\oculus\oculus_disable.bat


