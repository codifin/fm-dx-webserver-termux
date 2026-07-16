#!/bin/bash

MISSING_PKGS=""
for pkg in nodejs ffmpeg pulseaudio; do
    if ! command -v $pkg &> /dev/null; then
        MISSING_PKGS="$MISSING_PKGS $pkg"
    fi
done

if [ ! -z "$MISSING_PKGS" ]; then
    echo "[!] Error: Missing required system packages:$MISSING_PKGS"
    echo "Please run: pkg update && pkg install$MISSING_PKGS -y"
    exit 1
fi

echo "[...] Cleaning up previous session"

pkill node 2>/dev/null
killall pulseaudio 2>/dev/null
sleep 1

pkill -9 node 2>/dev/null
killall -9 pulseaudio 2>/dev/null

rm -rf $TMPDIR/pulse-* 2>/dev/null
rm -rf ~/.config/pulse 2>/dev/null

sleep 2

echo "[...] Starting Audio Services..."
pulseaudio --start --exit-idle-time=-1 2>/dev/null

sleep 0.5

pactl unload-module module-sles-source 2>/dev/null
pactl load-module module-sles-source > /dev/null 2>&1

if [ $? -eq 0 ]; then
    echo "[OK] Android Audio Source Connected"
else
    echo "[!] Audio Warning: Check Microphone Permissions in Android Settings for Termux"
fi

echo "[...] Starting FM-DX Webserver..."
node .
