#!/usr/bin/env bash
# v1.2.1: Charming Chmoddy
cd "$(dirname "$0")"

# Header strings
dot () {
    if [[ -z "$1" ]]; then sleep 1; fi
    clear
    echo '
Installer updated and maintained by aaronliu0130 (@aaronliu)

....  ...  .... .   .      ..  ....  ..  ...
.  .  .  . .    ..  .     .  . .    .  . .  .
.  .  ...  .... . . .     .... .... .... ...
.  .  .    .    .  ..     .  .    . .  . .  .
....  .    .... .   .  .  .  . .... .  . .  .
' >&2
}
eq () {
    if [[ -z "$1" ]]; then sleep 1; fi
    clear
    echo '
Installer updated and maintained by aaronliu0130 (@aaronliu)

====  ===  ==== =   =      ==  ====  ==  ===
=  =  =  = =    ==  =     =  = =    =  = =  =
=  =  ===  ==== = = =     ==== ==== ==== ===
=  =  =    =    =  ==     =  =    = =  = =  =
====  =    ==== =   =  =  =  = ==== =  = =  =
'
} >&2
hash () {
    if [[ -z "$1" ]]; then sleep 1; fi
    clear
    echo '
Installer updated and maintained by aaronliu0130 (@aaronliu)

####  ###  #### #   #      ##  ####  ##  ###
#  #  #  # #    ##  #     #  # #    #  # #  #
#  #  ###  #### # # #     #### #### #### ###
#  #  #    #    #  ##     #  #    # #  # #  #
####  #    #    #   #  #  #  # #### #  # #  #
'
} >&2
end='OpenAsar should be installed! You can check by looking for an "OpenAsar" option in your Discord settings.
Not installed? Try restarting Discord, running this script again, filing a GitHub issue or contacting @aaronliu on Discord.'

if [[ -z $spaceballs ]]; then
    # li'l nicer animation, can be skipped by exporting spaceballs
    dot n
    # Update checker
    if [[ $(curl -r 0-99 -sL 'https://github.com/aaronliu0130/Better-OpenAsar/raw/main/installer/openasar-install.bash' | sed '2!d') != "# v1.2: Charming Chmoddy" ]]; then
        eq
        echo 'Updating...'
        curl -Lo "./openasar-install.bash" 'https://github.com/aaronliu0130/Better-OpenAsar/raw/main/installer/openasar-install.bash'
        if ! ./openasar-install.bash; then
            exit $?
        else
            if [ $? -ne 0 ]; then exit $?; fi
            export spaceballs="If you can read this, you don't need glasses."
            eq
            echo "$end" >&2
            exit 0
        fi
    fi
    eq
    sleep 1
fi
hash n
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
            echo Please enter a number from 1 to 3 corresponding to a version above or the path to app.asar.
            read -r ans
        fi
        ;;
    esac
done

# Generate list of possible paths to app.asar
ans=$((ans-1)) # Arrays are 0-indexed
camel=('discord' 'discordPtb' 'discordCanary')
pascal=('Discord' 'DiscordPtb' 'DiscordCanary')
plain=('Discord' 'Discord PTB' 'Discord Canary')
files=(
    "/opt/$kebab/resources/app.asar"
    "/usr/share/$kebab/resources/app.asar"
    "/var/lib/flatpak/app/com.discordapp.${pascal[ans]}/current/active/files/${camel[ans]}/resources/app.asar"
    "$HOME/local/share/flatpak/app/com.discordapp.${pascal[ans]}/current/active/files/${camel[ans]}/resources/app.asar"
    "/Applications/${plain[ans]}.app/Contents/Resources/app.asar"
    "$HOME/Applications/${plain[ans]}.app/Contents/Resources/app.asar"
    "/usr/lib/$kebab/resources/app.asar"
    "/usr/lib64/$kebab/resources/app.asar"
    "/usr/lib/$kebab/app.asar"
    #'/usr/lib/discord-development/app.asar' # Old name for PTB
    'WtoI-7DWs4o')

echo 'Looking for app.asar...' >&2
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
                eq
                echo "$end" >&2
                if [[ $spaceballs == 6 ]]; then
                    export spaceballs="If you can read this, you don't need glasses."
                    echo "
                    $spaceballs" >&2
                fi
                dot
                echo "$end" >&2
                exit 0
            fi
        fi
        if [[ -d "$file" ]]; then
            echo Please enter the path to the file, not a directory.
            read -r file
        fi
        if [[ ! -e "$file" ]]; then
            echo "$file doesn't exist. Exiting..." >&2
            exit 66 # EX_NOINPUT
        fi
    fi
fi
echo "Found app.asar at $file. Press enter to continue and ^C (Ctrl+C) to quit."
read -r

echo "
Killing ${plain[$ans]} (if found)..." >&2
paskill=('Discord' 'DiscordPTB' 'DiscordCanary') # why, discord, whyyyy
killall "${paskill[ans]}"
until ! killall "${paskill[ans]}" -s 0; do # Send a 0 code to the program to check if it's running
    sleep 1
done

sudo="" # Add sudo if needed
echo 'Installing...

1. Backing up original app.asar(s) to app.asar(s).backup...' >&2
if ! eval "$sudo mv" "$file" "$file.backup"; then
    echo Modification failed, please provide the sudo password to elevate and retry.
    sudo="sudo"
    if ! eval "$sudo mv" "$file" "$file.backup"; then
        echo 'Failed even with elevation. Please file an issue and report this. Exiting...' >&2
        exit 77 # EX_NOPERM
    fi
fi
# Popular client mods refer to these files as the original asar
if [[ -e "$(dirname "$file")/_app.asar" ]]; then
    echo "Detected Vencord installation; installing to $(dirname "$file")/_app.asar instead." >&2
    eval "$sudo mv" "$(dirname "$file")/_app.asar" "$(dirname "$file")/_app.asar.backup"
fi
if [[ -e "$(dirname "$file")/app.orig.asar" ]]; then
    echo "Detected Replugged installation; installing to $(dirname "$file")/app.orig.asar instead." >&2
    eval "$sudo mv" "$(dirname "$file")/app.orig.asar" "$(dirname "$file")/app.orig.asar.backup"
fi

echo '2. Downloading OpenAsar...'
if ! eval "$sudo curl" -sLo "$file" 'https://github.com/GooseMod/OpenAsar/releases/download/latest/app.asar'; then
    echo 'Downloading failed. Please file an issue and report this. Exiting...' >&2
    exit 69 # EX_UNAVAILABLE
fi
echo 'Adding write perms to OpenAsar for auto-updating...' >&2
eval "$sudo chmod" +w "$file"
if [[ -e "$(dirname "$file")/_app.asar.backup" && "$(basename "$file")" != _app.asar ]]; then # Prevent smarty-users from breaking script by pointing to actual asar
    eval "$sudo cp" "$file" "$(dirname "$file")/_app.asar"
    eval "$sudo mv" -f "$file.backup" "$file"
fi
if [[ -e "$(dirname "$file")/app.orig.asar.backup" && "$(basename "$file")" != app.orig.asar ]]; then
    if ! eval "$sudo cp" "$file" "$(dirname "$file")/app.orig.asar" 2>/dev/null; then
        # Weird user has both replugged and vencord installed smh so we hide errors
        echo "Detected both Vencord and Replugged. Why‽ I'm not putting up with this soot. Installing to both." >&2
        eval "$sudo cp" "$(dirname "$file")/_app.asar" "$(dirname "$file")/app.orig.asar"
    else
        eval "$sudo mv" -f "$file.backup" "$file"
    fi
fi

echo 'All clear!' >&2
hash
echo "$end" >&2
