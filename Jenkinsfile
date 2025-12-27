pipeline{
    agent any
    stages{
        stage('Checkout'){
            steps{
                git 'https://github.com/Chaithanyababu04/work-scheduler'
            }
        }
        stage('Build'){
            steps{
                sh 'docker build -t html-app:latest .'
            }
        }
        stage('run container'){
            steps{
                sh '''
                docker rm -f html-container || true
                docker run -d -p 8080:80 --name html-container html-app:latest
                '''
            }
        }
        
    }
}