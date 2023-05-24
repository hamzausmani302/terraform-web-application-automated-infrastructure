resource "aws_security_group" "security_g_ssh" {
  vpc_id      = aws_vpc.main.id
  name        = "security_g_ssh"
  description = "security group that allows ssh and bacalhau and all egress traffic"
  ingress{
    description= "SSH ACCESS"
    from_port=22
    to_port=22
    protocol="tcp"
    cidr_blocks= ["0.0.0.0/0" ]
  }

  ingress{
    description= "HTTP ACCESS"
    from_port=80
    to_port=80
    protocol="tcp"
    cidr_blocks= ["0.0.0.0/0" ]
    
  }

  
  egress{
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }  
}


resource "aws_security_group" "IIS_group" {
  vpc_id      = aws_vpc.main.id
  name        = "IIS_group"
  description = "allow rdp , http and https access to machine"
  ingress{
    description= "RDP ACCESS"
    from_port=3389
    to_port=3389
    protocol="tcp"
    cidr_blocks= ["0.0.0.0/0" ]
  }

  ingress{
    description= "HTTP ACCESS"
    from_port=80
    to_port=80
    protocol="tcp"
    cidr_blocks= ["0.0.0.0/0" ]
    ipv6_cidr_blocks = ["::/0"]
    
  }
  
  ingress{
    description= "HTTPS ACCESS"
    from_port=443
    to_port=443
    protocol="tcp"
    cidr_blocks= ["0.0.0.0/0" ]
    ipv6_cidr_blocks = ["::/0"]
  }
  
  
  
  egress{
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }  
}



resource "aws_security_group" "elb_http" {
  name        = "elb_http"
  description = "Allow HTTP traffic to instances through Elastic Load Balancer"
  vpc_id = aws_vpc.main.id
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
  tags = {
    Name = "Allow HTTP through ELB Security Group"
  }
}




resource "aws_security_group" "rds_sg" {
  name = "rds_sg"
  vpc_id = aws_vpc.main.id
  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    cidr_blocks = [aws_subnet.pubSubnet1.cidr_block , aws_subnet.priSubnet1.cidr_block , aws_subnet.priSubnet2.cidr_block  ]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}