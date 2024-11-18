# Terraform Settings Block
terraform {
  required_version = ">= 1.6.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.31"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.20"
    }
  }
  # Adding Backend as S3 for Remote State Storage
  backend "s3" {
    bucket         = "hnj-tf-state"
    key            = "dev/app1k8s/terraform.tfstate"
    region         = "us-west-1"
    dynamodb_table = "dev-app1k8s"
  }
}
