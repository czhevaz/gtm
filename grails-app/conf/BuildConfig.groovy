grails.servlet.version = "2.5" // Change depending on target container compliance (2.5 or 3.0)
grails.project.class.dir = "target/classes"
grails.project.test.class.dir = "target/test-classes"
grails.project.test.reports.dir = "target/test-reports"
grails.project.target.level = 1.6
grails.project.source.level = 1.6
//grails.project.war.file = "target/${appName}-${appVersion}.war"

// uncomment (and adjust settings) to fork the JVM to isolate classpaths
//grails.project.fork = [
//   run: [maxMemory:1024, minMemory:64, debug:false, maxPerm:256]
//]

grails.project.dependency.resolution = {
    // inherit Grails' default dependencies
    inherits("global") {
        // specify dependency exclusions here; for example, uncomment this to disable ehcache:
        // excludes 'ehcache'
    }
    log "error" // log level of Ivy resolver, either 'error', 'warn', 'info', 'debug' or 'verbose'
    checksums true // Whether to verify checksums on resolve
    legacyResolve false // whether to do a secondary resolve on plugin installation, not advised and here for backwards compatibility

    repositories {
        inherits true // Whether to inherit repository definitions from plugins

        mavenRepo "http://repo.grails.org/grails/plugins"
        mavenRepo "http://repo1.maven.org/maven2"
        mavenRepo "https://github.com/slorber/gcm-server-repository/raw/master/releases/"
        mavenRepo "https://oss.sonatype.org/content/repositories/snapshots/"
        mavenRepo "https://github.com/basejump/grails-executor"
        
    }

    dependencies {
        // specify dependencies here under either 'build', 'compile', 'runtime', 'test' or 'provided' scopes e.g.

        //runtime 'postgresql:postgresql-9.4-1206-jdbc41'
        compile 'joda-time:joda-time:2.4'
        compile 'joda-time:joda-time-hibernate-1.3'
        compile 'org.usb4java:usb4java-1.2.0'
        compile 'org.scream3r:jssc-2.8.0'
        compile 'org.usb4java:usb4java-javax:1.2.0'
    }

    plugins {
        runtime ":hibernate:$grailsVersion"
        runtime ":jquery:1.8.3"
        runtime ":jquery-ui:1.8.24"
        runtime ":resources:1.2"

        build ":tomcat:$grailsVersion"

        runtime ":database-migration:1.3.2"

        compile ':cache:1.0.1'

        compile ':font-awesome-resources:3.2.1.2'
        compile ':cache:1.0.1'

        compile "org.grails.plugins:kickstart-with-bootstrap:0.9.9"
       // compile ":spring-security-core:1.2.7.3"
        compile ":authentication:2.0.1"
        compile "org.grails.plugins:easyui:1.5"
        compile ":quartz2:2.1.6.2"
        compile ":mail:1.0.1"
        compile ":jasper:1.10.0"
        runtime ":executor:0.3"


    }
}
