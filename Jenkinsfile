pipeline {
    agent any 
    
    stages{
        stage('Checkout'){
            steps {
                git url: 'https://github.com/sivas-git/nodejs-app.git', branch: 'main'
            }
        }
        stage('Build Docker Image'){
            steps {
                sh 'docker build -t siva3r/nodejs-app:latest' 
            }
        }
        stage('Login and Push Image'){
            steps {
                echo 'logging in to docker hub and pushing image..'
                withCredentials([usernamePassword(credentialsId:'dockerHub',passwordVariable:'dockerHubPassword', usernameVariable:'dockerHubUser')]) {
                    sh "docker login -u ${env.dockerHubUser} -p ${env.dockerHubPassword}"
                    sh "docker push siva3r/nodejs.app:latest"
                }
            }
        }
        stage('Deploy'){
            steps {
                sh 'docker-compose down && docker-compose up -d'
            }
        }
    }
}
