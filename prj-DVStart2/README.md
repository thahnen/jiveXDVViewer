# DVStart2 - JiveX DICOM Viewer (Java) starter

Java application to start the JiveX DICOM Viewer from the JVM runtime itself. It is a workaround
for [JDK-8173753](https://bugs.openjdk.org/browse/JDK-8173753). This application will be called from *DVStart*, which
will apply changes from *DVStart.ini* to "JiveX DICOM Viewer.app" before running the main application. Necessary due to
the Java-on-macOS issue which does only show app icon and name in the menu bar when running an actual app and not just
an executable.

## Building the application

The build logic requires an artifact, *appbundler-1.0ea.jar*, compiled from the following sources
[TheInfiniteKind/appbundler](https://github.com/TheInfiniteKind/appbundler.git) via the Ant build
script provided.

To build the main application (JiveX DICOM Viewer) run the following Gradle task:
> gradlew create.app

To build the side application (JiveX DICOM CD Viewer) run the following Gradle task:
> gradlew create.app.prj-variante_light

## Providing the application

After running the Gradle task to build the application, copy it to JiveX DICOM (CD) Viewer installation "jar"
subdirectory. Test it by running either the "JiveX DICOM Viewer.app/Contents/MacOS/JavaAppLauncher" or the 
"JiveX DICOM CD Viewer.app/Contents/MacOS/JavaAppLauncher" executable from within a Terminal window depending on the
application created.
