# JiveX DICOM Viewer installer

Verwendet den
[KosalaHerath/macos-installer-builder](https://github.com/KosalaHerath/macos-installer-builder)
zum Bauen des nativen macOS-Installer.

## Problem mit dem Installer-Script

Das Bash-Script kann keine Produkte erfassen, die Leerzeichen im Namen haben, daher wird hier nur
die enstandene Datei umbenannt. Der "interne" Name im Installer muss daher ein anderer bleiben.

## Problembehandlung:

Wenn nach einer Installation im Ordner kein "JiveX DICOM Viewer.app" vorhanden ist, dann lag auf
dem System irgendwo diese App! D.h. der Installer hat die vorhandene Datei an einem anderen Ort
ersetzt - ergo vorher müssen alle Vorkommnisse davon gelöscht werden

- DVStart2/build -> da liegt die gebaute App
- prj-installer/build/macos-installer-builder -> darunter liegt die App gleich mehrfach
- am besten keine Installation irgendwo
