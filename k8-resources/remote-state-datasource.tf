# Terraform Remote State Datasource - Remote Backend AWS S3
data "terraform_remote_state" "eks" {
  backend = "s3"
  config = {
    bucket = "hnj-tf-state"
    key    = "dev/eks-cluster/terraform.tfstate"
    region = "us-west-1"
  }
}