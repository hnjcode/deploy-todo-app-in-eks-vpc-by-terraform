variable "Region_US_West_1_NCalifornia" {
  default = "us-west-1"
}

variable "environment" {
  description = "The environment to deploy (dev or prod)"
  type        = string
}

variable "vpc_cidr_block_map" {
  type = map(string)
  default = {
    "vpc"             = "10.0.0.0/24"   # (256 IPs will be allocated for the VPC)
    "public_subnet1"  = "10.0.0.0/26"   # (64 IPs available in public_subnet1)
    "public_subnet2"  = "10.0.0.64/26"  # (64 IPs available in public_subnet2)
    "private_subnet1" = "10.0.0.128/26" # (64 IPs available in private_subnet1)
    "private_subnet2" = "10.0.0.192/26" # (64 IPs available in private_subnet2)
    "all_ip"          = "0.0.0.0/0"
  }
}

variable "Amazon_linux_AMI_US_WEST_1_NCalifornia" {
  default = "ami-09b2477d43bc5d0ac"
}

variable "dev_AMI" {
  description = "pre installed from Amazon_linux_AMI_US_WEST_1_NCalifornia"
  default     = "ami-0d4c1e0e961c3e2a1"
}

variable "T2_Micro" {
  default = "t2.micro"
}

variable "availability_zone_1" {
  default = "us-west-1a"
}

variable "availability_zone_2" {
  default = "us-west-1c"
}