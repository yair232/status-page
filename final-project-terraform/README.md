# AWS EKS Infrastructure with Terraform

This terraform project sets up an AWS infrastructure with a VPC, subnets, an Internet Gateway, a Load Balancer, and an EKS cluster.
Estimate time - 5min

## Directory Structure
- `vpc/` - Contains VPC, subnets, and Internet Gateway configurations.
- 'rds/' - Contains RDS Database configuration.
- `eks/` - Contains EKS cluster configuration.
- `load_balancer/` - Contains Load Balancer configuration.
- `main.tf` - Entry point for the Terraform configuration.
- `variables.tf` - Variable definitions.
- `outputs.tf` - Output values from the Terraform configuration.
