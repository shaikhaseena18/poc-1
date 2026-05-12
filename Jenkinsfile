pipeline {
    agent any

    environment {
        SONAR_TOKEN = credentials('sonar-token')
    }

    stages {

        stage('Build & Unit Tests') {
            steps {
                sh 'mvn clean test'
            }
        }

        stage('Package') {
            steps {
                sh 'mvn clean package'
            }
        }

        stage('SonarQube Analysis') {
    steps {
        sh '''
        mvn sonar:sonar \
        -Dsonar.projectKey=devsecops-app \
        -Dsonar.host.url=http://localhost:9000 \
        -Dsonar.login=$SONAR_TOKEN
        '''
    }
}

        stage('Docker Build') {
            steps {
                sh 'docker build -t devsecops-app:latest .'
            }
        }

        stage('Trivy Scan') {
    steps {
        sh 'trivy image --severity HIGH,CRITICAL --scanners vuln devsecops-app:latest'
    }
}
        stage('Deploy Container') {
            steps {
                sh '''
                docker rm -f devsecops-app || true
                docker run -d --name devsecops-app -p 8080:8080 devsecops-app:latest
                '''
            }
        }
    }
}
