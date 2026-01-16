pipeline {
  agent any



  environment {
    IMAGE_NAME = "stm32-flasher:${env.BUILD_NUMBER}"
  }

  stages {

    stage('Checkout') {
      steps {
        checkout scm
      }
    }

    stage('Build Docker Image') {
      steps {
        sh '''
          docker build -t $IMAGE_NAME .
        '''
      }
    }

    stage('Flash STM32') {
      when {
        branch 'main'   // only flash from main branch
      }
      steps {
        sh '''
          docker run --rm \
            --privileged \
            $IMAGE_NAME
        '''
      }
    }
  }

  post {
    always {
      sh '''
        docker image rm -f $IMAGE_NAME || true
      '''
      cleanWs()
    }

    success {
      echo "✅ Flash successful"
    }

    failure {
      echo "❌ Flash failed"
    }
  }
}
