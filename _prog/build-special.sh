
# Unusual. Seprate due to 'rotten' script (for better performance) of extendedInterface . Other projects with MSW installers (eg. 'BOM_designer') do not have this issue.



_getRelease-ubcp() {
    mkdir -p "$shortTmp"/integrations/ubcp
    # Download ubcp release binary if not already present.
    if [[ ! -e "$shortTmp"/integrations/ubcp/"$1" ]]
    then
        #curl -L -o "$shortTmp"/integrations/ubcp/"$1"  -H "Authorization: Bearer ${{ secrets.GITHUB_TOKEN }}" $(curl -s "https://api.github.com/repos/mirage335/ubiquitous_bash/releases" | jq -r ".[] | select(.name == \"internal\") | .assets[] | select(.name == \""$1" \") | .browser_download_url")
        curl -L -o "$shortTmp"/integrations/ubcp/"$1"  $(curl -s "https://api.github.com/repos/mirage335/ubiquitous_bash/releases" | jq -r ".[] | select(.name == \"internal\") | .assets[] | select(.name == \""$1" \") | .browser_download_url")
    fi
}


_build_extendedInterface() {
    _start
    #mkdir -p "$shortTmp"
    local functionEntryPWD="$PWD"

    
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

    mkdir -p "$shortTmp"/parts/ubcp/package_ubcp-core
    cd "$shortTmp"/parts/ubcp/package_ubcp-core
    7za x "$shortTmp"/integrations/ubcp/package_ubcp-core.7z

    cd "$functionEntryPWD"
    _stop
}




