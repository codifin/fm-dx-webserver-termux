# FM-DX Webserver Termux (Android) Installation
### !!!WORKS ONLY WI-FI CONNECT WITH XDRD!!!

1. Install Termux from [Google Play](https://play.google.com/store/apps/details?id=com.termux) or [F-Droid](https://f-droid.org/packages/com.termux/)

2. Update and install necessary dependencies:
```bash
pkg update && pkg upgrade -y
pkg install nodejs-lts ndk-sysroot clang cmake make binutils python ffmpeg git -y
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

## 🐛 Reporting Issues

If you encounter an error, please open an issue and provide the following information:

1. **Terminal Logs**: Copy the full output from Termux (from the start of the command until the error).
2. **System Info**: 
   - Android version
   - Phone model
   - Output of `node -v` and `uname -m`

> **Note**: Most installation errors in Termux are related to missing build tools. Make sure you have run `pkg install clang cmake make ndk-sysroot` before reporting.
