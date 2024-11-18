# Terraform AWS Provider Block
provider "aws" {
  region = "us-west-1"
}

data "aws_eks_cluster" "cluster" {
  name = data.terraform_remote_state.eks.outputs.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = data.terraform_remote_state.eks.outputs.cluster_id
}

# Terraform Kubernetes Provider
provider "kubernetes" {
  host                   = data.terraform_remote_state.eks.outputs.cluster_endpoint
  cluster_ca_certificate = base64decode(data.terraform_remote_state.eks.outputs.cluster_certificate_authority_data)
  token                  = data.aws_eks_cluster_auth.cluster.token
}

module "namespace" {
  source = "./modules/namespace"
  name   = "todo"
}

module "service" {
  source    = "./modules/service"
  namespace = module.namespace.namespace_name
}

module "deployment" {
  source        = "./modules/deployment"
  namespace     = module.namespace.namespace_name
  mysql_service = jsonencode(module.service.mysql_service)
  todo_service  = jsonencode(module.service.todo_service)
}