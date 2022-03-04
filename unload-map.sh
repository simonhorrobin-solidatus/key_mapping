su solidatusadmin
sudo launchctl unload -w -- /Library/LaunchDaemons/org.custom.varmilo-map.plist; sudo rm -f -- /Library/LaunchDaemons/org.custom.varmilo-map.plist ~/.varmilo/map

echo $?
