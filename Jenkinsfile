pipeline {
    agent any
    environment {
        registry = "bar"
    }
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
        stage ("Docker Build & Push") {
            steps {
                script {
                CREATED_REPO = sh (
                    script: "aws ecr describe-repositories --query 'repositories[].[repositoryUri]' --output text",
                    returnStdout: true
                    ).trim()
                echo "URL of the newly created repository -->  ${CREATED_REPO}"
                } 
                sh ("sudo aws ecr get-login-password --region us-east-1 | sudo docker login --username AWS --password-stdin ${CREATED_REPO}")
                sh ("sudo docker build -t app-image .")
                sh ("sudo docker tag app-image:latest ${CREATED_REPO}:latest")
                sh ("sudo docker push ${CREATED_REPO}:latest")
            }   
        }

    }
}