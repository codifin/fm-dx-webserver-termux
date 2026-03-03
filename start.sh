#!/bin/bash

if [ ! -f "config.json" ]; then
    echo "config.json not found. Starting first-time setup..."
    node .
    exit 0
fi

IP=""
PORT=""
PASS=""

# Parse arguments
while [[ "$#" -gt 0 ]]; do
    case $1 in
        -ip) IP="$2"; shift ;;
        -port) PORT="$2"; shift ;;
        -pass) PASS="$2"; shift ;;
        *) echo "Unknown parameter passed: $1"; exit 1 ;;
    esac
    shift
done

if [ ! -z "$IP" ] || [ ! -z "$PORT" ] || [ ! -z "$PASS" ]; then
    echo "Updating configuration..."
    python3 -c "
import json
try:
    with open('config.json', 'r') as f:
        data = json.load(f)
    if '$IP': data['xdrd']['xdrdIp'] = '$IP'
    if '$PORT': data['xdrd']['xdrdPort'] = '$PORT'
    if '$PASS': data['xdrd']['xdrdPassword'] = '$PASS'
    with open('config.json', 'w') as f:
        json.dump(data, f, indent=2)
    print('Update successful.')
except Exception as e:
    print(f'Error: {e}')
"
fi

echo "Starting FM-DX Webserver..."
node .
