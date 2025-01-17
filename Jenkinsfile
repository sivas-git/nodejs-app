pipeline {
    agent any
    environment {
        DOCKER_REGISTRY = 'siva3r' // Replace 
        DOCKER_IMAGE = 'nodejs-app'
        DOCKER_TAG = 'latest'
        REGISTRY_URL = 'docker.io'
    }
    stages {
        stage('Checkout') {
            steps {
                echo 'Checking out code...'
                git url:'https://github.com/sivas-git/nodejs-app', branch:'main'
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    echo 'Building Docker image: ${DOCKER_IMAGE}:${DOCKER_TAG}'
                    sh 'docker build -t ${DOCKER_REGISTRY}/${DOCKER_IMAGE}:${DOCKER_TAG} .'
                }
            }
        }
        stage('Push Docker Image') {
            steps {
                script {
                    echo "Logging in to Docker registry..."
                    sh "echo ${DOCKER_PASSWORD} | docker login -u ${DOCKER_USERNAME} --password-stdin ${REGISTRY_URL}"
                    
                    echo "Pushing Docker image to registry..."
                    sh "docker push ${REGISTRY_URL}/${DOCKER_IMAGE}:${DOCKER_TAG}"
                }
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying application via SSH...'
                /* sshagent(['ssh-id']) {
                    sh '''
                    ssh ubuntu@18.212.84.49 "
                        docker pull siva3r/nodejs-app:latest &&
                        docker stop nodejs || true &&
                        docker rm nodejs || true &&
                        docker run -d --name nodejs r -p 80:80 siva3r/nodejs-app:latest
                    "
                    '''
                }*/
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
