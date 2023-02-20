#!/usr/bin/env bash

# Only available as root user
if [[ "$EUID" -ne "0" ]]; then
    echo "Must be run as root!"
    exit
fi

# Workaround for installer
PRODUCT=__PRODUCT__
VERSION=__VERSION__

# Remove link in /Applications
[ -L "/Applications/JiveX DICOM CD Viewer.app" ] && rm -f "/Applications/JiveX DICOM CD Viewer.app"
if [[ "$?" -ne "0" ]]; then
    echo "Link not removed from /Applications"
else
    echo "Link removed from /Applications"
fi

# Delete package from pkgutil (list all: pkgutil --pkgs)
pkgutil --forget "org.$PRODUCT.$VERSION"
if [[ "$?" -ne "0" ]]; then
    echo "pkgutil not removed the artifact 'org.$PRODUCT.$VERSION'"
else
    echo "pkgutil removed the artifact 'org.$PRODUCT.$VERSION'"
fi

# Remove application
[ -d "/Library/$PRODUCT" ] && rm -rf "/Library/$PRODUCT"
if [[ "$?" -ne "0" ]]; then
    echo "Installation not removed from /Library/$PRODUCT"
else
    echo "Installation removed from /Library/$PRODUCT"
fi
