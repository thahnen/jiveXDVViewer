/** 1) Import Ant script */
ant.importBuild("$projectDir/build.xml")


/** 2) Gradle plugins (Java) */
plugins { id("java") }


/** 3) Project settings */
group = project.extra["software.group"] as String
version = project.extra["software.version"] as String


/** 4) Configure Gradle "jar" task */
tasks.jar {
    archiveFileName.set("${project.extra["software.name"]}.jar")
    manifest {
        attributes["Main-Class"] = project.ext["software.class"]
    }
}


/** 5) Configure Ant targets */
tasks.getByName("create.app") { dependsOn(tasks.jar) }
tasks.getByName("create.app.prj-variante_light") { dependsOn(tasks.jar) }
