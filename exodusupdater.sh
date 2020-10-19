#!/bin/bash

# Exodus updater
# Rob Hendricks (robstahendricks@gmail.com)
# @https://github.com/robotard
# V 1.0 - 19/10/2020
# Creative Commons Zero V1.0 - Do as you wish. Simple script, but your risk ;)

#The URL for Exodus releases... 
exodusBaseURL="https://updates.exodus.io/releases/"

#Check our current version
#### For testing uncomment here - exodusVer="1.1.1"
exodusVer=$(exodus --version)
echo "Current verion = $exodusVer"

#This gives us the latest version (albeit the macOS one that apparently releases at same time as Ubuntu)
exodusLatest=$(curl -sS https://updates.exodus.io/releases/feed/darwin.json | jq -r '.version')
echo "Latest version = $exodusLatest"
echo

#Do our versions differ?
if [ "$exodusVer" = "$exodusLatest" ]; then
	#We're hot to trot!
    echo "Exodus is already the latest version"
else
	#Lets update
    echo "Not latest Exodus"
    echo
    #This should be the file format for the .deb
    exodusDownload="exodus_"$exodusLatest"_amd64.deb"
    echo "Latest version is - $exodusDownload"
    echo
    
    #Lets clean up any old download of the same version... Could include clean up of older versions here too?
    if [ -f "$exodusDownload" ]; then
    	rm -rf "$exodusDownload"
	fi

	#Yea, this is the full path we'll use
    echo Downloading - $exodusBaseURL$exodusDownload
    echo
    #and getting it...
    $(wget $exodusBaseURL$exodusDownload)

    #then installing it... 
	echo "$(sudo dpkg -i $exodusDownload)"
fi