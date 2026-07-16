#!/bin/bash

MISSING_PKGS=""
for pkg in nodejs ffmpeg pulseaudio; do
    if ! command -v $pkg &> /dev/null; then
        MISSING_PKGS="$MISSING_PKGS $pkg"
    fi
done

echo "[...] Cleaning up previous session"

pids=$(pgrep -f "pulseaudio|node")
if [ ! -z "$pids" ]; then
    kill -9 $pids 2>/dev/null
fi

rm -rf $TMPDIR/pulse-* 2>/dev/null
rm -rf ~/.config/pulse 2>/dev/null
rm -f ~/.config/pulse/* 2>/dev/null

sleep 1

echo "[...] Starting Audio Services..."

pulseaudio --start --exit-idle-time=-1 > /dev/null 2>&1 &

sleep 2

if ! pactl info >/dev/null 2>&1; then
    pulseaudio -D --exit-idle-time=-1 > /dev/null 2>&1 &
    sleep 2
fi

pactl unload-module module-sles-source 2>/dev/null
pactl load-module module-sles-source > /dev/null 2>&1

if [ $? -eq 0 ]; then
    echo "[OK] Android Audio Source Connected"
else
    echo "[!] Audio Warning: Check Microphone Permissions in Android Settings for Termux"
fi

echo "[...] Starting FM-DX Webserver..."
node .
