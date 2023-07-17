
# Unusual. Seprate due to 'rotten' script (for better performance) of extendedInterface . Other projects with MSW installers (eg. 'BOM_designer') do not have this issue.



_getRelease-ubcp() {
    mkdir -p "$currentAccessoriesDir"/integrations/ubcp
    # Download ubcp release binary if not already present.
    if [[ ! -e "$currentAccessoriesDir"/integrations/ubcp/"$1" ]]
    then
        #-H "Authorization: Bearer ${{ secrets.GITHUB_TOKEN }}"
        curl -L -o "$currentAccessoriesDir"/integrations/ubcp/"$1"  $(curl -s "https://api.github.com/repos/mirage335/ubiquitous_bash/releases" | jq -r ".[] | select(.name == \"internal\") | .assets[] | select(.name == \"package_ubcp-core.7z\") | .browser_download_url" | sort -n -r | head -n1)
    fi
}


_build_extendedInterface-fetch() {
    _start
    #mkdir -p "$shortTmp"
    local functionEntryPWD="$PWD"


    export currentAccessoriesDir="$scriptAbsoluteFolder"/../"$objectName"-accessories
    #export currentAccessoriesDir="$shortTmp"
    
    _discoverResource-cygwinNative-ProgramFiles 'makensis' 'NSIS/bin' false
    if ! type makensis
    then
        _getMost_backend apt-get update
        _getMost_backend_aptGetInstall nsis
    fi


    if ! type 7za
    then
        _getMost_backend apt-get update
        _getMost_backend_aptGetInstall p7zip
    fi

    _getDep 'makensis'
    _getDep '7za'

    #_getRelease-ubcp 'package_ubiquitous_bash-msw-rotten.7z'
    #_getRelease-ubcp 'package_ubcp-cygwinOnly.tar.xz'
    _getRelease-ubcp 'package_ubcp-core.7z'

    mkdir -p "$currentAccessoriesDir"/parts/ubcp/package_ubcp-core
    cd "$currentAccessoriesDir"/parts/ubcp/package_ubcp-core
    7za x "$currentAccessoriesDir"/integrations/ubcp/package_ubcp-core.7z
    cd "$functionEntryPWD"



    mkdir -p "$currentAccessoriesDir"/parts/extendedInterface
    cd "$currentAccessoriesDir"/parts/extendedInterface
    cp "$scriptAbsoluteFolder"/.git ./
    git reset --hard
    git submodule update
    cd "$functionEntryPWD"

    

    cd "$functionEntryPWD"
    _stop
}



_build_extendedInterface-build() {
    #_start
    mkdir -p "$shortTmp"
    local functionEntryPWD="$PWD"


    export currentAccessoriesDir="$scriptAbsoluteFolder"/../"$objectName"-accessories


    _at_userMSW_probeCmd_discoverResource-cygwinNative-ProgramFiles 'makensis' 'NSIS/bin' false
    if ! type makensis
    then
        _getMost_backend apt-get update
        _getMost_backend_aptGetInstall nsis
    fi

    cd "$scriptLib"/nsis
    makensis "$scriptLib"/nsis/extIface.nsi






    cd "$functionEntryPWD"
    _stop
}


