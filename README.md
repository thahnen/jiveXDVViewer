# JiveX DICOM Viewer: Tools

Tools rund um den (frei verfuegbaren) JiveX DICOM Viewer der VISUS Health IT GmbH.

## Projekte

Hier folgt eine Auflistung der Unterprojekte in diesem Repository.

### DVStart: Starter fuer den JiveX DICOM Viewer

Kleines Python-Tool, dass die *DVStart.ini*-Datei einliest und dementsprechend die
"JiveX DICOM Viewer.app" (DVStart2) anpasst, damit die Applikation anhand der Aenderungen an der
Ini-Datei immer korrekt startet.

Siehe die README.md-Datei im Projekt-Verzeichnis!

### DVStart2: Java-Starter fuer den JiveX DICOM Viewer

Kleines Java-Tool, dass den eigentlichen JiveX DICOM Viewer sartet. Wird benoetigt, damit die
Applikation im Dock korrekt angezeigt wird (Name, Icon, etc.). Wird von der *DVStart* Applikation
mit Daten aus der *DVStart.ini* gefuettert.

### Variante "light": JiveX DICOM CD Viewer

INFO: Hier kommt noch Text.

## Skripte

Die folgenden Skripte sind schnellere Implementationen zum Testen:

- scripts/run.sh
- scripts/install.sh
- scripts/uninstall.sh
