# # Existing IAM Role for EKS Cluster - When Running this terraform at the first time uncomment this file.
# resource "aws_iam_role" "eks_cluster_role" {

#   name = "eks-cluster-role"

#   assume_role_policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Action = "sts:AssumeRole"
#         Principal = {
#           Service = "eks.amazonaws.com"
#         }
#         Effect = "Allow"
#         Sid    = ""
#       },
#     ]
#   })

#   tags = {
#     Name = "Y-R-EKS-Cluster-Role"
#   }
# }

# resource "aws_iam_role_policy_attachment" "eks_cluster_policy" {
#   role       = aws_iam_role.eks_cluster_role.name
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
# }

# Existing IAM Role for Node Group (EC2 instances)
# resource "aws_iam_role" "eks_node_group_role" {
#   name = "eks-node-group-role"

#   assume_role_policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Action = "sts:AssumeRole"
#         Principal = {
#           Service = "ec2.amazonaws.com"
#         }
#         Effect = "Allow"
#         Sid    = ""
#       },
#     ]
#   })

#   tags = {
#     Name = "Y-R-EKS-Node-Group-Role"
#   }
# }

# resource "aws_iam_role_policy_attachment" "eks_worker_node_policy" {
#   role       = aws_iam_role.eks_node_group_role.name
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
# }

# resource "aws_iam_role_policy_attachment" "eks_cni_policy" {
#   role       = aws_iam_role.eks_node_group_role.name
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
# }

# resource "aws_iam_role_policy_attachment" "ecr_read_only" {
#   role       = aws_iam_role.eks_node_group_role.name
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
# }

# ELB Management Policy
# resource "aws_iam_policy" "elb_policy" {
#   name        = "ELBManagementPolicy"
#   description = "IAM policy for managing Elastic Load Balancer"

#   policy = jsonencode({
#     Version = "2012-10-17",
#     Statement = [
#       {
#         Effect = "Allow",
#         Action = [
#           "elasticloadbalancing:*",
#           "ec2:DetachNetworkInterface",
#           "ec2:DescribeNetworkInterfaces",
#           "ec2:DeleteNetworkInterface",
#         ],
#         Resource = "*"
#       }
#     ]
#   })
# }

# # IAM Role for ELB Management
# resource "aws_iam_role" "elb_role" {
#   name               = "ELBManagementRole"
#   assume_role_policy = jsonencode({
#     Version = "2012-10-17",
#     Statement = [
#       {
#         Action = "sts:AssumeRole",
#         Principal = {
#           Service = "ec2.amazonaws.com"
#         },
#         Effect = "Allow",
#         Sid    = ""
#       }
#     ]
#   })
# }

# # Attach ELB Management Policy to Role
# resource "aws_iam_role_policy_attachment" "elb_attachment" {
#   policy_arn = aws_iam_policy.elb_policy.arn
#   role       = aws_iam_role.elb_role.name
# }
