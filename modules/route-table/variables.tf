variable "environment" {
  description = "The environment to deploy (dev or prod)"
  type        = string
}

variable "vpc_id" {
  type = string
}

variable "igw_id" {
  type = string
}

variable "nat_gw_id" {
  type = string
}

variable "all_ip_cidr" {
  type = string
}

variable "public_subnet1_id" {
  type = string
}

variable "public_subnet2_id" {
  type = string
}

variable "private_subnet1_id" {
  type = string
}

variable "private_subnet2_id" {
  type = string
}