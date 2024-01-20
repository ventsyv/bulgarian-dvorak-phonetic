#!/usr/bin/env bash

COUNTRY_CODE="bg"

#Create backups before modifying anything ...
cp --backup=numbered /usr/share/X11/xkb/symbols/$COUNTRY_CODE /usr/share/X11/xkb/symbols/${COUNTRY_CODE}_backup
cp --backup=numbered /usr/share/X11/xkb/rules/evdev.lst /usr/share/X11/xkb/rules/evdev_backup.lst
cp --backup=numbered /usr/share/X11/xkb/rules/evdev.xml /usr/share/X11/xkb/rules/evdev_backup.xml



#Save the original configuration before adding the new variant layout

if [ -e /usr/share/X11/xkb/symbols/${COUNTRY_CODE}_orig ]
then
	#To avoid duplicates, reset to the original before adding the new layout
	mv /usr/share/X11/xkb/symbols/${COUNTRY_CODE}_orig /usr/share/X11/xkb/symbols/${COUNTRY_CODE}
else
	#First time we are installing the new variant. Save the original
	cp /usr/share/X11/xkb/symbols/${COUNTRY_CODE} /usr/share/X11/xkb/symbols/${COUNTRY_CODE}_orig
fi

#Now add the layout to the symbols
#Add a new line
echo >> /usr/share/X11/xkb/symbols/$COUNTRY_CODE
#Add the new variant layout to the symbols
cat bg_phonetic_dvorak.symbols >> /usr/share/X11/xkb/symbols/$COUNTRY_CODE


#insert the new layout in the layout list file only if it doesn't exist already
grep "Bulgarian (phonetic Dvorak)" /usr/share/X11/xkb/rules/evdev.lst > /dev/null
if [ $? != 0 ]
then
	sed -i "s|.*Bulgarian (enhanced)$|&\n  bg_phonetic_dvorak bg: Bulgarian (phonetic Dvorak)|g" /usr/share/X11/xkb/rules/evdev.lst
fi

#Add the new layout to the evdev.xml
./insertXML.py bg_phonetic_dvorak.xml /usr/share/X11/xkb/rules/evdev.xml $COUNTRY_CODE

dpkg-reconfigure xkb-data
systemctl restart keyboard-setup
