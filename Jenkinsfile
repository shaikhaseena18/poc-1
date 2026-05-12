pipeline {
    agent any

    stages {

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build & Test') {
            steps {
                sh 'mvn clean package'
            }
        }

        stage('SonarQube Analysis') {
            steps {
                sh 'mvn sonar:sonar'
            }
        }

        stage('Dependency Check') {
            steps {
                sh 'mvn org.owasp:dependency-check-maven:check'
            }
        }

        stage('Docker Build') {
            steps {
                sh 'docker build -t devsecops-app:latest .'
            }
        }

        stage('Trivy Scan') {
            steps {
                sh 'bash trivy-scan.sh'
            }
        }

        stage('Deploy Container') {
            steps {
                sh '''
                  docker run -d --name devsecops-app \
                  -p 8080:8080 devsecops-app:latest
                '''
            }
        }
    }
}
