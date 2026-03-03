#!/bin/bash

echo "Creating system shims..."
echo -e "#!/bin/sh\nexit 0" > $PREFIX/bin/udevadm
echo -e "#!/bin/sh\nexit 0" > $PREFIX/bin/arecord
chmod +x $PREFIX/bin/udevadm $PREFIX/bin/arecord

echo "Installing Node.js dependencies..."
npm install --omit=optional

echo "Creating dummy Node modules..."
# FFmpeg shim
mkdir -p node_modules/ffmpeg-static
echo "module.exports = '$PREFIX/bin/ffmpeg';" > node_modules/ffmpeg-static/index.js
echo '{"name": "ffmpeg-static", "version": "5.2.0", "main": "index.js"}' > node_modules/ffmpeg-static/package.json

# SerialPort and Parser shims
mkdir -p node_modules/serialport/dist
mkdir -p node_modules/@serialport/parser-byte-length

# Main serialport shim with .list() method
cat <<EOT > node_modules/serialport/dist/index.js
module.exports = {
  SerialPort: function() {
    this.on = () => {};
    this.write = () => {};
    this.pipe = () => ({ on: () => {} });
  },
  list: function() {
    return Promise.resolve([]);
  }
};
EOT

# Parser-byte-length shim
echo "module.exports = { ByteLengthParser: function() { this.on = () => {}; } };" > node_modules/@serialport/parser-byte-length/index.js
echo '{"name": "@serialport/parser-byte-length", "version": "1.0.0", "main": "index.js"}' > node_modules/@serialport/parser-byte-length/package.json
echo '{"name": "serialport", "version": "1.0.0", "main": "dist/index.js"}' > node_modules/serialport/package.json

echo "Setting up library permissions..."
find . -name "librdsparser.so" -exec chmod +x {} \;

echo "Setup complete. You can now run your start script."
