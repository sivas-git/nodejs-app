pipeline {
    agent any
    environment {
        DOCKER_REGISTRY = 'siva3r' // Replace 
        DOCKER_IMAGE = 'nodejs-app'
        DOCKER_TAG = 'latest'
    }
    stages {
        stage('Checkout') {
            steps {
                echo 'Checking out code...'
                checkout scm
            }
        }
        stage('Build Docker Image') {
            steps {
                echo 'Building Docker image...'
                script {
                    docker.build("${DOCKER_REGISTRY}/${DOCKER_IMAGE}:${DOCKER_TAG}")
                }
            }
        }
        stage('Push Docker Image') {
            steps {
                echo 'Pushing Docker image to the registry...'
                script {
                    docker.withRegistry('https://hub.docker.com/repository/create?namespace=siva3r', 'docker-hub') {
                        docker.image("${DOCKER_REGISTRY}/${DOCKER_IMAGE}:${DOCKER_TAG}").push()
                    }
                }
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying application via SSH...'
                sshagent(['ssh-credentials-id']) {
                    sh '''
                    ssh root@0.0.0.0 "
                        docker pull siva3r/nodejs-app:latest &&
                        docker stop nodejs || true &&
                        docker rm nodejs || true &&
                        docker run -d --name nodejs r -p 80:80 siva3r/nodejs-app:latest
                    "
                    '''
                }
           }
       }
    }
    post {
        success {
            echo 'Pipeline completed successfully!'
        }
        failure {
            echo 'Pipeline failed!'
        }
    }
}
