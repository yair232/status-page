provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source = "./modules/vpc"
}

module "IAM" {
  source = "./modules/iam"
}

module "rds" {
  source                   = "./modules/rds"
  vpc_id                   = module.vpc.vpc_id
  eks_node_security_group_id = [
  aws_security_group.eks_node_sg.id
  ]
  db_name                  = "status_page"
  db_instance_class        = "db.t3.micro"
  allocated_storage        = 20
  db_username              = "admin"
  db_password              = "yourpassword"
  cidr_block               = "10.0.0.0/16"
}

module "load_balancer" {
  source      = "./modules/load_balancer"
  vpc_id      = module.vpc.vpc_id
  subnet_ids  = module.vpc.public_subnet_ids
}

module "eks" {
  source              = "./modules/eks"
  vpc_id              = module.vpc.vpc_id
  subnet_ids          = concat(module.vpc.public_subnet_ids, module.vpc.private_subnet_ids)
  security_group_ids  = [module.vpc.app_security_group_id]
}
