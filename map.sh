#Inspired by https://apple.stackexchange.com/questions/329085/tilde-and-plus-minus-±-in-wrong-place-on-keyboard
echo "       su " $?

mkdir -p ~/.varmilo
echo "      dir " $?

product_id=$(hidutil list | grep "Varmilo Keyboard" | head -1 | awk -F"    " '{print $2}')
echo "ProductID " $product_id

sudo cat << EOF > /Users/simonhorrobin/.varmilo/map.sh && chmod +x /Users/simonhorrobin/.varmilo/map.sh
hidutil property --matching '{"ProductID":$product_id}' --set '{"UserKeyMapping":
    [{"HIDKeyboardModifierMappingSrc":0x700000035,
      "HIDKeyboardModifierMappingDst":0x700000064},
     {"HIDKeyboardModifierMappingSrc":0x700000064,
      "HIDKeyboardModifierMappingDst":0x700000035}]
}'
EOF
echo "      map " $?

sudo /usr/bin/env bash -c "cat > /Users/simonhorrobin/Library/LaunchAgents/org.custom.varmilo-map.plist" << EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
    <dict>
        <key>Label</key>
        <string>com.user.loginscript</string>
        <key>ProgramArguments</key>
        <array>
            <string>/usr/bin/hidutil</string>
            <string>property</string>
            <string>--set</string>
            <string>${HOME}/.varmilo/map.sh</string>
        </array>
        <key>RunAtLoad</key>
        <true/>
    </dict>
</plist>
EOF
echo "    plist " $?

sudo launchctl bootstrap gui/503 /Users/simonhorrobin/Library/LaunchAgents/org.custom.varmilo-map.plist
echo "launchctl " $?
