# FM-DX Webserver Termux (Android) Installation ([На русском](https://github.com/codifin/fm-dx-webserver-termux/blob/main/README_ru.md))
### !!!WORKS ONLY WI-FI CONNECT WITH XDRD!!!

1. Install Termux from [Google Play](https://play.google.com/store/apps/details?id=com.termux) or [F-Droid](https://f-droid.org/packages/com.termux/)

2. Update and install necessary dependencies:
```bash
pkg update && pkg upgrade -y
```
```bash
pkg install nodejs-lts ndk-sysroot clang cmake binutils python ffmpeg git make-guile -y
```

3. Clone the repository (or alternatively download it manually):

```bash
git clone https://github.com/codifin/fm-dx-webserver-termux/
cd fm-dx-webserver-termux
chmod +x setup.sh
```

4. Run the Setup script.
```bash
./setup.sh
```

5. Start the server:
```bash
node .
```
Open your web browser and navigate to http:/localhost:8080 to access the web interface.

## 🔗 Pairing the Tuner with your Phone

To connect your TEF tuner to the webserver over Wi-Fi, follow these steps:

1.  **Enable Wi-Fi Hotspot**: 
    Turn on the **Mobile Hotspot** on your Android phone. Ensure you know your Hotspot's SSID (name) and Password.

2.  **Connect the Tuner**:
    Power on your TEF receiver and connect it to your phone's Hotspot. 
    * *Tip: Check your phone's "Connected Devices" list to find the Tuner's IP address or check it on TEF's Connectivity setting.*

3.  **Launch & Configure**:
    Start the server by entering the Tuner's IP. Keep the port as default:
    * **IP Address**: Enter the IP assigned to the tuner (e.g., `192.168.x.x`).
    * **Port**: `7373` (Default).
    * **Password**: Enter your xdrd password.

## 🐛 Reporting Issues

If you encounter an error, please open an issue and provide the following information:

1. **Terminal Logs**: Copy the full output from Termux (from the start of the command until the error).
2. **System Info**: 
   - Android version
   - Phone model
   - Output of `node -v` and `uname -m`

> **Note**: Most installation errors in Termux are related to missing build tools. Make sure you have run `pkg install clang cmake make ndk-sysroot` before reporting.
