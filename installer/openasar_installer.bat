@echo off
rem This changes variables from %variable% to !variable! to allow for delayed expansion
rem This is required for the for loops to work properly
setlocal enabledelayedexpansion

rem lil animation, can be skipped by pressing any key 3 times
cls
echo.
echo Installer created by @greenman36 and updated by @aaronliu
echo.
echo ....  ...  .... .   .      ..  ....  ..  ...  
echo .  .  .  . .    ..  .     .  . .    .  . .  . 
echo .  .  ...  .... . . .     .... .... .... ...  
echo .  .  .    .    .  ..     .  .    . .  . .  . 
echo ....  .    .... .   .  .  .  . .... .  . .  . 
echo.
timeout /t 1 >nul
cls
echo.
echo Installer created by @greenman36 and updated by @aaronliu
echo.
echo ====  ===  ==== =   =      ==  ====  ==  ===  
echo =  =  =  = =    ==  =     =  = =    =  = =  = 
echo =  =  ===  ==== = = =     ==== ==== ==== ===  
echo =  =  =    =    =  ==     =  =    = =  = =  = 
echo ====  =    ==== =   =  =  =  = ==== =  = =  = 
echo.
timeout /t 1 >nul
cls
echo.
echo Installer created by @greenman36 and updated by @aaronliu
echo.
echo ####  ###  #### #   #      ##  ####  ##  ###  
echo #  #  #  # #    ##  #     #  # #    #  # #  # 
echo #  #  ###  #### # # #     #### #### #### ###  
echo #  #  #    #    #  ##     #  #    # #  # #  # 
echo ####  #    #### #   #  #  #  # #### #  # #  # 
echo.
timeout /t 1 >nul
cls

:select
rem Discord flavor selection menu
echo.
echo Installer created by @greenman36 and updated by @aaronliu
echo.
echo Select the Discord channel to install to.
echo.
echo 1. Discord Stable (Default)
echo 2. Discord PTB
echo 3. Discord Canary
echo.
set /p "selection=Enter the number corresponding to your selection: "
echo.

if "%selection%"=="1" (
    set "discordApp=Discord"
) else if "%selection%"=="2" (
    set "discordApp=DiscordPTB"
) else if "%selection%"=="3" (
    set "discordApp=DiscordCanary"
) else if "%selection%"=="" (
    color f6
    echo Warning: No input detected. Defaulting to Discord Stable.
    echo.
    pause
    color 07
    set "discordApp=Discord"
) else (
	color f4
    echo Invalid selection. Please only enter a number from one to three.
    echo.
    pause
    color 07
    cls
    goto select
)


rem Finds the latest version folder for the selected Discord flavor
set "latestVersion="
for /f "delims=" %%d in ('dir /b /ad /on "%localappdata%\%discordApp%\app-*"') do (
    set "folderName=%%~nxd"
    rem just the version number (without the app- prefix)
    set "version=!folderName:~4!"
    if "!version!" gtr "!latestVersion!" (
        set "latestVersion=!version!"
    )
)
rem If no version folders are found, exit. We can't continue
if not defined latestVersion (
    set "error=No version folders found. Do you even have %discordApp% installed?"
    goto error
)

echo Closing Discord...
echo.
taskkill /f /im %discordApp%.exe
cls

rem Let the user make sure all info is correct before continuing
echo Installer created by @greenman36 and updated by @aaronliu
echo.
echo Confirm the following information before continuing.
echo.
echo Channel: %discordApp%
echo Host Version: %latestVersion%
echo Full Path: %localappdata%\%discordApp%\app-%latestVersion%\resources\
echo.
pause

echo Installing OpenAsar...
echo.
echo 1. Backing up original app.asar to app.asar.backup
if exist "%localappdata%\%discordApp%\app-%latestVersion%\resources\app.asar.backup" (
    color f6
    echo Warning: A backup already exists. OpenAsar can auto-update and there's no need to reinstall.
    echo Are you sure you still want to continue?
    echo.
    pause
    color 07
)
rem This is done multiple times because there's multiple client mods that use different file names and we support those
move /y "%localappdata%\%discordApp%\app-%latestVersion%\resources\app.asar" "%localappdata%\%discordApp%\app-%latestVersion%\resources\app.asar.backup" >nul
if exist "%localappdata%\%discordApp%\app-%latestVersion%\resources\_app.asar" (
    move /y "%localappdata%\%discordApp%\app-%latestVersion%\resources\_app.asar" "%localappdata%\%discordApp%\app-%latestVersion%\resources\_app.asar.backup" >nul
)
if exist "%localappdata%\%discordApp%\app-%version%\resources\app.asar.orig" (
    move /y "%localappdata%\%discordApp%\app-%latestVersion%\resources\app.asar.orig" "%localappdata%\%discordApp%\app-%latestVersion%\resources\app.asar.orig.backup" >nul
)
rem If the copy command failed, exit
if errorlevel 1 (
    color f6
    echo.
    echo Warning: Failed to backup the existing ASARs.
    echo.
    pause
    color 07
)

echo 2. Downloading OpenAsar (ignore any flashes, this is a download progress bar)
powershell -Command "Invoke-WebRequest https://github.com/GooseMod/OpenAsar/releases/download/nightly/app.asar -OutFile "%localappdata%\%discordApp%\app-%version%\resources\app.asar"" >nul

if exist "%localappdata%\%discordApp%\app-%version%\resources\_app.asar.backup" (
    copy "%localappdata%\%discordApp%\app-%version%\resources\app.asar" "%localappdata%\%discordApp%\app-%version%\resources\_app.asar"
)
if exist "%localappdata%\%discordApp%\app-%version%\resources\app.asar.orig.backup" (
    copy "%localappdata%\%discordApp%\app-%version%\resources\app.asar" "%localappdata%\%discordApp%\app-%version%\resources\app.asar.orig"
)

rem If the download command failed, exit
if errorlevel 1 (
    set "error=Failed to download and replace the ASARs.\nPlease check your internet connectin and make sure Discord is closed and not in your tray menu."
    goto error
)

echo Opening Discord...
start "" "%localappdata%\%discordApp%\Update.exe" --processStart %discordApp%.exe >nul

rem Change the color to indicate success and start Discord
cls
color f2
echo Installer created by @greenman36 and updated by @aaronliu
echo.
echo OpenAsar should be installed^^! You can check by looking for an "OpenAsar" option in your Discord settings.
echo Not installed? Try restarting Discord, running the script again, joining the OpenAsar Discord or contacting @greenman36 on Discord.
echo Also, check out some of our other projects at https://greenman36.github.io and https://github.com/aaronliu0130 and petition Ducko to use this as the official installer^^!
echo.
pause
color 07
exit /b

:error
color f4
echo Error: %error%
echo.
pause
color 07
exit /b 1
