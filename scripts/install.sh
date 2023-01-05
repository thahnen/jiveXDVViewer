#!/usr/bin/env bash

# Installiert den JiveX DICOM Viewer mit dem Windows Installer unter macOS
# ========================================================================

# Global variables
START_DIR="$( pwd )"
BUILD_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )/$( dirname -- $0 )/../build"
SETUP_FILE="$BUILD_DIR/../bin/Setup-5.4.exe"

# i) note user about start of installer
echo "[jiveXDVViewer Installer] Installing JiveX DICOM Viewer!"

# ii) uninstall old installation
echo "[jiveXDVViewer Installer] 1) Uninstalling possible old installation ..."
source $BUILD_DIR/../scripts/uninstall.sh

# iii) check if Java installed
#      TODO: Also check for exact version! Get version from Setup.exe->jre.exe->file containing version info!?
echo "[jiveXDVViewer Installer] 2) Checking for Java 11 installation ..."
which java >/dev/null 2>&1
if [[ $? -ne 0 ]]; then
    echo "[jiveXDVViewer Installer]    -> Java 11 not installed but required!"
    cd $START_DIR
    exit 1
fi

# iv) check if 7zz installed
echo "[jiveXDVViewer Installer] 2) Checking for 7-Zip (macOS) installation ..."
which 7zz >/dev/null 2>&1
if [[ $? -ne 0 ]]; then
    echo "[jiveXDVViewer Installer]    -> 7-Zip (macOS) not installed but required!"
    cd $START_DIR
    exit 2
fi

# v) delete build dir if exists
if [[ -d "$BUILD_DIR" ]]; then
    rm -rf $BUILD_DIR
fi

# vi) unpack Setup.exe to build directory
mkdir $BUILD_DIR
cd $BUILD_DIR
7zz x $SETUP_FILE >/dev/null
echo "[jiveXDVViewer Installer] 3) Unpacking setup (NSIS) ..."
if [[ $? -ne 0 ]]; then
    echo "[jiveXDVViewer Installer]    -> Unpacking setup (NSIS) failed!"
    cd $START_DIR
    exit 3
fi

# vii) run install.jar with the silent option on
cd $BUILD_DIR/\$TEMP/nsistemp\$9
echo "[jiveXDVViewer Installer] 4) Running install.jar ..."
java -jar install.jar -q $HOME/jivexdv >/dev/null
if [[ $? -ne 0 ]]; then
    echo "[jiveXDVViewer Installer]    -> Running install.jar failed!"
    cd $START_DIR
    exit 4
fi

# viii) remove Windows / 32-bit macOS stuff
[ -f "$HOME/.com.visustt.jivex.properties" ] && rm -f $HOME/.com.visustt.jivex.properties
[ -d "$HOME/Desktop/JiveX DICOM Viewer" ] && rm -rf $HOME/Desktop/JiveX\ DICOM\ Viewer
[ -d "$HOME/jivexdv/- Documentation JiveX DICOM Viewer.app" ] && rm -rf $HOME/jivexdv/-\ Documentation\ JiveX\ DICOM\ Viewer.app
[ -f "$HOME/jivexdv/DVStart.exe" ] && rm -f $HOME/jivexdv/DVStart.exe
[ -d "$HOME/jivexdv/JExpress" ] && rm -rf $HOME/jivexdv/JExpress
[ -d "$HOME/jivexdv/JiveX DICOM Viewer.app" ] && rm -rf $HOME/jivexdv/JiveX\ DICOM\ Viewer.app
[ -f "$HOME/jivexdv/showJiveXDocs.bat" ] && rm -f $HOME/jivexdv/showJiveXDocs.bat
[ -f "$HOME/jivexdv/uninstaller.exe" ] && rm -f $HOME/jivexdv/uninstaller.exe
[ -d "$HOME/jivexdv/www.visus.com.app" ] && rm -rf $HOME/jivexdv/www.visus.com.app

# ix) get back to starting working directory
echo "[jiveXDVViewer Installer] Installing JiveX DICOM Viewer successfully!"
cd $START_DIR
