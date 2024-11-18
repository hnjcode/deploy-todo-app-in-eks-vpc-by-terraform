# Create AWS EKS MASTER Cluster
resource "aws_eks_cluster" "eks_cluster" {
  count = var.environment == "prod" ? 1 : 0
  name     = var.cluster_name
  role_arn = var.cluster_role_arn
  version = var.cluster_version

  vpc_config {
    subnet_ids = [var.public_subnet1_id, var.public_subnet2_id]
    endpoint_private_access = var.cluster_endpoint_private_access
    endpoint_public_access  = var.cluster_endpoint_public_access
    public_access_cidrs     = var.cluster_endpoint_public_access_cidrs    
  }

  kubernetes_network_config {
    service_ipv4_cidr = var.cluster_service_ipv4_cidr
  }
  
  # Enable EKS Cluster Control Plane Logging
  enabled_cluster_log_types = ["api", "audit", "authenticator", "controllerManager", "scheduler"]

  # Ensure that IAM Role permissions are created before and deleted after EKS Cluster handling.
  # Otherwise, EKS will not be able to properly delete EKS managed EC2 infrastructure such as Security Groups.
  depends_on = [
    var.role_policy_AmazonEKSClusterPolicy,
    var.role_policy_AmazonEKSVPCResourceController,
  ]
}


# EKS Cluster Outputs
output "cluster_id" {
  description = "The name/id of the EKS cluster."
  value       = var.environment == "prod" ? aws_eks_cluster.eks_cluster[0].id : null
}

output "cluster_arn" {
  description = "The Amazon Resource Name (ARN) of the cluster."
  value       = var.environment == "prod" ? aws_eks_cluster.eks_cluster[0].arn : null
}

output "cluster_certificate_authority_data" {
  description = "Nested attribute containing certificate-authority-data for your cluster. This is the base64 encoded certificate data required to communicate with your cluster."
  value       = var.environment == "prod" ? aws_eks_cluster.eks_cluster[0].certificate_authority[0].data : null
}

output "cluster_endpoint" {
  description = "The endpoint for your EKS Kubernetes API."
  value       = var.environment == "prod" ? aws_eks_cluster.eks_cluster[0].endpoint : null
}

output "cluster_version" {
  description = "The Kubernetes server version for the EKS cluster."
  value       = var.environment == "prod" ? aws_eks_cluster.eks_cluster[0].version : null
}
