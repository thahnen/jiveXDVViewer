#!/usr/bin/env bash

# Installiert den JiveX DICOM Viewer mit dem Windows Installer unter macOS
# ========================================================================

# Global variables
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
LOG_FILE=$DIR/../build/log/install.log
SETUP_FILE=$DIR/../bin/Setup-5.4.exe
VERSION="$( exiftool $SETUP_FILE | grep "Product Version" | grep -v "Product Version Number" )"

# i) check if Java installed
which java >/dev/null 2>&1
if [[ $? -ne 0 ]]; then
    echo "[jiveXDVViewer Installer] Java not installed but required!"
    exit 1
fi

# ii) check if 7zz installed
which 7zz >/dev/null 2>&1
if [[ $? -ne 0 ]]; then
    echo "[jiveXDVViewer Installer] 7zz not installed but required!"
fi

# iii) TODO: ...
