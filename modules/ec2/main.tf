# Bastion Host in Public Subnet 1
resource "aws_instance" "bastion_host" {
  count = var.environment == "prod" ? 1 : 0
  ami                    = var.ami
  instance_type          = var.instance_type
  subnet_id              = var.public_subnet1_id
  key_name               = "vpc-bastion-key"
  vpc_security_group_ids = [var.bastion_host_sg_id] # Attach Security Group here
  tags = {
    Name = "bastion_host"
  }
}

output "bastion_host_ip" {
  value = var.environment == "prod" ? aws_instance.bastion_host[0].public_ip : null
}

output "bastion_host_pvt_ip" {
  value = var.environment == "prod" ? aws_instance.bastion_host[0].private_ip : null
}