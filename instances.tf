resource "aws_instance" "ec2_machine" {
  # ami           = "ami-08333bccc35d71140" # us-west-2
  ami = "ami-008dc7c58d3db0798"
  instance_type = "t2.micro"
  subnet_id= aws_subnet.pubSubnet1.id
  

  vpc_security_group_ids = [ aws_security_group.bastion_security_group] //aws_security_group.security_g_ssh.id 
  key_name = aws_key_pair.deployer.key_name
  associate_public_ip_address = true
  
  tags={
    Name = "web-server"
  }
}


// AUTO SCALING GROUP


resource "aws_launch_template" "iisMachineTemplate" {
  name_prefix   = "IIS"
  image_id      = var.web_server_ami
  instance_type = "t2.micro"
  key_name = "web-server"
  vpc_security_group_ids = [aws_security_group.IIS_group.id]

  tags = {
    Name = "IIS-Machine-Template"
  }
}

resource "aws_autoscaling_group" "scaling_group" {
#   availability_zones = [data.aws_availability_zones.available.names[0] , data.aws_availability_zones.available.names[1]]
  vpc_zone_identifier = [aws_subnet.priSubnet1.id, aws_subnet.priSubnet2.id]
  desired_capacity   = 2
  max_size           = 3
  min_size           = 1
  
  
  launch_template {
    id      = aws_launch_template.iisMachineTemplate.id
    version = "$Latest"
  }
}