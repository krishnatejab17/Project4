resource "aws_lb" "project1_alb" {
  name               = "project1-alb"
  internal           = false
  load_balancer_type = "application"
  ip_address_type    = "ipv4"
  security_groups    = [aws_security_group.project1_ecs_sg.id]
  subnets            = data.aws_subnets.default_subnets.ids
  enable_deletion_protection = false
}

resource "aws_lb_target_group" "project1_tg" {
  name     = "project1-tg"
  port     = 80
  protocol = "HTTP"
  target_type = "ip"
  vpc_id   = data.aws_vpc.default.id
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.project1_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.project1_tg.arn
  }
}