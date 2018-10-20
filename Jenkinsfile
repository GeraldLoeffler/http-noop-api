pipeline {
  agent none
  
  stages {
    stage('Maven build, package, install') {
      agent {
        docker {
          image 'maven:3.5.4'
          args '-v /root/.m2:/root/.m2'
        }
      }
      steps {
        sh 'mvn clean install'
        stash includes: 'target/*.jar', name: 'app'
      }
    }
    stage('Deploy') {
      agent {
        docker {
          image 'integrational/anypoint-cli:3.0.0'
        }
      }
      steps {
        unstash 'app'
        withCredentials([usernamePassword(credentialsId: 'ANYPOINT_USERNAME_PASSWORD', usernameVariable: 'ANYPOINT_USERNAME', passwordVariable: 'ANYPOINT_PASSWORD')]) {
          /* sh './deploy.sh $ANYPOINT_USERNAME $ANYPOINT_PASSWORD Staging *.jar' */
          sh '''
            set +x
            echo Unstashed Mule app to: $(ls target/*.jar)
            echo Deploying that Mule app
            anypoint-cli api-mgr api list -o json
          '''
        }
      }
    }
  }
}