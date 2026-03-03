#!/bin/bash

echo "Creating system shims..."
echo -e "#!/bin/sh\nexit 0" > $PREFIX/bin/udevadm
echo -e "#!/bin/sh\nexit 0" > $PREFIX/bin/arecord
chmod +x $PREFIX/bin/udevadm $PREFIX/bin/arecord

echo "Installing Node.js dependencies..."
npm install --omit=optional

echo "Creating dummy Node modules..."
# Shim for ffmpeg-static to use Termux system ffmpeg
mkdir -p node_modules/ffmpeg-static
echo "module.exports = '$(which ffmpeg)';" > node_modules/ffmpeg-static/index.js
echo '{"name": "ffmpeg-static", "version": "5.2.0", "main": "index.js"}' > node_modules/ffmpeg-static/package.json

# Shim for serialport to prevent hardware access errors
mkdir -p node_modules/serialport/dist
mkdir -p node_modules/@serialport/parser-byte-length
echo "module.exports = { SerialPort: function() { this.on = () => {}; this.write = () => {}; this.pipe = () => ({ on: () => {} }); } };" > node_modules/serialport/dist/index.js
echo "module.exports = { ByteLengthParser: function() {} };" > node_modules/@serialport/parser-byte-length/index.js
echo '{"name": "serialport", "version": "1.0.0", "main": "dist/index.js"}' > node_modules/serialport/package.json
echo '{"name": "@serialport/parser-byte-length", "version": "1.0.0", "main": "index.js"}' > node_modules/@serialport/parser-byte-length/package.json

echo "Setting up library permissions..."
find . -name "librdsparser.so" -exec chmod +x {} \;

echo "Setup complete. You can now run your start script."
