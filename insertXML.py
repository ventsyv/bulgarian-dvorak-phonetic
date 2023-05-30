#!/usr/bin/env python3

import xml.etree.ElementTree as ET
import sys


# The source contains the XML Node for the new layout that we are adding
# The destination is the evdev.xml file. Location might vary depending on distro
def appendXML (sourcePath, targetPath, countryCode):
	target = ET.parse(targetPath)
	root = target.getroot()
	
	# File structure is:
	# <xkbConfigRegistry version="1.1">
	#	<layoutList>
	#		<layout>
	#			<configItem>
	#				<name>bg</name>
	#			</configItem>
	#			<variantList>
	#			</variantList>
	#		<l/ayout>
	#
	# We need to find the layout element with the correct name
	# This is done by XPath //name[.="bg")]
	# the ../.. part goes up 2 level
	# Then we select the variantList where we want to append the new layout
	layoutXpath= './/name[.="{0}"]/../../variantList'.format(countryCode)
	
	#Find the Bulgarian layout. There should only be one
	bgLayoutNode = root.findall(layoutXpath)[0]

	#Append the new layout and overwrite
	newLayout = ET.parse(sourcePath).getroot()
	bgLayoutNode.append(newLayout)
	ET.indent(target)
	target.write(targetPath)



def main ():
	sourcePath = sys.argv[1]
	targetPath = sys.argv[2]
	countryCode="bg"
	if (len(sys.argv) == 4):
		countryCode = sys.argv[3]
	appendXML(sourcePath, targetPath, countryCode)

if __name__ == "__main__":
	main()
