#!/usr/bin/env bash

# Loesche alle Dateien / Verzeichnisse, die von der Installation gesetzt wurden
# > find $HOME -iname "*jivex*"
# =============================================================================

# non JiveX DICOM Viewer stuff
rm -rf $HOME/.jivex
rm -f $HOME/.com.visustt.jivex.properties
rm -f $HOME/Library/Preferences/com.visustt.jivex.plist

# JiveX DICOM Viewer stuff
rm -rf $HOME/jivexdv
