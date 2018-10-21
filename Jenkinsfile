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
        stash includes: 'target/*.jar', name: 'appArchive'
        // once there are unit test results:
        // junit 'target/*.xml' 
        script {
          appArchiveFilename = sh(script: 'cd target; ls *.jar', returnStdout: true).trim()
          // shorten Maven artifact name as much as possible and use as Mule app name
          appName = sh(script: './artifact-final-name.sh', returnStdout: true).trim().replaceAll('\\W', '')
        }
        echo "Packaged Mule app $appName as $appArchiveName"
      }
    }

    stage('Deploy to Stage 1 environment') {
      agent {
        docker {
          image 'integrational/anypoint-cli:3.0.0-cmd'
        }
      }
      environment {
        ENV                  = "${params.STAGE1_ENV}"
        APP_ARCHIVE_FILENAME = "$appArchiveFilename"
        APP_NAME             = "$appName"
      }
      steps {
        echo "Deploying Mule app $APP_ARCHIVE_FILENAME as $APP_NAME to $ENV"
        unstash 'appArchive'
        withCredentials([usernamePassword(credentialsId: 'ANYPOINT_USERNAME_PASSWORD', 
            usernameVariable: 'USR', 
            passwordVariable: 'PWD')]) {
          sh './deploy-app.sh $USR $PWD $ENV target/$APP_ARCHIVE_FILENAME $APP_NAME'
        }
      }
    }
  }
}