resource "aws_lb" "niginx-alb" {
  name                       = "niginx-alb"
  internal                   = false
  load_balancer_type         = "application"
  subnets                    = [aws_subnet.public1.id, aws_subnet.public2.id]
  security_groups    = [aws_security_group.default.id]
  enable_deletion_protection = false
  tags = {
    Name = "Nginx-alb"
  }
}

resource "aws_lb_target_group" "niginx-alb" {
  name     = "niginx-alb"
  port     = 80
  protocol = "HTTP"
  stickiness {
    type = "lb_cookie"
  }
  vpc_id   = aws_vpc.vpc.id
}


resource "aws_lb_listener" "niginx-alb" {
  load_balancer_arn = aws_lb.niginx-alb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.niginx-alb.arn
  }
}