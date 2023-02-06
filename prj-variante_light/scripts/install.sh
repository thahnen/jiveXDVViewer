#!/usr/bin/env bash

# Installiert den JiveX DICOM CD Viewer mit dem Windows Installer unter macOS
# ===========================================================================

# Global variables
START_DIR="$( pwd )"
BUILD_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )/$( dirname -- $0 )/../build"
SETUP_FILE="$BUILD_DIR/../bin/Setup-5.2.0.26.exe"

# i) note user about start of installer
echo "[jiveXDVViewer Installer] Installing JiveX DICOM CD Viewer!"

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
java -jar install.jar -q $HOME/jivexdvlight >/dev/null
if [[ $? -ne 0 ]]; then
    echo "[jiveXDVViewer Installer]    -> Running install.jar failed!"
    cd $START_DIR
    exit 4
fi

# viii) remove Windows / 32-bit macOS stuff
echo "[jiveXDVViewer Installer] 5) Removing Windows / 32-bit macOS applications ..."
[ -f "$HOME/.com.visustt.jivex.properties" ] && rm -f $HOME/.com.visustt.jivex.properties
[ -d "$HOME/Desktop/JiveX DICOM CD Viewer" ] && rm -rf $HOME/Desktop/JiveX\ DICOM\ CD\ Viewer
[ -d "$HOME/jivexdvlight/- Documentation JiveX DICOM CD Viewer.app" ] && rm -rf $HOME/jivexdvlight/-\ Documentation\ JiveX\ DICOM\ CD\ Viewer.app
[ -f "$HOME/jivexdvlight/DVStart.exe" ] && rm -f $HOME/jivexdvlight/DVStart.exe
[ -d "$HOME/jivexdvlight/JExpress" ] && rm -rf $HOME/jivexdvlight/JExpress
[ -d "$HOME/jivexdvlight/JiveX DICOM CD Viewer.app" ] && rm -rf $HOME/jivexdvlight/JiveX\ DICOM\ CD\ Viewer.app
[ -f "$HOME/jivexdvlight/showJiveXDocs.bat" ] && rm -f $HOME/jivexdvlight/showJiveXDocs.bat
[ -f "$HOME/jivexdvlight/uninstaller.exe" ] && rm -f $HOME/jivexdvlight/uninstaller.exe
[ -d "$HOME/jivexdvlight/www.visus.com.app" ] && rm -rf $HOME/jivexdvlight/www.visus.com.app

# ix) get back to starting working directory
echo "[jiveXDVViewer Installer] Installing JiveX DICOM CD Viewer successfully!"
cd $START_DIR
