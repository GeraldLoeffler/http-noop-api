pipeline {
  agent none
  parameters {
    string(name: 'STAGE1_ENV', defaultValue: 'Experiment', description: 'Name of Anypoint Platform environment for initial deployment, e.g., for integration testing.')
    string(name: 'STAGE2_ENV', defaultValue: 'Experiment', description: 'Name of Anypoint Platform environment for final deployment.')
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
          image 'integrational/anypoint-cli:3.0.0-cmd'
        }
      }
      environment {
        ANYPOINT_ENV = "${params.STAGE1_ENV}"
      }
      steps {
        unstash 'app'
        withCredentials([usernamePassword(credentialsId: 'ANYPOINT_USERNAME_PASSWORD', 
            usernameVariable: 'ANYPOINT_USERNAME', 
            passwordVariable: 'ANYPOINT_PASSWORD')]) {
          sh '''
            set +x

            export ANYPOINT_ENV # otherwise not picked-up by anypoint-cli

            cd target
            export APP=$(ls *.jar)
            echo Deploying Mule app $APP to $ANYPOINT_ENV

            #anypoint-cli api-mgr api list -o json
            #anypoint-cli exchange asset list -o json
            anypoint-cli runtime-mgr cloudhub-application deploy --runtime 4.1.4 --workers 2 --workerSize 0.1 --region us-east-1 --autoRestart true gerald-acli-1 $APP
          '''
        }
      }
    }
  }
}