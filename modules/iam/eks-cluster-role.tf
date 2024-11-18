# Create IAM Role
resource "aws_iam_role" "eks_cluster_role" {
  count = var.environment == "prod" ? 1 : 0
  name = "eks-cluster-role"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

# Associate IAM Policy to IAM Role
resource "aws_iam_role_policy_attachment" "eks_AmazonEKSClusterPolicy" {
  count = var.environment == "prod" ? 1 : 0
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks_cluster_role[0].name
}

resource "aws_iam_role_policy_attachment" "eks_AmazonEKSVPCResourceController" {
  count = var.environment == "prod" ? 1 : 0
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
  role       = aws_iam_role.eks_cluster_role[0].name
}

output "cluster_iam_role_name" {
  value       = var.environment == "prod" ? aws_iam_role.eks_cluster_role[0].name : null
}

output "cluster_iam_role_arn" {
  value       = var.environment == "prod" ? aws_iam_role.eks_cluster_role[0].arn : null
}

output "role_policy_AmazonEKSVPCResourceController" {
  value       = var.environment == "prod" ? aws_iam_role_policy_attachment.eks_AmazonEKSVPCResourceController[0].id : null
}

output "role_policy_AmazonEKSClusterPolicy" {
  value       = var.environment == "prod" ? aws_iam_role_policy_attachment.eks_AmazonEKSClusterPolicy[0].id : null
}