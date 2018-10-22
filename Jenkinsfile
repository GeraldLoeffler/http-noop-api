//
// requires:
// Jenkins' "recommended plugins"
// Maven settings.xml required by Maven build added to Jenkins as secret file with that name
//
pipeline {
  agent none
  parameters {
    string(name: 'APP_PREFIX', defaultValue: 'gl',         description: 'To be prepended to Mule app name.')
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
          // shorten Maven artifact name as much as possible and use as Mule app name
          artifactName       = sh(script: './artifact-final-name.sh', returnStdout: true).trim()
          appName            = env.APP_PREFIX + artifactName.replaceAll('\\W', '')
          appArchiveFilename = sh(script: 'cd target; ls *.jar', returnStdout: true).trim()
        }
        echo "Packaged Mule app ${appName} as ${appArchiveFilename}"
      }
    }

    stage('Deploy to Stage 1 environment') {
      agent {
        docker {
          image 'integrational/anypoint-cli:3.0.0-cmd'
        }
      }
      environment {
        ANY                  = credentials('ANYPOINT_USERNAME_PASSWORD')
        ANY_ENV              = "${params.STAGE1_ENV}"
        APP_ARCHIVE_FILENAME = "${appArchiveFilename}"
        APP_NAME             = "${appName}"
      }
      steps {
        echo "Deploying Mule app ${env.APP_ARCHIVE_FILENAME} as ${env.APP_NAME} to ${env.ANY_ENV}"
        unstash 'appArchive'
        sh './deploy-app.sh $ANY_USR $ANY_PSW $ANY_ENV $APP_ARCHIVE_FILENAME $APP_NAME'
      }
    }
  }
}