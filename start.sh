#!/bin/bash

echo "[...] Cleaning up previous session"
pkill -9 node 2>/dev/null
killall -9 pulseaudio 2>/dev/null
rm -rf $TMPDIR/pulse-*

sleep 1

pulseaudio --start --exit-idle-time=-1 2>/dev/null

pactl unload-module module-sles-source 2>/dev/null
pactl load-module module-sles-source > /dev/null 2>&1

if [ $? -eq 0 ]; then
    echo "[OK] Android Audio Source Connected"
else
    echo "[!] Audio Error: Check Microphone Permissions"
    exit 1
fi

echo "[...] Starting FM-DX Webserver"

node .
