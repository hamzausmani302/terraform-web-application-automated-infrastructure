resource "aws_db_subnet_group" "db_subnet_group" {
  name        = "my-db-subnet-group"
  description = "My DB subnet group"
  subnet_ids  = [aws_subnet.priSubnet3.id , aws_subnet.priSubnet4.id]
}
resource "aws_db_instance" "myinstance" {
  engine               = var.db_engine
  identifier           = var.identifier
  allocated_storage    =  20
  engine_version       = "5.7"
  instance_class       = var.db_instance_type
  username             = var.db_username
  password             = var.db_password
  parameter_group_name = "default.mysql5.7"
  vpc_security_group_ids = ["${aws_security_group.rds_sg.id}"]
  skip_final_snapshot  = true
  db_subnet_group_name = aws_db_subnet_group.db_subnet_group.name
}