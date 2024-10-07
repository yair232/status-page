output "cluster_name" {
  value = aws_eks_cluster.this.name
}

output "app_security_group_id" {
  value = aws_security_group.app_sg.id
}
