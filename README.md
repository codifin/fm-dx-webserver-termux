# FM-DX Webserver Termux (Android) Installation
### !!!WORKS ONLY WI-FI CONNECT WITH XDRD!!!

1. Install Termux from [Google Play](https://play.google.com/store/apps/details?id=com.termux) or [F-Droid](https://f-droid.org/packages/com.termux/)

2. Update and install necessary dependencies:
```bash
pkg update && pkg upgrade -y
pkg install nodejs-lts clang cmake make binutils python ffmpeg git -y
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
