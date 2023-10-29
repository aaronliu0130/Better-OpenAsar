# Better OpenAsar Installer

This has a Linux install script and GreenMan36's improved version of the Windows install script.

## 🐧 Linux & 🍎 macOS

On Linux and macOS, no updates have changed the path of Discord's files yet. However, there are a ton of paths that could have them, as Discord does not have official packages for every distro (variety) of Linux, and even the official packages might get installed to different places by package managers.

Macs fortunately support bash/zsh and should only be in one of two locations.

You can run the script with any shell that supports bash's [[ conditionals, including zsh. 

### 🎥 Demo

[![asciicast](https://asciinema.org/a/ucSR2ZZcSpIvl6AKPJY5TISBU.svg)](https://asciinema.org/a/608376?autoplay=1)

#### 😩 TL;DR:

1. Show a better animation
2. Pick the Discord channel
3. Confirm the info
4. Insstall
5. Done!

* Bash is the most widely installed shell that allows for Bash scripting
* Try every known location of Discord's files
* Even nicer animation
* Always only download OpenAsar once
* Automatically try to sudo if installation fails
* Intuitive input hints
* Allow specifying a custom path
* Unsupressed system commands' error messages, allowing you to nicely debug stuff

## 🐌 Windows

Sometimes, Discord updates its host. This means you'll have to install OpenAsar again, for the new host version. However, the path to the Discord files changes with every host update, and OpenAsar's official installer hardcodes the path to a specific host version. This means that every time Discord updates its host, OpenAsar and you have to update their installer.

GreenMan36's improved version automatically detects the folder for the newest version and installs OpenAsar there.

### 🎥 Demo

[![asciicast](https://asciinema.org/a/594421.svg)](https://asciinema.org/a/594421?autoplay=1)

#### 😩 TL;DR:

1. Show a little animation
2. Pick the Discord version
3. Confirm the info
4. Install
5. Open Discord and done!

* Installs no matter Discord's version
* Intuitive error messages
* Nice li'l animation
* If there's any issues, the installer will give you a nice error message which an be used to quickly debug where things went wrong.

## 🤓 Misc

- Ducko doesn't want to use these scripts for some reason
- Please also check out <https://github.com/stefanhaustein/TerminalImageViewer> and <https://github.com/upscayl/upscayl>
- Check out GreenMan36's OpenAsar supported Discord themes at  [![Discord](https://img.shields.io/discord/1050062854860046417?color=7289da&logo=discord&logoColor=white)](https://discord.gg/A6vwGchJYs)
