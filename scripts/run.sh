#!/usr/bin/env bash

# Startet den installierten JiveX DICOM Viewer
# ============================================

# i) create Java classpath
ALL=""
for f in $HOME/jivexdv/jar/**/*.jar; do
    ALL=$ALL$f:
done
ALL=${ALL%?}

# ii) run application
java -cp $ALL com.visustt.jiveX.client.jiveXViewer.JiveXViewer
