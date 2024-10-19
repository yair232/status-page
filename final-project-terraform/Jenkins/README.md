**Terraform Infrastructure & Jenkins CI/CD Pipeline**
This repository contains Terraform scripts for provisioning AWS infrastructure and a Jenkins pipeline for continuous integration (CI) and deployment (CD). The pipeline provisions AWS infrastructure using Terraform, builds Docker images, and pushes them to Docker Hub.

**Table of Contents**
Prerequisites
Jenkins Plugins
Jenkins CI/CD Pipeline Setup
Step 1: Jenkins Credentials Configuration
Step 2: Setting Up Jenkins Pipeline
Step 3: Running the CI Pipeline
Terraform Destroy Pipeline
Important Notes
Prerequisites
To run this pipeline, you need the following:

Jenkins Server: Running on an EC2 instance or another server.
GitHub Repository: This repo contains Terraform files and Jenkinsfile.
AWS Account: For provisioning infrastructure via Terraform.
Docker Hub Account: To store the Docker images created during the pipeline.
SSH Key Pair: GitHub access via SSH.
Ensure the following tools are installed on the Jenkins server:

Terraform
Docker
Git
**Jenkins Plugins**
The following Jenkins plugins are required to successfully run the CI/CD pipeline:

Git Plugin: Provides Git support for Jenkins jobs.

Install from Jenkins: Manage Jenkins → Manage Plugins → Available → Search for Git Plugin and install it.
Pipeline Plugin: Enables the creation of multi-step pipelines as code.

Already built into Jenkins, but ensure it’s installed: Manage Plugins → Installed → Check for Pipeline.
SSH Agent Plugin: Provides SSH credentials management and use in Jenkins pipelines.

Install from Jenkins: Manage Plugins → Available → Search for SSH Agent and install it.
Docker Pipeline Plugin: Allows Jenkins to interact with Docker containers and execute Docker commands.

Install from Jenkins: Manage Plugins → Available → Search for Docker Pipeline and install it.
Credentials Binding Plugin: Allows binding of credentials in Jenkins Pipelines.

Install from Jenkins: Manage Plugins → Available → Search for Credentials Binding and install it.

**Step 1: Jenkins Credentials Configuration**
Login to Jenkins → Go to Manage Jenkins → Manage Credentials.

Add the following credentials under the Global credentials domain:

GitHub SSH Key:

Type: SSH Username with Private Key
ID: github-ssh-key
Description: GitHub SSH key for repository access.
AWS Credentials:

Type: Username with password
ID: aws-credentials
Description: AWS Access Key ID and Secret Access Key.
Docker Hub Credentials:

Type: Username with password
ID: dockerhub-credentials
Description: Docker Hub account credentials.

**Step 2: Setting Up Jenkins Pipeline**
In Jenkins, go to Dashboard → New Item → Select Pipeline → Enter a name (e.g., Terraform-CI-Pipeline) → Click OK.
Under the Pipeline section:
Pipeline Script from SCM → Choose Git.
Enter your repository URL: git@github.com:<your-github-username>/status-page.git.
Select the GitHub SSH Key from the credentials dropdown.
Specify the branch (e.g., main).
Set the Jenkinsfile path (if different from root).

**Step 3: Running the CI Pipeline**
The following Jenkinsfile provisions AWS resources, builds and tests a Docker image, and pushes it to Docker Hub.

**Jenkinsfile for CI Pipeline**
```
pipeline {
    agent any
    environment {
        DOCKER_CREDENTIALS_ID = 'dockerhub-credentials'
        DOCKER_IMAGE_NAME = 'your-dockerhub-username/status-page'
        GITHUB_CREDENTIALS_ID = 'github-ssh-key'
    }
    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'main', url: 'git@github.com:<your-github-username>/status-page.git', credentialsId: "${GITHUB_CREDENTIALS_ID}"
            }
        }
        stage('Terraform Init & Apply') {
            environment {
                AWS_ACCESS_KEY_ID = credentials('aws-credentials')
                AWS_SECRET_ACCESS_KEY = credentials('aws-credentials')
            }
            steps {
                dir('final-project-terraform') {
                    sh 'terraform init && terraform plan -out=tfplan && terraform apply -auto-approve tfplan'
                }
            }
        }
        stage('Build Docker Image') {
            steps {
                sh 'docker build -t ${DOCKER_IMAGE_NAME}:latest .'
            }
        }
        stage('Test Docker Image') {
            steps {
                sh '''
                docker run --name test-container -d ${DOCKER_IMAGE_NAME}:latest
                docker exec test-container /bin/bash -c "echo \'Service is up\'"
                docker stop test-container && docker rm test-container
                '''
            }
        }
        stage('Push Docker Image to Docker Hub') {
            steps {
                withCredentials([usernamePassword(credentialsId: "${DOCKER_CREDENTIALS_ID}", usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh '''
                    echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
                    docker push ${DOCKER_IMAGE_NAME}:latest
                    docker logout
                    '''
                }
            }
        }
    }
    post {
        always {
            cleanWs()
            sh 'docker system prune -f'
        }
        success {
            echo 'Pipeline completed successfully!'
        }
        failure {
            echo 'Pipeline failed. Please check the logs.'
        }
    }
}
```
How to Run: Once the pipeline is configured, you can trigger the build by clicking Build Now in Jenkins. Monitor the progress via Console Output.
Terraform Destroy Pipeline
To clean up your AWS resources when no longer needed, configure a destroy pipeline. It will run the terraform destroy command.

**Jenkinsfile for Destroy Pipeline**
```
pipeline {
    agent any
    environment {
        AWS_CREDENTIALS_ID = 'aws-credentials'
    }
    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'main', url: 'git@github.com:<your-github-username>/status-page.git', credentialsId: 'github-ssh-key'
            }
        }
        stage('Terraform Destroy') {
            environment {
                AWS_ACCESS_KEY_ID = credentials("${AWS_CREDENTIALS_ID}")
                AWS_SECRET_ACCESS_KEY = credentials("${AWS_CREDENTIALS_ID}")
            }
            steps {
                dir('final-project-terraform') {
                    sh 'terraform init && terraform destroy -auto-approve'
                }
            }
        }
    }
    post {
        always {
            cleanWs()
        }
        success {
            echo 'Terraform destroy completed successfully!'
        }
        failure {
            echo 'Terraform destroy failed. Please check the logs.'
        }
    }
}
```
**Running the Destroy Pipeline**
Set up a new pipeline in Jenkins (similar to the CI pipeline) and point it to this Jenkinsfile.
This pipeline will destroy all the AWS resources created by the CI pipeline.

**Important Notes**
Security: Ensure all sensitive credentials (AWS keys, GitHub SSH keys, Docker Hub credentials) are securely stored in Jenkins and not hardcoded in the pipeline.
Scaling: This pipeline can be expanded to include more robust testing, security checks, and automated deployment to production environments.

**Conclusion**
This pipeline setup provides a comprehensive CI/CD workflow with Terraform and Docker for building, testing, and managing infrastructure and applications in a secure and automated way.
