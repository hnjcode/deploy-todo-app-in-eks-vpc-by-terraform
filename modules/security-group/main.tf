data "http" "my_ipv4" {
  url = "https://ipv4.icanhazip.com"
}

# Security Group for Bastion Host
resource "aws_security_group" "bastion_sg" {
  count = var.environment == "prod" ? 1 : 0
  name   = "bastion_sg"
  vpc_id = var.vpc_id

  # Ingress rule to allow SSH from your IP only
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${chomp(data.http.my_ipv4.response_body)}/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.all_ip_cidr] # Allow all outbound traffic
  }

  tags = {
    Name = "bastion_sg"
  }
}

output "bastion_host_sg_id" {
  value = var.environment == "prod" ? aws_security_group.bastion_sg[0].id : null
}

