# jiveXDVViewer.app - JiveX DICOM Viewer (Java) starter

Java application to start the JiveX DICOM Viewer from the JVM runtime itself. It is a workaround
for [JDK-8173753](https://bugs.openjdk.org/browse/JDK-8173753) but offers some drawbacks:
- status bar of application is not the macOS bar
- header image with application logo gets compressed

## Bulding the application

The build logic requires an artifact, *appbundler-1.0ea.jar*, compiled from the following sources
[TheInfiniteKinde/appbundler](https://github.com/TheInfiniteKind/appbundler.git) via the Ant build
script provided.

To build this application run the following Gradle tasks:
> gradlew a-create.app
