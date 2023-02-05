package com.github.thahnen;

import java.io.File;
import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.net.URL;
import java.net.URLClassLoader;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Collections;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.Stream;


/**
 *  DVStart2: Internal starter for the JiveX DICOM Viewer main Java class (JiveXViewer)
 *
 *  @author thahnen
 */
public class DVStart2 {
    @SuppressWarnings({"deprecation", "java:S106", "java:S1874", "java:S3878"})
    public static void main(String[] args) throws JarArchivesException, JiveXViewerNotFound, JiveXViewerMainNotFound {
        // i) constants used inside main class
        final String className          = DVStart2.class.getSimpleName();
        final String appPostfix         = ".app";
        final String jarPostfix         = ".jar";
        final String starterClassName   = "com.visustt.jiveX.client.jiveXViewer.JiveXViewer";
        final String starterMethodName  = "main";


        // ii) get path to DVStart2 class, will be inside DVStart2.jar file inside app directory
        String path = DVStart2.class.getProtectionDomain().getCodeSource().getLocation().getPath();
        System.out.println("[" + className + "] Path of " + className + ".class: " + path);

        // iii) get path to directory containing JAR
        String pathToApp = path.substring(0, path.lastIndexOf(appPostfix));
        pathToApp = pathToApp.substring(0, pathToApp.lastIndexOf("/"));
        System.out.println("[" + className + "] Path of application: " + pathToApp);

        // iv) Patch system property as JavaAppLauncher always starts at "/"
        System.setProperty("user.dir", pathToApp);

        // v) get all JAR files inside directory excluding the ones in the app directory
        List<URL> jarArchives = new ArrayList<>(Collections.emptyList());
        try (Stream<Path> stream = Files.walk(Paths.get(pathToApp), 44801)) {
            List<String> jars = stream.map(String::valueOf)
                                        .filter(it -> !it.toLowerCase().contains(appPostfix))
                                        .filter(it -> it.toLowerCase().endsWith(jarPostfix))
                                        .sorted()
                                        .collect(Collectors.toList());

            for (String jar: jars) {
                jarArchives.add(new File(jar).toURI().toURL());
                System.out.println("[" + className + "] Jar archive found: " + jar);
            }
        } catch (IOException err) {
            throw new JarArchivesException("[" + className + "] No Jar archive(s) found, see exception: " + err);
        }

        // vi) extend classpath with all JAR archives found
        URLClassLoader classLoader = new URLClassLoader(jarArchives.toArray(new URL[0]),
                                                        ClassLoader.getSystemClassLoader());
        Thread.currentThread().setContextClassLoader(classLoader);

        // vii) load main class and try to start application
        try {
            Class<?> jiveXViewerClass = Class.forName(starterClassName, true, classLoader);
            Object jiveXViewer = jiveXViewerClass.newInstance();
            jiveXViewer.getClass()
                        .getMethod(starterMethodName, args.getClass())
                        .invoke(jiveXViewer, new Object[] {args});
        } catch (ClassNotFoundException | InstantiationException | IllegalAccessException err) {
            throw new JiveXViewerNotFound(
                "[" + className + "] Cannot load starter class '" + starterClassName + "', see exception: " + err
            );
        } catch (NoSuchMethodException | InvocationTargetException err) {
            throw new JiveXViewerMainNotFound(
                "[" + className + "] Cannot invoke method '" + starterMethodName + "', see exception: " + err
            );
        }
    }


    /** Exception thrown when reading all classpath artifacts (Jar archives) fails */
    static class JarArchivesException extends Exception {
        public JarArchivesException(String message) { super(message); }
    }


    /** Exception thrown when application main class ("JiveXViewer") cannot be loaded from classpath */
    static class JiveXViewerNotFound extends Exception {
        public JiveXViewerNotFound(String message) { super(message); }
    }


    /** Exception thrown when application main method ("JiveXViewer.main") cannot be called */
    static class JiveXViewerMainNotFound extends Exception {
        public JiveXViewerMainNotFound(String message) { super(message); }
    }
}
