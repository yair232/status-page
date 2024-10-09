variable "cidr_block" {
  description = "CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

output "eks_node_sg_id" {
  description = "The security group ID for the EKS worker nodes."
  value       = aws_security_group.eks_node_sg.id
}
