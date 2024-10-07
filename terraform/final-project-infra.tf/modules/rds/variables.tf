variable "vpc_id" {
  description = "The ID of the VPC where RDS will be deployed"
  type        = string
}

variable "cidr_block" {
  description = "CIDR block for security group ingress rules"
  type        = string
}

variable "eks_node_security_group_id" {
  description = "The security group ID of the EKS nodes to allow DB access"
  type        = string
}

variable "db_name" {
  description = "Name of the RDS database"
  type        = string
}

variable "allocated_storage" {
  description = "Allocated storage for the RDS database"
  type        = number
}

variable "db_instance_class" {
  description = "Instance class for the RDS database"
  type        = string
}

variable "db_username" {
  description = "Username for the RDS instance"
  type        = string
}

variable "db_password" {
  description = "Password for the RDS instance"
  type        = string
}