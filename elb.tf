resource "aws_lb" "iis_lb" {
  name               = "learn-asg-IIS-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.elb_http.id]
  subnets            = [aws_subnet.pubSubnet1.id , aws_subnet.pubSubnet2.id]
}

resource "aws_lb_listener" "elb_listener" {
  load_balancer_arn = aws_lb.iis_lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.iis_target_group.arn
  }
}

 resource "aws_lb_target_group" "iis_target_group" {
   name     = "Target-group-IIS"
   port     = 80
   protocol = "HTTP"
   vpc_id   = aws_vpc.main.id
 }

resource "aws_autoscaling_attachment" "terramino" {
  autoscaling_group_name = aws_autoscaling_group.scaling_group.id
  alb_target_group_arn   = aws_lb_target_group.iis_target_group.arn
}