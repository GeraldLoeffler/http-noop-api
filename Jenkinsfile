pipeline {
  agent {
    docker {
      image 'maven:3.5.4'
    }
  }

  stages {
    stage('Maven build') {
      steps {
        sh 'mvn clean install'
      }
    }
  }
}