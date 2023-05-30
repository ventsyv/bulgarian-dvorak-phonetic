# About #
If you use Dvorak for your English layout, it makes sense to also
use Dvorak for Bulgarian. I couldn't find one for Linux so I created my own.

Markup : ![picture alt](https://github.com/ventsyv/bulgarian-dvorak-phonetic/blob/main/layout.png "Layout")

## Installation ##

Installation is simple:

- Enable language support in the settings

- Run the installer

```
sudo ./install.sh
```

There are only 3 files that are modified, and all are backed up.

- /usr/share/X11/xkb/symbols/bg
- /usr/share/X11/xkb/rules/evdev.lst
- /usr/share/X11/xkb/rules/evdev.xml

This has only been tested on Ubuntu, it's likely it will work on other
Linux distros. If you are on a non-Debian distro, check if the files listed above exist.
You'll probably need to restart after the install script is ran.

- Go to Settings -> Keyboards and install the new layout

## Development ##

If you want to create your own version (perhaps for a different language)
follow these steps:

- Copy an existing layout from /usr/share/X11/xkb/symbols/<COUNTRY CODE>
- Modify this layout as you see fit
- Make sure it has unique name
- Modify the install script
	- Change the country code
	- Change any mentions of "Bulgarian"

## Contribute ##

Just fork the project, make the changes, then submit a pull request!
