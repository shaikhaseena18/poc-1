pipeline {
    agent any

    environment {
        SONAR_TOKEN = credentials('sonar-token')
    }

    stages {

        stage('Checkout') {
            steps {
                git 'https://github.com/shaikhaseena18/poc-1.git'
            }
        }

        stage('Install Dependencies') {
            steps {
                sh 'pip3 install -r requirements.txt'
            }
        }

        stage('Unit Tests') {
            steps {
                sh 'pytest'
            }
        }

        stage('SonarQube Analysis') {
            steps {
                sh '''
                sonar-scanner \
                -Dsonar.projectKey=poc-1 \
                -Dsonar.sources=. \
                -Dsonar.host.url=http://52.66.208.22:9000 \
                -Dsonar.login=$SONAR_TOKEN
                '''
            }
        }

        stage('Docker Build') {
            steps {
                sh 'docker build -t poc-python-app .'
            }
        }

        stage('Trivy Scan') {
            steps {
                sh 'trivy image poc-python-app'
            }
        }

        stage('Deploy Container') {
            steps {
                sh '''
                docker rm -f poc-python-app || true
                docker run -d --name poc-python-app -p 8080:8080 poc-python-app
                '''
            }
        }
    }
}
