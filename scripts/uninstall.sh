#!/usr/bin/env bash

# Loesche alle Dateien / Verzeichnisse, die von der Installation gesetzt wurden
# > find $HOME -iname "*jivex*"
# =============================================================================

# non JiveX DICOM Viewer stuff
[ -d "$HOME/.jivex" ] && rm -rf $HOME/.jivex
[ -f "$HOME/.com.visustt.jivex.properties" ] && rm -f $HOME/.com.visustt.jivex.properties
[ -f "$HOME/Library/Preferences/com.visustt.jivex.plist" ] && rm -f $HOME/Library/Preferences/com.visustt.jivex.plist

# JiveX DICOM Viewer stuff
[ -d "$HOME/jivexdv" ] && rm -rf $HOME/jivexdv
[ -d "$HOME/Desktop/JiveX DICOM Viewer" ] && rm -rf $HOME/Desktop/JiveX\ DICOM\ Viewer
[ -f "$HOME/serverport" ] && rm -f $HOME/serverport
