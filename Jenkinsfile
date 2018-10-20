pipeline {
  agent none
  environment {
    STAGE1_ENV = 'Experiment'
    STAGE2_ENV = 'Experiment'
  }
  
  stages {
    stage('Maven package') {
      agent {
        docker {
          image 'maven:3.5.4'
          args '-v /root/.m2:/root/.m2'
        }
      }
      steps {
        sh 'mvn clean package'
        // only after integration tests succeed:
        // archiveArtifacts artifacts: 'target/*.jar', fingerprint: true
        stash includes: 'target/*.jar', name: 'app'
        // once there are unit test results:
        // junit 'target/*.xml' 
      }
    }
    stage('Deploy to Stage 1 environment') {
      agent {
        docker {
          image 'integrational/anypoint-cli:3.0.0'
        }
      }
      steps {
        unstash 'app'
        withCredentials([usernamePassword(credentialsId: 'ANYPOINT_USERNAME_PASSWORD', 
          usernameVariable: 'ANYPOINT_USERNAME', 
          passwordVariable: 'ANYPOINT_PASSWORD')]) {
          sh '''
            set +x

            export ANYPOINT_ENV=Experiment

            cd target
            export APP=$(ls *.jar)
            echo Deploying Mule app $APP to $ANYPOINT_ENV

            anypoint-cli api-mgr api list -o json
            anypoint-cli exchange asset list -o json
          '''
        }
      }
    }
  }
}