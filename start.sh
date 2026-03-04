#!/bin/bash

killall -9 node pulseaudio 2>/dev/null
rm -rf $TMPDIR/pulse-*

pulseaudio --start --exit-idle-time=-1 2>/dev/null

pactl load-module module-sles-source > /dev/null 2>&1

if [ $? -eq 0 ]; then
    echo "[OK] Android Audio Source Connected"
else
    echo "[!] Audio Error: Check Microphone Permissions"
fi

echo "[...] Starting FM-DX Webserver"
node .
