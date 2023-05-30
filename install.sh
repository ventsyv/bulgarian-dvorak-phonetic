#!/usr/bin/env bash

COUNTRY_CODE="bg"

#Create backups before modifying anything ...
cp --backup=numbered /usr/share/X11/xkb/symbols/$COUNTRY_CODE /usr/share/X11/xkb/symbols/${COUNTRY_CODE}_backup
cp --backup=numbered /usr/share/X11/xkb/rules/evdev.lst /usr/share/X11/xkb/rules/evdev_backup.lst
cp --backup=numbered /usr/share/X11/xkb/rules/evdev.xml /usr/share/X11/xkb/rules/evdev_backup.xml


#Add a new line
echo >> /usr/share/X11/xkb/symbols/$COUNTRY_CODE
#Add the new layout to the file for the Bulgarian layouts
cat bg_phonetic_dvorak.symbols >> /usr/share/X11/xkb/symbols/$COUNTRY_CODE


#insert the new layout in the layout list file
sed -i "s|.*Bulgarian (enhanced)$|&\n  bg_phonetic_dvorak bg: Bulgarian (phonetic Dvorak)|g" /usr/share/X11/xkb/rules/evdev.lst

#Add the new layout to the evdev.xml
./insertXML.py bg_phonetic_dvorak.xml /usr/share/X11/xkb/rules/evdev.xml $COUNTRY_CODE

dpkg-reconfigure xkb-data
systemctl restart keyboard-setup
