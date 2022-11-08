pipeline {
    agent any
    stages {
        stage('Terraform Init') {
            steps {
                sh 'terraform -v'
                sh 'docker --version'
                sh 'cd Terraform/'
                sh 'terraform init'
            }
        }
        stage('Terraform Apply') {
            steps {
                sh 'terraform apply'
            }
        }
    }
}