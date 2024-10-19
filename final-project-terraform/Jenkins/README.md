
***Instructions for Running the Jenkins Pipeline for Terraform and Docker***

**Step 1: Set Up Jenkins**

Install Jenkins on an EC2 instance or your server.
Install the required Jenkins plugins:
- Git
- Pipeline
- SSH Agent
- Docker Pipeline
- Credentials Binding

**Step 2: Configure Jenkins Credentials**

Navigate to Manage Jenkins → Manage Credentials.

**Add the following credentials:**
- GitHub SSH Key: Add SSH credentials with the ID github-ssh-key to access your GitHub repository.
- AWS Credentials: Add an AWS Access Key and Secret Key with the ID aws-credentials.
- Docker Hub Credentials: Add Docker Hub username and password with the ID dockerhub-credentials.

**Step 3: Set Up the Pipeline**

In Jenkins, create a new Pipeline project.
Under Pipeline settings, choose Pipeline from SCM.
Configure the Git repository to point to your GitHub repo with the Jenkinsfile.
Use the GitHub SSH Key credential (github-ssh-key) for authentication.

**Step 4: Run the CI Pipeline**

The Jenkins pipeline will automatically execute the following stages:
1. Clone Repository: Clones the code from GitHub.
2. Terraform Init & Apply: Initializes and applies the Terraform code to provision AWS infrastructure.
3. Build Docker Image: Builds the Docker image from the Dockerfile.
4. Test Docker Image: Runs and tests the Docker image.
5. Push Docker Image: Pushes the Docker image to Docker Hub.

**Step 5: Clean Up Resources (Optional)**

To destroy the infrastructure after use:
Create a new pipeline using the same repository.
Modify the pipeline to use the terraform destroy command to clean up AWS resources.
