pipeline {
    agent any

    environment {
        PATH = "/opt/homebrew/bin:/Applications/Docker.app/Contents/Resources/bin:/usr/bin:/bin:/usr/sbin:/sbin"
        IMAGE_NAME = "chaitanya010104/html-app"
        IMAGE_TAG  = "latest"
    }

    stages {

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $IMAGE_NAME:$IMAGE_TAG .'
            }
        }

        stage('DockerHub Login') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'dockerhub-creds',
                    usernameVariable: 'DOCKER_USER',
                    passwordVariable: 'DOCKER_PASS'
                )]) {
                    sh 'echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin'
                }
            }
        }

        stage('Push Image') {
            steps {
                sh 'docker push $IMAGE_NAME:$IMAGE_TAG'
            }
        }

        stage('Run Container') {
            steps {
                sh '''
                docker rm -f html-container || true
                docker run -d -p 9090:80 --name html-container $IMAGE_NAME:$IMAGE_TAG
                '''
            }
        }
        stage('Deployment'){
            steps {
                sh'''
                kubectl apply -f deployment.yaml
                kubectl apply -f service.yaml
                '''
                        }
        }
        stage('Deploy ingress'){
            steps {
                sh'''
                kubectl apply -f ingress.yaml
                '''
                        }
        }
    }
}
