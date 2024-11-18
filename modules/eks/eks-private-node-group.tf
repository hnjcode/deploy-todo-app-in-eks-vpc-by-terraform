# Create AWS EKS Worker Node Group - Private
resource "aws_eks_node_group" "eks_ng_private" {
  count = var.environment == "prod" ? 1 : 0
  cluster_name    = aws_eks_cluster.eks_cluster[0].name
  node_group_name = "eks-private-nodegroup"
  node_role_arn   = var.nodegroup_iam_role_arn
  subnet_ids      = [var.private_subnet1_id, var.private_subnet2_id]
  #version = var.cluster_version #(Optional: Defaults to EKS Cluster Kubernetes version)    
  
  ami_type = "AL2_x86_64"  
  capacity_type = "ON_DEMAND"
  disk_size = 20
  instance_types = ["t3.medium"]
  
  
  remote_access {
    ec2_ssh_key = "eks-terraform-key"    
  }

  scaling_config {
    desired_size = 1
    min_size     = 1    
    max_size     = 2
  }

  # Desired max percentage of unavailable worker nodes during node group update.
  update_config {
    max_unavailable = 1
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  depends_on = [
    var.ng_role_policy_AmazonEKSWorkerNodePolicy,
    var.ng_role_policy_AmazonEKS_CNI_Policy,
    var.ng_role_policy_AmazonEC2ContainerRegistryReadOnly,
  ]

  tags = {
    Name = "Private-Node-Group"
  }
}

