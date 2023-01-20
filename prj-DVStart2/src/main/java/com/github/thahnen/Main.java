/**
 *
 */
package com.github.thahnen;

import java.io.File;

import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLClassLoader;
import java.util.ArrayList;
import java.util.List;

public class Main {
    //
    private static final String pathInsideAppDirectory = "/JiveX%20DICOM%20Viewer.app/Contents/Java/DVStart2.jar";

    //
    public static void main(String[] args) throws ClassNotFoundException, InstantiationException,
            IllegalAccessException, NoSuchMethodException, InvocationTargetException, MalformedURLException {
        // 1) Extend classpath with the artifacts from $JIVEXDV/jar and $JIVEXDV/jar/localization folder
        String path = Main.class.getProtectionDomain().getCodeSource().getLocation().getPath();
        System.out.println("Main.class path: " + path);

        List<URL> urls = new ArrayList<>();

        if (path.endsWith(pathInsideAppDirectory)) {
            String jarDirectory = path.substring(0, path.lastIndexOf(pathInsideAppDirectory));
            for (File file: new File(jarDirectory).listFiles((dir, name) -> name.toLowerCase().endsWith(".jar"))) {
                System.out.println("Jar archive: " + file.getName());

                urls.add(file.toURI().toURL());
            }
        }

        URLClassLoader classLoader = new URLClassLoader(urls.toArray(new URL[0]), ClassLoader.getSystemClassLoader());
        Thread.currentThread().setContextClassLoader(classLoader);

        // 2) Load main class (com.visustt.jiveX.client.jiveXViewer.JiveXViewer) and start application
        Class jiveXViewerClass = Class.forName("com.visustt.jiveX.client.jiveXViewer.JiveXViewer",
                                       true,
                                               classLoader);
        Object jiveXViewer = jiveXViewerClass.newInstance();
        Method jiveXViewerMain = jiveXViewer.getClass().getMethod("main", args.getClass());
        jiveXViewerMain.invoke(jiveXViewer, new Object[] {args});
    }
}