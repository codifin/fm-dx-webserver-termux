#!/bin/bash

echo "Creating system shims..."
echo -e "#!/bin/sh\nexit 0" > $PREFIX/bin/udevadm
echo -e "#!/bin/sh\nexit 0" > $PREFIX/bin/arecord
chmod +x $PREFIX/bin/udevadm $PREFIX/bin/arecord

echo "Linking pre-installed Node.js dependencies..."
mkdir -p node_modules/ffmpeg-static
echo "module.exports = '$PREFIX/bin/ffmpeg';" > node_modules/ffmpeg-static/index.js
echo '{"name": "ffmpeg-static", "version": "5.2.0", "main": "index.js"}' > node_modules/ffmpeg-static/package.json

echo "Setting up library and binary permissions..."
find . -name "librdsparser.so" -exec chmod +x {} \;

if [ -d "node_modules/koffi" ]; then
    chmod -R +x node_modules/koffi 2>/dev/null
fi

if [ -d "bin" ]; then
    chmod +x bin/* 2>/dev/null
fi
if [ -d "server/bin" ]; then
    chmod +x server/bin/* 2>/dev/null
fi

echo "------------------------------------------------"
echo "Setup complete!"
echo "You can now start the server using: ./start.sh"
echo "------------------------------------------------"
