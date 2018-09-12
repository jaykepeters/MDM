#!/bin/bash
# Install Google Chrome Auto Updater
app="/Applications/Google Chrome.app"
la="/Library/LaunchAgents/com.google.keystone.agent.plist"
versionPath="${app}/Contents/Versions"
newest=$(ls -td "$versionPath"/* | head -1)
ksPath="${newest}"/"Google Chrome Framework.framework/Versions/A/Frameworks/KeystoneRegistration.framework/Resources/"
ksPKG="${ksPath}""Keystone.tbz"
ksinstall="${ksPath}""ksinstall"

# Installation Options
interval=3600

# Check if Google Chrome is installed
if [ ! -d "$app" ]; then
    echo 'Google Chrome is not Installed'
    exit 1
fi

# Uninstall the Updater
if [ -f "$la" ]; then
    echo 'Removing Old Launch Agent'
    launchctl stop $la
    rm -rf $la
fi

# Install the Google Chrome Updater
echo 'Enabling Automatic Software Updates'
"$ksinstall" --install="${ksPKG}" --lockdown --interval=$interval

# Does ksinstall load the launchagent?
echo 'Loading new Launch Agent'
launchctl start $la