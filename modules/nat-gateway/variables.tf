variable "environment" {
  description = "The environment to deploy (dev or prod)"
  type        = string
}

variable "nat_eip_id" {
  type = string
}

variable "public_subnet1_id" {
  type = string
}