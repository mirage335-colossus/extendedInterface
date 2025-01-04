
# Unusual. Seprate due to 'rotten' script (for better performance) of extendedInterface . Other projects with MSW installers (eg. 'BOM_designer') do not have this issue.



_getMinimal-build_extendedInterface() {
    
    ! type makensis && _if_cygwin && _at_userMSW_probeCmd_discoverResource-cygwinNative-ProgramFiles 'makensis' 'NSIS/bin' false
    
    if ! type makensis
    then
        _getMost_backend apt-get update

        #https://askubuntu.com/questions/876240/how-to-automate-setting-up-of-keyboard-configuration-package
        #apt-get install -y debconf-utils
        export DEBIAN_FRONTEND=noninteractive
        
        _set_getMost_backend "$@"
        _test_getMost_backend "$@"
        #_getMost_debian11_aptSources "$@"
        
        _getMost_backend_aptGetInstall nsis
    fi


    if ! type 7za
    then
        _getMost_backend apt-get update

        #https://askubuntu.com/questions/876240/how-to-automate-setting-up-of-keyboard-configuration-package
        #apt-get install -y debconf-utils
        export DEBIAN_FRONTEND=noninteractive
        
        _set_getMost_backend "$@"
        _test_getMost_backend "$@"
        #_getMost_debian11_aptSources "$@"

        _getMost_backend_aptGetInstall p7zip
    fi

    
    _getDep 'makensis'
    _getDep '7za'


    ! type makensis && _if_cygwin && _at_userMSW_probeCmd_discoverResource-cygwinNative-ProgramFiles 'makensis' 'NSIS/bin' false

    type makensis > /dev/null 2>&1
}




_getRelease-ubcp() {
    mkdir -p "$currentAccessoriesDir"/integrations/ubcp
    # Download ubcp release binary if not already present.
    if [[ ! -e "$currentAccessoriesDir"/integrations/ubcp/"$1" ]]
    then
        #-H "Authorization: Bearer ${{ secrets.GITHUB_TOKEN }}"
        #curl -L -o "$currentAccessoriesDir"/integrations/ubcp/"$1"  $(curl -s "https://api.github.com/repos/mirage335/ubiquitous_bash/releases" | jq -r ".[] | select(.name == \"internal\") | .assets[] | select(.name == \"""$1""\") | .browser_download_url" | sort -n -r | head -n1)
        curl -L -o "$currentAccessoriesDir"/integrations/ubcp/"$1"  $(curl -s "https://api.github.com/repos/mirage335-colossus/ubiquitous_bash/releases" | jq -r ".[] | select(.name == \"internal\") | .assets[] | select(.name == \"""$1""\") | .browser_download_url" | sort -n -r | head -n1)
    fi
}


_build_extendedInterface-fetch() {
    _start
    #mkdir -p "$shortTmp"
    local functionEntryPWD="$PWD"
    cd "$scriptAbsoluteFolder"


    export currentAccessoriesDir="$scriptAbsoluteFolder"/../"$objectName"-accessories
    [[ -e "$scriptAbsoluteFolder"/../"$objectName"-accessories/parts ]] && _messageFAIL && _stop 1
    #export currentAccessoriesDir="$shortTmp"
    
    #! type makensis && _if_cygwin && _at_userMSW_probeCmd_discoverResource-cygwinNative-ProgramFiles 'makensis' 'NSIS/bin' false
    _getMinimal-build_extendedInterface


    #_getRelease-ubcp 'package_ubiquitous_bash-msw-rotten.7z'
    #_getRelease-ubcp 'package_ubcp-cygwinOnly.tar.xz'
    _getRelease-ubcp 'package_ubcp-core.7z'

    mkdir -p "$currentAccessoriesDir"/parts/ubcp/package_ubcp-core
    cd "$currentAccessoriesDir"/parts/ubcp/package_ubcp-core
    7za -y x "$currentAccessoriesDir"/integrations/ubcp/package_ubcp-core.7z
    cd "$functionEntryPWD"

    cp "$scriptAbsoluteFolder"/support/000-OS/MSW/root/_bash_bat_lnk.zip "$currentAccessoriesDir"/parts/
    cd "$currentAccessoriesDir"/parts/
    rm -f "$currentAccessoriesDir"/parts/_bash.bat.lnk
    unzip -o "$currentAccessoriesDir"/parts/_bash_bat_lnk.zip
    rm -f "$currentAccessoriesDir"/parts/_bash_bat_lnk.zip
    cd "$functionEntryPWD"


    cd "$currentAccessoriesDir"/parts
    #_gitBest clone --depth 1 --recursive git@github.com:mirage335-colossus/"$objectName".git
    _gitBest clone git@github.com:mirage335-colossus/"$objectName".git

    mkdir -p "$currentAccessoriesDir"/parts/"$objectName"
    cd "$currentAccessoriesDir"/parts/"$objectName"
    if [[ ! -e ./.git ]]
    then
        cp -a "$scriptAbsoluteFolder"/.git ./
    fi


    #git config gc.pruneExpire now
    #git config gc.reflogExpire now
    #git config gc.reflogExpireUnreachable now

    git reset --hard
    

    #git submodule update --depth 1
    #git submodule update --depth 1 --init --recursive
    #git submodule update --depth 1 --force --recursive

    git checkout HEAD
    _gitBest pull
    _gitBest submodule update --depth 1
    _gitBest submodule update --init --depth 1 --recursive
    _gitBest submodule update --depth 1 --force --recursive


    #git gc --aggressive

    #git show-ref -s HEAD > $(git rev-parse --git-dir)/shallow
    #git reflog expire --expire-unreachable=now --all
    #git reflog expire --expire=0
    #git reflog expire --expire=now --all
    #git prune
    #git prune-packed

    cd "$currentAccessoriesDir"/parts/extendedInterface/_lib/ubiquitous_bash/
    #git show-ref -s HEAD > $(git rev-parse --git-dir)/shallow
    #git reflog expire --expire-unreachable=now --all
    #git reflog expire --expire=0
    #git reflog expire --expire=now --all
    #git prune
    #git prune-packed

    cd "$currentAccessoriesDir"/parts/extendedInterface/
    #git reflog expire --expire-unreachable=now --all
    #git reflog expire --expire=now --all
    #git reflog expire --expire=0
    #git prune
    #git prune-packed
    #git gc --prune=all
    #git gc --aggressive
    git gc

    _github_removeActionsHTTPS ./.git


    cd "$functionEntryPWD"

    

    cd "$currentAccessoriesDir"/parts/extendedInterface/_lib/ubiquitous_bash/
    ./compile.sh
    cd "$functionEntryPWD"


    cd "$currentAccessoriesDir"/parts/
    _gitBest clone --depth 1 --recursive git@github.com:mirage335-special/iconArt.git
    cd "$functionEntryPWD"


    cd "$currentAccessoriesDir"/parts/
    _gitBest clone --depth 1 --recursive git@github.com:mirage335-colossus/extendedInterface_bundle.git
    cd "$functionEntryPWD"



    cd "$functionEntryPWD"
    _stop
}



_build_extendedInterface-build() {
    #_start
    mkdir -p "$shortTmp"
    local functionEntryPWD="$PWD"

    rm -f "$scriptAbsoluteFolder"/../extIface.exe 2> /dev/null

    export currentAccessoriesDir="$scriptAbsoluteFolder"/../"$objectName"-accessories


    #! type makensis && _if_cygwin && _at_userMSW_probeCmd_discoverResource-cygwinNative-ProgramFiles 'makensis' 'NSIS/bin' false
    _getMinimal-build_extendedInterface
    

    unix2dos "$scriptAbsoluteFolder"/license-installer.txt

    cd "$scriptLib"/nsis
    makensis -V4 "$scriptLib"/nsis/extIface.nsi






    cd "$functionEntryPWD"
    _stop
}


