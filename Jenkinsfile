node {

    checkout scm

    stage('Maven build') {
        // JDK, a Maven settings.xml and a Maven installation with that name must be defined globally in Jenkins
        withMaven(maven: 'maven-3.5.x') {
            sh 'mvn clean install -Dskip.maven.deploy=true -Dbuild.number=${BUILD_NUMBER}'
        }
     }
}
