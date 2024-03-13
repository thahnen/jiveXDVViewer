# JiveX DICOM Viewer: Tools

Tools rund um den (frei verfuegbaren) JiveX DICOM Viewer der VISUS Health IT GmbH. Die Applikation
funktioniert mit Ausnahme der Bibliotheken, die auf nativen Windows DLLs beruhen, einwandfrei.
Fuer die DLLs (bspw. PDF-Bibliothek) muss noch eine Alternative gefunden werden, bei von der VISUS
Health IT GmbH gepatchten Bibliotheken (bspw. Kakadu) ist dies allerdings nicht moeglich.

## Projekte

Hier folgt eine Auflistung der Unterprojekte in diesem Repository.

### DVStart2: Java-Starter fuer den JiveX DICOM Viewer

Kleines Java-Tool, das den eigentlichen JiveX DICOM Viewer sartet. Wird benoetigt, damit die
Applikation im Dock korrekt angezeigt wird (Name, Icon, etc.). Ausserdem wird sichergestellt, dass
die Dokumentation korrekt geladen werden kann.

Siehe die README.md-Datei im Projekt-Verzeichnis!

### Variante "light": JiveX DICOM CD Viewer

Variante des JiveX DICOM Viewer, die fuer die Patienten-CD verwendet wird.

### Installer fuer den JiveX DICOM Viewer

Erstellt einen Installer fuer macOS, der es erlaubt, den JiveX DICOM Viewer wie jede andere
Application zu installieren.

Siehe die README.md-Datei im Projekt-Verzeichnis!

## Skripte

Die folgenden Skripte sind schnellere Implementationen zum Testen:

- scripts/run.sh
- scripts/install.sh
- scripts/uninstall.sh
