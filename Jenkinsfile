pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Install') {
            steps {
                bat 'echo No dependencies required'
            }
        }

        stage('Test') {
            steps {
                bat 'node tests\\test_app.js'
            }
        }

        stage('Build') {
            steps {
                bat 'echo Build successful - static HTML/CSS/JS project'
            }
        }
    }

    post {
        success {
            echo 'Jenkins pipeline completed successfully!'
        }

        failure {
            echo 'Jenkins pipeline failed!'
        }
    }
}
