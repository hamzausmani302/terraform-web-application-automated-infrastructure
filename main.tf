resource "aws_vpc" "main" { //this is the vpc
  cidr_block = "172.0.0.0/16"
  tags = {
    Name = "dev-vpc"
  }
}

resource "aws_subnet" "pubSubnet1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "172.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.available.names[0]


  tags = {
    Name = "subnet-1-public"
  }
}

resource "aws_subnet" "pubSubnet2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "172.0.2.0/24"
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.available.names[1]


  tags = {
    Name = "subnet-2-public"
  }
}

resource "aws_subnet" "priSubnet1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "172.0.3.0/24"
  availability_zone       = data.aws_availability_zones.available.names[0]
  # map_public_ip_on_launch = true
  

  tags = {
    Name = "subnet-1-private"
  }
}



resource "aws_subnet" "priSubnet2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "172.0.4.0/24"
  availability_zone       = data.aws_availability_zones.available.names[1]
  # map_public_ip_on_launch = true
  

  tags = {
    Name = "subnet-2-private"
  }
}

resource "aws_subnet" "priSubnet3" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "172.0.5.0/24"
  availability_zone       = data.aws_availability_zones.available.names[2]
  map_public_ip_on_launch = true
  

  tags = {
    Name = "subnet-3-private"
  }
}


resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "test-internet=gateway"
  }
}

resource "aws_route_table" "rtpublic" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }


  tags = {
    Name = "gateway-route-table-public"
  }
}

resource "aws_route_table" "rtprivate" {
  vpc_id = aws_vpc.main.id




  tags = {
    Name = "gateway-route-table-private"
  }
}

resource "aws_route_table" "rtprivateNAT" {
  vpc_id = aws_vpc.main.id

  route{
      cidr_block = "0.0.0.0/0"
      nat_gateway_id = aws_nat_gateway.nat_gateway.id
  }


  tags = {
    Name = "gateway-route-table-private"
  }
}




resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.pubSubnet1.id
  route_table_id = aws_route_table.rtpublic.id
}
resource "aws_route_table_association" "b" {
  subnet_id      = aws_subnet.pubSubnet2.id
  route_table_id = aws_route_table.rtpublic.id
}

resource "aws_route_table_association" "c" {
  subnet_id      = aws_subnet.priSubnet1.id
  route_table_id = aws_route_table.rtprivateNAT.id
}

resource "aws_route_table_association" "d" {
  subnet_id      = aws_subnet.priSubnet2.id
  route_table_id = aws_route_table.rtprivateNAT.id
}

resource "aws_route_table_association" "e" {
  subnet_id      = aws_subnet.priSubnet3.id
  route_table_id = aws_route_table.rtprivate.id
}





resource "tls_private_key" "pk" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = tls_private_key.pk.public_key_openssh
  provisioner "local-exec" { # Create "myKey.pem" to your computer!!
    command = "echo '${tls_private_key.pk.private_key_pem}' > ./myKey.pem"
  }
}
resource "local_file" "ssh_key" {
  filename = "${aws_key_pair.deployer.key_name}.pem"
  content = tls_private_key.pk.private_key_pem
}




