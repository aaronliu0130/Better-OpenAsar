#!/usr/bin/env bash
# v1.1.0: Benign Bepluggings
cd "$(dirname "$0")"
if [[ -z $spaceballs ]]; then
    # lil animation, can be skipped by exporting spaceballs
    clear
    echo
    echo 'Installer updated and maintained by aaronliu0130 (@aaronliu)'
    echo
    echo '....  ...  .... .   .      ..  ....  ..  ...'
    echo '.  .  .  . .    ..  .     .  . .    .  . .  .'
    echo '.  .  ...  .... . . .     .... .... .... ...'
    echo '.  .  .    .    .  ..     .  .    . .  . .  .'
    echo '....  .    .... .   .  .  .  . .... .  . .  .'
    echo
    sleep 1
    clear
    echo
    echo 'Installer updated and maintained by aaronliu0130 (@aaronliu)'
    echo
    echo '====  ===  ==== =   =      ==  ====  ==  ==='
    echo '=  =  =  = =    ==  =     =  = =    =  = =  ='
    echo '=  =  ===  ==== = = =     ==== ==== ==== ==='
    echo '=  =  =    =    =  ==     =  =    = =  = =  ='
    echo '====  =    ==== =   =  =  =  = ==== =  = =  ='
    echo
    sleep 1
    if [[ $(curl -sL 'https://github.com/aaronliu0130/Better-OpenAsar/raw/main/installer/openasar-install.bash' | sed '2!d') != "# v1.1.0: Benign Bepluggings" ]]; then
        curl -sLo "./openasar-install.bash" 'https://github.com/aaronliu0130/Better-OpenAsar/raw/main/installer/openasar-install.bash'
        if ! ./openasar-install.bash; then
            exit $?
        else
            if [ $? -ne 0 ]; then exit $?; fi
            export spaceballs="If you can read this, you don't need glasses."
            clear
            echo
            echo 'Installer updated and maintained by aaronliu0130 (@aaronliu)'
            echo
            echo '====  ===  ==== =   =      ==  ====  ==  ==='
            echo '=  =  =  = =    ==  =     =  = =    =  = =  ='
            echo '=  =  ===  ==== = = =     ==== ==== ==== ==='
            echo '=  =  =    =    =  ==     =  =    = =  = =  ='
            echo '====  =    ==== =   =  =  =  = ==== =  = =  ='
            echo
            echo 'OpenAsar should be installed! You can check by looking for an "OpenAsar" option in your Discord settings.'
            echo 'Not installed? Try restarting Discord, running this script again, filing a GitHub issue or contacting @aaronliu on Discord.'
            exit 0
        fi
    fi
fi
clear
echo
echo 'Installer updated and maintained by aaronliu0130 (@aaronliu)'
echo
echo '####  ###  #### #   #      ##  ####  ##  ###'
echo '#  #  #  # #    ##  #     #  # #    #  # #  #'
echo '#  #  ###  #### # # #     #### #### #### ###'
echo '#  #  #    #    #  ##     #  #    # #  # #  #'
echo '####  #    #### #   #  #  #  # #### #  # #  #'
echo
echo '1. Discord Stable (default)'
echo '2. Discord PTB'
echo '3. Discord Canary'
echo
echo Select your Discord channel by number or manually specify the path to app.asar.
read -r ans

while [[ -z $kebab ]]; do
    case $ans in
    1) kebab='discord' ;;
    2) kebab='discord-ptb' ;;
    3) kebab='discord-canary' ;;
    *)
        if [[ -d "$ans" ]]; then
            echo Please enter the path to the file, not a directory.
            read -r ans
        elif [[ -e "$ans" ]]; then
            file="$ans"
        else
            echo Please enter a number from 1 to 3 corresponding to a version above, or the path to app.asar.
            read -r ans
        fi
        ;;
    esac
done

ans=$((ans-1))
camel=('discord' 'discordPtb' 'discordCanary')
pascal=('Discord' 'DiscordPtb' 'DiscordCanary')
plain=('Discord Stable' 'Discord PTB' 'Discord Canary')
files=(
    "/opt/$kebab/resources/app.asar"
    "/var/lib/flatpak/app/com.discordapp.${pascal[ans]}/current/active/files/${camel[ans]}/resources/app.asar"
    "$HOME/local/share/flatpak/app/com.discordapp.${pascal[ans]}/current/active/files/${camel[ans]}/resources/app.asar"
    "/usr/lib/$kebab/resources/app.asar"
    "/usr/lib64/$kebab/resources/app.asar"
    "/usr/share/$kebab/resources/app.asar"
    "/usr/lib/$kebab/app.asar"
    'WtoI-7DWs4o')
echo Looking for app.asar...
for file in "${files[@]}"; do
    if [[ -e "$file" ]]; then
        break
    fi
done
if [[ "$file" == "WtoI-7DWs4o" ]]; then
    if [[ $ans == 1 && -e '/usr/lib/discord-development/app.asar' ]]; then
        file=/usr/lib/discord-development/app.asar
    else
        echo "Couldn't find ${plain[ans]}'s app.asar, please specify the path to the app.asar file or input 0 to restart."
        read -r file
        if [[ $file == 0 ]]; then
            export spaceballs=$((spaceballs + 1))
            if ! ./openasar-install.bash; then
                exit $?
            else
                if [ $? -ne 0 ]; then exit $?; fi
                sleep 1
                clear
                echo
                echo 'Installer updated and maintained by aaronliu0130 (@aaronliu)'
                echo
                echo '====  ===  ==== =   =      ==  ====  ==  ==='
                echo '=  =  =  = =    ==  =     =  = =    =  = =  ='
                echo '=  =  ===  ==== = = =     ==== ==== ==== ==='
                echo '=  =  =    =    =  ==     =  =    = =  = =  ='
                echo '====  =    ==== =   =  =  =  = ==== =  = =  ='
                echo
                echo 'OpenAsar should be installed! You can check by looking for an "OpenAsar" option in your Discord settings.'
                echo 'Not installed? Try restarting Discord, running this script again, filing a GitHub issue or contacting @aaronliu on Discord.'
                if [[ $spaceballs == 6 ]]; then
                echo
                echo "If you can read this, you don't need glasses."
                export spaceballs="If you can read this, you don't need glasses."
                fi
                sleep 1
                clear
                echo
                echo 'Installer updated and maintained by aaronliu0130 (@aaronliu)'
                echo
                echo '....  ...  .... .   .      ..  ....  ..  ...'
                echo '.  .  .  . .    ..  .     .  . .    .  . .  .'
                echo '.  .  ...  .... . . .     .... .... .... ...'
                echo '.  .  .    .    .  ..     .  .    . .  . .  .'
                echo '....  .    .... .   .  .  .  . .... .  . .  .'
                echo
                echo 'OpenAsar should be installed! You can check by looking for an "OpenAsar" option in your Discord settings.'
                echo 'Not installed? Try restarting Discord, running this script again, filing a GitHub issue or contacting @aaronliu on Discord.'
                exit 0
            fi
        fi
        if [[ -d "$file" ]]; then
            echo Please enter the path to the file, not a directory.
            read -r file
        fi
        if [[ ! -e "$file" ]]; then
            echo "$file doesn't exist. Exiting..."
            exit 2
        fi
    fi
fi
echo "Found app.asar at $file. Press enter to continue and ^C (Ctrl+C) to quit."
read -r

echo
paskill=('Discord' 'DiscordPTB' 'DiscordCanary')
echo "Killing ${plain[$ans]} (if found)..."
killall "${paskill[ans]}"
until ! killall "${paskill[ans]}" -s 0; do
    sleep 1
done

echo Installing...
echo
echo '1. Backing up original app.asar(s) to app.asar(s).backup...'
if ! mv "$file" "$file.backup"; then
    echo Modification failed, please provide the sudo password to elevate and retry.
    if ! sudo mv "$file" "$file.backup"; then
        echo Failed even with elevation. Please file an issue and report this. Exiting...
        exit 77
    fi
    # See the other comment below.
    if [[ -e "$(dirname "$file")/_app.asar" ]]; then
        sudo mv "$(dirname "$file")/_app.asar" "$(dirname "$file")/_app.asar.backup"
    fi
    if [[ -e "$(dirname "$file")/app.orig.asar" ]]; then
        sudo mv "$(dirname "$file")/app.orig.asar" "$(file).orig.backup"
    fi
else
    # Popular client mods refer to these files as the original asar
    if [[ -e "$(dirname "$file")/_app.asar" ]]; then
        mv "$(dirname "$file")/_app.asar" "$(dirname "$file")/_app.asar.backup"
    fi
    if [[ -e "$(dirname "$file")/app.orig.asar" ]]; then
        mv "$(dirname "$file")/app.orig.asar" "$(dirname "$file")/app.orig.asar.backup"
    fi
fi

echo '2. Downloading OpenAsar...'
if ! curl -sLo "$file" 'https://github.com/GooseMod/OpenAsar/releases/download/latest/app.asar'; then
    echo Downloading failed, retrying with sudo...
    if ! sudo curl -sLo "$file" 'https://github.com/GooseMod/OpenAsar/releases/download/latest/app.asar'; then
        echo Failed even with elevation. Please file an issue and report this. Exiting...
        exit 77
    fi
    if [[ -e "$(dirname "$file")/_app.asar.backup" && "$(basename "$file")" != _app.asar ]]; then
        sudo cp "$file" "$(dirname "$file")/_app.asar"
        sudo mv -f "$file.backup" "$file"
    fi
    if [[ -e "$(dirname "$file")/app.orig.asar.backup" && "$(basename "$file")" != app.orig.asar ]]; then
        if ! sudo cp "$file" "$(dirname "$file")/app.orig.asar" 2>/dev/null; then
            # weird user has both replugged and BD installed smh so we hid errors
            sudo cp "$(dirname "$file")/_app.asar" "$(dirname "$file")/app.orig.asar"
        else
            sudo mv -f "$file.backup" "$file"
        fi
    fi
else
    if [[ -e "$(dirname "$file")/_app.asar.backup" && "$(basename "$file")" != _app.asar ]]; then
        cp "$file" "$(dirname "$file")/_app.asar"
        mv -f "$file.backup" "$file"
    fi
    if [[ -e "$(dirname "$file")/app.orig.asar.backup" && "$(basename "$file")" != app.orig.asar ]]; then
        if ! cp "$file" "$(dirname "$file")/app.orig.asar" 2>/dev/null; then
            # weird user has both replugged and BD installed smh so we hid errors
            cp "$(dirname "$file")/_app.asar" "$(dirname "$file")/app.orig.asar"
        else
            mv -f "$file.backup" "$file"
        fi
    fi
fi
echo All clear!
sleep 1
clear
echo
echo 'Installer updated and maintained by aaronliu0130 (@aaronliu)'
echo
echo '####  ###  #### #   #      ##  ####  ##  ###'
echo '#  #  #  # #    ##  #     #  # #    #  # #  #'
echo '#  #  ###  #### # # #     #### #### #### ###'
echo '#  #  #    #    #  ##     #  #    # #  # #  #'
echo '####  #    #### #   #  #  #  # #### #  # #  #'
echo
echo 'OpenAsar should be installed! You can check by looking for an "OpenAsar" option in your Discord settings.'
echo 'Not installed? Try restarting Discord, running this script again, filing a GitHub issue or contacting @aaronliu on Discord.'
