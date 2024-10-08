Terraform AWS EKS and RDS Setup
This project provides an automated infrastructure setup using Terraform to create an AWS environment including:

VPC (Virtual Private Cloud) with public and private subnets.
EKS (Elastic Kubernetes Service) for container orchestration.
RDS (Relational Database Service) for a managed PostgreSQL database.
IAM (Identity and Access Management) roles and policies for EKS and RDS security.
The Terraform configuration manages the lifecycle of the resources, ensuring a clean and efficient infrastructure deployment.

Project Structure
css
Copy code
├── modules/
│   ├── iam/
│   ├── vpc/
│   ├── eks/
│   ├── rds/
├── main.tf
├── variables.tf
├── outputs.tf
├── README.md
Modules
VPC Module: Defines the Virtual Private Cloud with public and private subnets, an internet gateway, and associated routing.
IAM Module: Creates necessary IAM roles and policies for the EKS cluster and worker nodes, and the RDS database.
EKS Module: Sets up the EKS cluster and node groups within the specified VPC and subnets.
RDS Module: Configures an RDS PostgreSQL database with subnet groups restricted to private subnets.
Prerequisites
Terraform: Install Terraform v0.12+.
AWS CLI: Set up AWS CLI and ensure your credentials are configured.
IAM Roles: Pre-created IAM roles can be skipped by setting the appropriate Terraform flag (see below).
How to Use
1. Clone the repository
bash
Copy code
git clone https://github.com/yourusername/terraform-eks-rds.git
cd terraform-eks-rds
2. Modify Variables
Customize variables in variables.tf or pass them via the CLI during deployment. Key variables include:

VPC configuration: CIDR block, subnet details.
EKS configuration: Cluster name, node group settings.
RDS configuration: Database instance size, username, password.
3. Skip IAM Resource Creation (Optional)
If your IAM roles already exist (for example, the eks-cluster-role, eks-node-group-role, etc.), you can skip the IAM module by passing the create_iam_resources=false flag:

bash
Copy code
terraform plan -var="create_iam_resources=false"
terraform apply -var="create_iam_resources=false"
This will skip the IAM resource creation while allowing the use of the existing roles and policies in your AWS account.

4. Initialize and Apply Terraform
Run the following commands to initialize the Terraform configuration and apply the plan.

bash
Copy code
terraform init
terraform plan
terraform apply
5. Destroying Resources
To clean up the created resources, run:

bash
Copy code
terraform destroy
Inputs
Name	Description	Type	Default	Required
vpc_cidr_block	CIDR block for the VPC	string	"10.0.0.0/16"	no
eks_cluster_name	Name of the EKS cluster	string	"my-eks-cluster"	no
eks_node_instance_type	Instance type for EKS worker nodes	string	"t3.medium"	no
db_name	Name of the RDS database	string	"status-page"	no
db_instance_class	Instance class for RDS	string	"db.t3.micro"	no
create_iam_resources	Controls whether to create IAM roles and policies	bool	true	no
Outputs
Name	Description
vpc_id	The ID of the created VPC
eks_cluster_name	Name of the EKS cluster
db_instance_address	Address of the RDS PostgreSQL instance
public_subnet_ids	List of public subnet IDs
private_subnet_ids	List of private subnet IDs
Best Practices
Environment Separation: Use separate Terraform workspaces or configurations for dev, staging, and production environments.
State Management: Store Terraform state remotely (e.g., in an S3 bucket) to avoid state conflicts in team environments.
Security Groups: Ensure that the security group configurations only allow necessary ingress/egress for enhanced security.
Troubleshooting
IAM Policy Issues: If IAM roles or policies already exist, use create_iam_resources=false to skip creating new roles.
Invalid Subnets for RDS: Ensure that RDS is attached to private subnets for security.
Access Denied Errors: Make sure that your AWS credentials have sufficient permissions to create the required resources.
