pipeline {
  agent {
    docker {
      image 'maven:3.5.4'
      args '-v /root/.m2:/root/.m2'
    }
  }

  stages {
    stage('Maven build, package, install') {
      steps {
        withCredentials([file(credentialsId: 'settings.xml', variable: 'MVN_SETTINGS_XML_PATH')]) {
          sh 'mvn clean install -s $MVN_SETTINGS_XML_PATH'
        }
      }
    }
    stage('Deploy') { 
      steps {
        sh './deploy.sh' 
      }
    }
  }
}