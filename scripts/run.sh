#!/usr/bin/env bash

# Startet den installierten JiveX DICOM Viewer
# ============================================

# Global variables
START_DIR="$( pwd )"

# i) create Java classpath
ClassPath=""
for archive in $HOME/jivexdv/jar/**/*.jar; do
    ClassPath=$ClassPath$archive:
done
ClassPath=${ClassPath%?}

# ii) run application
cd $HOME/jivexdv
java -cp $ClassPath com.visustt.jiveX.client.jiveXViewer.JiveXViewer

# iii) get back to starting working directory
cd $START_DIR
