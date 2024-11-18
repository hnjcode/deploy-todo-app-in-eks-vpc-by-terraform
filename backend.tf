terraform {
  backend "s3" {
    bucket         = "hnj-tf-state"
    key            = "dev/eks-cluster/terraform.tfstate"
    region         = "us-west-1"
    dynamodb_table = "dev-ekscluster"
  }
}