variable "environment" {
  description = "The environment to deploy (dev or prod)"
  type        = string
}

variable "vpc_id" {
  type = string
}

variable "bastion_host_pvt_ip" {
  type = string
}

variable "all_ip_cidr" {
  type = string
}