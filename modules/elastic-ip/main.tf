# Elastic IP for NAT Gateway
resource "aws_eip" "nat_eip" {
  count = var.environment == "prod" ? 1 : 0
  depends_on = [var.igw_id]
  tags = {
    Name = "nat_eip"
  }
}

output "nat_eip_id" {
  value = var.environment == "prod" ? aws_eip.nat_eip[0].id : null
}