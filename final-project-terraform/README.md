**Terraform AWS EKS and RDS Setup**

This project automates the deployment of a complete AWS infrastructure using Terraform. It sets up:

VPC (Virtual Private Cloud) with public and private subnets.
EKS (Elastic Kubernetes Service) for container orchestration.
RDS (Relational Database Service) for a managed PostgreSQL database.
IAM (Identity and Access Management) roles and policies for EKS and RDS security.

**Project Structure**
```bash
├── modules/
│   ├── iam/
│   ├── vpc/
│   ├── eks/
│   ├── rds/
├── main.tf
├── variables.tf
├── outputs.tf
├── README.md
```
**Modules**
VPC Module: Creates a VPC with public and private subnets, an internet gateway, and route tables.
IAM Module: Manages IAM roles and policies needed for EKS and RDS.
EKS Module: Configures an EKS cluster and node groups within the VPC.
RDS Module: Sets up an RDS PostgreSQL database with a subnet group restricted to private subnets.
