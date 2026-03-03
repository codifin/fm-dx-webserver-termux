#!/bin/bash

INTERFACE=$(ip route | grep default | awk '{print $5}')
[ -z "$INTERFACE" ] && INTERFACE="wlan0"

NETWORK=$(ip addr show $INTERFACE | grep -oP '(?<=inet\s)\d+(\.\d+){3}/\d+' | cut -d/ -f1 | sed 's/\.[0-9]*$/\.0\/24/')

if [ -z "$NETWORK" ]; then
    echo "Error: Network not found. Check if Hotspot is active."
    exit 1
fi

echo "Scanning $NETWORK on port 7373..."
RECEIVER_IP=$(nmap -p 7373 --open -n $NETWORK | grep "Nmap scan report for" | awk '{print $NF}')

if [ -z "$RECEIVER_IP" ]; then
    echo "Error: Receiver not found."
    exit 1
fi

echo "Receiver found at: $RECEIVER_IP"

python3 -c "
import json
try:
    with open('config.json', 'r') as f:
        data = json.load(f)
    data['xdrd']['xdrdIp'] = '$RECEIVER_IP'
    with open('config.json', 'w') as f:
        json.dump(data, f, indent=2)
    print('Configuration updated.')
except Exception as e:
    print(f'Error updating config: {e}')
"

node .
