#!/usr/bin/env bash

# Loesche alle Dateien / Verzeichnisse, die von der Installation gesetzt wurden
# > find $HOME -iname "*jivex*"
# > find $HOME -iname "*visus*"
# > find $HOME -iname "*DVStart*"
# =============================================================================

# non JiveX DICOM CD Viewer stuff
[ -d "$HOME/.jivex" ] && rm -rf $HOME/.jivex
[ -f "$HOME/.com.visustt.jivex.properties" ] && rm -f $HOME/.com.visustt.jivex.properties
[ -f "$HOME/Library/Preferences/com.visustt.jivex.plist" ] && rm -f $HOME/Library/Preferences/com.visustt.jivex.plist

# JiveX DICOM CD Viewer stuff
[ -d "$HOME/jivexdvlight" ] && rm -rf $HOME/jivexdvlight
[ -d "$HOME/Desktop/JiveX DICOM CD Viewer" ] && rm -rf $HOME/Desktop/JiveX\ DICOM\ CD\ Viewer
[ -f "$HOME/serverport" ] && rm -f $HOME/serverport

# DVStart / DVStart2 stuff
[ -f "$HOME/Library/Preferences/com.github.thahnen.DVStart.plist" ] && rm -f $HOME/Library/Preferences/com.github.thahnen.DVStart.plist
[ -f "$HOME/Library/Preferences/com.github.thahnen.DVStart2.plist" ] && rm -f $HOME/Library/Preferences/com.github.thahnen.DVStart2.plist
[ -f "$HOME/Library/Preferences/com.github.thahnen.jiveXDVViewer.plist" ] && rm -f $HOME/Library/Preferences/com.github.thahnen.jiveXDVViewer.plist
[ -d "$HOME/Library/Saved Application State/DVStart.savedState" ] && rm -rf $HOME/Library/Saved\ Application\ State/DVStart.savedState
[ -d "$HOME/Library/Saved Application State/com.github.thahnen.DVStart.savedState" ] && rm -rf $HOME/Library/Saved\ Application\ State/com.github.thahnen.DVStart.savedState
[ -d "$HOME/Library/Saved Application State/com.github.thahnen.DVStart2.savedState" ] && rm -rf $HOME/Library/Saved\ Application\ State/com.github.thahnen.DVStart2.savedState
[ -d "$HOME/Library/Saved Application State/com.github.thahnen.jiveXDVViewer.savedState" ] && rm -rf $HOME/Library/Saved\ Application\ State/com.github.thahnen.jiveXDVViewer.savedState
