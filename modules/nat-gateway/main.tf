# NAT Gateway
resource "aws_nat_gateway" "nat_gw" {
  count = var.environment == "prod" ? 1 : 0
  allocation_id = var.nat_eip_id
  subnet_id     = var.public_subnet1_id
  tags = {
    Name = "nat_gateway"
  }
}

output "nat_gw_id" {
  value = var.environment == "prod" ? aws_nat_gateway.nat_gw[0].id : null
}