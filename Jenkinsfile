pipeline {
    agent any
    parameters {
        choice(name: 'ACTION', choices: ['apply', 'destroy'], description: 'Pick something')
    }
    stages {
        stage('Checkout') {
            steps {
            checkout([$class: 'GitSCM', branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/lnachmias/image-ecr-pipeline']]])            

          }
        }
        
        stage ("terraform init") {
            steps {
                sh ('terraform init') 
            }
        }
        
        stage ("terraform Action") {
            steps {
                echo "Terraform action is --> ${params.ACTION}"
                sh ("terraform ${params.ACTION} --auto-approve") 
           }
        }
        stage ("Catch Repository URL") {
            steps {
                environment {
                CREATED_REPO = sh(aws ecr describe-repositories --query "repositories[].[repositoryUri]" --output text)
                echo "Your Repo URL is --> ${CREATED_REPO}"
                }
            }   
        }
}