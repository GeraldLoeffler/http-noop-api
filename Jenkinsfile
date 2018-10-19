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
        sh 'mvn clean install'
      }
    }
  }
}