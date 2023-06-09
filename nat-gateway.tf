resource "aws_eip" "nat_gateway" {
  vpc = true
}


resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.nat_gateway.id
  subnet_id = aws_subnet.pubSubnet2.id
  tags = {
    "Name" = "PublicNATGateway"
  }
}