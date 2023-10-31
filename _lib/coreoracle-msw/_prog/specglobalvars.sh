export tmpid="$safeTmp"/tmp-"$sessionid"


#Default. Override at "_config/crypto.sh", "ops", or similar.
export packfile="$scriptAbsoluteFolder"/"packfile"
export dataDir="$scriptAbsoluteFolder"/"temple"
export fileDir="$scriptAbsoluteFolder"/"pyre"

export varStore="$dataDir"/_v

# WARNING: No known production use. May be dropped entirely.
export keyList="$dataDir"/_k
export commKey="$dataDir"/_kd
export padList="$dataDir"/_pd
export padMatch="/dev/null"


#Default. Override at "_config/crypto.sh", "ops", or similar.
##CLIENT##SPECIAL
export containerPath="$scriptAbsoluteFolder"/container
export fsPath="$scriptLocal"/fs

export shortTunAuthKeyDefault="HsHAP6q3Ftcbyef18qAaYQPxkMaZWFT94BVstX8FfsDTWSyp9GwhzLw87DHNBfz"
export tunAuthKeyDefault="scWgwbXO7kFsqeYNA66V2bqbaVDKFOyNepTwEvRPimt2WNYtMH70oANHo3qrZqdV"

