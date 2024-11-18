# IAM Role for EKS Node Group 
resource "aws_iam_role" "eks_nodegroup_role" {
  count = var.environment == "prod" ? 1 : 0
  name = "eks-nodegroup-role"

  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
}

resource "aws_iam_role_policy_attachment" "eks_AmazonEKSWorkerNodePolicy" {
  count = var.environment == "prod" ? 1 : 0
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.eks_nodegroup_role[0].name
}

resource "aws_iam_role_policy_attachment" "eks_AmazonEKS_CNI_Policy" {
  count = var.environment == "prod" ? 1 : 0
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.eks_nodegroup_role[0].name
}

resource "aws_iam_role_policy_attachment" "eks_AmazonEC2ContainerRegistryReadOnly" {
  count = var.environment == "prod" ? 1 : 0
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.eks_nodegroup_role[0].name
}

output "nodegroup_iam_role_arn" {
  value       = var.environment == "prod" ? aws_iam_role.eks_nodegroup_role[0].arn : null
}

output "ng_role_policy_AmazonEKSWorkerNodePolicy" {
  value       = var.environment == "prod" ? aws_iam_role_policy_attachment.eks_AmazonEKSWorkerNodePolicy[0].id : null
}

output "ng_role_policy_AmazonEKS_CNI_Policy" {
  value       = var.environment == "prod" ? aws_iam_role_policy_attachment.eks_AmazonEKS_CNI_Policy[0].id : null
}

output "ng_role_policy_AmazonEC2ContainerRegistryReadOnly" {
  value       = var.environment == "prod" ? aws_iam_role_policy_attachment.eks_AmazonEC2ContainerRegistryReadOnly[0].id : null
}
