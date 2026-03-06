#!/bin/bash

echo "Creating system shims..."
echo -e "#!/bin/sh\nexit 0" > $PREFIX/bin/udevadm
echo -e "#!/bin/sh\nexit 0" > $PREFIX/bin/arecord
chmod +x $PREFIX/bin/udevadm $PREFIX/bin/arecord

echo "Configuring FFmpeg for Termux..."
mkdir -p node_modules/ffmpeg-static
echo "module.exports = '$PREFIX/bin/ffmpeg';" > node_modules/ffmpeg-static/index.js
echo '{"name": "ffmpeg-static", "version": "5.2.0", "main": "index.js"}' > node_modules/ffmpeg-static/package.json

echo "Setting up library permissions..."
find . -name "librdsparser.so" -exec chmod +x {} \;

echo "Setup complete. USB support has been removed from shims."
