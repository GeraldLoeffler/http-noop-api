pipeline {
  agent {
    docker {
      image 'maven:3.5.4'
      args '-v /root/.m2:/root/.m2 -v $MVN_SETTINGS_XML_PATH:/root/settings.xml'
    }
  }

  stages {
    stage('Maven build, package, install') {
      steps {
        sh 'mvn clean install -s /root/settings.xml'
      }
    }
    stage('Deploy') { 
      steps {
        sh './deploy.sh' 
      }
    }
  }
}