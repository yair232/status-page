provider "aws" {
  region = var.aws_region
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

# VPC Module
module "vpc" {
  source     = "./modules/vpc"
  cidr_block = var.cidr_block
}

# IAM Module
module "iam" {
  source = "./modules/iam"
}

# RDS Module
module "rds" {
  source                     = "./modules/rds"
  vpc_id                     = module.vpc.vpc_id
  cidr_block                 = var.cidr_block
  db_name                    = var.db_name
  db_instance_class          = var.db_instance_class
  allocated_storage          = var.allocated_storage
  db_username                = var.db_username
  db_password                = var.db_password
  eks_node_security_group_id = module.vpc.eks_node_sg_id
  private_subnet_ids         = module.vpc.private_subnet_ids
}

# EKS Module
module "eks" {
  source             = "./modules/eks"
  vpc_id             = module.vpc.vpc_id
  subnet_ids         = concat(module.vpc.public_subnet_ids, module.vpc.private_subnet_ids)
  security_group_ids = [module.vpc.eks_node_sg_id]
  eks_cluster_role_arn           = module.iam.eks_cluster_role_arn
  eks_node_group_role_arn        = module.iam.eks_node_group_role_arn

  eks_worker_node_policy_attachment = module.iam.eks_worker_node_policy_attachment
  eks_cni_policy_attachment         = module.iam.eks_cni_policy_attachment
  ecr_read_only_policy_attachment   = module.iam.ecr_read_only_policy_attachment
}

# Helm Installation for Load Balancer Controller
resource "helm_release" "aws_load_balancer_controller" {
  name       = "aws-load-balancer-controller"
  repository = "https://aws.github.io/eks-charts"
  chart      = "aws-load-balancer-controller"
  namespace  = "kube-system"

  set {
    name  = "clusterName"
    value = var.cluster_name
  }

  set {
    name  = "serviceAccount.create"
    value = "false"
  }

  set {
    name  = "serviceAccount.name"
    value = "aws-load-balancer-controller"
  }

  depends_on = [module.iam, module.eks]
}
